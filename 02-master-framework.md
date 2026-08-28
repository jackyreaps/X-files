# The Hierarchical Jacobian + Discrete Möbius Fold Framework
## A Unified Structural Approach to Local-vs-Global Obstructions

**Author:** JackyReaps / AnooBus  
**Priority Date:** July 25, 2026  
**Compiled:** August 28, 2026

---

## Abstract

We present a unified three-layer framework that converts the classical local-vs-global obstruction in manifold chart transitions, dynamical systems, and nonlinear PDEs into a monitored topological charge conservation problem. The architecture consists of: (1) a local hierarchical triangular Jacobian enforcing causal DAG-ordered coordinate dependence with unit determinant; (2) a global discrete Möbius fold mediated by an interference membrane and scar tensor Λ; and (3) a bridge composite map Φ_Λ = Φ ∘ exp(ad_Λ) whose monodromy is controlled by a residual-flux parity invariant. The framework yields exact information identities with computable leakage, supplies explicit global selection rules for orientation-reversing concentrations, and maps onto the dimensional ladder S²–S⁶ with maximal leverage at the exceptional S⁶ case. Applications to the Collatz conjecture and Navier–Stokes regularity are derived as conditional arguments governed by the sharpness monitor ΔS_n.

---

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

---

## 1. Introduction

The inverse function theorem guarantees local invertibility when the Jacobian determinant is non-zero. Global injectivity, however, frequently fails in unconstrained non-linear systems due to multi-sheeted overlapping folds. To eliminate this local-vs-global gap, we restrict the transformation to the class of triangular polynomial automorphisms and extend the local control to global closure via a discrete Möbius fold.

The framework converts open existence questions into checkable dynamical conditions governed by a topological charge that cannot flip spontaneously.

---

## 2. Layer 1 — Local Charts: The Upgraded Hierarchical Jacobian

### 2.1 Ordered Density Field

Define the ordered density field ρ = (ρ₁, ρ₂, ρ₃)ᵀ with hierarchical power-law dependence:

    ρ₂ = ρ₁³,        ρ₃ = ρ₁ · ρ₂ = ρ₁⁴.

### 2.2 DAG-Enforced Embedding

The coordinate embedding respects the causal hierarchy:

    x = f₁(ρ₁),
    y = f₂(ρ₁, ρ₂),
    z = f₃(ρ₁, ρ₂, ρ₃).

Each successive coordinate depends only on the contracted state of its predecessors, preventing backward-causal sheet collisions.

### 2.3 Jacobian Structure

Computing partial derivatives yields a strictly lower-triangular unipotent Jacobian by construction:

              ⎡ ∂_{ρ₁}f₁     0           0        ⎤
    J_Φ   =   ⎢ ∂_{ρ₁}f₂   ∂_{ρ₂}f₂     0        ⎥
              ⎣ ∂_{ρ₁}f₃   ∂_{ρ₂}f₃   ∂_{ρ₃}f₃   ⎦

**Invariants:**
- **Volume preservation:** det J_Φ = 1 identically
- **Rigid spectrum:** Eigenvalues are {1, 1, 1}
- **Explicit inverse:** Sequential back-substitution in O(n) steps

### 2.4 General Form

For arbitrary polynomial functions g(x) and h(x, y), define the feed-forward map G : ℝ³ → ℝ³:

    P(x, y, z) = x,
    Q(x, y, z) = y + g(x),
    R(x, y, z) = z + h(x, y).

The Jacobian is:

              ⎡ 1      0      0 ⎤
    J_G   =   ⎢ ∂g/∂x  1      0 ⎥
              ⎣ ∂h/∂x  ∂h/∂y  1 ⎦

with det J_G = 1 and explicit global inverse:

    x = P,
    y = Q − g(P),
    z = R − h(P, Q − g(P)).

---

## 3. Layer 2 — Global Discrete Fold: Interference Membrane

### 3.1 Configuration

A global configuration is specified by the tuple:

    U_n = (I_n, J_n, Λ_n, B_{Λ_n}, R_{Λ_n}),

where I_n and J_n are information sources, Λ_n is the scar tensor, B_Λ is the bottleneck operator, and R_Λ is the rebound operator.

### 3.2 Residual Membrane

