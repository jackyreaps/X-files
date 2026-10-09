module

public import Mathlib

/-!
# LASLS: correctness of the triangular core, and where the refinements break it

**Status: proved (algebra over any commutative ring; no security statement).**

The X-files repository specifies the LASLS cryptosystem in
`07-LASLS-post-quantum-trapdoor.md` and asks (§8) for a Lean correctness theorem
`decrypt (encrypt m) = m`. This module gives it for the 6-dimensional construction
of §4, and checks the two refinements the document adds on top of the classical
scheme. Nothing is copied from the repository. Everything is over an arbitrary
commutative ring `R`, so in particular over every finite field `𝔽_q`.

**What is proved.**

* `backSub6_tame6`, `tame6_backSub6`: the classical 6D tame map
  `P₁ = x₁ + c₀`, `P_{i+1} = x_{i+1} + g_i(x₁, …, x_i)` (any functions `g_i`, of any
  degree) is a bijection, and the back-substitution cascade of §4.4 is its exact
  two-sided inverse.
* `decrypt_encrypt`: the §8 correctness theorem for the public key
  `F = A · G(B · X)`: whenever `A⁻¹ A = 1` and `B⁻¹ B = 1`,
  `decrypt (encrypt m) = m` for every plaintext `m`.
* `tame6_add_lower`, `decrypt_encrypt_lower_perturbed`: a perturbation whose
  `i`-th coordinate depends only on the earlier coordinates is absorbed into the
  `g_i`, so correctness survives it.

**What fails as stated.**

* `perturbed_not_injective`: for a general perturbation `Π : 𝔽_qⁿ → V` (§2.3),
  correctness is not automatic. With `G = id` and the degree-1, rank-1
  perturbation `Π(X) = −x₁ e₁`, the map `G + Π` is not injective.
* `refined6_not_injective`: the refined anchor of §2.1,
  `P₁ = x₁ + α₂x₂ + … + α₆x₆ + φ₁(X)`, does not preserve invertibility. With
  `α₂ = 1`, `g₁ = id` and everything else zero, `P₁ = P₂ = x₁ + x₂`.
* `refined6_jac_det`, `refined_det_two`: the claim `det J_G = 1` (§2.2, §4.2)
  fails for the refined anchor. The Jacobian determinant is `1 − α₂ c`.

The document's security estimates (§6) are attack-cost arithmetic about
external algorithms and are not formalized.
-/

@[expose] public section

set_option autoImplicit false

open Matrix

namespace Xfiles.LASLS

variable {R : Type*} [CommRing R]

/-- The classical LASLS secret map in dimension 6. -/
def tame6 (c₀ : R) (g₁ : R → R) (g₂ : R → R → R) (g₃ : R → R → R → R)
    (g₄ : R → R → R → R → R) (g₅ : R → R → R → R → R → R) (x : Fin 6 → R) : Fin 6 → R :=
  ![x 0 + c₀, x 1 + g₁ (x 0), x 2 + g₂ (x 0) (x 1), x 3 + g₃ (x 0) (x 1) (x 2),
    x 4 + g₄ (x 0) (x 1) (x 2) (x 3), x 5 + g₅ (x 0) (x 1) (x 2) (x 3) (x 4)]

/-- The back-substitution cascade of §4.4 (unperturbed). -/
def backSub6 (c₀ : R) (g₁ : R → R) (g₂ : R → R → R) (g₃ : R → R → R → R)
    (g₄ : R → R → R → R → R) (g₅ : R → R → R → R → R → R) (y : Fin 6 → R) : Fin 6 → R :=
  let x₁ := y 0 - c₀
  let x₂ := y 1 - g₁ x₁
  let x₃ := y 2 - g₂ x₁ x₂
  let x₄ := y 3 - g₃ x₁ x₂ x₃
  let x₅ := y 4 - g₄ x₁ x₂ x₃ x₄
  let x₆ := y 5 - g₅ x₁ x₂ x₃ x₄ x₅
  ![x₁, x₂, x₃, x₄, x₅, x₆]

section Classical

