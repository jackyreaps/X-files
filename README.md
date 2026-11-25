# X-Files

**Hierarchical Jacobian + Discrete Möbius Fold Framework**

**Author:** JackyReaps / AnooBus  
**Priority Date:** July 25, 2026  
**Compiled:** August 28, 2026  
**Last audit update:** November 25, 2026

## What This Is

This repository is a public, timestamped research log of an independent structural framework built around hierarchical (triangular/unipotent) Jacobians and a discrete Möbius-fold / scar-tensor construction. The algebraic core (Layer 1) is elementary and fully explicit. The global and analytic layers (scar dynamics, residual-flux parity, information identity) are still at the level of **definitions + conditional templates**. All claims about Navier–Stokes, S⁶, Collatz, etc. remain **conditional** on the existence and regularity of embeddings that have not yet been constructed in full detail. The Prime Tower Drift Hypothesis is a self-contained module, numerically verified to n = 10⁵, and independent of the heavier analytic claims.

This repository also contains a separate Lean 4 case study on architectural auditing and a continuum-gap countermodel. Its conclusions are scoped to the explicitly modeled interfaces; see `META_VERIFICATION.md` and `riemann-hypothesis/COUNTERMODEL.md`.

## Status of Major Directions (November 2026)

| Direction | Status | Notes |
|---|---|---|
| Hierarchical triangular Jacobian | Complete & elementary | det = 1, explicit inverse |
| Discrete Möbius / scar tensor | Definitional + formalisation gaps | See gap analysis |
| Residual-flux parity | Defined, not yet proved to control monodromy | — |
| Navier–Stokes | Conditional template only | Requires unverified embedding hypotheses |
| S⁶ complex structure | Exploratory | — |
| Collatz | Heuristic gauge idea | — |
| **Prime Tower Drift Hypothesis** | Numerically solid inside n ≤ 10⁵ | Clean, self-contained module |
| RH continuum-gap case study | Modeled-interface result | See scope notes in `COUNTERMODEL.md` |

## The Three-Layer Architecture

1. **Local:** Hierarchical triangular Jacobian (unipotent, det = 1, explicit inverse)
2. **Global:** Discrete Möbius fold + scar tensor Λ (interference membrane)
3. **Bridge:** Composite map Φ_Λ = Φ ∘ exp(ad_Λ) with monitored monodromy

The residual-flux parity μ_n = ∫ tr(M_s) ds mod 2 is proposed as a global selection rule.

**Correction (October 2026).** The claim `Hol_γ(Φ_Λ) = ±1` is wrong as stated. Every Jacobian in the composition is unit lower-triangular, hence has determinant `+1` and all eigenvalues `1`. A product of such matrices is again unit lower-triangular. Therefore `Hol_γ(Φ_Λ) = +1` for any monodromy built from these Jacobians. A sign `−1` cannot occur without an orientation-reversing gluing outside the unipotent group; no such gluing is constructed here.

**Correction (October 2026).** The claim `L ≥ 0` is a hypothesis, not a theorem. With `D(I) = H(I) − I(I;M)` and `D(J) = H(J) − I(J;M)`, the identity

```text
H(I) + H(J) = H(M) + D(I) + D(J) + L
```

forces `L = I(I;M) + I(J;M) − H(M)`. This is negative in general. For independent fair bits `I`, `J` and `M = I ⊕ J`, it equals `−1`. Any use of `L ≥ 0` must carry it as an additional hypothesis on the joint distribution.

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
| `X-files_Dimensional_Table_Corrected.md` | Corrected dimensional scaling table |
| `X-files_Minimal_Closure_NS.md` | Conditional theorem for Navier–Stokes |
| `X-files_Minimal_Closure_S6.md` | Conditional theorem for S⁶ complex structure |
| `Structural_Obstructions.md` | Scaling obstructions and practical filters |
| `X-files_Filters.lean` | Lean filters: coordinate non-degeneracy, rotational inertia, energy-parity |
| `X-files_Unforced_Boundary.lean` | Lean predicate `IsStrictlyUnforced` and forced-vs-unforced classifier |
| `Euler_Discrepancy_Audit.md` | Methodological parallels: forcing dependency and coordinate degeneracy |
| `VolumePreservation.lean` | Liouville interface for incompressible flows |
| `VolumePreservationLemmas.lean` | Algebraic support and Jacobi interface |
| `LASLS_Correctness.lean` | Lean: classical LASLS correctness and refutations |
| `LASLS_Anchor.lean` | Lean: exact bijectivity criterion and repaired family |
| `META_VERIFICATION.md` | Meta-layer verification motivation, current linter scope, and limitations |
| `riemann-hypothesis/ScaffoldingAudit.lean` | Lean command `#audit_theorem`; traces value dependencies and reports syntactically `True` definitions |
| `riemann-hypothesis/ScaffoldingAuditDemo.lean` | Runnable example for the current audit command |
| `riemann-hypothesis/DirectImportHypsAlt.lean.template` | Optional archive-specific probe template; not part of the build |
| `riemann-hypothesis/` | RH continuum-gap case study and supporting documentation |

## Quick Reference

Hierarchical Jacobian:

```text
P_i(x₁, …, x_i) = x_i + g_i(x₁, …, x_{i−1}),   det J = 1.
```

Information identity:

```text
H(I) + H(J) = H(M) + D(I) + D(J) + L
L := I(I;M) + I(J;M) − H(M)
```

`L ≥ 0` is a hypothesis on the joint distribution, not a theorem.

Composite map: `Φ_Λ = Φ ∘ exp(ad_Λ)`.

For monodromy built from unipotent Jacobians, `Hol_γ(Φ_Λ) = +1`; a sign `−1` requires an orientation-reversing gluing not constructed here.

## Meta-Layer Verification

The repository's current `ScaffoldingAudit.lean` implementation accepts `#audit_theorem SomeNamespace.someTheorem`, traverses constants referenced by declaration values, and reports definitions whose lambda body is syntactically `True`. The self-contained example is in `riemann-hypothesis/ScaffoldingAuditDemo.lean`.

The current checker does **not** implement shortest-path reporting, `whnf` normalization, pass-through analysis, mutual-inductive metadata checks, or a semantic judgment that a reported definition invalidates a theorem. Findings are diagnostic leads for manual review. See [`META_VERIFICATION.md`](META_VERIFICATION.md) for the scope, limitations, and broader audit goals.

## Open Problems Addressed

Each entry is a **conditional template**: a formal scheme is stated, but the embedding that would connect it to the classical problem is not constructed.

| Problem | Status |
|---|---|
| S⁶ complex structure | Conditional template; embedding not constructed |
| Collatz conjecture | Conditional template; embedding not constructed |
| Navier–Stokes regularity | Conditional template; embedding not constructed |

## Lean Formalisation

The repository uses Lean v4.30.0, with Mathlib pinned in `lake-manifest.json`.

```bash
lake build
```

The configured build includes the `ScaffoldingAuditDemo` module so the example and the exact `#audit_theorem` syntax are checked by CI. The archive-specific `.template` probe is intentionally excluded from the build because its imports belong to the separate mirror repository.
