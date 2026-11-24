/-
  ScaffoldingAudit.lean
  ---------------------------------------------------------------
  A structural linter for Lean 4. 
  Identifies vacuous geometry in ultra-large formalizations.
  
  Core metaprogramming only. No Mathlib.Tactic dependency required.
-/

import Lean

open Lean Elab Command

namespace ScaffoldingAudit

def isStdLib (n : Name) : Bool :=
  let s := n.toString
  s.startsWith "Lean." || s.startsWith "Init." || s.startsWith "Std." ||
  s.startsWith "Mathlib." || s.startsWith "Classical."

/-- BFS over the live dependency cone from `root`. -/
partial def walkDependencyCone (env : Environment) (root : Name) : Array Name :=
  let rec bfs (queue : List Name) (visited : NameSet) : NameSet :=
    match queue with
    | [] => visited
    | curr :: rest =>
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
          let newNodes := deps.filter (fun d => !visited.contains d && !isStdLib d)
          bfs (rest ++ newNodes) visited
  (bfs [root] ({} : NameSet)).toArray

/-- Peels off lambda binders to find the core body of an expression. -/
partial def peelLambdas (e : Expr) : Expr :=
  match e with
  | .lam _ _ b _ => peelLambdas b
  | _ => e

/-- Checks if a definition evaluates to `True`. -/
def isVacuousDef (info : ConstantInfo) : Bool :=
  match info with
  | .defnInfo val => (peelLambdas val.value).isConstOf ``True
  | _ => false

elab "#audit_theorem " target:ident : command => do
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
