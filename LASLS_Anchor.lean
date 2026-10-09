module

public import Xfiles.LASLS

/-!
# LASLS: the exact condition that makes the refined anchor decryptable

**Status: proved (algebra over any commutative ring; no security statement).**

`Xfiles.LASLS` shows that the refined first coordinate of
`07-LASLS-post-quantum-trapdoor.md` (§2.1, §4.1),
`P₁ = x₁ + α₂x₂ + … + α₆x₆ + φ₁(X)`, can break both invertibility and `det J = 1`.
This module gives the condition on `α`, `φ₁` and the perturbation `Π` that restores
correctness, and one explicit family for which `det J = 1` also holds.

**The exact criterion.** Write any secret map whose last five coordinates are tame,
`P_{i+1} = x_{i+1} + g_i(x₁, …, x_i)`, and whose first coordinate `F(X)` is
arbitrary, as `anchor6 F g`. For a ciphertext `y` and a trial value `t` for `x₁`, the
cascade `x₂ = y₂ − g₁(t)`, `x₃ = y₃ − g₂(t, x₂)`, … is forced; substituting it into
`F` gives the *anchor equation* `a_y(t) := F(t, x₂(t), …, x₆(t)) = y₁`.

* `anchor6_bijective_iff`: the secret map is a bijection **iff** for every `y` the
  one-variable map `t ↦ a_y(t)` is a bijection.
* `decryptAnchor_encrypt_of_solve`: if a solver returns a root of the anchor equation
  and the root is unique, decrypt-after-encrypt is the identity.
* `refined6_eq_anchor6`, `refined6_add_perturbation_eq_anchor6`: the refined map of
  §2.1, with or without a perturbation, is of this form.

**A family where everything works.** Take
`φ₁(X) = α₂ g₁(x₁) + α₃ g₂(x₁,x₂) + … + α₆ g₅(x₁,…,x₅) + ψ₀(P₂(X), …, P₆(X))`
for an arbitrary `ψ₀`. Then `P₁ = x₁ + Σ αⱼ Pⱼ(X) + ψ₀(P₂(X), …, P₆(X))`:

* `refined6_eq_anchored`: the refined map is the composite of the tame map with an
  upper elementary map, and `anchorFn_anchored`: the anchor equation reads
  `t + const = y₁`.
* `refined6_fixed_bijective`, `decrypt_encrypt_refined_fixed`: decryption is
  `x₁ = y₁ − Σ αⱼ yⱼ − ψ₀(y₂, …, y₆)` followed by the usual cascade, and recovers
  every plaintext.
* `det_upper_mul_lower`, `det_upperRow_mul_lower`: at every point the Jacobian of
  such a composite is `E · L` with `E` unit upper triangular and `L` unit lower
  triangular; every such product has determinant `1`.

**Caveat on what the repair buys.** `anchored_linear_eq_upperRow`: with no nonlinear
`ψ₀`, the repaired map is the classical tame map followed by a linear map, so its
public key is a classical-anchor public key with mixing matrix `A · upperRow α`. Only
a nonlinear `ψ₀` changes the public key's form. This is a correctness statement; it
says nothing about security.

**The counterexample, revisited.** `counterexample_eq_anchor6`,
`anchorFn_counterexample`: for `α₂ = 1`, `g₁ = id`, `φ₁ = 0` the anchor equation is
`a_y(t) = y₂`, constant in `t`, which is why injectivity fails.
`counterexample_repaired_bijective`: the repair `φ₁(X) = α₂ g₁(x₁) = x₁` makes the
same data a bijection.

**Indexing note.** Lean's `α j` is the document's `α_{j+1}` (0-based vs 1-based).

The document's security estimates are not formalised.
-/

@[expose] public section

set_option autoImplicit false

open Matrix

namespace Xfiles.LASLS.Anchor

variable {R : Type*} [CommRing R]

section Anchor

variable (g₁ : R → R) (g₂ : R → R → R) (g₃ : R → R → R → R)
    (g₄ : R → R → R → R → R) (g₅ : R → R → R → R → R → R)

/-- A secret map with an arbitrary first coordinate `F(X)` and tame coordinates
`P_{i+1} = x_{i+1} + g_i(x₁, …, x_i)` below it. -/
def anchor6 (F : (Fin 6 → R) → R) (x : Fin 6 → R) : Fin 6 → R :=
  ![F x, x 1 + g₁ (x 0), x 2 + g₂ (x 0) (x 1), x 3 + g₃ (x 0) (x 1) (x 2),
    x 4 + g₄ (x 0) (x 1) (x 2) (x 3), x 5 + g₅ (x 0) (x 1) (x 2) (x 3) (x 4)]

