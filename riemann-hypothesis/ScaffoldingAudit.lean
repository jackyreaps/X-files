/-
  ScaffoldingAudit.lean
  ---------------------------------------------------------------
  A structural linter for Lean 4. 
  Identifies vacuous geometry and pass-through transport in 
  ultra-large formalizations.
  
  Core metaprogramming only. No Mathlib.Tactic dependency required.
-/

import Lean

open Lean Elab Command Meta

namespace ScaffoldingAudit

def isStdLib (n : Name) : Bool :=
  let s := n.toString
  s.startsWith "Lean." || s.startsWith "Init." || s.startsWith "Std." ||
  s.startsWith "Mathlib." || s.startsWith "Classical."

/-- Checks if a definition's value reduces to `True` after peeling all lambdas. -/
def isVacuousDef (info : ConstantInfo) : MetaM Bool := do
  match info with
  | .defnInfo val =>
    lambdaTelescope val.value fun _ body => do
      let body' ← whnf body
      return body'.isConstOf ``True
  | _ => return false

/-- BFS over the live dependency cone from `root`. -/
partial def walkDependencyCone (env : Environment) (root : Name) :
    NameSet × Std.HashMap Name Name :=
  let rec bfs (queue : List Name) (visited : NameSet) (parents : Std.HashMap Name Name) :
      NameSet × Std.HashMap Name Name :=
    match queue with
    | [] => (visited, parents)
    | curr :: rest =>
      if isStdLib curr then
        bfs rest visited parents
      else
        match env.find? curr with
        | none => bfs rest visited parents
        | some info =>
          let valDeps := match info.value? with
            | some v => v.getUsedConstants.toList
            | none => []
          let deps := (valDeps ++ info.type.getUsedConstants.toList).eraseDups
          let (nextQueue, nextVisited, nextParents) :=
            deps.foldl (init := ([], visited, parents)) fun (accQ, accV, accP) d =>
              if accV.contains d || isStdLib d then
                (accQ, accV, accP)
              else
                (d :: accQ, accV.insert d, accP.insert d curr)
          bfs (rest ++ nextQueue.reverse) nextVisited nextParents
  bfs [root] ({} : NameSet) {}

/-- Reconstructs the shortest path from `root` to `target` using `parents`. -/
partial def reconstructPath (parents : Std.HashMap Name Name) (root target : Name) : List Name :=
  let rec go (curr : Name) (acc : List Name) : List Name :=
    if curr == root then curr :: acc
    else match parents[curr]? with
      | some p => go p (curr :: acc)
      | none => curr :: acc
  go target []

/-- Checks if `fvarId` is used in `proofTerm` without ever being passed to an eliminator. -/
def isPassThrough (env : Environment) (proofTerm : Expr) (fvarId : FVarId) : Bool :=
  let (_, (uses, eliminated)) := StateT.run (m := Id) (s := (0, false)) do
    ForEachExpr.forEach proofTerm fun e => do
      match e with
      | .fvar id =>
        if id == fvarId then
          modify fun (u, el) => (u + 1, el)
      | .app _ _ =>
        let fn := e.getAppFn
        if let .const fnName _ := fn then
          let s := fnName.toString
          if env.isRec fnName || s.endsWith ".rec" || s.endsWith ".casesOn" || fnName == ``False.elim then
            if e.getAppArgs.any (fun arg => arg.hasAnyFVar (· == fvarId)) then
              modify fun (u, _) => (u, true)
      | _ => pure ()
  uses > 0 && !eliminated

elab "#audit_theorem " target:ident : command => do
  let env ← getEnv
  let rootName := target.getId
  let some _ := env.find? rootName | throwError s!"Target `{rootName}` not found."

  logInfo m!"Auditing live dependency cone for: {rootName}"
  let (cone, parents) := walkDependencyCone env rootName
  logInfo m!"Active non-stdlib constants in cone: {cone.size}"

  liftTermElabM do
    let mut vacuousCount := 0
    let mut passThroughCount := 0

    for constName in cone do
      let some info := env.find? constName | continue

      if (← isVacuousDef info) then
        vacuousCount := vacuousCount + 1
        let path := reconstructPath parents rootName constName
        logInfo m!"[VACUOUS DEFINITION] `{constName}` ({path.length - 1} edges below `{rootName}`):"
        logInfo m!"   {String.intercalate " -> " (path.map toString)}"

      if let some val := info.value? then
        lambdaTelescope val fun args body => do
          for arg in args do
            let type ← inferType arg
            let hasGeoConst := type.getUsedConstants.any (·.toString.contains "Geo")
            if (← isProp type) && hasGeoConst then
              if isPassThrough env body arg.fvarId! then
                passThroughCount := passThroughCount + 1
                logInfo m!"[PASS-THROUGH] `{constName}` transports `{type}` without eliminating it."

    logInfo m!"Audit complete: {vacuousCount} vacuous definitions, {passThroughCount} pass-through carriers."

end ScaffoldingAudit