variable (c₀ : R) (g₁ : R → R) (g₂ : R → R → R) (g₃ : R → R → R → R)
    (g₄ : R → R → R → R → R) (g₅ : R → R → R → R → R → R)

/-- Back-substitution undoes the tame map. -/
theorem backSub6_tame6 (x : Fin 6 → R) :
    backSub6 c₀ g₁ g₂ g₃ g₄ g₅ (tame6 c₀ g₁ g₂ g₃ g₄ g₅ x) = x := by
  funext i; fin_cases i <;> simp [backSub6, tame6]

/-- The tame map undoes back-substitution. -/
theorem tame6_backSub6 (y : Fin 6 → R) :
    tame6 c₀ g₁ g₂ g₃ g₄ g₅ (backSub6 c₀ g₁ g₂ g₃ g₄ g₅ y) = y := by
  funext i; fin_cases i <;> simp [backSub6, tame6]

/-- The tame map is a bijection. -/
theorem tame6_bijective : Function.Bijective (tame6 c₀ g₁ g₂ g₃ g₄ g₅) :=
  ⟨Function.LeftInverse.injective (backSub6_tame6 c₀ g₁ g₂ g₃ g₄ g₅),
    Function.RightInverse.surjective (tame6_backSub6 c₀ g₁ g₂ g₃ g₄ g₅)⟩

/-- Encryption with the public key `F = A · G(B · X)` (§2.5, §4.3). -/
def encrypt (A B : Matrix (Fin 6) (Fin 6) R) (m : Fin 6 → R) : Fin 6 → R :=
  A *ᵥ tame6 c₀ g₁ g₂ g₃ g₄ g₅ (B *ᵥ m)

/-- Decryption: unmix, back-substitute, unmix (§4.4). -/
def decrypt (Ainv Binv : Matrix (Fin 6) (Fin 6) R) (c : Fin 6 → R) : Fin 6 → R :=
  Binv *ᵥ backSub6 c₀ g₁ g₂ g₃ g₄ g₅ (Ainv *ᵥ c)

/-- **Correctness (§5, §8).** For every plaintext, decryption inverts encryption. -/
theorem decrypt_encrypt (A B Ainv Binv : Matrix (Fin 6) (Fin 6) R)
    (hA : Ainv * A = 1) (hB : Binv * B = 1) (m : Fin 6 → R) :
    decrypt c₀ g₁ g₂ g₃ g₄ g₅ Ainv Binv (encrypt c₀ g₁ g₂ g₃ g₄ g₅ A B m) = m := by
  simp [decrypt, encrypt, Matrix.mulVec_mulVec, hA, backSub6_tame6, hB]

/-- A lower (triangular) perturbation is absorbed into the tame map: its `i`-th
coordinate depends only on `x₁, …, x_{i−1}`. -/
theorem tame6_add_lower (π₁ : R) (π₂ : R → R) (π₃ : R → R → R) (π₄ : R → R → R → R)
    (π₅ : R → R → R → R → R) (π₆ : R → R → R → R → R → R) (x : Fin 6 → R) :
    tame6 c₀ g₁ g₂ g₃ g₄ g₅ x +
        ![π₁, π₂ (x 0), π₃ (x 0) (x 1), π₄ (x 0) (x 1) (x 2), π₅ (x 0) (x 1) (x 2) (x 3),
          π₆ (x 0) (x 1) (x 2) (x 3) (x 4)] =
      tame6 (c₀ + π₁) (fun a => g₁ a + π₂ a) (fun a b => g₂ a b + π₃ a b)
        (fun a b c => g₃ a b c + π₄ a b c) (fun a b c d => g₄ a b c d + π₅ a b c d)
        (fun a b c d e => g₅ a b c d e + π₆ a b c d e) x := by
  funext i; fin_cases i <;> simp [tame6] <;> ring

