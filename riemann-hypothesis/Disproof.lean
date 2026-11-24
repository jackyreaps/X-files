/-
  Disproof.lean
  ---------------------------------------------------------------
  Countermodel obligation against challenge_lemma_theta_layering.

  fakeMultiplicity carries:
    - literature hA / hM (True stubs, as on the live path discharge)
    - classical hX
    - the three archive-named constraints (slope / relative-trace /
      character-avg) set to True
    - vacuous geometry marker
  and still produces surviving mass far above the classical bound.

  This shows: literature + named archive constraint *slots* alone do
  not force the multiplicity bound. Closing the open sorry therefore
  requires real force from those constraints, not merely inhabiting
  the Props as True.
-/

import ThetaConstraints
import Mathlib.Tactic

open ThetaConstraints

namespace Disproof

def C : ClassicalAnalyticData where
  boundary := {
    reflectionLaw := fun _ => True
    windowLength := 1
    errorBound := 1
    window_pos := by norm_num
    error_nonneg := by norm_num
    localArchimedeanMatch := fun _ => True
    localNonArchimedeanMatch := fun _ => True
    auxiliaryTraceIdentity := fun _ => True
  }
  weakDensity := True

/-- Violating multiplicity: all live-path hypothesis slots hold (as True),
    mass = 100 ≫ classical window+error. -/
def fakeMultiplicity : ThetaLiftMultiplicity where
  window := 1
  mass_raw := 100
  mass_after_averaging := 100
  mass_after_slope := 100
  mass_after_trace := 100
  window_pos := by norm_num
  raw_nonneg := by norm_num
  avg_nonneg := by norm_num
  slope_nonneg := by norm_num
  trace_nonneg := by norm_num
  avg_le_raw := le_rfl
  slope_le_avg := le_rfl
  trace_le_slope := le_rfl
  boundary := C.boundary
  hA := trivial
  hM := trivial
  hX := ⟨100, by norm_num, le_rfl⟩
  slope_bound_holds := True
  relative_trace_holds := True
  character_avg_holds := True
  geo_vacuous := True

theorem countermodel_violates_bound :
    survivingMass fakeMultiplicity.toLiftMultiplicity
      > C.boundary.errorBound + C.boundary.windowLength := by
  simp [survivingMass, fakeMultiplicity, C]
  norm_num

theorem disproof_obligation_holds : DisproofObligation C :=
  ⟨fakeMultiplicity, trivial, trivial, trivial, countermodel_violates_bound⟩

/-- If challenge_lemma_theta_layering is stated for arbitrary lists
    with no restriction beyond the structure fields, it is false. -/
theorem challenge_lemma_false :
    ¬ (∀ (ms : List ThetaLiftMultiplicity) (C : ClassicalAnalyticData),
        thetaLiftMultiplicity_bounded ms C) := by
  intro h
  have h1 := h [fakeMultiplicity] C
  exact absurd (h1 fakeMultiplicity (by simp)) (not_le.mpr countermodel_violates_bound)

end Disproof
