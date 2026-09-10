import Mathlib.Analysis.Calculus.FDeriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.ODE.Basic
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.LinearAlgebra.Matrix.Trace

noncomputable section
open Set

abbrev ℝ³ := EuclideanSpace ℝ (Fin 3)
abbrev Matrix3 := Matrix (Fin 3) (Fin 3) ℝ

/-- Divergence = trace of the Fréchet derivative. -/
def div (v : ℝ³ → ℝ³) (x : ℝ³) : ℝ := (fderiv ℝ v x).trace

/-- Incompressible: divergence-free at every time. -/
def Incompressible (u : ℝ → ℝ³ → ℝ³) : Prop :=
  ∀ t x, div (u t) x = 0

/-- Flow map. **Includes the initial condition** Φ 0 x = x.
    Without it, the flow is only defined up to time translation
    and det DΦ_0 = 1 is unprovable. -/
def IsFlow (u : ℝ → ℝ³ → ℝ³) (Φ : ℝ → ℝ³ → ℝ³) : Prop :=
  (∀ x, Φ 0 x = x) ∧
  (∀ t x, HasDerivAt (fun s => Φ s x) (u t (Φ t x)) t)

/-
  BLOCKED — not proven. Two open obligations:

  (a) hy_cont: continuity of t ↦ fderiv ℝ (Φ t) x.
      Requires smooth dependence of the flow on initial conditions
      (variational equation + ODE parameter-regularity). May not be
      assembled in current Mathlib.

  (b) hy_deriv: Jacobi's formula in adjugate form,
        HasFDerivAt Matrix.det (fun H => tr(adj(A) · H)) A.
      Not located in Mathlib as a bundled lemma.

  CLOSED: ode_zero_derivative_uniqueness, trace_adjugate_cycle.
  See VolumePreservationLemmas.lean.

  Consequence: IsNonDegenerate with δ = 1 is a theorem for
  incompressible flows *if* (a) and (b) are supplied. It is not
  currently a theorem in this repository.
-/
theorem liouville_formula
    (hu : ∀ t, ContDiff ℝ 1 (u t))
    (hΦ : IsFlow u Φ)
    (hdiv : Incompressible u) :
    ∀ t x, (fderiv ℝ (Φ t) x).det = 1 := by
  intro t x
  sorry

/-- IsNonDegenerate with δ = 1, conditional on liouville_formula. -/
theorem isNonDegenerate_unconditional
    (hu : ∀ t, ContDiff ℝ 1 (u t))
    (hΦ : IsFlow u Φ)
    (hdiv : Incompressible u) (T : ℝ) :
    ∀ t ∈ Icc 0 T, ∀ x, 1 ≤ |(fderiv ℝ (Φ t) x).det| := by
  intro t _ x
  rw [liouville_formula hu hΦ hdiv t x]
  simp