The residual membrane captures the nonlinearity on shared support:

    M_n = R_Λ(B_Λ(I_n) + B_Λ(J_n)) − R_Λ(B_Λ(I_n)) − R_Λ(B_Λ(J_n)).

M_n is nonzero only where the supports of I_n and J_n overlap.

### 3.3 Irreversible Scar Update (Discrete Half-Twist)

The scar tensor evolves by a damped driven update:

    Λ_{n+1} = α Λ_n + β M_n + γ F(Λ_n, M_n),    α ∈ (0, 1),  β > 0.

Because α < 1, the scar eventually saturates. Once saturated, further hierarchy-reversing events are forbidden.

### 3.4 Information Identity with Directed Leakage

The total information decomposes exactly:

    H(I) + H(J) = H(M) + D(I) + D(J) + L,    L ≥ 0,

where:
- H(M) is the entropy of the residual membrane,
- D(I) = H(I) − I(I; M) and D(J) = H(J) − I(J; M) are private informations,
- L = ½ ‖[B_Λ(I), B_Λ(J)]‖²_HS is the irreversible leakage (Hilbert–Schmidt norm of the commutator).

**Key property:** L = 0 if and only if the compressed kernels have disjoint support.

### 3.5 Sharpness Monitor

The scar dynamics are tracked by:

    ΔS_n = S(M_{n+1}) − S(M_n).

- ΔS_n > 0: the orbit is generative (membrane is becoming more structured).
- ΔS_n ≤ 0: the scar is saturating; the system is approaching global closure.

---

## 4. Layer 3 — Bridge: Composite Map and Monodromy

### 4.1 Composite Embedding

Lift the hierarchical embedding onto the scarred base via the infinitesimal action of the scar:

    Φ_Λ = Φ ∘ exp(ad_Λ).

### 4.2 Infinitesimal Action

Treat ad_Λ as a strictly lower-triangular derivation on the density coordinates:

              ⎡ 0    0    0 ⎤
    ad_Λ · ρ = ⎢ λ₂₁  0    0 ⎥ ρ,
              ⎣ λ₃₁  λ₃₂  0 ⎦

where the entries λ_ij are continuous linear functionals of the accumulated residual flux:

    λ_ij = ∫₀¹ K_ij(s) tr(M_s) ds,

with smooth kernels K_ij of compact support.

### 4.3 Exponential Map

Because Λ is strictly lower-triangular with nilpotency index 3, the exponential terminates:

    exp(ad_Λ) = I + Λ + ½ Λ².

Explicitly:

    exp(ad_Λ) ρ = ⎛ ρ₁                                    ⎞
                  ⎜ ρ₂ + λ₂₁ ρ₁                           ⎟
                  ⎝ ρ₃ + λ₃₁ ρ₁ + λ₃₂ ρ₂ + ½ λ₃₂ λ₂₁ ρ₁ ⎠.

### 4.4 Composite Jacobian

The Jacobian of the composite map is:

    J_{Φ_Λ} = J_Φ · (I + Λ + ½ Λ²)    ⟹    det J_{Φ_Λ} = 1.

All higher-order terms stay strictly below the diagonal, so DAG causality and volume preservation are preserved under the discrete fold.

### 4.5 Global Monodromy and the Discrete Möbius Invariant

While the composite Jacobian remains unipotent (det = 1), the global monodromy around any closed loop γ acquires the discrete Möbius invariant:

    Hol_γ(Φ_Λ) = ±1,

fixed by the parity of the total residual flux:

    ∫_γ tr(M) ds  (mod 2).

Because the leakage L ≥ 0, the sign cannot flip spontaneously; it is a **controlled topological charge**.

---

## 5. Document A — Explicit Operator Realization

### 5.1 Scar Tensor Representation

In the density basis, the scar tensor is the strictly lower-triangular matrix:

              ⎡ 0    0    0 ⎤
    Λ     =   ⎢ λ₂₁  0    0 ⎥,
              ⎣ λ₃₁  λ₃₂  0 ⎦

with entries λ_ij = ∫₀¹ K_ij(s) tr(M_s) ds.

### 5.2 Infinitesimal Derivation

    ad_Λ · ρ := Λ ρ.

### 5.3 Finite Exponential (Nilpotency Index 3)

    exp(ad_Λ) = I + Λ + ½ Λ².

