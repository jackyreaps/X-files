# 07 — LASLS: Lower-Anchor Skew-Linear Stacking

**A Perturbed Triangular Multivariate Cryptosystem**

**Author:** JackyReaps / AnooBus  
**Date of original posts:** 26 July 2026  
**Refined specification:** October 2026  
**Correction note:** 8–9 October 2026 — refined-anchor claims repaired per Lean counterexamples and repair theorems (`Xfiles.LASLS`, `Xfiles.LASLS.Anchor`)

**Status:** Research specification. Not standardized. Not recommended for deployment.

---

## 0. Status and Scope

This document specifies LASLS (Lower-Anchor Skew-Linear Stacking), a public-key cryptosystem in the Multivariate Public-Key Cryptography (MPKC) family. LASLS is a perturbed triangular multivariate scheme derived from the tame automorphism construction.

**Relationship to prior work.** LASLS is structurally a variant of the TTM (Triangle Plus Minus) family of tame automorphism cryptosystems. The specific contributions here are:

1. The hierarchical Jacobian embedding from the X-files framework (`02-master-framework.md`).
2. An explicit internal perturbation construction (with a precise invertibility condition).
3. A machine-checkable correctness proof (Lean), including counterexamples to earlier unrestricted refined-anchor wording and a repaired family.

**Security posture.** Security rests on the estimated hardness of a specific MinRank instance combined with resistance to linearization equations under perturbation. No security proof exists. See §6 for the full caveats.

**Correction posture (October 2026).** Two claims in the original refined-anchor wording were false as stated: that an arbitrary first-row refinement preserves invertibility (back-substitution), and that `det J_G = 1` holds for an arbitrary first row. Both are refuted by Lean theorems over any commutative ring (hence over every finite field). The repaired form in §2.1 restores both properties. See §2.1–§2.3, §4.4, §5.

---

## 1. Notation and Parameters

| Symbol | Meaning |
|--------|---------|
| \( q \) | Field size (prime power) |
| \( n \) | Dimension (number of variables) |
| \( d \) | Maximum degree of secret polynomials |
| \( r \) | Perturbation subspace dimension |
| \( \mathbb{F}_q \) | Finite field of order \( q \) |
| \( X \) | Column vector \( (x_1, \dots, x_n)^\top \) |
| \( M \) | Plaintext block in \( \mathbb{F}_q^n \) |
| \( C \) | Ciphertext block in \( \mathbb{F}_q^n \) |

### Recommended Parameter Regime

| Parameter | Value | Rationale |
|-----------|-------|---------|
| \( n \) | 6 | Minimum viable for 128-bit classical security target |
| \( q \) | \( 2^{31} \) or 31-bit prime | Required for MinRank resistance |
| \( d \) | 5 | Balances expressiveness and attack surface |
| \( r \) | 5 | Perturbation dimension for linearization resistance |

The 4-dimensional construction is retained in §3 for expositional clarity but is **not secure** at practical field sizes. See §6.3.

---

## 2. Cryptographic Primitives

### 2.1 Secret Tame Map

The secret map \( G: \mathbb{F}_q^n \to \mathbb{F}_q^n \) is built from a classical tame (unit lower-triangular) map \( T \) and a first-coordinate refinement.

**Classical cascade coordinates:**

```
P_2(X) = x_2 + g_1(x_1)
P_3(X) = x_3 + g_2(x_1, x_2)
...
P_n(X) = x_n + g_{n-1}(x_1, ..., x_{n-1})
```

where \( g_1, \dots, g_{n-1} \) are secret polynomials of degree at most \( d \).

**Refined first coordinate (repaired form).** The classical construction sets \( P_1(X) = x_1 \). The refined construction sets

\[
P_1(X) = x_1 + \psi\bigl(P_2(X), \dots, P_n(X)\bigr)
\]

for a secret polynomial \( \psi \). Written out, this is

\[
P_1(X) = x_1 + \alpha_2 x_2 + \cdots + \alpha_n x_n + \varphi_1(X)
\]

with

\[
\varphi_1(X) = \sum_{j=2}^{n} \alpha_j\, g_{j-1}(x_1,\dots,x_{j-1}) + \psi_0\bigl(P_2(X),\dots,P_n(X)\bigr),
\]

where \( \psi(u) = \sum_j \alpha_j u_j + \psi_0(u) \) and \( \alpha_2,\dots,\alpha_n \in \mathbb{F}_q \).

**Note on the anchor.** An arbitrary \( \varphi_1 \) does **not** preserve invertibility. The map is a bijection exactly when, for every ciphertext \( y \) (after unmixing), the one-variable **anchor equation**