/-- The forced cascade for a ciphertext `y` and a trial value `t` of `x₁`. -/
def cascade6 (y : Fin 6 → R) (t : R) : Fin 6 → R :=
  let x₂ := y 1 - g₁ t
  let x₃ := y 2 - g₂ t x₂
  let x₄ := y 3 - g₃ t x₂ x₃
  let x₅ := y 4 - g₄ t x₂ x₃ x₄
  let x₆ := y 5 - g₅ t x₂ x₃ x₄ x₅
  ![t, x₂, x₃, x₄, x₅, x₆]

/-- The left side of the anchor equation `a_y(t) = y₁`. -/
def anchorFn (F : (Fin 6 → R) → R) (y : Fin 6 → R) (t : R) : R :=
  F (cascade6 g₁ g₂ g₃ g₄ g₅ y t)

variable (F : (Fin 6 → R) → R)

theorem cascade6_anchor6 (x : Fin 6 → R) :
    cascade6 g₁ g₂ g₃ g₄ g₅ (anchor6 g₁ g₂ g₃ g₄ g₅ F x) (x 0) = x := by
  funext i; fin_cases i <;> simp [cascade6, anchor6]

theorem anchor6_cascade6 (y : Fin 6 → R) (t : R) :
    anchor6 g₁ g₂ g₃ g₄ g₅ F (cascade6 g₁ g₂ g₃ g₄ g₅ y t) =
      Function.update y 0 (anchorFn g₁ g₂ g₃ g₄ g₅ F y t) := by
  funext i; fin_cases i <;> simp [cascade6, anchor6, anchorFn, Function.update]

theorem cascade6_update (y : Fin 6 → R) (v : R) :
    cascade6 g₁ g₂ g₃ g₄ g₅ (Function.update y 0 v) = cascade6 g₁ g₂ g₃ g₄ g₅ y := by
  funext t i; fin_cases i <;> simp [cascade6, Function.update]

/-- The anchor equation holds at the true first coordinate. -/
theorem anchorFn_anchor6 (x : Fin 6 → R) :
    anchorFn g₁ g₂ g₃ g₄ g₅ F (anchor6 g₁ g₂ g₃ g₄ g₅ F x) (x 0) =
      anchor6 g₁ g₂ g₃ g₄ g₅ F x 0 := by
  rw [anchorFn, cascade6_anchor6]; rfl

/-- **Exact criterion.** The secret map is a bijection iff every anchor equation
`t ↦ a_y(t)` is a bijection of the ring. -/
theorem anchor6_bijective_iff :
    Function.Bijective (anchor6 g₁ g₂ g₃ g₄ g₅ F) ↔
      ∀ y, Function.Bijective (anchorFn g₁ g₂ g₃ g₄ g₅ F y) := by
  constructor
  · intro ⟨hinj, hsurj⟩ y
    refine ⟨fun t s hts => ?_, fun v => ?_⟩
    · have h := hinj (a₁ := cascade6 g₁ g₂ g₃ g₄ g₅ y t)
        (a₂ := cascade6 g₁ g₂ g₃ g₄ g₅ y s) (by rw [anchor6_cascade6, anchor6_cascade6, hts])
      simpa [cascade6] using congrFun h 0
    · obtain ⟨x, hx⟩ := hsurj (Function.update y 0 v)
      refine ⟨x 0, ?_⟩
      have h := anchorFn_anchor6 g₁ g₂ g₃ g₄ g₅ F x
      rw [hx, anchorFn, cascade6_update] at h
      simpa using h
  · intro h
    refine ⟨fun x x' hxx => ?_, fun y => ?_⟩
    · have e1 := anchorFn_anchor6 g₁ g₂ g₃ g₄ g₅ F x
      have e2 := anchorFn_anchor6 g₁ g₂ g₃ g₄ g₅ F x'
      rw [hxx] at e1
      have h0 : x 0 = x' 0 := (h _).1 (e1.trans e2.symm)
      rw [← cascade6_anchor6 g₁ g₂ g₃ g₄ g₅ F x, ← cascade6_anchor6 g₁ g₂ g₃ g₄ g₅ F x',
        hxx, h0]
    · obtain ⟨t, ht⟩ := (h y).2 (y 0)
      exact ⟨cascade6 g₁ g₂ g₃ g₄ g₅ y t, by rw [anchor6_cascade6, ht]; simp⟩