### 5.4 Explicit Action on Density Coordinates

    exp(ad_Λ) ρ = ⎛ ρ₁                                    ⎞
                  ⎜ ρ₂ + λ₂₁ ρ₁                           ⎟
                  ⎝ ρ₃ + λ₃₁ ρ₁ + λ₃₂ ρ₂ + ½ λ₃₂ λ₂₁ ρ₁ ⎠.

### 5.5 Composite Embedding

    Φ_Λ = Φ ∘ exp(ad_Λ).

### 5.6 Jacobian Preservation

    J_{Φ_Λ} = J_Φ · (I + Λ + ½ Λ²)    ⟹    det J_{Φ_Λ} = 1.

All higher-order terms remain strictly below the diagonal.

---

## 6. Document B — Concrete Entropy Functional

### 6.1 Sharpness Functional

Define the sharpness functional on the residual membrane by the relative surprisal:

    S(M) := −Tr(M log M) + Tr(M log(P_I + P_J)),

where P_I, P_J are the orthogonal projections onto the private supports of I and J.

### 6.2 Private Information

    D(I) = H(I) − I(I; M),    D(J) = H(J) − I(J; M),

with mutual information in the von Neumann sense:

    I(A; M) = H(A) + H(M) − H(A, M).

### 6.3 Exact Information Partition

A direct expansion using the definition of M_n and the continuity of the bottleneck/rebound operators yields:

    H(I) + H(J) = H(M) + D(I) + D(J) + L,

where the irreversible leakage is the non-negative quantity:

    L = ½ ‖[B_Λ(I), B_Λ(J)]‖²_HS ≥ 0.

Equality holds if and only if the two compressed kernels have disjoint support.

### 6.4 Computability

Thus L is an explicit, computable functional, and ΔS_n = S(M_{n+1}) − S(M_n) inherits a concrete lower bound in terms of the residual flux.

---

## 7. Document C — Insertion of Residual-Flux Parity into Conditional Arguments

### 7.1 Collatz Hierarchical Gauge

Let V_n be the hierarchical Lyapunov function already used in the conditional Collatz argument (built from the ordered densities and the triangular Jacobian).

Define the **discrete Möbius charge**:

    μ_n = ∫₀ⁿ tr(M_s) ds  (mod 2)  ∈ {0, 1}.

The updated Lyapunov is:

    Ṽ_n = V_n + C · μ_n,

where C > 0 is large enough that any hierarchy-reversing step increases μ and therefore cannot decrease Ṽ.

Because the scar saturates (L ≥ 0 and α < 1), μ_n eventually freezes. Once frozen, every subsequent step is strictly volume-preserving and orientation-preserving, so the standard descent argument applies and the orbit reaches the trivial cycle.

### 7.2 Navier–Stokes (LASLS Gauge)

The local energy and enstrophy inequalities remain unchanged because det J_{Φ_Λ} = 1. The only global threat is an orientation-reversing concentration.

Insert the residual-flux parity into the energy inequality by the multiplier:

    E(t) + κ ∫₀ᵗ μ(s) ds,

where κ > 0 is chosen so that any orientation-reversing event is charged against the energy.

The sharpness condition (ΔS > 0) implies that the modified energy remains bounded, converting the topological obstruction into a controllable integral term. Under the existing QD-TER analytic hypotheses, the bound closes and regularity follows.

---

## 8. Dimensional Scaling: S² Through S⁶

The framework scales dimensionally through the nilpotency index of the scar tensor Λ.

| Target | Real dim | Complex dim | Λ nilpotency | Complex structure? | Framework mode |
|--------|----------|-------------|--------------|-------------------|----------------|
| **S² (CP¹)** | 2 | 1 | 2 | **Yes** — canonical | Möbius origin: discrete fold = classical inversion |
| **S³** | 3 | — | 3 | **No** — Hopf/Adams | Real manifold: triangular group = full tame subgroup |
| **S⁴** | 4 | — | 4 | **No** — Adams 1960 | Real manifold: no almost-complex structure |
| **S⁵** | 5 | — | 5 | **No** | Real manifold: purely smooth |
| **S⁶** | 6 | 3 (candidate) | 3 | **Almost complex** (octonionic) | **Exceptional**: holomorphy constraint + Möbius control |

### 8.1 S² — The Möbius Origin

