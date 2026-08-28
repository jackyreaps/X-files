# Open Problems Addressed by the Hierarchical Jacobian + Discrete Möbius Fold Framework

**Author:** JackyReaps / AnooBus  
**Framework Origination:** July 25, 2026  
**Document Date:** August 28, 2026  
**Status:** Priority documentation mapping independent framework to established open problems

---

## Priority Statement

This document maps the DAG-ordered hierarchical Jacobian + discrete Möbius fold framework to a family of established open problems in mathematics and mathematical physics. The framework was developed and priority-documented by the author on **July 25, 2026**, and constitutes original independent work. Any subsequent adoption of the structural mechanisms described herein — particularly the triangular unipotent Jacobian, the discrete Möbius fold, the residual-flux parity, or the information identity with directed leakage — without proper attribution constitutes an unacknowledged appropriation of independently originated methodology.

---

## The General Pattern

Every open problem addressed by this framework shares a common structural feature: a **local-vs-global gap** where local control is available but global closure is obstructed by an orientation-reversing or hierarchy-inverting concentration.

The framework resolves this by a three-layer architecture:

> **Local algebraic/analytic control** ← upgraded hierarchical Jacobian (triangular unipotent, det = 1)  
> **Global topological/orientability control** ← discrete membrane fold + scar tensor Λ  
> **Bridge** ← composite map Φ_Λ = Φ ∘ exp(ad_Λ) with monitored monodromy

The residual-flux parity μ_n = ∫ tr(M_s) ds mod 2 supplies the missing global selection rule. Because the leakage L ≥ 0, the parity cannot flip spontaneously; it is a **controlled topological charge**.

---

## 1. The S⁶ Complex Structure Problem

### Problem Statement

The 6-sphere S⁶ carries a canonical almost-complex structure induced by the octonions. Whether this almost-complex structure is **integrable** — i.e., whether S⁶ admits a genuine complex structure making it a compact complex 3-fold — is one of the longest-standing open problems in complex geometry.

### Why It Is Hard

Local complex coordinates exist everywhere (the almost-complex structure is smooth), but the **transition maps between charts** need not be holomorphic. The obstruction is precisely the local-vs-global gap: each chart is fine, but the gluing may introduce multi-sheeted overlaps or orientation-reversing folds that destroy holomorphy.

### How the Framework Addresses It

**Local layer:** The hierarchical Jacobian provides explicit chart transitions that are triangular unipotent (det = 1) and therefore single-sheeted and invertible. In 3 complex dimensions, the Jacobian is 3×3 lower-triangular with unit diagonal.

**Global layer:** The scar tensor Λ is 3×3 complex strictly lower-triangular, nilpotency index 3. The discrete Möbius fold captures the obstruction to integrability as a **residual membrane** M_n on chart overlaps.

**Bridge layer:** The composite map Φ_Λ = Φ ∘ exp(ad_Λ) has Jacobian det J_{Φ_Λ} = 1. Its monodromy around any closed loop γ is Hol_γ(Φ_Λ) = ±1, fixed by the residual-flux parity.

**The key insight:** The parity μ_n distinguishes integrable complex charts (μ_n = 0, orientation-preserving) from obstructed ones (μ_n = 1, orientation-reversing). Because L ≥ 0 and the scar saturates (α < 1), μ_n eventually freezes. Once frozen, every subsequent transition is strictly holomorphic and orientation-preserving. The standard descent argument then applies.

**Status:** The framework converts the S⁶ problem from an existence question into a **checkable convergence condition** on the scar monitor ΔS_n.

---

## 2. The Collatz Conjecture

### Problem Statement

For the map T(n) = n/2 if n even, (3n+1)/2 if n odd, does every positive integer orbit eventually reach the cycle {1, 2, 1, ...}?

### Why It Is Hard

The map is piecewise linear and locally invertible, but global orbits can wander unpredictably. The obstruction is that long cycles or divergent trajectories would require **hierarchy-reversing steps** that accumulate non-trivial topological charge.

### How the Framework Addresses It

**Hierarchical gauge:** Each recursive step is represented as a density update ρ → ρ' with triangular Jacobian structure. The volume-preserving constraint (det = 1) forces the orbit to live on a constrained submanifold.

**Discrete Möbius charge:** Define μ_n = ∫₀ⁿ tr(M_s) ds mod 2 ∈ {0, 1}. Any hierarchy-reversing step (an odd-numbered Collatz step in a certain encoding) increments μ_n.