/-- Decryption with a solver for the anchor equation. -/
def decryptAnchor (solve : (Fin 6 → R) → R) (Ainv Binv : Matrix (Fin 6) (Fin 6) R)
    (c : Fin 6 → R) : Fin 6 → R :=
  Binv *ᵥ cascade6 g₁ g₂ g₃ g₄ g₅ (Ainv *ᵥ c) (solve (Ainv *ᵥ c))

/-- **Correctness with a solver.** If `solve` returns a root of the anchor equation
and that root is unique, decryption inverts encryption. -/
theorem decryptAnchor_encrypt_of_solve (solve : (Fin 6 → R) → R)
    (hsolve : ∀ y, anchorFn g₁ g₂ g₃ g₄ g₅ F y (solve y) = y 0)
    (huniq : ∀ y, Function.Injective (anchorFn g₁ g₂ g₃ g₄ g₅ F y))
    (A B Ainv Binv : Matrix (Fin 6) (Fin 6) R) (hA : Ainv * A = 1) (hB : Binv * B = 1)
    (m : Fin 6 → R) :
    decryptAnchor g₁ g₂ g₃ g₄ g₅ solve Ainv Binv
      (A *ᵥ anchor6 g₁ g₂ g₃ g₄ g₅ F (B *ᵥ m)) = m := by
  set x := B *ᵥ m
  have hy : Ainv *ᵥ (A *ᵥ anchor6 g₁ g₂ g₃ g₄ g₅ F x) = anchor6 g₁ g₂ g₃ g₄ g₅ F x := by
    simp [Matrix.mulVec_mulVec, hA]
  have hs : solve (anchor6 g₁ g₂ g₃ g₄ g₅ F x) = x 0 :=
    huniq _ ((hsolve _).trans (anchorFn_anchor6 g₁ g₂ g₃ g₄ g₅ F x).symm)
  simp only [decryptAnchor, hy, hs, cascade6_anchor6, x, Matrix.mulVec_mulVec, hB,
    Matrix.one_mulVec]

/-- The refined map of §2.1 is an anchored map. -/
theorem refined6_eq_anchor6 (α : Fin 6 → R) (φ : (Fin 6 → R) → R) :
    refined6 α φ g₁ g₂ g₃ g₄ g₅ = anchor6 g₁ g₂ g₃ g₄ g₅
      (fun x => x 0 + (α 1 * x 1 + α 2 * x 2 + α 3 * x 3 + α 4 * x 4 + α 5 * x 5) + φ x) :=
  rfl

/-- The refined map plus a perturbation `Π` is still an anchored map. -/
theorem refined6_add_perturbation_eq_anchor6 (α : Fin 6 → R) (φ : (Fin 6 → R) → R)
    (π₁ : (Fin 6 → R) → R) (π₂ : R → R) (π₃ : R → R → R) (π₄ : R → R → R → R)
    (π₅ : R → R → R → R → R) (π₆ : R → R → R → R → R → R) (x : Fin 6 → R) :
    refined6 α φ g₁ g₂ g₃ g₄ g₅ x +
        ![π₁ x, π₂ (x 0), π₃ (x 0) (x 1), π₄ (x 0) (x 1) (x 2), π₅ (x 0) (x 1) (x 2) (x 3),
          π₆ (x 0) (x 1) (x 2) (x 3) (x 4)] =
      anchor6 (fun a => g₁ a + π₂ a) (fun a b => g₂ a b + π₃ a b)
        (fun a b c => g₃ a b c + π₄ a b c) (fun a b c d => g₄ a b c d + π₅ a b c d)
        (fun a b c d e => g₅ a b c d e + π₆ a b c d e)
        (fun x => x 0 + (α 1 * x 1 + α 2 * x 2 + α 3 * x 3 + α 4 * x 4 + α 5 * x 5) + φ x
          + π₁ x) x := by
  funext i; fin_cases i <;> simp [refined6, anchor6] <;> ring

/-! ### The repaired family -/

/-- The anchored first coordinate `x₁ + ψ(P₂(X), …, P₆(X))`. -/
def anchoredFirst (ψ : R → R → R → R → R → R) (x : Fin 6 → R) : R :=
  x 0 + ψ (x 1 + g₁ (x 0)) (x 2 + g₂ (x 0) (x 1)) (x 3 + g₃ (x 0) (x 1) (x 2))
    (x 4 + g₄ (x 0) (x 1) (x 2) (x 3)) (x 5 + g₅ (x 0) (x 1) (x 2) (x 3) (x 4))

