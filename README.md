
# X-Files

**Hierarchical Jacobian + Discrete Möbius Fold Framework**  
**Author:** JackyReaps / AnooBus  
**Priority Date:** July 25, 2026  
**Compiled:** August 28, 2026  
**Last audit update:** September 9, 2026

---

## What This Is

This repository contains the complete priority-documented mathematical framework for a unified structural approach to the local-vs-global problem in manifold chart transitions, dynamical systems, and nonlinear PDEs.

The framework was developed and posted incrementally on X (Twitter) starting July 25, 2026. This repository consolidates all formal documents, equations, and priority evidence into a single immutable public record. The original X posts (images) are referenced but not duplicated here — they remain the primary visual source.

---

## The Three-Layer Architecture

1. **Local:** Hierarchical triangular Jacobian (unipotent, det = 1, explicit inverse)
2. **Global:** Discrete Möbius fold + scar tensor Λ (interference membrane)
3. **Bridge:** Composite map Φ_Λ = Φ ∘ exp(ad_Λ) with monitored monodromy

The residual-flux parity μ_n = ∫ tr(M_s) ds mod 2 supplies the missing global selection rule. Because the leakage L ≥ 0, the parity cannot flip spontaneously; it is a controlled topological charge.

---

## Repository Contents

| File | Description |
|------|-------------|
| `01-priority-declaration.md` | Dated priority statement |
| `02-master-framework.md` | Complete mathematical framework |
| `03-open-problems.md` | Mapping to established open problems |
| `04-x-posts-index.md` | Chronological index of X posts |
| `X-files_Formalisation_Gap_Analysis.md` | Audit: what is proved, what is missing, what is unformalisable |
| `X-files_Dimensional_Table_Corrected.md` | Corrected dimensional scaling table (S⁴ attribution, Λ nilpotency) |
| `X-files_Minimal_Closure_NS.md` | Conditional theorem for Navier–Stokes + audit criteria for forced singularities |
| `X-files_Minimal_Closure_S6.md` | Conditional theorem for S⁶ complex structure |
| `Structural_Obstructions.md` | Scaling obstructions & practical filters for NS and three-body |
| `X-files_Filters.lean` | Lean filters: coordinate non-degeneracy, rotational inertia, energy-parity |
| `X-files_Unforced_Boundary.lean` | Lean predicate `IsStrictlyUnforced` and forced-vs-unforced classifier |

---

## Quick Reference

### Key Equations

**Hierarchical Jacobian:**
J_Φ = [ ∂_{ρ₁}f₁ 0 0 ] [ ∂_{ρ₁}f₂ ∂_{ρ₂}f₂ 0 ] [ ∂_{ρ₁}f₃ ∂_{ρ₂}f₃ ∂_{ρ₃}f₃ ]
det J_Φ = 1
**Information Identity:**
H(I) + H(J) = H(M) + D(I) + D(J) + L, L ≥ 0 L = ½ ‖[B_Λ(I), B_Λ(J)]‖²_HS
**Composite Map:**
Φ_Λ = Φ ∘ exp(ad_Λ) exp(ad_Λ) = I + Λ + ½ Λ² det J_{Φ_Λ} = 1
**Monodromy:**
Hol_γ(Φ_Λ) = ±1 μ_n = ∫_γ tr(M) ds mod 2
---

## Dimensional Scaling (Corrected)

| Target | Real dim | Complex dim | Λ size / nilpotency | Scheme | Status |
|--------|----------|-------------|---------------------|--------|--------|
| S² (CP¹) | 2 | 1 | 2×2 real / 2 | R | Solved — Möbius origin |
| S³ | 3 | — | 3×3 real / 3 | R | Real only |
| S⁴ | 4 | — | 4×4 real / 4 | R | Real only (Chern-class obstruction) |
| S⁵ | 5 | — | 5×5 real / 5 | R | Real only |
| S⁶ | 6 | 3 (candidate) | 3×3 complex / 3 | C | **Open** — exceptional case |

---

## Open Problems Addressed (Conditional)

- **S⁶ Complex Structure** — checkable scar-monitor convergence (see `X-files_Minimal_Closure_S6.md`)
- **Collatz Conjecture** — hierarchy-reversing steps charge μ_n; scar saturation
- **Navier–Stokes Regularity** — orientation-reversing concentrations charged against energy (see `X-files_Minimal_Closure_NS.md`)
- **General Chart Transitions** — triangular Jacobians guarantee global injectivity
- **Information Partitioning** — exact identity with computable leakage

All applications are **conditional theorems**: the algebraic core is proved; the PDE / geometric embeddings are stated as explicit hypotheses.

---

## Analytical Filters (Lean)

Two Lean modules supply machine-checkable filters that any claimed singularity must pass:

1. **`X-files_Unforced_Boundary.lean`**  
   - `IsStrictlyUnforced f` — external force identically zero  
   - Forced constructions (including the 8 Sep 2026 OpenAI “spaghetti-vortex”) are automatically classified as outside the classical unforced Millennium statement.

2. **`X-files_Filters.lean`**  
   - `IsNonDegenerate` — Jacobian determinant bounded away from zero  
   - `PreservesRotationalInertia` — no artificial angular-momentum suppression  
   - `HasEnergyParityClosure` — bounded cumulative energy injection  

A singularity is admissible for the classical unforced problem only when it is strictly unforced **and** passes the analytic filters.

See also `Structural_Obstructions.md` for the corresponding scaling heuristics and a lightweight keyword pre-filter.

---

## Priority Statement

This repository consolidates work that was developed and posted incrementally on X starting **July 25, 2026**. The structural parallelism between causal DAG hierarchies and classical triangular (Jonquières) polynomial automorphisms, together with the discrete Möbius fold, residual-flux parity, scar tensor, and associated entropy identity, was conceived and formalized by the author prior to any external publication or usage.

Any subsequent adoption, citation, or extension of these ideas without proper attribution constitutes an unacknowledged appropriation of independently originated research.

The author reserves all rights to proper attribution for these independently developed contributions.

---

*JackyReaps / AnooBus · August 28, 2026*  
*Audit & Lean filters updated · September 9, 2026*


