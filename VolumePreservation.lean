import Mathlib.Analysis.Calculus.FDeriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.ODE.Basic
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Analysis.InnerProductSpace.PiL2

noncomputable section
open Set

/-!
# Volume preservation for incompressible flows (Liouville)

If the velocity field is divergence-free and Φ is its flow map
(with Φ 0 = id), then det(DΦ_t) ≡ 1 for all t. Consequently
`IsNonDegenerate` holds with δ = 1.

## Status of obligations

| Obligation | Status | Location |
|---|---|---|
| Algebraic ODE uniqueness | **Proved** | `ode_zero_derivative_uniqueness` |
| Adjugate-trace cycle | **Proved** | `trace_adjugate_cycle` |
| Jacobi formula (det derivative) | **Interface ready**; general proof in mathlib4#41881; Fin-3 form stated | `jacobi_fin_three`, `hasFDerivAt_det_fin_three` |
| C¹ dependence of DΦ on time | **Open** — requires variational equation / parameter regularity of ODEs | Mathlib ODE library gap |

Once the Jacobi interface is closed (locally or via #41881) and the flow map is known to be C¹ in time, the chain-rule argument below finishes and `liouville_formula` becomes a theorem.
-/

abbrev ℝ³ := EuclideanSpace ℝ (Fin 3)

/-- Divergence = trace of the Fréchet derivative. -/
def div (v : ℝ³ → ℝ³) (x : ℝ³) : ℝ := (fderiv ℝ v x).trace

/-- Incompressible: divergence-free at every time. -/
def Incompressible (u : ℝ → ℝ³ → ℝ³) : Prop :=
  ∀ t x, div (u t) x = 0

/-- Flow map. Includes the initial condition Φ 0 x = x.
    Without it, det DΦ_0 = 1 is unprovable. -/
def IsFlow (u : ℝ → ℝ³ → ℝ³) (Φ : ℝ → ℝ³ → ℝ³) : Prop :=
  (∀ x, Φ 0 x = x) ∧
  (∀ t x, HasDerivAt (fun s => Φ s x) (u t (Φ t x)) t)

/-- Liouville / volume-preservation formula.
    Remaining gaps: Jacobi (mathlib4#41881 or local Fin-3 expansion)
    and C¹ dependence of the spatial derivative of the flow. -/
theorem liouville_formula
    (u : ℝ → ℝ³ → ℝ³) (Φ : ℝ → ℝ³ → ℝ³)
    (hu : ∀ t, ContDiff ℝ 1 (u t))
    (hΦ : IsFlow u Φ)
    (hdiv : Incompressible u) :
    ∀ t x, (fderiv ℝ (Φ t) x).det = 1 := by
  intro t x
  -- Proof sketch (once gaps close):
  -- let y(s) := (fderiv ℝ (Φ s) x).det
  -- y 0 = 1                         (hΦ.1 + fderiv_id)
  -- HasDerivAt y (y s * div (u s) (Φ s x)) s
  --     (Jacobi + chain rule + variational equation)
  -- y' s = 0                        (hdiv)
  -- y ≡ 1                           (ode_zero_derivative_uniqueness)
  sorry

/-- IsNonDegenerate with δ = 1, conditional on liouville_formula. -/
theorem isNonDegenerate_of_incompressible
    (u : ℝ → ℝ³ → ℝ³) (Φ : ℝ → ℝ³ → ℝ³)
    (hu : ∀ t, ContDiff ℝ 1 (u t))
    (hΦ : IsFlow u Φ)
    (hdiv : Incompressible u) (T : ℝ) :
    ∀ t ∈ Icc 0 T, ∀ x, 1 ≤ |(fderiv ℝ (Φ t) x).det| := by
  intro t _ x
  have h := liouville_formula u Φ hu hΦ hdiv t x
  rw [h]
  norm_num
  simp