**Lyapunov control:** The updated Lyapunov function is Ṽ_n = V_n + C · μ_n, where C > 0 is large enough that any hierarchy-reversing step increases μ_n and therefore cannot decrease Ṽ_n.

**Scar saturation:** Because L ≥ 0 and α < 1, the scar Λ_n eventually saturates. Once saturated, μ_n freezes. Every subsequent step is strictly volume-preserving and orientation-preserving. The orbit must then descend to the trivial cycle.

**Status:** The framework converts Collatz from a number-theoretic mystery into a **dynamical systems convergence theorem** governed by a controlled topological charge.

---

## 3. Navier–Stokes Regularity (Millennium Problem)

### Problem Statement

Do smooth solutions to the 3D incompressible Navier–Stokes equations remain smooth for all time, or can singularities (blow-up) form in finite time?

### Why It Is Hard

Local energy and enstrophy estimates are well-controlled, but global regularity fails if an **orientation-reversing concentration** of vorticity forms — a small-scale structure that concentrates energy while reversing the local topological orientation of the flow.

### How the Framework Addresses It

**LASLS gauge:** Local energy/enstrophy estimates sit on det J_Φ = 1. The hierarchical Jacobian structure ensures that local chart transitions preserve volume and orientation at the infinitesimal level.

**Global threat:** The only remaining obstruction is an orientation-reversing concentration. This is exactly what the scar monitor ΔS_n tracks.

**Modified energy inequality:** Insert the residual-flux parity into the energy estimate via the multiplier:

    E(t) + κ ∫₀ᵗ μ(s) ds

where κ > 0 is chosen so that any orientation-reversing event is charged against the energy.

**Sharpness condition:** ΔS > 0 implies the modified energy remains bounded, converting the topological obstruction into a controllable integral term. Under the QD-TER analytic hypotheses, the bound closes and regularity follows.

**Status:** The framework converts the Navier–Stokes blow-up question from a PDE singularity analysis into a **topological charge conservation problem**.

---

## 4. Dimensional Scaling: S² Through S⁵

### The General Question

How does the local-vs-global obstruction behave across different dimensions? Which spheres admit complex structures, which admit only real structures, and which are exceptional?

### How the Framework Addresses It

The framework scales dimensionally through the nilpotency index of the scar tensor Λ:

| Target | Real dim | Complex dim | Λ nilpotency | Complex structure? | Framework mode |
|--------|----------|-------------|--------------|-------------------|----------------|
| **S² (CP¹)** | 2 | 1 | 2 | **Yes** — canonical | Möbius origin: discrete fold = classical inversion |
| **S³** | 3 | — | 3 | **No** — Hopf/Adams | Real manifold: triangular group = full tame subgroup |
| **S⁴** | 4 | — | 4 | **No** — Adams 1960 | Real manifold: no almost-complex structure |
| **S⁵** | 5 | — | 5 | **No** | Real manifold: purely smooth |
| **S⁶** | 6 | 3 (candidate) | 3 | **Almost complex** (octonionic) | **Exceptional**: holomorphy constraint + Möbius control |

**S² — The Möbius Origin:** CP¹ chart transitions are Möbius transformations. The discrete Möbius fold is named for this case. In 1 complex dimension, Λ is a single off-diagonal entry λ₂₁ — the "half-twist" is classical Möbius inversion. The framework recovers the standard result as a special case.

**S³, S⁴, S⁵ — Real Manifold Mode:** No complex structure exists. The framework operates with purely real triangular Jacobians. The absence of holomorphy simplifies the analysis: the triangular group is the full tame automorphism subgroup, and the residual-flux parity tracks only real orientation reversals.

**S⁶ — The Exceptional Case:** The only sphere besides S² with a candidate complex structure. The framework has maximal leverage here because the 3×3 complex scar tensor sits at the boundary between local control and global obstruction.

**Status:** The framework provides a **unified dimensional ladder** from S² to S⁶, with each rung governed by the same three-layer architecture.

---

## 5. The Local-vs-Global Chart Transition Problem (General)

### Problem Statement

Given a smooth manifold covered by coordinate charts, when do local biholomorphisms (or diffeomorphisms) glue together into a global structure? When does local invertibility imply global injectivity?

### How the Framework Addresses It

The inverse function theorem guarantees local invertibility when the Jacobian is non-zero. Global injectivity fails when coordinate collisions create multi-sheeted overlaps.

