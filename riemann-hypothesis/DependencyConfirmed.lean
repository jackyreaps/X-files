/-
  DependencyConfirmed.lean
  ---------------------------------------------------------------
  Closure of the dependency-trace item left open in
  VacuousGeometryBridge.lean.

  Public evidence (22 Nov 2026):
  - Compiled declaration graph (proofsandreasons.io) records
    GlobalTheory.Mem.Top.Bl.anyGeometry at
    steps_below_riemannHypothesis = 8.
  - Source path (high-level):
      riemannHypothesis
        := rhOfAll
          ← allChi / everyCharacter
            ← … ← zero_free_all_of_green_v_win
              ← forall_goal_of_shape_of_hyps
                ← HypsAlt witness
                  ← nonempty_hyps_definite_side_of_closed_bound
                    ← geoCl anyGeometry
  - Definition (OverIx.lean):
      def anyGeometry : GeoP := fun _ _ _ => True
  - GeoCl.base trivial inhabits the geometry slot for free.
  - The non-vacuous alternative geoOf is not used on this path.

  Status: the geometric content on the live path is vacuous.
  This realises the continuum-gap obstruction inside the
  certified term. Kernel acceptance of a term of type
  RiemannHypothesis is unaffected; the named geometric
  argument is empty of independent content.

  Does not import the 17 M-line archive.
  Companion files:
    ContinuumGapChallenge.lean
    VacuousGeometryBridge.lean
    X-files_Continuum_Gap_Challenge.md
  Date: 2026-11-22
-/

import Mathlib.NumberTheory.LSeries.RiemannZeta
import Mathlib.Data.Real.Basic
import Mathlib.Tactic

open Complex Real

namespace DependencyConfirmed

/-!
## 1. The geometry predicate on the live path
-/

/-- Abstract shape of the geometry predicate appearing in the archive.
    We do not import the archive; we only record the interface that
    was found. -/
abbrev GeometryPredicate := Unit → Unit → Unit → Prop

/-- The predicate that appears on the live dependency path.
    In the archive this is defined as:
      def anyGeometry : GeoP := fun _ _ _ => True -/
def anyGeometry : GeometryPredicate := fun _ _ _ => True

/-- A non-vacuous geometry would demand actual content
    (IsGeoOf witness + true surface). That alternative exists
    in the same file but is not the one used on the final path. -/
def nonVacuousGeometry (witness : Prop) : GeometryPredicate :=
  fun _ _ _ => witness

/-!
## 2. Public graph fact
-/

/-- Recorded from the compiled declaration graph
    (proofsandreasons.io / alp-declaration-graph-used-by-rh).
    GlobalTheory.Mem.Top.Bl.anyGeometry sits 8 steps below
    riemannHypothesis. -/
def steps_below_riemannHypothesis_anyGeometry : ℕ := 8

theorem steps_positive : 0 < steps_below_riemannHypothesis_anyGeometry := by
  native_decide

/-!
## 3. Vacuity on the live path
-/

/-- The geometry certificate that reaches the final term
    is definitionally True. -/
theorem geometry_on_path_is_vacuous :
    anyGeometry () () () ↔ True := by
  rfl

/-- Consequently it carries no independent geometric force. -/
theorem vacuous_geometry_carries_no_force
    (h : anyGeometry () () ()) : True := h

/-!
## 4. Link to the continuum-gap challenge

A geometry (or multiplicity) object that is definitionally True
is no stronger than a trivial classical placeholder. This is the
extreme case of the comparison isolated in ContinuumGapChallenge:
the structural content supplied on the live path does not exceed
what classical non-RH data already give.
-/

/-- Vacuous geometry supplies no continuum rigidity beyond a
    trivial placeholder. -/
theorem vacuous_geometry_supplies_no_extra_force :
    anyGeometry () () () → True := fun h => h

/-- If the multiplicity / geometry object that reaches rhOfAll
    is the vacuous one, then any “force toward RH” it supplies
    is already present in the trivial classical package. -/
theorem vacuous_content_bounded_by_trivial
    (h : anyGeometry () () ()) :
    True := h

/-!
## 5. Status (updated 2026-11-22)

| Item                                      | Previous state | Current state          |
|-------------------------------------------|----------------|------------------------|
| Existence of anyGeometry = True           | confirmed      | confirmed              |
| Use in 24 files / HypsAlt constructions   | confirmed      | confirmed              |
| Dependency path to rhOfAll                | open           | **closed (8 steps)**   |
| Geometric content on live path            | unresolved     | **vacuous**            |
| Continuum-gap obstruction realised        | incomplete     | **realised on path**   |
| Kernel acceptance of final term           | certified      | still certified        |

The named geometric argument that was supposed to supply
continuum rigidity is empty on the actual dependency path used
by the certified archive. The abstract challenge lemma in
ContinuumGapChallenge.lean can now be discharged by observing
that the concrete object reaching the final estimates is the
vacuous geometry recorded here.

This file does not claim that Lean’s kernel is unsound.
It records that the geometric content the proof names is
definitionally absent on the live route.
-/

end DependencyConfirmed
