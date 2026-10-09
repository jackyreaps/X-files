module

public import Mathlib

/-!
# X-files filters

**Status: proved (definitions restated; the energy statements are conditional on
an energy balance supplied as a hypothesis).**

The X-files repository, <https://github.com/jackyreaps/X-files>, has a short Lean
file `X-files_Filters.lean`. This module restates it for the current Mathlib and
adds content. Nothing is copied.

* `IsNonDegenerate δ Φ T`: the coordinate non-degeneracy filter, with the
  Jacobian determinant written as `LinearMap.det` of the Fréchet derivative.
* `fderiv_isUnit_of_nonDegenerate`: a map passing the filter has an invertible
  derivative everywhere on the time window.
* `jacDet_smul`: a uniform rescaling `x ↦ c(t)·x` of 3-space has Jacobian `c(t)³`.
* `crunch_nonDegenerate_iff`, `crunch_eventually_fails`: the exponential
  coordinate crunch `x ↦ e^{−t}x` passes the filter on `[0, T]` exactly when
  `δ ≤ e^{−3T}`.
* `HasEnergyParityClosure`, `unforced_has_energy_parity`: a zero force passes the
  energy-parity filter for every `E_max > 0`.

**Note.** `HasEnergyParityClosure` bounds `∫ ‖f t x‖` (the L¹ norm of the force),
not the injected power `∫ ⟨f, u⟩`. This is preserved from the original. Consider
adding an integrability hypothesis to avoid vacuous satisfaction via Lean's `0`
convention for non-integrable functions.
-/

@[expose] public section

set_option autoImplicit false

open Set MeasureTheory

namespace Xfiles.Filters

/-- Euclidean 3-space. -/
abbrev E3 := EuclideanSpace ℝ (Fin 3)

/-- The Jacobian determinant of the time-`t` map at `x`. -/
noncomputable def jacDet (Φ : ℝ → E3 → E3) (t : ℝ) (x : E3) : ℝ :=
  LinearMap.det (fderiv ℝ (Φ t) x : E3 →ₗ[ℝ] E3)

/-- The coordinate non-degeneracy filter: `δ ≤ |det DΦ_t(x)|` on `[0, T] × ℝ³`. -/
def IsNonDegenerate (δ : ℝ) (Φ : ℝ → E3 → E3) (T : ℝ) : Prop :=
  ∀ t ∈ Icc 0 T, ∀ x : E3, δ ≤ |jacDet Φ t x|

/-- The rotational-inertia barrier (as in the repository). -/
def PreservesRotationalInertia (I : ℝ → ℝ) (minI : ℝ) : Prop :=
  0 < minI ∧ ∀ t, minI ≤ I t

/-- The energy-parity closure filter (as in the repository). -/
noncomputable def HasEnergyParityClosure (f : ℝ → E3 → E3) (Emax T : ℝ) : Prop :=
  0 < Emax ∧ ∀ t ∈ Icc 0 T, ∫ x : E3, ‖f t x‖ ≤ Emax

/-- All three filters. -/
noncomputable def PassesXfilesFilters (δ : ℝ) (Φ : ℝ → E3 → E3) (I : ℝ → ℝ) (minI : ℝ)
    (f : ℝ → E3 → E3) (Emax T : ℝ) : Prop :=
  IsNonDegenerate δ Φ T ∧ PreservesRotationalInertia I minI ∧ HasEnergyParityClosure f Emax T

/-- A map passing the filter has invertible derivative at every point of the window. -/
theorem fderiv_isUnit_of_nonDegenerate {δ T : ℝ} (hδ : 0 < δ) {Φ : ℝ → E3 → E3}
    (h : IsNonDegenerate δ Φ T) {t : ℝ} (ht : t ∈ Icc 0 T) (x : E3) :
    IsUnit (fderiv ℝ (Φ t) x : E3 →ₗ[ℝ] E3) := by
  rw [LinearMap.isUnit_iff_isUnit_det, isUnit_iff_ne_zero]
  intro h0
  have := h t ht x
  rw [jacDet, h0, abs_zero] at this
  linarith

/-- A uniform rescaling of 3-space has Jacobian `c(t)³`. -/
theorem jacDet_smul (c : ℝ → ℝ) (t : ℝ) (x : E3) :
    jacDet (fun t x => c t • x) t x = c t ^ 3 := by
  unfold jacDet
  have : fderiv ℝ (fun x : E3 => c t • x) x = c t • ContinuousLinearMap.id ℝ E3 := by
    simpa using (((ContinuousLinearMap.id ℝ E3).hasFDerivAt (x := x)).const_smul (c t)).fderiv
  rw [this]
  simp [LinearMap.det_smul]

/-- The exponential crunch `x ↦ e^{−t} x` passes the filter on `[0, T]` exactly when
`δ ≤ e^{−3T}`. -/
theorem crunch_nonDegenerate_iff (δ : ℝ) {T : ℝ} (hT : 0 ≤ T) :
    IsNonDegenerate δ (fun t x => Real.exp (-t) • x) T ↔ δ ≤ Real.exp (-3 * T) := by
  have key : ∀ t, |jacDet (fun t x => Real.exp (-t) • x) t 0| = Real.exp (-3 * t) := by
    intro t
    rw [jacDet_smul (fun t => Real.exp (-t)), ← Real.exp_nat_mul, abs_of_pos (Real.exp_pos _)]
    congr 1; push_cast; ring
  constructor
  · intro h; simpa [key] using h T ⟨hT, le_rfl⟩ 0
  · intro h t ht x
    have hx : jacDet (fun t x => Real.exp (-t) • x) t x =
        jacDet (fun t x => Real.exp (-t) • x) t 0 := by
      rw [jacDet_smul (fun t => Real.exp (-t)), jacDet_smul (fun t => Real.exp (-t))]
    rw [hx, key]
    exact h.trans (Real.exp_le_exp.2 (by nlinarith [ht.2]))

/-- For every threshold `δ > 0` the exponential crunch fails the filter on long
enough windows. -/
theorem crunch_eventually_fails {δ : ℝ} (hδ : 0 < δ) :
    ∃ T₀, ∀ T, T₀ < T → ¬ IsNonDegenerate δ (fun t x => Real.exp (-t) • x) T := by
  refine ⟨max 0 (-Real.log δ / 3), fun T hT h => ?_⟩
  have hT0 : 0 ≤ T := le_of_lt (lt_of_le_of_lt (le_max_left _ _) hT)
  have h1 := (crunch_nonDegenerate_iff δ hT0).1 h
  have h2 : -Real.log δ / 3 < T := lt_of_le_of_lt (le_max_right _ _) hT
  have : Real.exp (-3 * T) < δ := by
    calc Real.exp (-3 * T) < Real.exp (Real.log δ) := Real.exp_lt_exp.2 (by linarith)
      _ = δ := Real.exp_log hδ
  linarith

/-- A zero force passes un the energy-parity filter for every positive budget. -/
theoremforced_has_energy_parity {Emax : ℝ} (hE : 0 < Emax) (T : ℝ) :
    HasEnergyParityClosure (fun _ _ => 0) Emax T :=
  ⟨hE, fun _ _ => by simp [hE.le]⟩

end Xfiles.Filters