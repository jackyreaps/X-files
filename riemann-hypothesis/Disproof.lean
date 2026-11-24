/-
  Disproof.lean
  ---------------------------------------------------------------
  Countermodel against the classical interface that remains after
  the geometric payload is dropped.

  Live-path geometry drop-off (archive commit 40e56bab)
  ----------------------------------------------------
  The constant-True predicate `anyGeometry` sits 8 dependency edges
  below `riemannHypothesis`. The terminal edge is:

    every_character_of_theta_integrals_local_matching
      → parametersOfDependence
      → anyGeometry

  After `parametersOfDependence` the geometric payload is never
  inspected again on the live path. The recursive theta-layering
  apparatus therefore functions as a structural carrier for a
  vacuous `GeoP` inhabitant. The analytic force that continues is
  supplied by the classical literature package that discharges
  hA / hM / hX.

  This file constructs an explicit countermodel against that
  classical interface: it satisfies the discharged literature
  hypotheses while violating any RH-strength multiplicity bound.
  The kernel remains sound; the geometric narrative on the
  executed path does not match the active dependency.

  Date: 2026-11-23 (edge extraction 2026-11-24)
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

/-- Countermodel against the classical interface that remains
    after the geometry is dropped at
    `parametersOfDependence → anyGeometry`.
    Satisfies the archive hypotheses (hA, hM, hX) while producing
    a mass that violates the classical bound. -/
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
    If the theta-layering does not supply extra constraints beyond
    the classical literature bounds that remain after the geometry
    is dropped at `parametersOfDependence → anyGeometry`, then
    `challenge_lemma_theta_layering` is FALSE. -/
theorem challenge_lemma_false :
    ¬ (∀ (ms : List ThetaLiftMultiplicity) (C : ClassicalAnalyticData),
        thetaLiftMultiplicity_bounded ms C) := by
  intro h
  have h1 := h [fakeMultiplicity] C
  exact absurd (h1 fakeMultiplicity (by simp)) (not_le.mpr countermodel_violates_bound)

end Disproof
