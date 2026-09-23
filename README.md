
# X-Files

**Hierarchical Jacobian + Discrete Möbius Fold Framework**  
**Author:** JackyReaps / AnooBus  
**Priority Date:** July 25, 2026  
**Compiled:** August 28, 2026  
**Last audit update:** September 16, 2026

---

## What This Is

This repository is a public, timestamped research log of an independent structural framework built around hierarchical (triangular/unipotent) Jacobians and a discrete Möbius-fold / scar-tensor construction.  

The algebraic core (Layer 1) is elementary and fully explicit.  
The global and analytic layers (scar dynamics, residual-flux parity, information identity) are still at the level of **definitions + conditional templates**.  

All claims about Navier–Stokes, \(S^6\), Collatz, etc. remain **conditional** on the existence and regularity of the embeddings that have not yet been constructed in full detail.  

The newest module (Prime Tower Drift Hypothesis) is self-contained, numerically verified to \(n=10^5\), and independent of the heavier analytic claims.

## Status of Major Directions (September 2026)

| Direction                        | Status                                      | Notes |
|----------------------------------|---------------------------------------------|-------|
| Hierarchical triangular Jacobian | Complete & elementary                       | det = 1, explicit inverse |
| Discrete Möbius / scar tensor    | Definitional + formalisation gaps           | See gap analysis |
| Residual-flux parity             | Defined, not yet proved to control monodromy| — |
| Navier–Stokes                    | Conditional template only                   | Requires unverified embedding hypotheses |
| \(S^6\) complex structure        | Exploratory                                 | — |
| Collatz                          | Heuristic gauge idea                        | — |
| **Prime Tower Drift Hypothesis** | Numerically solid inside \(n\le 10^5\)       | Clean, self-contained module |
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
| `Euler_Discrepancy_Audit.md` | Methodological parallels: forcing dependency & coordinate degeneracy |
| `VolumePreservation.lean` | Liouville interface for incompressible flows (δ = 1 non-degeneracy) |
| `VolumePreservationLemmas.lean` | Algebraic support + Jacobi Fin-3 interface (points at mathlib4#41881) |
05-OpenAI-structural-correspondence.md | Structural correspondence: X-files Layer 1 and the OpenAI NS correction tower |
06-prime-tower-hypothesis.md           | Whitepaper: Dynamical coupling of x^x=y and Cipolla-normalized prime arrays
prime_tower.py                         | High-precision numerical validation sieve (n = 10⁵ verification matrix)

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
- **Transcendental Attractors** — The prime-tower acts as an algorithmic throttle, taming exponential acceleration and locking $x^x=y$ into an invariant dual-state real equilibrium.


All applications are **conditional theorems**: the algebraic core is proved; the PDE / geometric embeddings are stated as explicit hypotheses.

---

## Analytical Filters (Lean)

Three Lean modules supply machine-checkable filters that any claimed singularity must pass:

1. **X-files_Unforced_Boundary.lean** — `IsStrictlyUnforced`; forced constructions fall outside the classical unforced Millennium statement.
2. **X-files_Filters.lean** — coordinate non-degeneracy, rotational-inertia barrier, energy-parity closure.
3. **VolumePreservation.lean** — Liouville interface (`det DΦ ≡ 1` for incompressible flows). Algebraic half closed; Jacobi pending mathlib4#41881; flow-regularity still open.

See also `Structural_Obstructions.md` and `Euler_Discrepancy_Audit.md`.

---

## Priority Statement

This repository consolidates work that was developed and posted incrementally on X starting **July 25, 2026**. The structural parallelism between causal DAG hierarchies and classical triangular (Jonquières) polynomial automorphisms, together with the discrete Möbius fold, residual-flux parity, scar tensor, and associated entropy identity, was conceived and formalized by the author prior to any external publication or usage.

Any subsequent adoption, citation, or extension of these ideas without proper attribution constitutes an unacknowledged appropriation of independently originated research.

The author reserves all rights to proper attribution for these independently developed contributions.

---

*JackyReaps / AnooBus · August 28, 2026*  
*Audit & Lean filters updated · September 9, 2026*


