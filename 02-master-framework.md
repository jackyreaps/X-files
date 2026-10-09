# The Hierarchical Jacobian + Discrete Möbius Fold Framework

## A Unified Structural Approach to Local-vs-Global Obstructions

**Author:** JackyReaps / AnooBus
**Priority Date:** July 25, 2026
**Compiled:** August 28, 2026

## Abstract

We present a unified three-layer framework that converts the classical
local-vs-global obstruction in manifold chart transitions, dynamical systems,
and nonlinear PDEs into a monitored topological charge conservation problem.
The architecture consists of: (1) a local hierarchical triangular Jacobian
enforcing causal DAG-ordered coordinate dependence with unit determinant; (2) a
global discrete Möbius fold mediated by an interference membrane and scar tensor
Λ; and (3) a bridge composite map Φ_Λ = Φ ∘ exp(ad_Λ) whose monodromy is
controlled by a residual-flux parity invariant. The framework yields exact
information identities with computable leakage, supplies explicit global
selection rules for orientation-reversing concentrations, and maps onto the
dimensional ladder S²–S⁶ with maximal leverage at the exceptional S⁶ case.
Applications to the Collatz conjecture and Navier–Stokes regularity are derived
as conditional arguments governed by the sharpness monitor ΔS_n.

## Table of Contents

1. Introduction
2. Layer 1 — Local Charts: The Upgraded Hierarchical Jacobian
3. Layer 2 — Global Discrete Fold: Interference Membrane
4. Layer 3 — Bridge: Composite Map and Monodromy
5. Document A — Explicit Operator Realization
6. Document B — Concrete Entropy Functional
7. Document C — Residual-Flux Parity Insertion
8. Dimensional Scaling: S² Through S⁶
9. Application to Collatz (Hierarchical Gauge)
10. Application to Navier–Stokes (LASLS Gauge)
11. General Pattern and Conclusion
12. Priority Statement

## 1. Introduction

The inverse function theorem guarantees local invertibility when the Jacobian
determinant is non-zero. Global injectivity, however, frequently fails in
unconstrained non-linear systems due to multi-sheeted overlapping folds. To
eliminate this local-vs-global gap, we restrict the transformation to the class
of triangular polynomial automorphisms and extend the local control to global
closure via a discrete Möbius fold. The framework converts open existence
questions into checkable dynamical conditions governed by a topological charge
that cannot flip spontaneously.

## 2. Layer 1 — Local Charts: The Upgraded Hierarchical Jacobian

### 2.1 Ordered Density Field

Define the ordered density field ρ = (ρ₁, ρ₂, ρ₃)ᵀ with hierarchical power-law
dependence: ρ₂ = ρ₁³, ρ₃ = ρ₁ · ρ₂ = ρ₁⁴.

### 2.2 DAG-Enforced Embedding

The coordinate embedding respects the causal hierarchy:

    x = f₁(ρ₁), y = f₂(ρ₁, ρ₂), z = f₃(ρ₁, ρ₂, ρ₃).

Each successive coordinate depends only on the contracted state of its
predecessors, preventing backward-causal sheet collisions.

### 2.3 Jacobian Structure

**Correction (October 2026).** The phrase "strictly lower-triangular unipotent
Jacobian" is self-contradictory: strictly lower-triangular means zero diagonal
(determinant 0). The intended object is **lower-triangular with unit diagonal**.
The local map is

    P_i(x₁, …, x_i) = x_i + g_i(x₁, …, x_{i−1}),   ∂_{ρᵢ} fᵢ = 1.

The Jacobian is therefore unit lower-triangular:

    J_Φ = [[1, 0, 0],
           [∂_{ρ₁}f₂, 1, 0],
           [∂_{ρ₁}f₃, ∂_{ρ₂}f₃, 1]].

**Invariants:**

- **Volume preservation:** det J_Φ = 1 identically.
- **Rigid spectrum:** Eigenvalues are {1, 1, 1}.
- **Explicit inverse:** Sequential back-substitution in O(n) steps.

