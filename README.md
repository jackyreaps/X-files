# X-Files

**Hierarchical Jacobian + Discrete Möbius Fold Framework**  
**Author:** JackyReaps / AnooBus  
**Priority Date:** July 25, 2026  
**Compiled:** August 28, 2026

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
| `01-priority-declaration.md` | Dated priority statement establishing independent origination |
| `02-master-framework.md` | Complete mathematical framework: all three layers, Documents A/B/C, dimensional scaling |
| `03-open-problems.md` | Mapping of the framework to established open problems: S⁶, Collatz, Navier–Stokes, dimensional ladder |
| `04-x-posts-index.md` | Chronological index of all X posts with cross-references to framework components |

---

## Quick Reference

### Key Equations

**Hierarchical Jacobian:**
```
J_Φ = [ ∂_{ρ₁}f₁     0           0        ]
      [ ∂_{ρ₁}f₂   ∂_{ρ₂}f₂     0        ]
      [ ∂_{ρ₁}f₃   ∂_{ρ₂}f₃   ∂_{ρ₃}f₃   ]

det J_Φ = 1
```

**Information Identity:**
```
H(I) + H(J) = H(M) + D(I) + D(J) + L,    L ≥ 0
L = ½ ‖[B_Λ(I), B_Λ(J)]‖²_HS
```

**Composite Map:**
```
Φ_Λ = Φ ∘ exp(ad_Λ)
exp(ad_Λ) = I + Λ + ½ Λ²
det J_{Φ_Λ} = 1
```

**Monodromy:**
```
Hol_γ(Φ_Λ) = ±1
μ_n = ∫_γ tr(M) ds mod 2
```

---

## Dimensional Scaling

| Target | Real dim | Complex dim | Λ nilpotency | Status |
|--------|----------|-------------|--------------|--------|
| S² (CP¹) | 2 | 1 | 2 | Solved — Möbius origin |
| S³ | 3 | — | 3 | Real only |
| S⁴ | 4 | — | 4 | Real only |
| S⁵ | 5 | — | 5 | Real only |
| S⁶ | 6 | 3 (candidate) | 3 | **Open** — exceptional case |

---

## Open Problems Addressed

- **S⁶ Complex Structure** — checkable scar-monitor convergence
- **Collatz Conjecture** — hierarchy-reversing steps charge μ_n; scar saturation
- **Navier–Stokes Regularity** — orientation-reversing concentrations charged against energy
- **General Chart Transitions** — triangular Jacobians guarantee global injectivity
- **Information Partitioning** — exact identity with computable leakage

---

## Priority Statement

This repository consolidates work that was developed and posted incrementally on X starting **July 25, 2026**. The structural parallelism between causal DAG hierarchies and classical triangular (Jonquières) polynomial automorphisms, together with the discrete Möbius fold, residual-flux parity, scar tensor, and associated entropy identity, was conceived and formalized by the author prior to any external publication or usage.

Any subsequent adoption, citation, or extension of these ideas without proper attribution constitutes an unacknowledged appropriation of independently originated research.

The author reserves all rights to proper attribution for these independently developed contributions.

---

*JackyReaps / AnooBus · August 28, 2026*
