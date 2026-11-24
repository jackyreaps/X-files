/-
  ScaffoldingAudit.lean
  ---------------------------------------------------------------
  A structural linter for Lean 4. 
  Identifies vacuous geometry in ultra-large formalizations.
-/

import Lean
import Mathlib.Tactic

open Lean Elab Command

namespace ScaffoldingAudit

/-- Helper to skip stdlib/Mathlib internals during the dependency walk. -/
def isStdLib (n : Name) : Bool :=
  let s := n.toString
  s.startsWith "Lean." || s.startsWith "Init." || s.startsWith "Std." || 
  s.startsWith "Mathlib." || s.startsWith "Classical."

/-- Checks if a definition's value is explicitly `True` or `fun _ _ _ => True`. -/
def isVacuousDef (info : ConstantInfo) : Bool :=
  match info with
  | .defnInfo val =>
    let rec checkBody (e : Expr) : Bool :=
      match e with
      | .const ``True _ => true
      | .lam _ _ body _ => checkBody body
      | _ => false
    checkBody val.value
  | _ => false

/-- BFS over the live dependency cone from `root`. -/
partial def walkDependencyCone (env : Environment) (root : Name) : Array Name :=
  let rec bfs (queue : Array Name) (visited : Std.HashSet Name) : Std.HashSet Name :=
    if queue.isEmpty then visited
    else
      let curr := queue.back!
      let rest := queue.pop
      if isStdLib curr || visited.contains curr then
        bfs rest visited
      else
        let visited := visited.insert curr
        match env.find? curr with
        | none => bfs rest visited
        | some info =>
          let deps := match info.value? with
            | some v => v.getUsedConstants.toList
            | none => []
          -- Only add dependencies that haven't been visited and aren't stdlib
          let newNodes := deps.filter (fun d => !visited.contains d && !isStdLib d)
          bfs (rest ++ newNodes.toArray) visited
  let finalVisited := bfs #[root] (Std.HashSet.empty.insert root)
  finalVisited.toArray

/-- The command to run the audit. -/
elab "#audit_vacuous " target:ident : command => do
  let env ← getEnv
  let root := target.getId
  let some _ := env.find? root | throwError s!"Target {root} not found."
  
  logInfo m!"Auditing live dependency cone for: {root}"
  let cone := walkDependencyCone env root
  logInfo m!"Active non-stdlib constants in cone: {cone.size}"
  
  let mut count := 0
  for constName in cone do
    let some info := env.find? constName | continue
    if isVacuousDef info then
      logInfo m!"[VACUOUS DEFINITION] `{constName}` evaluates to True."
      count := count + 1
      
  logInfo m!"Audit complete: {count} vacuous definitions found."

end ScaffoldingAudit
