# Structural Invariants and Scaling Obstructions for Navier-Stokes and the Three-Body Problem

This note collects scaling heuristics and classical invariant constraints that
any claimed finite-time singularity in the 3D incompressible Navier-Stokes
equations or the Newtonian three-body problem must confront. The emphasis is on
intrinsic balances (dissipation versus stretching, angular momentum versus
potential) versus extrinsic mechanisms (velocity-dependent forcing, degenerate
coordinates, artificial parameter tuning). The arguments are **obstructions and
necessary filters**, not completed regularity theorems.

## 1. Navier-Stokes: Viscous versus Stretching Scales

Consider a smooth, divergence-free solution of the unforced 3D incompressible
Navier-Stokes equations:

    du/dt + (u · ∇)u = -∇p + ν Δu,   ∇ · u = 0

The vorticity formulation is:

    dω/dt + (u · ∇)ω = (ω · ∇)u + ν Δω

### Scaling for a filamentary geometry

Suppose a localized vortex structure of characteristic core radius `r(t)` going
to 0 and peak vorticity `Ω(t)`. Under the assumption that the structure remains
roughly filamentary, the two competing terms scale as:

    |(ω · ∇)u| ~ Ω² / r
    |ν Δω| ~ ν Ω / r²

Their ratio therefore satisfies:

    |ν Δω| / |(ω · ∇)u| ~ ν / (r Ω)

**Correction (October 2026).** If `Ω ≤ C/r`, then `ν/(rΩ) ≥ ν/C`. The ratio
tends to infinity only in the stronger regime `rΩ → 0`; the weaker `1/r` bound
gives a positive lower bound, not divergence.

By the Beale-Kato-Majda criterion, a singularity at time T* requires the
integral of Ω(t) from 0 to T* to be infinite. If `rΩ → 0`, viscous dissipation
dominates. This supplies a scaling obstruction for certain filament-type
geometries in the unforced equations. This is not a proof that no singularity
can form. It only constrains the admissible relative growth rates of Ω and r.

### Necessary filters for any claimed singularity

1. **Force structure** (if the claim is forced). The external force **f** must
   belong to a clearly stated function class. If **f** is permitted to depend on
   **u** (or its derivatives) in a way that cancels or overpowers `ν Δu`, the
   problem is effectively reduced to a driven Euler system.

2. **Coordinate non-degeneracy.** Any change of coordinates `Φ_t` used in the
   construction must satisfy `inf|det DΦ_t| ≥ δ > 0` up to the putative singular
   time. Otherwise one may be observing a coordinate collapse rather than a
   physical blow-up of velocity or vorticity norms.

3. **Energy-Parity Closure Bounds.** The total kinetic energy of the system must
   remain bounded by the initial energy input minus viscous dissipation over
   time. Any constructed forcing profile **f(x, t)** must not continuously inject
   unbounded localized energy without accounting for environmental
   counter-vortices or back-reactions that would physically disrupt the vortex
   core.

4. **Explicit Core Spatial Decay Rates.** The aspect ratio `(ℓ_z/ℓ_r)` governing
   the vortex core geometry must satisfy strict spatial decay and scaling
   constraints as `r(t) → 0`. Decoupling the dimensions to allow unconstrained
   axial stretching effectively treats a 3D fluid as a 1D line string,
   artificially bypassing 3D pressure-gradient dampening fields.

5. **Caffarelli–Kohn–Nirenberg (CKN) compatibility.** The singular set of a
   suitable weak solution has parabolic Hausdorff dimension at most 1. Any
   constructed self-similar singular profile restricted to a local spacetime box
   must prove compatibility with the global weak solution space; a persistent
   space-curve filament of positive length over a positive time interval sits in
   structural tension with this theorem unless extraordinary, globally balanced
   structure is present.

## 2. Three-Body Problem

The barrier

    K ≥ |J|² / (2I)

is large when the moment of inertia `I` is **small**. It therefore obstructs
**total collapse** (`I → 0`), not `I → ∞`. Sundman's theorem: total collision
forces `J = 0`, which is exactly the regime in which the barrier is active.

For exactly three bodies, Painlevé's theorem says every singularity is a
collision. Non-collision singularities require at least four bodies; Xia's
examples use five.

## 3. Trace Condition on 𝕋³

On 𝕋³ with `div u = 0`, one has the identity

    ‖ω‖²_{L²} = ‖∇u‖²_{L²}.

Pointwise, `|∇u|² − |ω|² = ∂ⱼuᵢ ∂ᵢuⱼ = ∂ⱼ(uᵢ ∂ᵢuⱼ) − uᵢ ∂ᵢ(div u)`, which
integrates to zero on the torus when `div u = 0`.

Therefore `tr M(t) = ‖ω‖² − ‖∇u‖² ≡ 0` and `μ ≡ 0`. The parity term in
`X-files_Minimal_Closure_NS.md` does no work.

Additionally, `M = (u·∇)u − ℙ(u·∇)u` is a vector field (the negative projected
pressure gradient), so "`tr M`" and `S(M) = −Tr(M log M)` require definitions;
the latter additionally requires `M` to be a positive operator, which is not
established.

## 4. Monodromy Sign

A product of unit lower-triangular matrices is unit lower-triangular, so its
determinant is `+1` and all eigenvalues are `1`. A monodromy built from
hierarchical unipotent Jacobians has `Hol_γ = +1` and cannot be `−1` without an
explicit orientation-reversing gluing outside the unipotent group.