/-- For the anchored first coordinate the anchor equation is `t + ψ(y₂, …, y₆) = y₁`. -/
theorem anchorFn_anchored (ψ : R → R → R → R → R → R) (y : Fin 6 → R) (t : R) :
    anchorFn g₁ g₂ g₃ g₄ g₅ (anchoredFirst g₁ g₂ g₃ g₄ g₅ ψ) y t =
      t + ψ (y 1) (y 2) (y 3) (y 4) (y 5) := by
  simp [anchorFn, anchoredFirst, cascade6]

/-- The repaired `φ₁`. -/
def repairedPhi (α : Fin 6 → R) (ψ₀ : R → R → R → R → R → R) (x : Fin 6 → R) : R :=
  α 1 * g₁ (x 0) + α 2 * g₂ (x 0) (x 1) + α 3 * g₃ (x 0) (x 1) (x 2)
    + α 4 * g₄ (x 0) (x 1) (x 2) (x 3) + α 5 * g₅ (x 0) (x 1) (x 2) (x 3) (x 4)
    + ψ₀ (x 1 + g₁ (x 0)) (x 2 + g₂ (x 0) (x 1)) (x 3 + g₃ (x 0) (x 1) (x 2))
        (x 4 + g₄ (x 0) (x 1) (x 2) (x 3)) (x 5 + g₅ (x 0) (x 1) (x 2) (x 3) (x 4))

/-- Under the repair condition the refined map is the anchored map. -/
theorem refined6_eq_anchored (α : Fin 6 → R) (ψ₀ : R → R → R → R → R → R) :
    refined6 α (repairedPhi g₁ g₂ g₃ g₄ g₅ α ψ₀) g₁ g₂ g₃ g₄ g₅ =
      anchor6 g₁ g₂ g₃ g₄ g₅
        (anchoredFirst g₁ g₂ g₃ g₄ g₅
          (fun u₂ u₃ u₄ u₅ u₆ => α 1 * u₂ + α 2 * u₃ + α 3 * u₄ + α 4 * u₅ + α 5 * u₆
            + ψ₀ u₂ u₃ u₄ u₅ u₆)) := by
  rw [refined6_eq_anchor6]
  congr 1
  funext x
  simp only [anchoredFirst, repairedPhi]
  ring

/-- Under the repair condition the refined map is a bijection. -/
theorem refined6_fixed_bijective (α : Fin 6 → R) (ψ₀ : R → R → R → R → R → R) :
    Function.Bijective (refined6 α (repairedPhi g₁ g₂ g₃ g₄ g₅ α ψ₀) g₁ g₂ g₃ g₄ g₅) := by
  rw [refined6_eq_anchored g₁ g₂ g₃ g₄ g₅ α ψ₀, anchor6_bijective_iff]
  intro y
  simp only [funext (anchorFn_anchored g₁ g₂ g₃ g₄ g₅ _ y)]
  exact (Equiv.addRight _).bijective

/-- The solver for the repaired scheme. -/
def refinedSolver (α : Fin 6 → R) (ψ₀ : R → R → R → R → R → R) (y : Fin 6 → R) : R :=
  y 0 - (α 1 * y 1 + α 2 * y 2 + α 3 * y 3 + α 4 * y 4 + α 5 * y 5
    + ψ₀ (y 1) (y 2) (y 3) (y 4) (y 5))

/-- **Correctness of the repaired refined scheme.** Decrypt by
`x₁ = y₁ − Σ αⱼ yⱼ − ψ₀(y₂, …, y₆)`, then the cascade; every plaintext is recovered. -/
theorem decrypt_encrypt_refined_fixed (α : Fin 6 → R) (ψ₀ : R → R → R → R → R → R)
    (A B Ainv Binv : Matrix (Fin 6) (Fin 6) R) (hA : Ainv * A = 1) (hB : Binv * B = 1)
    (m : Fin 6 → R) :
    decryptAnchor g₁ g₂ g₃ g₄ g₅ (refinedSolver α ψ₀) Ainv Binv
      (A *ᵥ refined6 α (repairedPhi g₁ g₂ g₃ g₄ g₅ α ψ₀) g₁ g₂ g₃ g₄ g₅ (B *ᵥ m)) = m := by
  rw [refined6_eq_anchored g₁ g₂ g₃ g₄ g₅ α ψ₀]
  refine decryptAnchor_encrypt_of_solve g₁ g₂ g₃ g₄ g₅ _ (refinedSolver α ψ₀)
    (fun y => ?_) (fun y => ?_) A B Ainv Binv hA hB m
  · simp [refinedSolver, anchorFn_anchored]; ring
  · intro s t hst
    simpa [anchorFn_anchored] using hst

end Anchor

/-! ### The counterexample and its repair, through the criterion -/

