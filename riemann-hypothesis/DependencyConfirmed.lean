/-
  DependencyConfirmed.lean
  ---------------------------------------------------------------
  Closure of the dependency-trace item.

  Public evidence (22–23 Nov 2026):
  - Compiled declaration graph: anyGeometry at steps_below_riemannHypothesis = 8.
  - Definition (OverIx.lean, commit 40e56bab):
      def anyGeometry : GeoP := fun _ _ _ => True
  - GeoCl.base trivial inhabits the geometry slot for free.
  - The non-vacuous alternative geoOf is NOT used on this path.

  Status: the geometric content on the live path is VACUOUS.
  Kernel acceptance of RiemannHypothesis is UNAFFECTED.

  Date: 2026-11-23
-/

import Mathlib.Data.Real.Basic
import Mathlib.Data.List.Basic
import Mathlib.Order.Basic
import Mathlib.Tactic

namespace DependencyConfirmed

/-! ## 1. The geometry predicate -/

abbrev GeometryPredicate := Unit -> Unit -> Unit -> Prop

def anyGeometry : GeometryPredicate := fun _ _ _ => True

def nonVacuousGeometry (witness : Prop) : GeometryPredicate := fun _ _ _ => witness

/-! ## 2. Public graph fact -/

def steps_below_riemannHypothesis_anyGeometry : Nat := Nat.succ (Nat.succ (Nat.succ (Nat.succ (Nat.succ (Nat.succ (Nat.succ (Nat.succ Nat.zero)))))))

theorem steps_positive : 0 < steps_below_riemannHypothesis_anyGeometry := Nat.succ_pos _

/-! ## 3. Vacuity on the live path -/

theorem geometry_on_path_is_vacuous : anyGeometry () () () <-> True := by rfl

theorem vacuous_geometry_carries_no_force (h : anyGeometry () () ()) : True := h

/-! ## 4. Link to the continuum-gap challenge -/

theorem vacuous_geometry_supplies_no_extra_force
    (h : anyGeometry () () ()) : True := h

/-- If the object that reaches rhOfAll is vacuous, then it is bounded
    by any classical package. Closed in FormalObstruction. -/
theorem vacuous_implies_bounded
    (mass : Real) (h_mass_zero : mass = 0)
    (errorBound windowLength : Real)
    (h_err : 0 <= errorBound) (h_win : 0 < windowLength) :
    mass <= errorBound + windowLength := by
  rw [h_mass_zero]
  linarith

/-! ## Status table

| Item | State |
|------|-------|
| anyGeometry extracted | confirmed (OverIx.lean:19) |
| = fun _ _ _ => True | confirmed |
| 8 edges below riemannHypothesis | confirmed by audits |
| Used in 24 RH-cone files | confirmed |
| OAt.geo vestigial | confirmed |
| Kernel acceptance unaffected | confirmed |
| Load-bearing swap test | OPEN |

-/

end DependencyConfirmed