/-- Correctness with a lower perturbation: decrypting with the absorbed maps
recovers every plaintext. -/
theorem decrypt_encrypt_lower_perturbed (π₁ : R) (π₂ : R → R) (π₃ : R → R → R)
    (π₄ : R → R → R → R) (π₅ : R → R → R → R → R) (π₆ : R → R → R → R → R → R)
    (A B Ainv Binv : Matrix (Fin 6) (Fin 6) R) (hA : Ainv * A = 1) (hB : Binv * B = 1)
    (m : Fin 6 → R) :
    let x := B *ᵥ m
    let c := A *ᵥ (tame6 c₀ g₁ g₂ g₃ g₄ g₅ x +
        ![π₁, π₂ (x 0), π₃ (x 0) (x 1), π₄ (x 0) (x 1) (x 2), π₅ (x 0) (x 1) (x 2) (x 3),
          π₆ (x 0) (x 1) (x 2) (x 3) (x 4)])
    decrypt (c₀ + π₁) (fun a => g₁ a + π₂ a) (fun a b => g₂ a b + π₃ a b)
        (fun a b c => g₃ a b c + π₄ a b c) (fun a b c d => g₄ a b c d + π₅ a b c d)
        (fun a b c d e => g₅ a b c d e + π₆ a b c d e) Ainv Binv c = m := by
  intro x c
  simp only [c, tame6_add_lower]
  exact decrypt_encrypt _ _ _ _ _ _ A B Ainv Binv hA hB m

end Classical

/-- A general perturbation can destroy invertibility. -/
theorem perturbed_not_injective [Nontrivial R] :
    ¬ Function.Injective (fun x : Fin 6 → R =>
      tame6 0 (fun _ => 0) (fun _ _ => 0) (fun _ _ _ => 0) (fun _ _ _ _ => 0)
        (fun _ _ _ _ _ => 0) x + Pi.single 0 (-x 0)) := by
  intro h
  have := congrFun (@h (Pi.single 0 1) 0 (by funext i; fin_cases i <;> simp [tame6])) 0
  simp at this

/-- The refined-anchor secret map of §2.1 / §4.1. -/
def refined6 (α : Fin 6 → R) (φ : (Fin 6 → R) → R) (g₁ : R → R) (g₂ : R → R → R)
    (g₃ : R → R → R → R) (g₄ : R → R → R → R → R) (g₅ : R → R → R → R → R → R)
    (x : Fin 6 → R) : Fin 6 → R :=
  ![x 0 + (α 1 * x 1 + α 2 * x 2 + α 3 * x 3 + α 4 * x 4 + α 5 * x 5) + φ x,
    x 1 + g₁ (x 0), x 2 + g₂ (x 0) (x 1), x 3 + g₃ (x 0) (x 1) (x 2),
    x 4 + g₄ (x 0) (x 1) (x 2) (x 3), x 5 + g₅ (x 0) (x 1) (x 2) (x 3) (x 4)]

/-- The refined anchor does not preserve invertibility. -/
theorem refined6_not_injective [Nontrivial R] :
    ¬ Function.Injective (refined6 (R := R) (Pi.single 1 1) (fun _ => 0) id
      (fun _ _ => 0) (fun _ _ _ => 0) (fun _ _ _ _ => 0) (fun _ _ _ _ _ => 0)) := by
  intro h
  have := @h ![1, -1, 0, 0, 0, 0] 0 (by funext i; fin_cases i <;> simp [refined6])
  have := congrFun this 0
  simp at this

/-- In two variables the refined Jacobian `[[1, α], [c, 1]]` has determinant `1 − αc`. -/
theorem refined_det_two (α c : R) :
    !![1, α; c, 1].det = 1 - α * c := by
  simp [Matrix.det_fin_two]

/-- The 6D refined Jacobian with `α₂ = α` in the first row and `∂g₁/∂x₁ = c` below the
diagonal has determinant `1 − αc`, not `1`. -/
theorem refined6_jac_det (α c : R) :
    (1 + Matrix.single 0 1 α + Matrix.single 1 0 c : Matrix (Fin 6) (Fin 6) R).det
      = 1 - α * c := by
  rw [Matrix.det_succ_row_zero]
  simp [Fin.sum_univ_succ, Matrix.det_succ_row_zero, Matrix.single_apply, Matrix.one_apply,
    Fin.succAbove]
  ring

end Xfiles.LASLS