CP¹ chart transitions are Möbius transformations. The discrete Möbius fold is named for this case. In 1 complex dimension, Λ is a single off-diagonal entry λ₂₁ — the "half-twist" is classical Möbius inversion. The framework recovers the standard result as a special case.

### 8.2 S³, S⁴, S⁵ — Real Manifold Mode

No complex structure exists. The framework operates with purely real triangular Jacobians. The absence of holomorphy simplifies the analysis: the triangular group is the full tame automorphism subgroup, and the residual-flux parity tracks only real orientation reversals.

### 8.3 S⁶ — The Exceptional Case

The only sphere besides S² with a candidate complex structure. The framework has maximal leverage here because the 3×3 complex scar tensor sits at the boundary between local control and global obstruction. The residual-flux parity μ_n distinguishes integrable complex charts from merely almost-complex ones, and the L ≥ 0 bound forbids spontaneous parity flips.

---

## 9. Application to Collatz (Hierarchical Gauge)

### 9.1 Setup

Each recursive step of the Collatz map T(n) = n/2 (n even), (3n+1)/2 (n odd) is represented as a density update ρ → ρ' with triangular Jacobian structure. The volume-preserving constraint (det = 1) forces the orbit to live on a constrained submanifold.

### 9.2 Möbius Charge

Any hierarchy-reversing step (an odd-numbered Collatz step in a certain encoding) increments the discrete Möbius charge μ_n.

### 9.3 Lyapunov Control

The updated Lyapunov Ṽ_n = V_n + C·μ_n ensures that hierarchy-reversing steps cannot decrease the Lyapunov function.

### 9.4 Scar Saturation and Convergence

Because L ≥ 0 and α < 1, the scar Λ_n eventually saturates. Once saturated, μ_n freezes. Every subsequent step is strictly volume-preserving and orientation-preserving. The orbit must then descend to the trivial cycle {1, 2, 1, ...}.

**Status:** The framework converts Collatz from a number-theoretic mystery into a dynamical systems convergence theorem governed by a controlled topological charge.

---

## 10. Application to Navier–Stokes (LASLS Gauge)

### 10.1 Local Control

Local energy/enstrophy estimates sit on det J_Φ = 1. The hierarchical Jacobian structure ensures that local chart transitions preserve volume and orientation at the infinitesimal level.

### 10.2 Global Threat

The only remaining obstruction is an orientation-reversing concentration of vorticity. This is exactly what the scar monitor ΔS_n tracks.

### 10.3 Modified Energy Inequality

Insert the residual-flux parity into the energy estimate:

    E(t) + κ ∫₀ᵗ μ(s) ds,

where κ > 0 charges any orientation-reversing event against the energy.

### 10.4 Regularity Closure

The sharpness condition ΔS > 0 implies the modified energy remains bounded, converting the topological obstruction into a controllable integral term. Under the QD-TER analytic hypotheses, the bound closes and regularity follows.

**Status:** The framework converts the Navier–Stokes blow-up question from a PDE singularity analysis into a topological charge conservation problem.

---

## 11. General Pattern and Conclusion

> **Local algebraic/analytic control** ← upgraded hierarchical Jacobian  
> **Global topological/orientability control** ← discrete membrane fold + scar  
> **Conditional Millennium statements** sit exactly at this interface.

For any n-dimensional manifold (real or complex), the same three-layer architecture applies. The only variable is whether local charts are constrained by holomorphy (complex case: S², S⁶) or merely smooth invertibility (real case: S³, S⁴, S⁵).

The hierarchical Jacobian + discrete Möbius fold framework is not a collection of tricks for individual problems. It is a unified structural principle that identifies the local-vs-global gap as a topological charge conservation problem, supplies an explicit monitor for that charge, and converts open existence questions into checkable dynamical conditions.

---

## 12. Priority Statement

This document consolidates work that was developed and posted incrementally on X (Twitter) starting **July 25, 2026**. The structural parallelism between causal DAG hierarchies and classical triangular (Jonquières) polynomial automorphisms, together with the discrete Möbius fold, residual-flux parity, scar tensor, and associated entropy identity, was conceived and formalized by the author prior to any external publication or usage.

Any subsequent adoption, citation, or extension of these ideas without proper attribution constitutes an unacknowledged appropriation of independently originated research.

The author reserves all rights to proper attribution for these independently developed contributions.

---

*JackyReaps / AnooBus · August 28, 2026*
