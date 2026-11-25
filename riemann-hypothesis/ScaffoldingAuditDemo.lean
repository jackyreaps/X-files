import ScaffoldingAudit

namespace AuditDemo

/-- A predicate whose definition is the constant proposition `True`. -/
def vacuousInvariant (_n : Nat) (_x : Nat) : Prop := True

/-- A structure containing an ordinary proposition and the vacuous payload. -/
structure LayeredWitness where
  realBound : 1 ≤ 2
  hollowPayload : vacuousInvariant 3 4

/-- Transports the vacuous proposition into the structure. -/
theorem transportStep (h : vacuousInvariant 3 4) : LayeredWitness :=
  { realBound := Nat.le_succ 1, hollowPayload := h }

/-- The theorem uses the ordinary bound from the constructed witness. -/
theorem demoHeadlineTheorem : 1 ≤ 2 := by
  have h0 : vacuousInvariant 3 4 := trivial
  have w : LayeredWitness := transportStep h0
  exact w.realBound

end AuditDemo

-- The current checker reports vacuous definitions it finds in this theorem's
-- transitive value-dependency cone. It does not perform pass-through analysis.
#audit_theorem AuditDemo.demoHeadlineTheorem
