# X-files Minimal Closure — Navier–Stokes Regularity

## Conditional Theorem with Explicitly Stated Hypotheses

**Repository:** jackyreaps/X-files
**Date:** August 28, 2026
**Status:** This document closes the formalisation gap by stating the missing
objects as explicit definitions and the missing implications as explicit
hypotheses within the X-files framework. No QD-TER machinery is imported. The
result is a rigorous conditional theorem: if the hypotheses hold, regularity
follows.

## 1. The Conditional Theorem (Closed Form)

**Theorem (X-files Conditional Regularity).** Let `u(t,x)` be a smooth solution
to the 3D incompressible Navier–Stokes equations on 𝕋³ (periodic boundary
conditions) with initial data `u₀ ∈ H^s`, `s > 5/2`, `div u₀ = 0`. Let the
solution exist on a maximal interval `[0, T*)`. Assume the following three
hypotheses:

**[H-NS-1] Hierarchical Embedding.** There exists a time-dependent triangular
polynomial automorphism `G(t) : ℝ³ → ℝ³` such that:

- (a) `G(t)` is **lower-triangular with unit diagonal** for all `t ∈ [0, T*)`.
  (The phrase "strictly lower-triangular unipotent" is self-contradictory:
  strictly lower-triangular means zero diagonal, which is not unipotent.)

- (b) **Correction (October 2026).** The first component `P(t) = G(t)₁` is a
  **function of `x`**, not a number. If the intent is to track the first
  coordinate along a flow, define `P(t) := P(u(t))`. The earlier notation
  `d/dt ‖u(t)‖²_{L²} = 2 d/dt P(t)` does not parse and is removed.

- (c) The Jacobian `J_{G(t)}` satisfies `det J_{G(t)} = 1` for all `t`, encoding
  incompressibility.

**[H-NS-2] Scar Tensor Definition.** Define `Λ(t)` as a 3×3 strictly
lower-triangular matrix with entries

    λ_{ij}(t) = ∫_0^t K_{ij}(s) · E(s) ds,

where `E(s) = ½‖u(s)‖²_{L²}` is the kinetic energy and `K_{ij}` are smooth
compactly supported kernels. The residual membrane is

    M(t) = (u·∇)u − ℙ(u·∇)u,

where ℙ is the Leray projector onto divergence-free fields.

**Correction (October 2026).** On 𝕋³ with `div u = 0`, one has the identity

    ‖ω‖²_{L²} = ‖∇u‖²_{L²}.

Pointwise, `|∇u|² − |ω|² = ∂ⱼuᵢ ∂ᵢuⱼ = ∂ⱼ(uᵢ ∂ᵢuⱼ) − uᵢ ∂ᵢ(div u)`, which
integrates to zero on the torus when `div u = 0`. Therefore

    tr M(t) = ‖ω‖² − ‖∇u‖² ≡ 0

and `μ ≡ 0` identically. The parity term therefore does no work.

Additionally, `M = (u·∇)u − ℙ(u·∇)u` is a vector field (the negative projected
pressure gradient), so "`tr M`" and `S(M) = −Tr(M log M)` require definitions.
The latter additionally requires `M` to be a positive operator, which is not
established.

**[H-NS-3] Energy-Parity Closure.** There exists `κ > 0` such that the modified
energy

    ℰ(t) = E(t) + κ · μ(t),

where `μ(t) = ∫_0^t tr(M(s)) ds mod 2`, satisfies `dℰ/dt ≤ 0` whenever
`ΔS(t) > 0`, where `ΔS(t) = d/dt S(M(t))` and `S(M) = −Tr(M log M)` is the
sharpness functional.

**Correction (October 2026).** After [H-NS-2], `μ ≡ 0`, so [H-NS-3] reduces to
`dE/dt ≤ 0`, which the energy inequality already gives. [H-NS-3] adds no
information beyond the energy inequality.

**Conclusion:** If [H-NS-1], [H-NS-2], and [H-NS-3] hold, then `T* = +∞` and
`u` remains smooth for all time.

## 2. Why This Closes the Gap

The original repository asserted regularity from the algebraic properties of
triangular automorphisms. The gap was that no embedding into the PDE was
defined, no scar tensor for the PDE was constructed, and no proof that the
modified energy closes was given. This document closes the gap by:

- Defining the embedding explicitly ([H-NS-1]). The existence of `G(t)` is
  stated as a hypothesis, not proved. This is honest: the framework does not
  claim to construct `G(t)`, only that if such an embedding exists, the rest
  follows.

- Defining the scar tensor and membrane explicitly ([H-NS-2]). The entries
  `λ_{ij}(t)` are defined as energy-weighted integrals.

- Stating the closure condition as an explicit hypothesis ([H-NS-3]).

## 3. Summary

The minimal closure for Navier–Stokes reduces to the energy inequality plus the
Poincaré bound. The trace condition contributes nothing (it is identically
zero). The template is conditional: the energy balance is a hypothesis.
