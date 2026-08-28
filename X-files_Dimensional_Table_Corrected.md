# X-files Dimensional Table — Corrected and Annotated

**Repository:** jackyreaps/X-files  
**Audit Date:** August 28, 2026  
**Scope:** Corrects two errors in the published dimensional scaling table: (1) the S⁴ obstruction attribution, and (2) the Λ nilpotency inconsistency.

---

## 1. The Two Errors

### Error 1: Adams (1960) attribution for S⁴

The original table states:

> S⁴ — Real only — No — Adams 1960

This is **incorrect**. The obstruction to an almost-complex structure on S⁴ is not due to J. F. Adams (1960). Adams' 1960 work concerns vector fields on spheres and the Hopf invariant one problem, not the existence of almost-complex structures.

The correct attribution: S⁴ does not admit an almost-complex structure because its Pontryagin class p₁(S⁴) = 0 and the Hirzebruch signature theorem, combined with the integrality conditions for Chern classes, forbid it. A more direct argument: if S⁴ were almost-complex, its tangent bundle would split as a complex 2-plane bundle, but the Euler characteristic χ(S⁴) = 2 and the Todd genus constraints are incompatible. This is a standard consequence of Chern–Weil theory and does not require Adams' deep results on K-theory.

**Correction:** Replace "Adams 1960" with "Chern class integrality / Pontryagin constraint" or simply "Standard obstruction."

### Error 2: Λ nilpotency inconsistency

The original table assigns nilpotency indices as follows:

| Target | Real dim | Complex dim | Λ nilpotency |
|---|---|---|---|
| S² | 2 | 1 | 2 |
| S³ | 3 | — | 3 |
| S⁴ | 4 | — | 4 |
| S⁵ | 5 | — | 5 |
| S⁶ | 6 | 3 | 3 |

This table is **internally inconsistent**. The pattern for real spheres (S³, S⁴, S⁵) is: nilpotency = real dimension. But for S², nilpotency = 2 ≠ 1 (complex dim) and ≠ 2 in a way that conflicts with the pattern if S² is treated as complex. For S⁶, nilpotency = 3 = complex dimension, but this breaks the real-dimension pattern.

The inconsistency arises because the framework **conflates two different indexing schemes**:
- **Scheme R:** For real manifolds, the scar tensor is an n×n real strictly lower-triangular matrix, where n = real dimension. Nilpotency ≤ n.
- **Scheme C:** For complex manifolds, the scar tensor is an n×n complex strictly lower-triangular matrix, where n = complex dimension. Nilpotency ≤ n.

For S² (real dim 2, complex dim 1), the framework uses a 2×2 real matrix in the S²–S⁵ ladder (Scheme R), but then calls S² "1 complex dimension" and assigns nilpotency 2, which would require a 2×2 matrix — inconsistent with Scheme C (which would give nilpotency 1 for a 1×1 matrix).

For S⁶ (real dim 6, complex dim 3), the framework uses a 3×3 complex matrix (Scheme C), giving nilpotency 3. But if the ladder is meant to be uniform, S⁶ should have nilpotency 6 under Scheme R.

---

## 2. The Corrected Table

Two corrected versions are presented, depending on whether the framework intends to index by real or complex dimension.

### Table A: Uniform Real-Dimension Indexing (Scheme R)

In this scheme, every sphere is treated as a real manifold, and the scar tensor size equals the real dimension. Complex structures are noted but do not reduce the matrix size.

| Target | Real dim | Complex dim | Matrix size | Λ nilpotency | Complex structure? | Obstruction source |
|---|---|---|---|---|---|---|
| S² (CP¹) | 2 | 1 | 2×2 real | 2 | **Yes — canonical** | None (Kähler) |
| S³ | 3 | — | 3×3 real | 3 | No | Real manifold |
| S⁴ | 4 | — | 4×4 real | 4 | No | Chern class integrality |
| S⁵ | 5 | — | 5×5 real | 5 | No | Real manifold |
| S⁶ | 6 | 3 (candidate) | 6×6 real | 6 | Almost complex (octonionic) | Exceptional: Nijenhuis ≠ 0? |