\[
a_y(t) := t + \alpha_2 x_2(t) + \cdots + \alpha_n x_n(t) + \varphi_1\bigl(t, x_2(t),\dots,x_n(t)\bigr) = y_1
\]

has a unique solution \( t \) in the field (over \( \mathbb{F}_q \): a permutation polynomial in \( t \)). Here the lower coordinates \( x_i(t) \) are forced by the cascade from the trial value \( t \) of \( x_1 \).

If \( \psi_0 = 0 \), the refinement is purely linear and is absorbed into the mixing matrix \( A \) (public key form unchanged relative to a classical-anchor key with \( A \) replaced by \( A\cdot E_\alpha \)). Only a nonlinear \( \psi_0 \) changes the form of the public key. Lean: `Xfiles.LASLS.Anchor.refined6_eq_anchored`, `Xfiles.LASLS.Anchor.anchorFn_anchored`, `Xfiles.LASLS.Anchor.refined6_fixed_bijective`, `Xfiles.LASLS.Anchor.anchored_linear_eq_upperRow`.

**Counterexamples (arbitrary refinement).** With \( \alpha_2 = 1 \), \( g_1 = \mathrm{id} \), and all other \( \alpha_j \), \( g_i \), \( \varphi_1 \) zero, one has \( P_1 = P_2 = x_1 + x_2 \), so distinct plaintexts encrypt to the same ciphertext (not injective). Lean: `Xfiles.LASLS.refined6_not_injective`. The corresponding Jacobian determinant is \( 1 - \alpha c \) when the first row carries \( \alpha_2 = \alpha \) and the second row carries \( \partial g_1/\partial x_1 = c \). Lean: `Xfiles.LASLS.refined6_jac_det`, `Xfiles.LASLS.refined_det_two`.

### 2.2 Secret Jacobian

For the refined anchor in the form of §2.1,

\[
G = E_\psi \circ T,
\]

where \( T \) is the classical tame map and \( E_\psi(u) = \bigl(u_1 + \psi(u_2,\dots,u_n),\, u_2,\dots,u_n\bigr) \). Hence

\[
J_G(X) = J_{E_\psi}\bigl(T(X)\bigr)\cdot J_T(X),
\]

a unit upper-triangular matrix times a unit lower-triangular one, so \( \det J_G = 1 \). Lean: `Xfiles.LASLS.Anchor.det_upper_mul_lower`, `Xfiles.LASLS.Anchor.det_upperRow_mul_lower`.

For an **arbitrary** first row this fails: with \( \alpha_2 = \alpha \) and \( \partial g_1/\partial x_1 = c \), \( \det J_G = 1 - \alpha c \).

The spectrum is \( \{1,\dots,1\} \) for the classical pure tame map. The refined anchored form keeps \( \det = 1 \) while the linear coefficients and \( \psi_0 \) alter the explicit matrix entries.

### 2.3 Perturbation Map

Choose an \( r \)-dimensional subspace \( V \subset \mathbb{F}_q^n \) and a random linear projection \( \pi_V: \mathbb{F}_q^n \to V \). Define a polynomial map

```
Π: F_q^n → V
```

with degree at most \( d \). The perturbed secret map is

```
G_pert(X) = G(X) + Π(X)
```

**Invertibility under perturbation.** A general perturbation \( \Pi \) can destroy invertibility: \( \Pi(X) = -x_1 e_1 \) with \( G = \mathrm{id} \) is already non-injective. Lean: `Xfiles.LASLS.perturbed_not_injective`.

Exact decryption by the cascade of §4.4 is guaranteed when each \( \Pi_i \) with \( i \ge 2 \) depends only on \( x_1,\dots,x_{i-1} \) (absorbed into the \( g_i \)) and \( \Pi_1 \) is absorbed into \( \varphi_1 \), **and** the anchor equation remains uniquely solvable. Lean: `Xfiles.LASLS.Anchor.refined6_add_perturbation_eq_anchor6`, `Xfiles.LASLS.Anchor.decryptAnchor_encrypt_of_solve`.

**Legitimate-user cost of a standard internal perturbation.** If \( \Pi \) is meant in the usual internal-perturbation sense (polynomials in \( r \) secret linear forms), the legitimate user typically decrypts by trying every value of those forms — about \( q^r \) trials. At the recommended \( q = 2^{31} \), \( r = 5 \), that is about \( 2^{155} \), the same order as the MinRank estimate. If that is the intended \( \Pi \), parameters need rethinking. If \( \Pi \) is the lower-triangular kind above, it adds no structure beyond the tame map.

