
---

07 — LASLS: Lower-Anchor Skew-Linear Stacking

A Perturbed Triangular Multivariate Cryptosystem

Author: JackyReaps / AnooBus
Date of original posts: 26 July 2026
Refined specification: October 2026
Status: Research specification. Not standardized. Not recommended for deployment.

---

0. Status and Scope

This document specifies LASLS (Lower-Anchor Skew-Linear Stacking), a public-key cryptosystem in the Multivariate Public-Key Cryptography (MPKC) family. LASLS is a perturbed triangular multivariate scheme derived from the tame automorphism construction.

Relationship to prior work. LASLS is structurally a variant of the TTM (Triangle Plus Minus) family of tame automorphism cryptosystems. The specific contributions here are:

1. The hierarchical Jacobian embedding from the X-files framework (02-master-framework.md).
2. An explicit internal perturbation construction.
3. A machine-checkable correctness proof (Lean).

Security posture. Security rests on the estimated hardness of a specific MinRank instance combined with resistance to linearization equations under perturbation. No security proof exists. See §6 for the full caveats.

---

1. Notation and Parameters

Symbol Meaning
q Field size (prime power)
n Dimension (number of variables)
d Maximum degree of secret polynomials
r Perturbation subspace dimension
F_q Finite field of order q
X Column vector (x_1, ..., x_n)^T
M Plaintext block in F_q^n
C Ciphertext block in F_q^n

Recommended parameter regime

Parameter Value Rationale
n 6 Minimum viable for 128-bit classical security target
q 2^31 or 31-bit prime Required for MinRank resistance
d 5 Balances expressiveness and attack surface
r 5 Perturbation dimension for linearization resistance

The 4-dimensional construction is retained in §3 for expositional clarity but is not secure at practical field sizes. See §6.3.

---

2. Cryptographic Primitives

2.1 Secret Tame Map

The secret map G: F_q^n → F_q^n is a strictly lower-triangular polynomial automorphism:

```
P_1(X) = x_1 + α_2 x_2 + ... + α_n x_n + φ_1(x_1, ..., x_n)
P_2(X) = x_2 + g_1(x_1)
P_3(X) = x_3 + g_2(x_1, x_2)
...
P_n(X) = x_n + g_{n-1}(x_1, ..., x_{n-1})
```

where:

· α_2, ..., α_n ∈ F_q are secret linear coefficients,
· φ_1 is a secret low-degree polynomial chosen so the first-coordinate recovery equation is efficiently solvable,
· g_1, ..., g_{n-1} are secret polynomials of degree at most d.

Note on the anchor. The classical LASLS construction set P_1(X) = x_1. This is the fixed lower anchor, and it produces a rank-1 structural deficiency exploitable by MinRank attacks. The refined construction replaces the fixed anchor with the linear-plus-low-degree form above, preserving triangular structure (back-substitution remains valid) while breaking the rank-1 invariant.

2.2 Secret Jacobian

The Jacobian J_G of the refined map is lower-triangular with unit diagonal except for the first row, which contains the secret linear coefficients α_2, ..., α_n and the partial derivatives of φ_1:

```
    [  1           α_2         α_3       ...    α_n    ]
    [ ∂g_1/∂x_1     1           0        ...     0     ]
J_G = [ ∂g_2/∂x_1   ∂g_2/∂x_2     1        ...     0     ]
    [   ...         ...         ...       ...    ...    ]
    [ ∂g_{n-1}/∂x_1 ...        ...       ...     1     ]
```

Properties:

· det(J_G) = 1 (unimodularity preserved under the refined anchor)
· The spectrum is {1, 1, ..., 1} only when α_2 = ... = α_n = 0 and φ_1 = 0. The refined anchor breaks the pure spectral fingerprint.

2.3 Perturbation Map

Choose an r-dimensional subspace V ⊂ F_q^n and a random linear projection π_V: F_q^n → V. Define a random polynomial map:

```
Π: F_q^n → V
```

with degree at most d. The perturbed secret map is:

```
G_pert(X) = G(X) + Π(X)
```

The perturbation is the primary defense against linearization equations. See §6.2 for the necessary condition on r.

2.4 Mixing Matrices

Generate two invertible matrices A, B ∈ GL_n(F_q) uniformly at random. Compute inverses A^{-1}, B^{-1}.

2.5 Public Key

```
F_Public(X) = A · G_pert(B · X)
```

2.6 Private Key

```
Private key = ( A^{-1}, B^{-1}, {g_i}, φ_1, {α_j}, Π, V )
```

---

3. The 4-Dimensional Construction (Reference Only)

For expositional clarity, the 4D form of the secret map is:

```
P(x, y, z, w) = x + α y + β z + γ w + φ(x, y, z, w)
Q(x, y, z, w) = y + g(x)
R(x, y, z, w) = z + h(x, y)
S(x, y, z, w) = w + k(x, y, z)
```

