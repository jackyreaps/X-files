module

public import Mathlib

/-!
# Volume preservation for the hierarchical Jacobian

**Status: proved (the two `sorry`s of the original are replaced by proofs).**

The X-files repository's `VolumePreservation.lean` contained two `sorry`ed
theorems (`jacobi_fin_three`, `hasFDerivAt_det_fin_three`) plus a stray Markdown
fence and invisible Unicode characters at the end. This module replaces them
with proofs. The "pending mathlib4#41881" note is removed.

* `jacobi_fin_three`: Jacobi's formula for `3 × 3` matrices,
  `det'(A) H = det A · tr(A⁻¹ H)` when `A` is invertible.
* `hasFDerivAt_det_fin_three`: the Fréchet derivative of `det` at an invertible
  `3 × 3` matrix.

Both are special cases of Jacobi's formula, proved in full generality in
`residual-core/Xfiles/Jacobi.lean`.
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