The perturbation is the primary defense against linearization equations when used in the internal-perturbation sense. See §6.2–§6.3.

### 2.4 Mixing Matrices

Generate two invertible matrices \( A, B \in \mathrm{GL}_n(\mathbb{F}_q) \) uniformly at random. Compute inverses \( A^{-1} \), \( B^{-1} \).

### 2.5 Public Key

```
F_Public(X) = A · G_pert(B · X)
```

### 2.6 Private Key

```
Private key = ( A^{-1}, B^{-1}, {g_i}, ψ (or φ_1 and {α_j}), Π, V )
```

---

## 3. The 4-Dimensional Construction (Reference Only)

For expositional clarity, the 4D form of the secret map (with the same repaired-anchor discipline as §2.1) is:

```
P(x, y, z, w) = x + ψ(Q, R, S)
Q(x, y, z, w) = y + g(x)
R(x, y, z, w) = z + h(x, y)
S(x, y, z, w) = w + k(x, y, z)
```

An unrestricted first coordinate of the form \( x + \alpha y + \beta z + \gamma w + \varphi(x,y,z,w) \) is **not** assumed to be invertible or to have determinant 1 unless it matches the repaired form of §2.1.

**Warning.** The 4D construction is retained only as a reference. At 4 dimensions, the MinRank attack complexity is \( O(q^r \cdot n^\omega) \) with \( \omega \approx 2.37 \). The 6D construction in §4 is the minimum viable dimension under the estimates of §6.

---

## 4. The 6-Dimensional Construction (Primary)

### 4.1 Secret Map

Using the repaired refined anchor of §2.1:

```
P_2 = x_2 + g_1(x_1)
P_3 = x_3 + g_2(x_1, x_2)
P_4 = x_4 + g_3(x_1, x_2, x_3)
P_5 = x_5 + g_4(x_1, x_2, x_3, x_4)
P_6 = x_6 + g_5(x_1, x_2, x_3, x_4, x_5)
P_1 = x_1 + ψ(P_2, P_3, P_4, P_5, P_6)
```

Equivalently, with the expanded \( \varphi_1 \) of §2.1 so that \( P_1 = x_1 + \sum_{j=2}^{6} \alpha_j x_j + \varphi_1(X) \).

### 4.2 Jacobian Structure

For this form, \( G = E_\psi \circ T \) as in §2.2, so \( \det J_G = 1 \). An arbitrary first row does **not** yield determinant 1.

### 4.3 Encryption

Given plaintext \( M = (m_1, \dots, m_6)^\top \in \mathbb{F}_q^6 \):

```
X = M
C = F_Public(X) = A · G_pert(B · X)
```

Forward evaluation cost: \( O(n \cdot d) \) field operations.

### 4.4 Decryption

**Step 1 — Unmix:**

```
Y = A^{-1} · C
```

**Step 2 — Solve the anchor equation.** For the refined anchor in the form of §2.1,

```
x̂_1 = y_1 − ψ(y_2, …, y_6)
```

(when \( \psi \) is evaluated on the already-unmixed lower ciphertext coordinates after any admissible perturbation has been absorbed into the \( g_i \) and \( \varphi_1 \)). In general, solve \( a_y(t) = y_1 \) for the unique root \( t = \hat{x}_1 \).

**Step 3 — Cascade:**

```
x̂_2 = y_2 − g_1(x̂_1)
x̂_3 = y_3 − g_2(x̂_1, x̂_2)
...
x̂_6 = y_6 − g_5(x̂_1, …, x̂_5)
```

with any admissible perturbation already absorbed into the \( g_i \). There is no iterative fixed-point loop and no “convergence within \( O(r) \) iterations”: over a finite field that language does not apply, and the unrestricted iteration of the earlier draft has no general guarantee.

**Step 4 — Unmix plaintext:**

```
M = B^{-1} · X̂
```

Authorized inversion cost: \( O(n) \) cascade plus the cost of the (unique) anchor solve.

---

## 5. Correctness

**Claim.** For the refined anchor in the form of §2.1, and for every plaintext \( M \in \mathbb{F}_q^n \), \( \mathrm{Decrypt}(\mathrm{Encrypt}(M)) = M \), provided the anchor equation is uniquely solvable for every ciphertext (which holds identically for the repaired \( \psi \)-form).