The corresponding Jacobian:

```
    [  1       α       β       γ   ]
    [ dg/dx    1       0       0   ]
J_G = [ dh/dx   dh/dy    1       0   ]
    [ dk/dx   dk/dy   dk/dz    1   ]
```

Warning. The 4D construction is retained only as a reference. At 4 dimensions, the MinRank attack complexity is O(q^r · n^ω) with ω ≈ 2.37. To reach 128-bit classical security requires q ≥ 2^32 at r = 4, which is impractical. The 6D construction in §4 is the minimum viable dimension.

---

4. The 6-Dimensional Construction (Primary)

4.1 Secret Map

```
P_1 = x_1 + α_2 x_2 + α_3 x_3 + α_4 x_4 + α_5 x_5 + α_6 x_6 + φ_1(X)
P_2 = x_2 + g_1(x_1)
P_3 = x_3 + g_2(x_1, x_2)
P_4 = x_4 + g_3(x_1, x_2, x_3)
P_5 = x_5 + g_4(x_1, x_2, x_3, x_4)
P_6 = x_6 + g_5(x_1, x_2, x_3, x_4, x_5)
```

4.2 Jacobian Structure

The Jacobian J_G is lower-triangular with unit diagonal except for the first row, which contains the secret linear coefficients α_2, ..., α_6 and the partial derivatives of φ_1. The determinant remains 1.

4.3 Encryption

Given plaintext M = (m_1, ..., m_6)^T ∈ F_q^6:

```
X = M
C = F_Public(X) = A · G_pert(B · X)
```

Forward evaluation cost: O(n · d) field operations. (The original O(1) claim assumed constant-degree polynomials; the cost is polynomial in n and d.)

4.4 Decryption

Step 1 — Unmix:

```
Y = A^{-1} · C
```

Step 2 — Remove perturbation and invert the triangular map:

The perturbation Π is not directly invertible. The legitimate user recovers X̂ = G^{-1}(Y - Π(X̂)) iteratively. For the recommended parameter regime, convergence is guaranteed within O(r) iterations when Π has image in a small subspace.

Step 3 — Back-substitution cascade:

```
x̂_1 = solve( y_1 − α_2 x̂_2 − ... − α_6 x̂_6 − φ_1(X̂) = x̂_1 + Π_1(X̂) )
x̂_2 = y_2 − g_1(x̂_1) − Π_2(X̂)
x̂_3 = y_3 − g_2(x̂_1, x̂_2) − Π_3(X̂)
...
x̂_6 = y_6 − g_5(x̂_1, ..., x̂_5) − Π_6(X̂)
```

The first equation is solved for x̂_1 by the choice of φ_1; subsequent coordinates are explicit.

Step 4 — Unmix plaintext:

```
M = B^{-1} · X̂
```

Authorized inversion cost: O(n) linear scan plus the cost of solving the first-coordinate equation.

---

5. Correctness

Claim. For any plaintext M ∈ F_q^n, Decrypt(Encrypt(M)) = M.

Proof sketch. The public key is F_Public = A · G_pert · B. Given C = F_Public(M):

```
A^{-1} C = G_pert(B M)
```

The back-substitution cascade inverts G exactly (triangular structure) and the perturbation Π is recovered iteratively. Multiplication by B^{-1} then yields M. ∎

Formalization. See §8 for the Lean correctness formalization.

---

6. Security Analysis

6.1 Security Model

Attack model: Chosen-plaintext attack (CPA) against the public key. CCA security is not claimed.

Hardness assumption: The security of LASLS rests on the estimated complexity of the MinRank problem applied to the public Jacobian, combined with resistance to linearization equations after perturbation.

This is not a reduction to a well-studied hard problem. The tame decomposition problem is not known to be NP-hard for n ≥ 3.

6.2 MinRank Attack

The public Jacobian J_Public = A · J_G_pert · B is a linear combination of the public key's quadratic forms. An attacker searches for a low-rank matrix in the span of these forms.

Attack complexity estimate:

```
T_MinRank ≈ q^r · n^ω
```

where ω ≈ 2.37 is the matrix multiplication exponent.

Parameter check at n = 6, q = 2^31, r = 5:

```
T_MinRank ≈ 2^{31·5} · 6^{2.37} ≈ 2^{155} · 2^{6.2} ≈ 2^{161}
```

This exceeds the 128-bit classical security target.

Parameter check at n = 4, q = 2^31, r = 4:

```
T_MinRank ≈ 2^{124} · 4^{2.37} ≈ 2^{124} · 2^{4.7} ≈ 2^{129}
```

This is marginal and does not account for constant-factor improvements in MinRank algorithms. The 4D construction is not recommended.

6.3 Linearization Equation Attack

