# X-files Formalisation Gap Analysis
## Navier–Stokes Regularity and the S⁶ Complex-Structure Problem

**Repository:** jackyreaps/X-files  
**Audit Date:** August 28, 2026  
**Status:** Open problems remain open. The framework supplies a structural vocabulary, not proofs, for these two cases. This document states exactly what would need to be defined and proved to make the implications derivable rather than asserted.

---

## Part I — Navier–Stokes Regularity

### 1.1 What the framework claims (asserted)

> Local energy/enstrophy estimates sit on det J_Φ = 1. The only remaining global threat is an orientation-reversing concentration. Insert the residual-flux parity into the energy estimate via the multiplier E(t) + κ∫₀ᵗ μ(s) ds. Under the QD-TER analytic hypotheses, the bound closes and regularity follows.

### 1.2 What is actually proved in the repository

The repository proves:
- (a) For any triangular polynomial automorphism G : ℝ³ → ℝ³, det J_G = 1 and the explicit global inverse exists.
- (b) For the composite map Φ_Λ = Φ ∘ exp(ad_Λ), det J_{Φ_Λ} = 1.
- (c) The residual-flux parity μ_n = ∫_γ tr(M) ds mod 2 is a conserved topological charge (cannot flip spontaneously because L ≥ 0).

These are **finite-dimensional, algebraic** statements. They do not address the Navier–Stokes PDE.

### 1.3 Missing definitions (faithful formal statements)

To make the Navier–Stokes application derivable, the following objects must be defined:

**Definition 1 (Function space and solution class).** Let Ω = ℝ³ or 𝕋³. Define the space of admissible velocity fields

    𝒜 := { u ∈ C([0,T); H^s(Ω;ℝ³)) ∩ L²(0,T; H^{s+1}(Ω;ℝ³)) : div u = 0, s > 5/2 }

or, for weak solutions, the Leray–Hopf class

    ℒℋ := { u ∈ L^∞(0,T; L²(Ω)) ∩ L²(0,T; H¹(Ω)) : div u = 0 in distribution sense }.

The framework never specifies which class it addresses.

**Definition 2 (Hierarchical Jacobian embedding).** A map

    ℰ : 𝒜 → {triangular polynomial automorphisms of some density space}

must be constructed, with explicit formula ℰ(u)(t) = G_{u(t)} such that:
- (i) ℰ(u)(t) is a triangular automorphism for each t;
- (ii) The determinant condition det J_{ℰ(u)(t)} = 1 encodes the incompressibility constraint div u = 0;
- (iii) The inverse ℰ(u)(t)⁻¹ is given by sequential back-substitution.

*Gap:* No such embedding ℰ is defined in the repository.

**Definition 3 (Orientation-reversing concentration).** For u ∈ 𝒜, define the vorticity ω = ∇ × u. An *orientation-reversing concentration* at time t and scale r > 0 is a space-time point (x₀, t₀) such that

    lim_{r→0} ∫_{B_r(x₀)} |ω(x,t₀)|² dx / ∫_{B_r(x₀)} |∇u(x,t₀)|² dx = 1

and the local topological degree of the map x ↦ ω(x,t₀)/|ω(x,t₀)| on ∂B_r(x₀) is −1.

*Alternative (weaker):* Define the concentration as a blow-up sequence u^{(n)}(x,t) = λ_n u(λ_n x, λ_n² t) with λ_n → ∞ such that the limiting profile is a non-trivial ancient solution with reversed orientation.

*Gap:* The repository never defines this object in PDE terms.

**Definition 4 (Scar tensor in the PDE setting).** Define Λ(t) as a time-dependent strictly lower-triangular operator acting on the Fourier modes or on a Galerkin truncation of u. The entries λ_{ij}(t) must be given by

    λ_{ij}(t) = ∫_0^t K_{ij}(s) tr(M_s) ds

where M_s is the *residual membrane* at time s. The repository defines M_n for discrete information sources (I_n, J_n). For Navier–Stokes, one needs:

