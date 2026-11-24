/-
  Disproof.lean
  ---------------------------------------------------------------
  The Countermodel Obligation.

  This file constructs the "Davenport-Heilbronn style" countermodel
  against the exact interface of the archive.

  It proves that if the classical hypotheses (hA, hM, hX) do not
  impose additional structural restrictions on the mass, the
  challenge lemma is mathematically FALSE.

  Date: 2026-11-23
-/

import ThetaConstraints
import Mathlib.Tactic

open ThetaConstraints

namespace Disproof

/-- The classical package with minimal error bounds. -/
def C : ClassicalAnalyticData where
  fe := { reflection_shape := True, trivial_zeros := True }
  afe := { windowLength := 1, errorBound := 1, window_pos := by norm_num, error_nonneg := by norm_num }
  weakDensity := True

/-- A violating theta-lift multiplicity. 
    It satisfies the exact archive hypotheses (hA, hM, hX), but
    completely ignores them to produce a mass of 100. -/
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
  hA := trivial
  hM := trivial
  hX := trivial
  geo_vacuous := True

/-- Proof that the surviving mass exceeds the classical bound. -/
theorem countermodel_violates_bound :
    survivingMass fakeMultiplicity.toLiftMultiplicity
      > C.afe.errorBound + C.afe.windowLength := by
  simp [survivingMass, fakeMultiplicity, C]
  norm_num

/-- The Disproof Obligation is satisfied for our classical package. -/
theorem disproof_obligation_holds : DisproofObligation C :=
  ⟨fakeMultiplicity, countermodel_violates_bound⟩

/-- **The Disproof.** 
    If the theta-layering does not supply extra constraints (i.e. 
    if hA, hM, and hX are just the classical literature bounds),
    then `challenge_lemma_theta_layering` is FALSE. -/
theorem challenge_lemma_false :
    ¬ (∀ (ms : List ThetaLiftMultiplicity) (C : ClassicalAnalyticData),
        thetaLiftMultiplicity_bounded ms C) := by
  intro h
  have h1 := h [fakeMultiplicity] C
  exact absurd (h1 fakeMultiplicity (by simp)) (not_le.mpr countermodel_violates_bound)

end Disproof