**Proof sketch.** \( A^{-1}C = G(BM) \) (or \( G_{\mathrm{pert}} \) with admissible \( \Pi \) absorbed). Step 2 recovers \( (BM)_1 \) because the anchor equation has the unique solution \( y_1 - \psi(y_2,\dots,y_n) \). The cascade recovers the remaining coordinates; \( B^{-1} \) yields \( M \). Machine-checked for \( n = 6 \) over every commutative ring: Lean `Xfiles.LASLS.Anchor.decrypt_encrypt_refined_fixed`, `Xfiles.LASLS.Anchor.decryptAnchor_encrypt_of_solve`.

**Exact criterion (arbitrary refinement).** The refined secret map is a bijection if and only if for every \( y \), \( t \mapsto a_y(t) \) is a bijection of the field. Lean: `Xfiles.LASLS.Anchor.anchor6_bijective_iff`, `Xfiles.LASLS.Anchor.refined6_eq_anchor6`.

---

## 6. Security Analysis

### 6.1 Security Model

Attack model: Chosen-plaintext attack (CPA) against the public key. CCA security is not claimed.

Hardness assumption: The security of LASLS rests on the estimated complexity of the MinRank problem applied to the public Jacobian (or the span of the public polynomials), combined with resistance to linearization equations after perturbation.

This is not a reduction to a well-studied hard problem. The tame decomposition problem is not known to be NP-hard for \( n \ge 3 \).

### 6.2 MinRank Attack

An attacker searches for a low-rank matrix in the span of the public polynomials (degree \( d = 5 \) before mixing — not merely quadratic forms; the MinRank setup must be stated for that degree).

Attack complexity estimate:

```
T_MinRank ≈ q^r · n^ω
```

where \( \omega \approx 2.37 \) is the matrix multiplication exponent.

Parameter check at \( n = 6 \), \( q = 2^{31} \), \( r = 5 \):

```
T_MinRank ≈ 2^{31·5} · 6^{2.37} ≈ 2^{155} · 2^{6.2} ≈ 2^{161}
```

This exceeds the 128-bit **classical** security target under this estimate.

Parameter check at \( n = 4 \), \( q = 2^{31} \), \( r = 4 \):

```
T_MinRank ≈ 2^{124} · 4^{2.37} ≈ 2^{124} · 2^{4.7} ≈ 2^{129}
```

Marginal classically; does not account for constant-factor improvements. The 4D construction is not recommended.

**Note on §3 vs this formula.** The formula above already clears ~128 classical bits at \( n = 4 \), \( q = 2^{31} \), \( r = 4 \) under the same estimate; any stricter requirement such as \( q \ge 2^{32} \) at \( r = 4 \) should be justified separately from this formula.

### 6.3 Linearization Equation Attack

Linearization equations are algebraic relations satisfied by all plaintext–ciphertext pairs. For unperturbed TTM-style schemes, first-order linearization equations can reduce recovery cost sharply.

Defense: Internal perturbation with \( r \) large enough that no linearization equations exist. Necessary condition from the perturbed TTM literature (approximate): \( r \ge d - 1 \). For \( d = 5 \), this requires \( r \ge 4 \). The recommended \( r = 5 \) satisfies this with margin.

**Note:** \( r = 5 \) inside \( n = 6 \) is not a “small subspace.”

### 6.4 Gröbner Basis Attacks

The public key can be attacked by computing a Gröbner basis of the ideal generated by the public equations. For \( n = 6 \) and \( d = 5 \), complexity is dominated by the degree of regularity. With internal perturbation the degree of regularity increases, but the exact bound is not known. Open attack vector.

### 6.5 Quantum Attacks

Grover’s algorithm provides a quadratic speedup for unstructured search. Applied to MinRank, \( 2^{161} \) classical becomes about \( 2^{80.5} \) quantum — below a 128-bit post-quantum target. Claiming 128-bit post-quantum security would require classical cost at least ~\( 2^{256} \) under this model (e.g. much larger \( q \) or \( r \)), which is currently impractical for this design.

Shor’s algorithm does not apply (no hidden abelian group structure). The scheme is not broken outright by quantum computers, but the Grover margin is insufficient for a 128-bit PQ claim.

### 6.6 Summary of Security Claims

| Attack | Estimated complexity | Meets 128-bit classical? | Meets 128-bit PQ? |
|--------|----------------------|---------------------------|-------------------|
| MinRank (classical) | \( \sim 2^{161} \) | Yes (under this estimate) | — |
| MinRank (Grover) | \( \sim 2^{80.5} \) | — | No |
| Linearization | Resisted at \( r = 5 \) | Conditional | Conditional |
| Gröbner basis | Unknown | Unknown | Unknown |

---

## 7. Caveats and Limitations

