module

public import Mathlib

/-!
# Volume preservation for the hierarchical Jacobian

**Status: statements only.** The two theorems below are true but are not proved in
this repository at this time. Their proofs depend on Jacobi's formula for the
derivative of `det`, which will be supplied in a separate module when it is
published. Until then, `lake build` on this file will report `sorry`.

The two theorems are:

* `jacobi_fin_three`: Jacobi's formula for `3 × 3` matrices,
  `det'(A) H = det A · tr(A⁻¹ H)` when `A` is invertible.
* `hasFDerivAt_det_fin_three`: the Fréchet derivative of `det` at an invertible
  `3 × 3` matrix.

**To do.** Replace the two `sorry`s with the proofs from the forthcoming Jacobi
module once that module is in the repository. Until then, this file should be
excluded from any "no `sorry`" check.
-/

@[expose] public section

set_option autoImplicit false

open Matrix

namespace Xfiles.VolumePreservation

variable {R : Type*} [CommRing R] [IsDomain R]

/-- Jacobi's formula for `3 × 3` matrices: the derivative of `det` at an
invertible matrix `A` in the direction `H` is `det A · tr(A⁻¹ H)`. -/
theorem jacobi_fin_three (A H : Matrix (Fin 3) (Fin 3) R) (hA : IsUnit A.det) :
    deriv (fun t : R => (A + t • H).det) 0 = A.det * (A⁻¹ * H).trace := by
  sorry

/-- The Fréchet derivative of `det` at an invertible `3 × 3` matrix. -/
theorem hasFDerivAt_det_fin_three (A : Matrix (Fin 3) (Fin 3) R) (hA : IsUnit A.det) :
    HasFDerivAt (fun M : Matrix (Fin 3) (Fin 3) R => M.det)
      (ContinuousLinearMap.mulRight _ _ (A⁻¹) |>.comp (ContinuousLinearMap.trace _ _ _)) A := by
  sorry

end Xfiles.VolumePreservation
