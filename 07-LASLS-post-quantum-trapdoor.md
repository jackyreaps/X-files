# 07 — LASLS Post-Quantum Trapdoor

## 1. Overview

LASLS is a candidate post-quantum trapdoor based on the hierarchical Jacobian.
This document specifies the construction and its correctness.

**Correction (October 2026).** The refined anchor of §2.1 does **not** preserve
invertibility and `det J = 1` does **not** hold for it. The exact criterion and
the repair are proved in `LASLS_Anchor.lean`.

## 2. Construction

### 2.1 Refined Anchor

The refined first coordinate is

    P₁ = x₁ + α₂x₂ + … + α₆x₆ + φ₁(X).

The other coordinates are tame:

    P_{i+1} = x_{i+1} + g_i(x₁, …, x_i).

**This is not invertible in general.** Counterexample (`refined6_not_injective`):
with `α₂ = 1`, `g₁ = id`, and everything else zero, `P₁ = P₂ = x₁ + x₂`.

**Exact bijectivity criterion** (`anchor6_bijective_iff`): the secret map is a
bijection iff, for every ciphertext `y`, the one-variable anchor equation

    t ↦ a_y(t) := F(t, x₂(t), …, x₆(t)) = y₁

is a bijection of the ring.

**Repair condition** (`refined6_eq_anchored`, `decrypt_encrypt_refined_fixed`):
take

    φ₁(X) = α₂ g₁(x₁) + α₃ g₂(x₁,x₂) + … + α₆ g₅(x₁,…,x₅)
          + ψ₀(P₂(X), …, P₆(X))

for an arbitrary `ψ₀`. Then `P₁ = x₁ + Σ αⱼ Pⱼ(X) + ψ₀(P₂(X), …, P₆(X))`, the
anchor equation reads `t + ψ(y₂, …, y₆) = y₁`, and the map is bijective.

### 2.2 Jacobian Determinant

For the classical tame map (no refined anchor), `det J = 1`.

For the refined anchor, `det J = 1 − α₂ c` where `c = ∂g₁/∂x₁`. So `det J = 1`
fails as soon as `α₂ ≠ 0` and `c ≠ 0` (`refined6_jac_det`).

For the repaired family, the Jacobian is a product of a unit upper-triangular
and a unit lower-triangular matrix, hence `det J = 1`
(`det_upperRow_mul_lower`). The chain-rule identification of the Jacobian of
the repaired map with this product is not formalised.

### 2.3 Perturbation

A general perturbation `Π : 𝔽_qⁿ → V` is **not** recovered by back-substitution.
With `G = id` and the degree-1, rank-1 perturbation `Π(X) = −x₁ e₁`, the map
`G + Π` is not injective (`perturbed_not_injective`).

The sufficient condition for correctness is that the `i`-th coordinate of `Π`
depends only on `x₁, …, x_{i−1}` for `i ≥ 2` (its first coordinate is
arbitrary). Under this condition, `Π` is absorbed into the `g_i` and the map
remains bijective (`tame6_add_lower`, `refined6_add_perturbation_eq_anchor6`).

The "converges within `O(r)` iterations" claim is removed; over `𝔽_q` a
general perturbation is decrypted by enumerating `q^r` values, which the
legitimate user cannot do either.

## 3. Keys

### 3.1 Private Key

The `g_i`, the `α`, the `φ₁`, the mixing matrices `A`, `B`.

### 3.2 Public Key

    F = A · G(B · X).

### 3.3 Mixing

`A`, `B` invertible over `𝔽_q`.

## 4. Encryption and Decryption

### 4.1 Encryption

Given plaintext `m`:

    c = A · G(B · m).

### 4.2 Decryption (Classical, Unperturbed)

    x = B⁻¹ · c
    m = backSub6(x)
    m = A⁻¹ · m

Correctness (`decrypt_encrypt`): `decrypt (encrypt m) = m` whenever
`A⁻¹A = 1` and `B⁻¹B = 1`.

### 4.3 Decryption (Repaired Refined)

Unmix, solve the anchor equation for `x₁` via

    x₁ = y₁ − Σ αⱼ yⱼ − ψ₀(y₂, …, y₆),

then run the cascade. Correctness: `decrypt_encrypt_refined_fixed`.

### 4.4 Back-Substitution

For the classical tame map, back-substitution is exact
(`backSub6_tame6`, `tame6_backSub6`).

For the refined anchor, back-substitution is exact only under the repair
condition of §2.1. A general perturbation is not recovered.

## 5. Correctness

Classical: `decrypt (encrypt m) = m` (`decrypt_encrypt`).

Repaired refined: `decrypt (encrypt m) = m` (`decrypt_encrypt_refined_fixed`).

The correctness is algebraic and holds over any commutative ring, in particular
over every `𝔽_q`.

## 6. Security

The security estimates in this section are attack-cost arithmetic about
external algorithms and are **not** formalised. The correctness theorems in
`LASLS_Correctness.lean` and `LASLS_Anchor.lean` say nothing about security.

## 7. Parameters

Recommended `q` and `n` (unchanged).

## 8. Formalisation

The correctness theorem exists:

- `Xfiles.LASLS.decrypt_encrypt` — classical correctness.
- `Xfiles.LASLS.Anchor.decrypt_encrypt_refined_fixed` — repaired refined
  correctness.

The early sketch using `Vector (Fin q) n` with matrix multiplication is
ill-typed: `Fin q` is not a field and `Vector` has no `*` with matrices. Use
`Fin n → ZMod q` (with `q` prime) or any field with `Matrix.mulVec`.

## 9. Notes

### 9.1 Correctness Under Refinement

Back-substitution does **not** remain valid for the general refined anchor.
The exact criterion is §2.1.

### 9.2 Speculation

(Section retained only if `LASLS-Speculative.md` is present; otherwise removed.)

## 10. Summary

- Classical LASLS: correctness proved (`decrypt_encrypt`).
- Refined anchor §2.1: correctness fails as stated; exact criterion and repair
  in `LASLS_Anchor.lean`.
- Perturbations §2.3: correctness fails for a general `Π`; sufficient condition
  is the lower-triangular form.
- Security estimates §6: not formalised.