**Notes on Table A:**
- S²: The 2×2 real triangular structure captures the classical Möbius inversion. The complex structure is a bonus property, not a matrix-size reduction.
- S⁶: The 6×6 real matrix is the honest size if the framework treats all spheres uniformly. The complex almost-structure J is an additional tensor on the 6×6 real base, not a reduction to 3×3.

### Table B: Complex-Dimension Indexing for Complex/Almost-Complex Cases (Scheme C)

In this scheme, when a complex structure exists or is candidate, the scar tensor is reduced to the complex dimension. Real-only spheres keep their real dimension.

| Target | Real dim | Complex dim | Matrix size | Λ nilpotency | Complex structure? | Framework mode |
|---|---|---|---|---|---|---|
| S² (CP¹) | 2 | 1 | 1×1 complex | 1 | **Yes — canonical** | Trivial scar (no obstruction) |
| S³ | 3 | — | 3×3 real | 3 | No | Real manifold |
| S⁴ | 4 | — | 4×4 real | 4 | No | Real manifold |
| S⁵ | 5 | — | 5×5 real | 5 | No | Real manifold |
| S⁶ | 6 | 3 (candidate) | 3×3 complex | 3 | Almost complex (octonionic) | Exceptional: 3×3 holomorphy constraint |

**Notes on Table B:**
- S²: Nilpotency 1 means Λ = 0 (the zero matrix). This correctly reflects that S² has no obstruction — it is already a complex manifold. The "Möbius origin" story is then a *historical naming* (the discrete fold is named after Möbius transformations on CP¹), not a statement that Λ is non-trivial.
- S⁶: The 3×3 complex matrix is the natural size for studying the integrability of the almost-complex structure. The nilpotency 3 is the maximum for a 3×3 strictly lower-triangular matrix.

### Table C: Hybrid (Original Intent, Made Consistent)

This table preserves the original intent (S² and S⁶ get special complex treatment) but fixes the inconsistency by explicitly noting the dual scheme.

| Target | Real dim | Complex dim | Λ size | Λ nilpotency | Scheme | Complex structure? | Notes |
|---|---|---|---|---|---|---|---|
| S² (CP¹) | 2 | 1 | 2×2 real | 2 | **R** | Yes | Möbius origin: classical inversion lives in 2×2 real group |
| S³ | 3 | — | 3×3 real | 3 | R | No | Hopf fibration; real triangular group = tame subgroup |
| S⁴ | 4 | — | 4×4 real | 4 | R | No | **Not** Adams 1960; Chern/Pontryagin obstruction |
| S⁵ | 5 | — | 5×5 real | 5 | R | No | Purely smooth |
| S⁶ | 6 | 3 (candidate) | 3×3 complex | 3 | **C** | Almost complex | Exceptional: 3×3 is the natural complex frame size |

**Notes on Table C:**
- The **Scheme** column makes the duality explicit.
- S² uses Scheme R because the discrete Möbius fold is defined as a real 2×2 transformation (the classical Möbius group PSL(2,ℝ) or PSL(2,ℂ) acting on RP¹ or CP¹). The real 2×2 matrix is the honest home of the "half-twist."
- S⁶ uses Scheme C because the question is about complex 3-folds, and the 3×3 complex triangular group is the natural gauge.
- S⁴ attribution is corrected.

---

## 3. Recommendation

The repository should adopt **Table C** as the canonical dimensional scaling table. It:

1. Corrects the Adams (1960) attribution to the standard Chern-class obstruction.
2. Makes the nilpotency indexing consistent by explicitly distinguishing Scheme R (real dimension) from Scheme C (complex dimension).
3. Preserves the special roles of S² (Möbius origin, 2×2 real) and S⁶ (exceptional complex, 3×3 complex).
4. Eliminates the internal contradiction where S² had nilpotency 2 under a 1-dimensional complex description.

---

*Document prepared August 28, 2026. Corrections to jackyreaps/X-files dimensional scaling.*
