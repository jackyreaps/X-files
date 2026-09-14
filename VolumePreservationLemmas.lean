import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.FDeriv.Basic
import Mathlib.LinearAlgebra.Matrix.Adjugate
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

open Matrix ContinuousLinearMap

/-!
# Supporting lemmas for Liouville volume preservation

Algebraic identities + Fin-3 Jacobi interface.
General Jacobi is drafted upstream in mathlib4#41881.
-/

/-- If y' = 0 globally and y(0) = 1, then y ≡ 1. -/
lemma ode_zero_derivative_uniqueness
    (y : ℝ → ℝ) (hy0 : y 0 = 1)
    (hy_deriv : ∀ s, HasDerivAt y 0 s) :
    y = fun _ => 1 := by
  have h_deriv_zero : ∀ s, deriv y s = 0 := fun s => (hy_deriv s).deriv
  have h_const : ∀ s, y s = y 0 := by
    intro s
    exact (isConst_of_deriv_eq_zero (fun s => h_deriv_zero s)).eq s 0
  ext t
  rw [h_const t, hy0]

/-- Algebraic cycle identity: tr(adj(A) · Du · A) = det(A) · tr(Du).
    Holds for all matrices, including singular ones. -/
theorem trace_adjugate_cycle
    (A Du : Matrix (Fin 3) (Fin 3) ℝ) :
    trace (A.adjugate * Du * A) = A.det * trace Du := by
  rw [trace_mul_cycle]
  rw [mul_adjugate]
  rw [smul_mul_assoc, one_mul, trace_smul]
  simp

/-! ## Fin-3 Jacobi formula

`det` on 3×3 is the explicit polynomial `det_fin_three`.
Its directional derivative is tr(adj(A)ᵀ * H).

A complete term-by-term expansion is possible but lengthy.
mathlib4#41881 provides the general case; until it merges we keep
the interface below so the volume-preservation argument is fully
wired.
-/

/-- Directional Jacobi formula on Fin 3. -/
theorem jacobi_fin_three
    (A H : Matrix (Fin 3) (Fin 3) ℝ) :
    deriv (fun t : ℝ => (A + t • H).det) 0 =
      (A.adjugate.transpose * H).trace := by
  -- Expand via det_fin_three, differentiate the six cubic monomials,
  -- evaluate at t = 0; the result is the classical cofactor expansion.
  -- Deferred to mathlib4#41881 or a direct (long) expansion.
  sorry

/-- Fréchet form of Jacobi on Fin 3. -/
theorem hasFDerivAt_det_fin_three
    (A : Matrix (Fin 3) (Fin 3) ℝ) :
    HasFDerivAt (fun M : Matrix (Fin 3) (Fin 3) ℝ => M.det)
      (fun H => (A.adjugate.transpose * H).trace) A := by
  -- Follows from jacobi_fin_three + uniqueness of Fréchet derivative.
  sorry