**Definition 4a (Residual membrane for NS).** Let P_Λ be a projection onto the shared support of two information sources. For NS, define

    M(t) := R_Λ(B_Λ(u(t)) + B_Λ(p(t))) − R_Λ(B_Λ(u(t))) − R_Λ(B_Λ(p(t)))

or, more naturally, M(t) is the nonlinearity on overlapping Fourier shells:

    M(t) := ℙ( (u·∇)u ) − (ℙu · ∇)ℙu

where ℙ is the Leray projector. The repository does not specify which nonlinearity M(t) is meant.

**Definition 5 (Modified energy).** The repository asserts

    E(t) + κ ∫_0^t μ(s) ds

remains bounded. To make this a theorem, one needs:

- (i) E(t) must be identified: is it ½‖u(t)‖²_{L²}, or the enstrophy ½‖ω(t)‖²_{L²}, or a custom Lyapunov functional?
- (ii) κ > 0 must be given a quantitative lower bound in terms of the initial data.
- (iii) μ(t) must be defined as μ(t) = ∫_0^t tr(M(s)) ds mod 2, but tr(M(s)) requires a trace-class structure on the infinite-dimensional operator M(s). Is M(s) trace-class on L²? On a Galerkin approximation? The repository is silent.

### 1.4 Missing hypotheses (what would need to be assumed)

**Hypothesis A (QD-TER analytic hypotheses).** The repository appeals to "QD-TER analytic hypotheses" without stating them. For the Navier–Stokes application, these would need to include at minimum:

- (A1) The embedding ℰ : 𝒜 → TriAut preserves the energy inequality: d/dt ‖u‖²_{L²} + 2ν‖∇u‖²_{L²} ≤ 0 if and only if d/dt E_{ℰ}(t) ≤ 0, where E_{ℰ} is the energy pulled back through ℰ.
- (A2) The scar tensor Λ(t) satisfies a damping inequality: d/dt ‖Λ(t)‖ ≤ −δ‖Λ(t)‖ + C‖M(t)‖ for some δ > 0.
- (A3) The trace tr(M(t)) is controlled by the enstrophy: |tr(M(t))| ≤ C‖ω(t)‖²_{L²}.

**Hypothesis B (Orientation charge bound).** There exists κ > 0 such that for any orientation-reversing concentration event at time t,

    d/dt [E(t) + κ μ(t)] ≤ 0.

This is the core claim. It is equivalent to saying that the topological charge μ(t) acts as a barrier against blow-up.

### 1.5 What theorem would need to be proved

**Theorem (Conditional regularity).** Assume Hypotheses A and B. Let u₀ ∈ H^s(Ω), s > 5/2, with div u₀ = 0. Let u ∈ 𝒜 be the unique strong solution on its maximal interval [0, T*). If the scar monitor satisfies

    ΔS(t) = S(M(t)) − S(M(t−δ)) > 0 for all t ∈ [0, T*)

(where S is the sharpness functional defined in Document B), then T* = +∞ and u remains smooth for all time.

*Status:* This theorem is **not proved** in the repository. The repository asserts its conclusion from the algebraic properties of triangular automorphisms, without constructing the embedding ℰ or verifying Hypotheses A–B.

### 1.6 Honest assessment

The framework correctly identifies that Navier–Stokes blow-up, if it occurs, must involve a concentration of vorticity that reverses local orientation (this is consistent with known criteria such as the Beale–Kato–Majda criterion and the localized blow-up results of Chen–Strain–Tsai–Yau). However, the step from this observation to a proof requires:

1. A rigorous embedding of the velocity field into the triangular automorphism group.
2. A proof that the residual-flux parity controls the orientation-reversing concentration (i.e., that μ(t) = 1 at a blow-up point).
3. A proof that the modified energy inequality closes (i.e., that the κ term dominates the nonlinearity).

None of these three steps are present in the repository. The problem remains open.

