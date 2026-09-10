import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.LinearAlgebra.Matrix.Adjugate
import Mathlib.LinearAlgebra.Matrix.Trace

open Matrix

/-- If y' = 0 globally and y(0) = 1, then y ≡ 1. -/
lemma ode_zero_derivative_uniqueness
    (y : ℝ → ℝ) (hy0 : y 0 = 1)
    (hy_deriv : ∀ s, HasDerivAt y 0 s) :
    y = fun _ => 1 := by
  have h_deriv_zero : ∀ s, deriv y s = 0 := fun s => (hy_deriv s).deriv
  have h_const : ∀ s, y s = y 0 := by
    intro s
    exact (is_const_of_deriv_eq_zero h_deriv_zero).eq s 0
  ext t
  rw [h_const t, hy0]

/-- tr(adj(A) · Du · A) = det(A) · tr(Du). Holds for all A,
    including singular ones, via the global adjugate identity. -/
theorem trace_adjugate_cycle
    (A Du : Matrix (Fin 3) (Fin 3) ℝ) :
    trace (A.adjugate * Du * A) = A.det * trace Du := by
  rw [trace_mul_cycle]
  rw [mul_adjugate]
  rw [smul_mul, one_mul, trace_smul]
  simp