/-- The counterexample of `refined6_not_injective` is the anchored map with first
coordinate `x₁ + x₂`. -/
theorem counterexample_eq_anchor6 :
    refined6 (R := R) (Pi.single 1 1) (fun _ => 0) id (fun _ _ => 0) (fun _ _ _ => 0)
        (fun _ _ _ _ => 0) (fun _ _ _ _ _ => 0) =
      anchor6 id (fun _ _ => 0) (fun _ _ _ => 0) (fun _ _ _ _ => 0) (fun _ _ _ _ _ => 0)
        (fun x => x 0 + x 1) := by
  rw [refined6_eq_anchor6]; congr 1; funext x; simp

/-- The counterexample's anchor equation `a_y(t) = y₂` does not depend on `t`. -/
theorem anchorFn_counterexample (y : Fin 6 → R) (t : R) :
    anchorFn id (fun _ _ => 0) (fun _ _ _ => 0) (fun _ _ _ _ => 0) (fun _ _ _ _ _ => 0)
      (fun x => x 0 + x 1) y t = y 1 := by
  simp [anchorFn, cascade6]

/-- The same `α₂ = 1`, `g₁ = id`, repaired by `φ₁(X) = α₂ g₁(x₁) = x₁`. -/
theorem counterexample_repaired_bijective :
    Function.Bijective (refined6 (R := R) (Pi.single 1 1) (fun x => x 0) id
      (fun _ _ => 0) (fun _ _ _ => 0) (fun _ _ _ _ => 0) (fun _ _ _ _ _ => 0)) :=
  refined6_fixed_bijective _ _ _ _ _ _ (Pi.single 1 1) (fun _ _ _ _ _ => 0)

/-! ### Determinant of the repaired Jacobian -/

/-- A unit upper-triangular matrix times a unit lower-triangular matrix has
determinant `1`. -/
theorem det_upper_mul_lower {n : ℕ} (U L : Matrix (Fin n) (Fin n) R)
    (hU : U.BlockTriangular id) (hL : L.BlockTriangular OrderDual.toDual)
    (hUd : ∀ i, U i i = 1) (hLd : ∀ i, L i i = 1) : (U * L).det = 1 := by
  rw [Matrix.det_mul, Matrix.det_of_upperTriangular hU, Matrix.det_of_lowerTriangular L hL]
  simp [hUd, hLd]

/-- The upper elementary factor: identity plus the first row `(0, a₂, …, a₆)`. -/
def upperRow (a : Fin 6 → R) : Matrix (Fin 6) (Fin 6) R :=
  Matrix.of fun i j => if i = j then 1 else if i = 0 then a j else 0

/-- **`det J = 1` for the repaired family.** The linear-algebra statement:
`upperRow a · L` has determinant `1` for any unit lower-triangular `L`. The
chain-rule identification of the Jacobian of the repaired map with this product
is not formalised here. -/
theorem det_upperRow_mul_lower (a : Fin 6 → R) (L : Matrix (Fin 6) (Fin 6) R)
    (hL : L.BlockTriangular OrderDual.toDual) (hLd : ∀ i, L i i = 1) :
    (upperRow a * L).det = 1 := by
  refine det_upper_mul_lower _ L ?_ hL (fun i => by simp [upperRow]) hLd
  intro i j hij
  have hi : i ≠ 0 := by
    rintro rfl; exact absurd hij (by simp [Fin.not_lt_zero])
  have hne : i ≠ j := fun h => by subst h; exact lt_irrefl _ hij
  simp [upperRow, hi, hne]

/-- The linear part of the refinement is absorbed into the mixing matrix. -/
theorem anchored_linear_eq_upperRow (α : Fin 6 → R) (g₁ : R → R) (g₂ : R → R → R)
    (g₃ : R → R → R → R) (g₄ : R → R → R → R → R) (g₅ : R → R → R → R → R → R)
    (A : Matrix (Fin 6) (Fin 6) R) (x : Fin 6 → R) :
    A *ᵥ anchor6 g₁ g₂ g₃ g₄ g₅
        (anchoredFirst g₁ g₂ g₃ g₄ g₅
          (fun u₂ u₃ u₄ u₅ u₆ => α 1 * u₂ + α 2 * u₃ + α 3 * u₄ + α 4 * u₅ + α 5 * u₆)) x =
      (A * upperRow α) *ᵥ tame6 0 g₁ g₂ g₃ g₄ g₅ x := by
  rw [← Matrix.mulVec_mulVec]
  congr 1
  funext i
  fin_cases i <;>
    simp [anchor6, anchoredFirst, tame6, upperRow, Matrix.mulVec, dotProduct, Fin.sum_univ_six]
  ring

end Xfiles.LASLS.Anchor
