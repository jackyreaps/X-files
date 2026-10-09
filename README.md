# X-Files

**Hierarchical Jacobian + Discrete Möbius Fold Framework**

**Author:** JackyReaps / AnooBus
**Priority Date:** July 25, 2026
**Compiled:** August 28, 2026
**Last audit update:** October 7, 2026

## What This Is

This repository is a public, timestamped research log of an independent
structural framework built around hierarchical (triangular/unipotent) Jacobians
and a discrete Möbius-fold / scar-tensor construction. The algebraic core
(Layer 1) is elementary and fully explicit. The global and analytic layers
(scar dynamics, residual-flux parity, information identity) are still at the
level of **definitions + conditional templates**. All claims about
Navier–Stokes, S⁶, Collatz, etc. remain **conditional** on the existence and
regularity of the embeddings that have not yet been constructed in full detail.
The newest module (Prime Tower Drift Hypothesis) is self-contained, numerically
verified to n = 10⁵, and independent of the heavier analytic claims.

## Status of Major Directions (October 2026)

| Direction | Status | Notes |
|---|---|---|
| Hierarchical triangular Jacobian | Complete & elementary | det = 1, explicit inverse |
| Discrete Möbius / scar tensor | Definitional + formalisation gaps | See gap analysis |
| Residual-flux parity | Defined, not yet proved to control monodromy | — |
| Navier–Stokes | Conditional template only | Requires unverified embedding hypotheses |
| S⁶ complex structure | Exploratory | — |
| Collatz | Heuristic gauge idea | — |
| **Prime Tower Drift Hypothesis** | Numerically solid inside n ≤ 10⁵ | Clean, self-contained module |

## The Three-Layer Architecture

1. **Local:** Hierarchical triangular Jacobian (unipotent, det = 1, explicit inverse)
2. **Global:** Discrete Möbius fold + scar tensor Λ (interference membrane)
3. **Bridge:** Composite map Φ_Λ = Φ ∘ exp(ad_Λ) with monitored monodromy

The residual-flux parity μ_n = ∫ tr(M_s) ds mod 2 supplies the missing global
selection rule.

**Correction (October 2026).** The claim `Hol_γ(Φ_Λ) = ±1` is wrong as stated.
Every Jacobian in the composition is unit lower-triangular, hence has determinant
`+1` and all eigenvalues `1`. A product of such matrices is again unit
lower-triangular. Therefore `Hol_γ(Φ_Λ) = +1` for any monodromy built from these
Jacobians. A sign `−1` cannot occur without an orientation-reversing gluing
outside the unipotent group; no such gluing is constructed here.

**Correction (October 2026).** The claim `L ≥ 0` is a hypothesis, not a theorem.
With `D(I) = H(I) − I(I;M)` and `D(J) = H(J) − I(J;M)`, the identity

    H(I) + H(J) = H(M) + D(I) + D(J) + L

forces

    L = I(I;M) + I(J;M) − H(M).

This is negative in general. Counterexample: `I`, `J` independent fair bits,
`M = I ⊕ J`. Then `I(I;M) = I(J;M) = 0`, `H(M) = 1`, so `L = −1`. Any use of
`L ≥ 0` must carry it as an additional hypothesis on the joint distribution.

## Repository Contents

| File | Description |
|---|---|
| `01-priority-declaration.md` | Dated priority statement |
| `02-master-framework.md` | Complete mathematical framework |
| `03-open-problems.md` | Mapping to established open problems |
| `04-x-posts-index.md` | Chronological index of X posts |
| `05-OpenAI-structural-correspondence.md` | Correspondence with OpenAI structural work |
| `06-prime-tower-hypothesis.md` | Prime tower drift hypothesis |
| `07-LASLS-post-quantum-trapdoor.md` | LASLS construction; see correction note |
| `X-files_Formalisation_Gap_Analysis.md` | Audit: what is proved, what is missing, what is unformalisable |
| `X-files_Dimensional_Table_Corrected.md` | Corrected dimensional scaling table (S⁴ attribution, Λ nilpotency) |
| `X-files_Minimal_Closure_NS.md` | Conditional theorem for Navier–Stokes + audit criteria for forced singularities |
| `X-files_Minimal_Closure_S6.md` | Conditional theorem for S⁶ complex structure |
| `Structural_Obstructions.md` | Scaling obstructions & practical filters for NS and three-body |
| `X-files_Filters.lean` | Lean filters: coordinate non-degeneracy, rotational inertia, energy-parity |
| `X-files_Unforced_Boundary.lean` | Lean predicate `IsStrictlyUnforced` and forced-vs-unforced classifier |
| `Euler_Discrepancy_Audit.md` | Methodological parallels: forcing dependency & coordinate degeneracy |
| `VolumePreservation.lean` | Liouville interface for incompressible flows (δ = 1 non-degeneracy) |
| `VolumePreservationLemmas.lean` | Algebraic support + Jacobi Fin-3 interface |
| `LASLS_Correctness.lean` | Lean: classical LASLS correctness + refutations of §2.1–2.2, §4.2 |
| `LASLS_Anchor.lean` | Lean: exact bijectivity criterion and repaired family |

## Quick Reference

Hierarchical Jacobian:

    P_i(x₁, …, x_i) = x_i + g_i(x₁, …, x_{i−1}),   det J = 1.

Information identity:

    H(I) + H(J) = H(M) + D(I) + D(J) + L
    L := I(I;M) + I(J;M) − H(M)
    L ≥ 0 is a hypothesis on the joint distribution, not a theorem.

Composite map:

    Φ_Λ = Φ ∘ exp(ad_Λ).

Monodromy:

    Hol_γ(Φ_Λ) = +1   (for a monodromy built from unipotent Jacobians;
                       a sign −1 requires an orientation-reversing gluing,
                       which is not constructed here)

## Open Problems Addressed

Each entry is a **conditional template**: a formal scheme is stated, but the
embedding that would connect it to the classical problem is not constructed.

| Problem | Status |
|---|---|
| S⁶ complex structure | Conditional template; embedding not constructed. |
| Collatz conjecture | Conditional template; embedding not constructed. |
| Navier–Stokes regularity | Conditional template; embedding not constructed. |

## Lean formalisation

| File | Status |
|---|---|
| `X-files_Filters.lean` | Proved; definitions restated for current Mathlib. |
| `X-files_Unforced_Boundary.lean` | Proved; `True`-valued placeholder replaced. |
| `VolumePreservation.lean` | Statements only; two `sorry`s pending the Jacobi module. |
| `LASLS_Correctness.lean` | Proved; classical correctness plus refutations of §2.1–2.2, §4.2. |
| `LASLS_Anchor.lean` | Proved; exact bijectivity criterion and repaired family. |

Build with `lake build` (Lean v4.30.0, Mathlib pinned in `lake-manifest.json`).