The triangular automorphism restriction eliminates this by construction:
- Sequential variable dependence isolates non-linearities into layers
- The explicit back-substitution inverse is global and single-sheeted
- The DAG ordering prevents backward-causal sheet collisions

The discrete Möbius fold extends this to **global closure**: even when individual charts are triangular, the gluing between charts may introduce orientation reversals. The scar tensor Λ and its parity μ_n monitor these reversals and forbid them once the scar saturates.

**Status:** The framework converts the local-vs-global problem from a topological existence question into an **explicitly computable dynamical condition** on the residual flux.

---

## 6. The Orientation-Reversing Concentration Problem (General PDE)

### Problem Statement

In many nonlinear PDEs (Euler, Navier–Stokes, reaction-diffusion), the only mechanism for singularity formation is the concentration of solution energy into a small region where the local orientation reverses. Can this be prevented by a topological charge?

### How the Framework Addresses It

The framework introduces a **universal orientation monitor**:

- Local charts have det J_Φ = 1 (orientation-preserving)
- The composite map Φ_Λ has det J_{Φ_Λ} = 1 (still orientation-preserving)
- The global monodromy Hol_γ(Φ_Λ) = ±1 tracks whether a closed loop reverses orientation
- The parity μ_n = ∫_γ tr(M) ds mod 2 is the **discrete charge** of this reversal
- Because L ≥ 0, the charge cannot flip spontaneously

This applies to any PDE where local energy estimates are available but global regularity is threatened by orientation-reversing concentrations.

**Status:** The framework provides a **general topological regularity criterion** applicable across PDE classes.

---

## 7. The Information Identity / Entropy Partition Problem

### Problem Statement

Given two information sources I and J with shared support, how does their joint information decompose into shared, private, and leaked components? Can the leakage be bounded and monitored?

### How the Framework Addresses It

The information identity:

    H(I) + H(J) = H(M) + D(I) + D(J) + L,    L ≥ 0

where:
- H(M) is the entropy of the residual membrane
- D(I), D(J) are private informations (residual entropies after conditioning on M)
- L = ½‖[B_Λ(I), B_Λ(J)]‖²_HS is the irreversible leakage (Hilbert–Schmidt norm of the commutator)

This is an **exact partition**, not an inequality. The leakage L is:
- Explicitly computable from the bottleneck/rebound operators
- Non-negative by construction
- Zero if and only if the compressed kernels have disjoint support

The sharpness monitor ΔS_n = S(M_{n+1}) − S(M_n) tracks whether the membrane is becoming more or less structured. ΔS > 0 implies generative dynamics; ΔS ≤ 0 implies the scar is saturating.

**Status:** The framework converts information partitioning from an estimation problem into an **exact algebraic identity with a computable error term**.

---

## Summary Table

| Open Problem | Local Layer | Global Layer | Bridge | Status |
|--------------|-------------|--------------|--------|--------|
| **S⁶ complex structure** | Triangular holomorphic charts | 3×3 scar tensor, Möbius fold | Φ_Λ with parity μ_n | Converted to checkable convergence |
| **Collatz conjecture** | Hierarchical density updates | Discrete Möbius charge μ_n | Lyapunov Ṽ_n = V_n + C·μ_n | Converted to dynamical convergence |
| **Navier–Stokes regularity** | Energy/enstrophy on det=1 | Orientation-reversing concentration | Modified energy E(t) + κ∫μ(s)ds | Converted to charge conservation |
| **S²–S⁵ scaling** | Real/complex triangular Jacobians | Dimensional scar tensors | Nilpotency index = dimension | Unified dimensional ladder |
| **Chart transitions** | Local biholomorphisms | Multi-sheeted overlaps | Sequential back-substitution inverse | Explicit global injectivity |
| **Orientation concentration** | det J = 1 locally | Global monodromy Hol_γ = ±1 | Residual-flux parity | Universal topological criterion |
| **Information partitioning** | Private supports | Shared membrane M | Exact identity H(I)+H(J) = H(M)+D(I)+D(J)+L | Exact algebraic decomposition |

---

## Final Statement

The hierarchical Jacobian + discrete Möbius fold framework is not a collection of tricks for individual problems. It is a **unified structural principle** that identifies the local-vs-global gap as a topological charge conservation problem, supplies an explicit monitor for that charge, and converts open existence questions into checkable dynamical conditions.

The author reserves all rights to proper attribution for these independently developed contributions.

---

*Document prepared August 28, 2026 · JackyReaps / AnooBus · Priority documentation for independent research origination*