Linearization equations are algebraic relations satisfied by all plaintext–ciphertext pairs. For unperturbed TTM-style schemes, all first-order linearization equations can be found by precomputation, reducing plaintext recovery to O(2^19) over F_{2^8}.

Defense: Internal perturbation with r large enough that no linearization equations exist.

Necessary condition: From the perturbed TTM literature, the condition for non-existence of linearization equations is approximately:

```
r ≥ d − 1
```

For d = 5, this requires r ≥ 4. The recommended r = 5 satisfies this with margin.

6.4 Gröbner Basis Attacks

The public key can be attacked directly by computing a Gröbner basis of the ideal generated by the public equations. For n = 6 and d = 5, the complexity is dominated by the degree of regularity of the system. With internal perturbation, the degree of regularity is increased but the exact bound is not known. This remains an open attack vector.

6.5 Quantum Attacks

Grover's algorithm provides a quadratic speedup for unstructured search. Applied to MinRank, this halves the effective bit-security: 2^{161} classical becomes 2^{80.5} quantum. This is below the 128-bit post-quantum target. To claim post-quantum security at 128 bits, the classical security must be at least 2^{256}.

This is a critical gap. LASLS as specified does not meet post-quantum 128-bit security under Grover. Achieving that requires doubling the exponent, e.g., q = 2^62 or r = 10, both of which are impractical.

Shor's algorithm does not apply to LASLS (no hidden abelian group structure), so the scheme is not broken outright by quantum computers — but its margin against Grover is insufficient for a 128-bit post-quantum claim.

6.6 Summary of Security Claims

Attack Estimated complexity Meets 128-bit PQ?
MinRank (classical) 2^{161} Yes (classical)
MinRank (Grover) 2^{80.5} No
Linearization Resisted at r = 5 Conditional
Gröbner basis Unknown Unknown

---

7. Caveats and Limitations

7.1 No Security Proof

There is no reduction from LASLS to a well-studied hard problem. The security claims in §6 are attack-cost estimates under current algorithms, not proofs.

7.2 Perturbation Has Been Broken Before

Internal perturbation is not a proven defense. Advanced HFE-style variants with internal perturbation were broken in 2025 by recovering the noise support. The same techniques may apply to LASLS.

7.3 The 4D Construction Is Broken

At n = 4, no practical field size achieves 128-bit security against MinRank. The 4D construction is included only for reference.

7.4 Grover Margin Is Insufficient

The specified parameters do not meet 128-bit post-quantum security under Grover's algorithm. A post-quantum claim would require parameters that are currently impractical.

7.5 Not a Replacement for Standardized Schemes

LASLS is not a drop-in replacement for ML-KEM (Kyber), Classic McEliece, or other standardized post-quantum schemes. Those schemes have rigorous security proofs and years of cryptanalysis. LASLS has neither.

---

8. Formalization in Lean

The repository includes Lean files for volume preservation and filter theory. A LASLS_Correctness.lean file should formalize:

Key generation:

```lean
def keygen (q n d r : ℕ) : KeyPair := ...
```

Encryption:

```lean
def encrypt (pk : PublicKey) (m : Vector (Fin q) n) : Vector (Fin q) n :=
  pk.A * G_pert (pk.B * m)
```

Decryption:

```lean
def decrypt (sk : PrivateKey) (c : Vector (Fin q) n) : Vector (Fin q) n :=
  sk.B_inv * back_substitute (sk.A_inv * c)
```

Correctness theorem:

```lean
theorem decrypt_encrypt (sk : PrivateKey) (m : Vector (Fin q) n) :
  decrypt sk (encrypt sk.pk m) = m := by
  ...
```

This formalizes correctness only. Security cannot be formalized without a reduction to a hard problem, which does not exist for LASLS.

---

9. Repository Integration

9.1 Relationship to the Hierarchical Jacobian Framework

The LASLS secret map is a 6D instantiation of the hierarchical Jacobian from 02-master-framework.md. The framework's det J = 1 invariant and O(n) sequential inverse are preserved. The cryptographic contribution is the perturbation layer and the mixing matrices.



9.2 Speculative Content

Speculative connections (Navier–Stokes gauge theory, S^6 holonomy, etc.) have been moved to LASLS-Speculative.md. They are not part of the cryptographic specification.

---

10. Summary

LASLS is a perturbed 6-dimensional triangular multivariate cryptosystem. It is a legitimate research direction within the MPKC family. It is not a deployable post-quantum encryption scheme.

What it has:

· A clean algebraic construction with det J = 1.
· An explicit perturbation defense against linearization.
· A machine-checkable correctness proof.
· Attack-cost estimates against MinRank, linearization, and Gröbner attacks.

What it lacks:

· A security proof.
· A post-quantum margin against Grover.
· Resistance to advanced perturbation-recovery attacks.
· Any form of standardization or external cryptanalysis.
