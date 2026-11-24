/-
  ScaffoldingAudit.lean
  ---------------------------------------------------------------
  A structural linter for Lean 4. 
  Identifies vacuous geometry and pass-through transport in 
  ultra-large formalizations.
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

/-- Checks if `fvarId` is used in `proofTerm` without ever being passed to an eliminator.
    Uses pure recursion to avoid Lean 4 monadic closure issues. -/
def isPassThrough (env : Environment) (proofTerm : Expr) (fvarId : FVarId) : Bool :=
  let rec go (e : Expr) (uses : Nat) (eliminated : Bool) : Nat × Bool :=
    match e with
    | .fvar id =>
      if id == fvarId then (uses + 1, eliminated) else (uses, eliminated)
    | .app f a =>
      let fn := f.getAppFn
      let newElim := match fn with
        | .const fnName _ =>
          let s := fnName.toString
          let isElim := env.isRec fnName || s.endsWith ".rec" || s.endsWith ".casesOn" || fnName == ``False.elim
          if isElim && (f.hasAnyFVar (· == fvarId) || a.hasAnyFVar (· == fvarId)) then true else eliminated
        | _ => eliminated
      let (u1, e1) := go f uses newElim
      go a u1 e1
    | .lam _ _ b _ => go b uses eliminated
    | .forallE _ _ b _ => go b uses eliminated
    | .letE _ _ v b _ =>
      let (u1, e1) := go v uses eliminated
      go b u1 e1
    | .mdata _ b => go b uses eliminated
    | .proj _ _ b => go b uses eliminated
    | _ => (uses, eliminated)
  let (u, el) := go proofTerm 0 false
  u > 0 && !el

elab "#audit_theorem " target:ident : command => do
  let env ← getEnv
  let rootName := target.getId
  let some _ := env.find? rootName | throwError s!"Target `{rootName}` not found."

  logInfo m!"Auditing live dependency cone for: {rootName}"
  let (cone, parents) := walkDependencyCone env rootName
  logInfo m!"Active non-stdlib constants in cone: {cone.toList.length}"

  let (vacuousCount, passThroughCount) ← liftTermElabM do
    cone.toList.foldlM (init := (0, 0)) fun (acc : Nat × Nat) constName => do
      let (vac, pt) := acc
      let some info := env.find? constName | return (vac, pt)

      let isVac := ← isVacuousDef info
      let vac' := if isVac then vac + 1 else vac
      if isVac then
        let path := reconstructPath parents rootName constName
        logInfo m!"[VACUOUS DEFINITION] `{constName}` ({path.length - 1} edges below `{rootName}`):"
        logInfo m!"   {String.intercalate " -> " (path.map toString)}"

      let pt' ← match info.value? with
        | some val =>
          lambdaTelescope val fun args body => do
            args.foldlM (init := pt) fun (count : Nat) (arg : Expr) => do
              let type ← inferType arg
              let hasGeoConst := type.getUsedConstants.any (·.toString.contains "Geo")
              if (← isProp type) && hasGeoConst then
                if isPassThrough env body arg.fvarId! then
                  logInfo m!"[PASS-THROUGH] `{constName}` transports `{type}` without eliminating it."
                  return count + 1
                else return count
              else return count
        | none => return pt

      return (vac', pt')

  logInfo m!"Audit complete: {vacuousCount} vacuous definitions, {passThroughCount} pass-through carriers."

end ScaffoldingAudit