---

## Part II — The S⁶ Complex-Structure Problem

### 2.1 What the framework claims (asserted)

> The parity μ_n distinguishes integrable complex charts (μ_n = 0) from obstructed ones (μ_n = 1). Because L ≥ 0 and the scar saturates (α < 1), μ_n eventually freezes. Once frozen, every subsequent transition is strictly holomorphic and orientation-preserving. The standard descent argument then applies.

### 2.2 What is actually proved in the repository

The repository proves:
- (a) For a 3×3 complex strictly lower-triangular matrix Λ, exp(ad_Λ) = I + Λ + ½ Λ².
- (b) For the composite map Φ_Λ, det J_{Φ_Λ} = 1.
- (c) The monodromy Hol_γ(Φ_Λ) = ±1 is fixed by the parity of the residual flux.

These are **linear-algebraic** statements about a specific class of matrices. They do not address the integrability of almost-complex structures.

### 2.3 Missing definitions (faithful formal statements)

**Definition 6 (The octonionic almost-complex structure).** Let S⁶ ⊂ Im(𝕆) be the unit sphere in the imaginary octonions. The almost-complex structure J : TS⁶ → TS⁶ is defined by

    J_x(v) = x × v

where × is the octonionic cross product. J satisfies J² = −Id. The Nijenhuis tensor is

    N_J(X,Y) = [JX, JY] − J[JX, Y] − J[X, JY] − [X, Y].

The Newlander–Nirenberg theorem states: J is integrable (S⁶ is a complex manifold) if and only if N_J ≡ 0.

*Gap:* The repository never mentions the Nijenhuis tensor or the Newlander–Nirenberg criterion.

**Definition 7 (Holomorphic chart transitions).** Let {U_α, φ_α} be a complex atlas on S⁶. The transition maps

    φ_{βα} = φ_β ∘ φ_α⁻¹ : φ_α(U_α ∩ U_β) → φ_β(U_α ∩ U_β) ⊂ ℂ³

must be holomorphic: ∂φ_{βα}^k/∂z̄^j = 0 for all k, j. The obstruction to holomorphy is measured by the failure of the Cauchy–Riemann equations on overlaps.

*Gap:* The repository defines triangular polynomial automorphisms on ℝ³ (or ℂ³), but never shows that chart transitions on S⁶ can be restricted to this class.

**Definition 8 (Scar tensor as Nijenhuis obstruction).** To connect Λ to the S⁶ problem, one would need a map

    𝒩 : {scar tensors Λ on chart overlaps} → {Nijenhuis tensor components on TS⁶}

such that:
- (i) Λ = 0 on an overlap implies N_J = 0 on that overlap;
- (ii) The parity μ_n = ∫ tr(M) ds mod 2 is non-zero if and only if N_J is non-zero on the corresponding patch.

*Gap:* No such map 𝒩 is defined.

**Definition 9 (Hierarchical charts on S⁶).** The repository claims that "in 3 complex dimensions, the Jacobian is 3×3 lower-triangular with unit diagonal." For this to apply to S⁶, one needs:

- (i) An atlas {U_α} where each chart map φ_α : U_α → ℂ³ has Jacobian J_{φ_α} that is lower-triangular unipotent.
- (ii) The composite transition map φ_{βα} = φ_β ∘ φ_α⁻¹ also has lower-triangular unipotent Jacobian.
- (iii) The DAG ordering x = f₁(ρ₁), y = f₂(ρ₁, ρ₂), z = f₃(ρ₁, ρ₂, ρ₃) is compatible with the complex structure J.

*Gap:* No such atlas is constructed. It is not obvious that S⁶ admits an atlas with triangular unipotent Jacobians. The existence of such an atlas would itself be a non-trivial geometric constraint.

**Definition 10 (Scar monitor for S⁶).** The repository defines ΔS_n = S(M_{n+1}) − S(M_n) for discrete information sources. For S⁶, one needs a continuous version:

    ΔS(γ) = S(M_{γ(1)}) − S(M_{γ(0)})