### 2.4 General Form

For arbitrary polynomial functions g(x) and h(x, y), define the feed-forward
form as above.

## 3. Layer 2 — Global Discrete Fold: Interference Membrane

### 3.1 Discrete Möbius Fold

A Möbius transformation on the boundary data, discretised as a finite
composition of elementary folds.

### 3.2 Scar Tensor Λ

The interference membrane accumulating the fold history.

### 3.3 Scar Saturation

The scar recurrence is

    Λ_{n+1} = α Λ_n + β M_n + γ F(…),   α < 1.

**Assume** `M_n` and `F(…)` are bounded by `B`. Then `Λ_n` is bounded:

    ‖Λ_n‖ ≤ αⁿ ‖Λ_0‖ + (β + γ) B / (1 − α).

Boundedness does **not** imply saturation in finite time. Saturation
(convergence to a fixed value) is a separate question and is not claimed here.
The earlier statement that "hierarchy-reversing events are forbidden" is not
proved and is removed.

### 3.4 Information Identity

**Correction (October 2026).** With `D(I) = H(I) − I(I;M)` and
`D(J) = H(J) − I(J;M)`, the identity

    H(I) + H(J) = H(M) + D(I) + D(J) + L

forces

    L = I(I;M) + I(J;M) − H(M).

This is **negative in general**. Counterexample: `I`, `J` independent fair bits,
`M = I ⊕ J`. Then `I(I;M) = I(J;M) = 0`, `H(M) = 1`, so `L = −1`.

The identity is therefore a **definition** of `L`, not a theorem. Any use of
`L ≥ 0` must carry it as an additional hypothesis on the joint distribution
(e.g. that `M` is determined by `I` and `J` jointly, so
`H(M) ≤ I(I;M) + I(J;M)`).

The equality `L = ½‖[B(I), B(J)]‖²_HS` is not established and is removed.

## 4. Layer 3 — Bridge: Composite Map and Monodromy

### 4.1 Composite Map

    Φ_Λ = Φ ∘ exp(ad_Λ).

### 4.2 The Exponential Factor

`exp(ad_Λ)` acts on the Lie algebra of the local Jacobians.

### 4.3 Mixing

Two mixing matrices `A`, `B` and their inverses, with `A⁻¹A = 1`, `B⁻¹B = 1`.

### 4.4 LASLS Public Key

`F = A · G(B · X)` where `G` is the secret map.

### 4.5 Monodromy

**Correction (October 2026).** Every Jacobian in the composition is unit
lower-triangular, hence has determinant `+1` and all eigenvalues `1`. A product
of such matrices is again unit lower-triangular. Therefore

    Hol_γ(Φ_Λ) = +1

for any monodromy built from these Jacobians. A sign `−1` cannot occur without
a transition outside the unipotent group; an orientation-reversing gluing would
supply one, but no such gluing is constructed here.

The earlier justification "because `L ≥ 0` the sign cannot flip" is removed;
it does not follow from the identity.

## 5. Document A — Explicit Operator Realization

## 6. Document B — Concrete Entropy Functional

## 7. Document C — Residual-Flux Parity Insertion

## 8. Dimensional Scaling: S² Through S⁶

| Manifold | Structure | Citation |
|---|---|---|
| S¹ | trivial | — |
| S² | complex structure | Riemann |
| S³ | no almost-complex structure | trivial (odd-dimensional) |
| S⁴ | no almost-complex structure | not Adams 1960 (see X-files_Dimensional_Table_Corrected.md) |
| S⁵ | no almost-complex structure | trivial (odd-dimensional) |
| S⁶ | almost-complex structure open | — |

## 9. Application to Collatz (Hierarchical Gauge)

Conditional template; embedding not constructed.

## 10. Application to Navier–Stokes (LASLS Gauge)

Conditional template; embedding not constructed. See
`X-files_Minimal_Closure_NS.md` for the trace-condition caveat.

## 11. General Pattern and Conclusion

## 12. Priority Statement
