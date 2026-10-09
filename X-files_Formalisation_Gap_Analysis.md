# X-files Formalisation Gap Analysis

## Navier–Stokes Regularity and the S⁶ Complex-Structure Problem

**Repository:** jackyreaps/X-files
**Audit Date:** August 28, 2026
**Status:** Open problems remain open. The framework supplies a structural
vocabulary, not proofs, for these two cases. This document states exactly what
would need to be defined and proved to make the implications derivable rather
than asserted.

## Part I — Navier–Stokes Regularity

### 1.1 What the framework claims (asserted)

> Local energy/enstrophy estimates sit on det J_Φ = 1. The only remaining
> global threat is an orientation-reversing concentration. Insert the
> residual-flux parity into the energy estimate via the multiplier
> E(t) + κ∫₀ᵗ μ(s) ds. Under the QD-TER analytic hypotheses, the bound closes
> and regularity follows.

### 1.2 What is actually proved in the repository

The repository proves:

- **(a)** For a triangular polynomial automorphism **with unit diagonal**,
  i.e. `P_i = x_i + g(x₁, …, x_{i−1})`, one has `det J_G = 1` and the explicit
  global inverse exists. **Unit diagonal is necessary.** The map
  `(x, y, z) ↦ (2x, y, z)` is triangular with `det J_G = 2`, so the
  unqualified claim is false.

- **(b)** For the composite map Φ_Λ = Φ ∘ exp(ad_Λ), det J_{Φ_Λ} = 1.

- **(c)** The residual-flux parity μ_n = ∫_γ tr(M) ds mod 2 is a
  conserved topological charge. **Status: not proved.** Nothing in the
  repository establishes that parity is a conserved charge; the statement is a
  target, not a result.

These are **finite-dimensional, algebraic** statements. They do not address the
Navier–Stokes PDE.

### 1.3 Missing definitions (faithful formal statements)

To make the Navier–Stokes application derivable, the following objects must be
defined:

**Definition 1 (Function space and solution class).** Let Ω = ℝ³ or 𝕋³. Define
the space of admissible velocity fields

    := { u ∈ C([0,T); H^s(Ω;ℝ³)) ∩ L²(0,T; H^{s+1}(Ω;ℝ³)) : div u = 0, s > 5/2 }

or, for weak solutions, the Leray–Hopf class

    ℒℋ := { u ∈ L^∞(0,T; L²(Ω)) ∩ L²(0,T; H¹(Ω)) : div u = 0 in distribution sense }.

The framework never specifies which class it addresses.

**Definition 2 (Hierarchical Jacobian embedding).** A map
`ℰ : → {triangular polynomial automorphisms of some density space}` must be
constructed, with explicit formula `ℰ(u)(t) = G_{u(t)}` such that:

- (i) `ℰ(u)(t)` is a triangular automorphism for each `t`;
- (ii) The determinant condition `det J_{ℰ(u)(t)} = 1` encodes the
  incompressibility constraint `div u = 0`;
- (iii) The inverse `ℰ(u)(t)⁻¹` is given by sequential back-substitution.

*Gap:* No such embedding ℰ is defined in the repository.

**Definition 3 (Orientation-reversing concentration).** For u ∈ , define the
vorticity ω = ∇ × u. An *orientation-reversing concentration* at time t and
scale r > 0 is a space-time point (x₀, t₀) such that

    lim_{r→0} ∫_{B_r(x₀)} |ω(x,t₀)|² dx / ∫_{B_r(x₀)} |∇u(x,t₀)|² dx = 1

and the local topological degree of the map `x ↦ ω(x,t₀)/|ω(x,t₀)|` on
`∂B_r(x₀)` is −1.

*Alternative (weaker):* Define the concentration as a blow-up sequence
`u^{(n)}(x,t) = λ_n u(λ_n x, λ_n² t)` with `λ_n → ∞` such that the limiting
profile is a non-trivial ancient solution with the same structure.

## Part II — S⁶ Complex Structure

### 2.1 What the framework claims (asserted)

> The hierarchical Jacobian supplies chart transitions on S⁶ that are
> triangular unipotent (det = 1) and single-sheeted. The residual-flux parity
> selects orientation-preserving gluings. The standard descent argument then
> gives an integrable complex structure.

### 2.2 What is actually proved

Nothing on S⁶. The algebraic core (unit triangular Jacobian) is
finite-dimensional and does not address the manifold S⁶.

### 2.3 Missing definitions

**Definition 4 (Chart atlas).** A finite atlas of S⁶ whose transition maps are
triangular unipotent.

**Definition 5 (Parity selection).** A proof that the residual-flux parity μ_n
is 0 on the chosen atlas, or a construction that enforces it.

## Part III — What Would Close the Gap

For each of the two applications:

1. Define the function space and solution class (Definition 1).
2. Construct the embedding ℰ (Definition 2).
3. Define the orientation-reversing concentration (Definition 3).
4. Prove that the modified energy `ℰ(t) = E(t) + κμ(t)` satisfies
   `dℰ/dt ≤ 0` under the hypotheses.

Until these are supplied, the Navier–Stokes and S⁶ claims remain **conditional
templates**.

## Appendix — Stale references

The following were cited in earlier versions but are not in this repository:

- `residual-core/Xfiles/Jacobi.lean`
- `residual-core/Xfiles/Filters.lean`
- `residual-core/Xfiles/UnipotentJacobian.lean`
- `main/Framework/External/PrimeTower.lean`

Replacements for these are now in this repository: `X-files_Filters.lean`,
`X-files_Unforced_Boundary.lean`, `VolumePreservation.lean` (conditional),
`LASLS_Correctness.lean`, `LASLS_Anchor.lean`.