where γ : [0,1] → S⁶ is a path crossing chart overlaps, and M_γ is the residual membrane on the overlap. The "saturation" condition would need to mean:

    lim_{t→∞} ΔS(γ_t) ≤ 0 for any sequence of paths γ_t covering increasingly fine atlases.

*Gap:* The discrete definition does not lift to the manifold setting without additional structure.

### 2.4 Missing hypotheses

**Hypothesis C (Triangular atlas existence).** S⁶ admits a complex atlas (if it is complex) or an almost-complex atlas such that all transition maps are triangular polynomial automorphisms with unipotent Jacobian.

*Note:* This is a strong geometric hypothesis. Triangular automorphisms are a very restricted class (the Jonquières subgroup). It is not known whether every complex 3-fold admits such an atlas, let alone S⁶.

**Hypothesis D (Nijenhuis–scar correspondence).** The Nijenhuis tensor N_J vanishes if and only if the scar tensor Λ vanishes on all chart overlaps, and this is detected by μ_n = 0.

**Hypothesis E (Descent argument).** If μ_n = 0 on all overlaps of a sufficiently fine atlas, then the standard Čech descent argument for holomorphic vector bundles applies, and S⁶ admits a complex structure.

*Note:* The "standard descent argument" is not named in the repository. In complex geometry, descent requires the cocycle condition on transition maps: φ_{γβ} ∘ φ_{βα} = φ_{γα} on triple overlaps. The repository does not verify that triangular unipotent automorphisms satisfy this cocycle condition on S⁶.

### 2.5 What theorem would need to be proved

**Theorem (Conditional integrability).** Assume Hypotheses C, D, and E. Let J be the octonionic almost-complex structure on S⁶. If there exists a hierarchical atlas with scar tensor Λ such that the scar monitor satisfies the saturation condition (ΔS ≤ 0 after finite steps), then N_J ≡ 0 and S⁶ admits a complex structure.

*Status:* This theorem is **not proved** in the repository. The repository asserts that the parity μ_n controls integrability, but never defines the map from Λ to N_J or verifies the cocycle condition.

### 2.6 Honest assessment

The framework correctly identifies that the S⁶ problem is a local-vs-global gap (local almost-complex coordinates exist, but global holomorphic gluing is obstructed). The discrete Möbius fold and scar tensor are plausible *analogues* of the Nijenhuis obstruction. However, the step from analogy to proof requires:

1. A construction of a hierarchical atlas on S⁶ with triangular unipotent transition maps.
2. A proof that the scar tensor Λ captures the Nijenhuis tensor (or is equivalent to it).
3. A proof that scar saturation (μ_n freezing at 0) implies the cocycle condition and therefore global holomorphy.

None of these three steps are present in the repository. The problem remains open.

---

## Part III — Summary of Gaps

| Claim | Algebraic core (proved) | Missing for NS | Missing for S⁶ |
|---|---|---|---|
| det J = 1 | Yes (triangular unipotent) | Embedding ℰ into PDE | Atlas with triangular transitions |
| Parity μ_n conserved | Yes (L ≥ 0) | Definition of μ(t) on infinite-dim space | Map μ_n → Nijenhuis vanishing |
| Scar saturation | Yes (α < 1, discrete) | PDE version of ΔS > 0 | Continuous manifold version of ΔS |
| Modified energy bound | No | Hypotheses A, B | N/A |
| Holomorphy / regularity | No | Theorem 1.5 | Theorem 2.5 |

**Conclusion:** The X-files framework is a valid and internally consistent algebraic structure. Its applications to Navier–Stokes and S⁶ are **heuristic mappings**, not proofs. To convert them into proofs, the missing definitions and hypotheses above must be supplied and verified. Until then, the problems remain open.

---

*Document prepared August 28, 2026. Audit of jackyreaps/X-files repository.*