### 7.1 No Security Proof

There is no reduction from LASLS to a well-studied hard problem. The claims in §6 are attack-cost estimates under current algorithms, not proofs.

### 7.2 Perturbation Has Been Broken Before

Internal perturbation is not a proven defense. Advanced HFE-style variants with internal perturbation have been broken by recovering the noise support. The same techniques may apply to LASLS.

### 7.3 The 4D Construction Is Not Recommended

At \( n = 4 \), practical parameters do not give a comfortable classical margin once algorithm improvements are considered. Included only for reference.

### 7.4 Grover Margin Is Insufficient

The specified parameters do not meet 128-bit post-quantum security under Grover. A post-quantum claim would require parameters that are currently impractical.

### 7.5 Refined Anchor Requires the Repaired Form

An unrestricted refined first coordinate does not preserve invertibility or \( \det J = 1 \). Only the form \( P_1 = x_1 + \psi(P_2,\dots,P_n) \) of §2.1 restores both (Lean-checked for \( n = 6 \)). Linear-only \( \psi_0 = 0 \) is absorbed into mixing and does not change public-key form.

### 7.6 Not a Replacement for Standardized Schemes

LASLS is not a drop-in replacement for ML-KEM (Kyber), Classic McEliece, or other standardized post-quantum schemes.

---

## 8. Formalization in Lean

Machine-checked material (no `sorry`; standard axioms only) lives in:

- `LASLS_Correctness.lean` — namespace `Xfiles.LASLS` — classical correctness, counterexamples to unrestricted refinement, Jacobian determinant identities for the general first row.
- `LASLS_Anchor.lean` — namespace `Xfiles.LASLS.Anchor` — exact bijectivity criterion, repaired family, explicit inverse, determinant via upper × lower triangular factorization.

Named results (among others):

| Claim | Lean |
|-------|------|
| Unrestricted refinement not injective | `Xfiles.LASLS.refined6_not_injective` |
| \( \det J = 1 - \alpha c \) in the two-row case | `Xfiles.LASLS.refined6_jac_det`, `Xfiles.LASLS.refined_det_two` |
| General rank-1 perturbation can kill injectivity | `Xfiles.LASLS.perturbed_not_injective` |
| Bijectivity iff anchor map bijective | `Xfiles.LASLS.Anchor.anchor6_bijective_iff`, `Xfiles.LASLS.Anchor.refined6_eq_anchor6` |
| Repaired form bijective + decrypt∘encrypt | `Xfiles.LASLS.Anchor.refined6_fixed_bijective`, `Xfiles.LASLS.Anchor.decrypt_encrypt_refined_fixed` |
| \( \det = 1 \) for repaired form | `Xfiles.LASLS.Anchor.det_upper_mul_lower`, `Xfiles.LASLS.Anchor.det_upperRow_mul_lower` |

Security cannot be formalized without a reduction to a hard problem, which does not exist for LASLS.

---

## 9. Repository Integration

### 9.1 Relationship to the Hierarchical Jacobian Framework

The LASLS secret map is a 6D instantiation of the hierarchical Jacobian from `02-master-framework.md`. The framework’s \( \det J = 1 \) invariant and \( O(n) \) sequential inverse are preserved **for the refined anchor in the form** \( x_1 + \psi(P_2,\dots,P_n) \), but **not** for an arbitrary \( \varphi_1 \). The cryptographic contribution is the (constrained) perturbation layer and the mixing matrices.

### 9.2 Speculative Content

Speculative connections (Navier–Stokes gauge theory, \( S^6 \) holonomy, etc.) are not part of the cryptographic specification. If `LASLS-Speculative.md` is present in the repository, that material lives there; otherwise it has been removed from this document rather than relocated.

---

## 10. Summary

LASLS is a perturbed 6-dimensional triangular multivariate cryptosystem. It is a legitimate research direction within the MPKC family. It is not a deployable post-quantum encryption scheme.

**What it has:**

- A clean algebraic construction with \( \det J = 1 \) **for the refined anchor** \( x_1 + \psi(P_2,\dots,P_n) \) (not for arbitrary first-row refinements).
- An explicit cascade inverse and Lean-checked correctness for the repaired family (\( n = 6 \), any commutative ring).
- A precise invertibility criterion (anchor equation) and documented counterexamples for unrestricted wording.
- Attack-cost estimates against MinRank, linearization, and Gröbner attacks.

**What it lacks:**

- A security proof.
- A post-quantum margin against Grover.
- Resistance guarantees against advanced perturbation-recovery attacks.
- Any form of standardization or external cryptanalysis.
