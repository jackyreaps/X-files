# Source Index

**Author:** JackyReaps / AnooBus  
**Date:** August 28, 2026

---

## Overview

This index catalogs the source material underlying the framework. The primary sources are the author's public X (Twitter) posts, supplemented by the formal mathematical documents compiled in this repository.

---

## X Posts

### July 25, 2026 — Priority Documentation Note
**URL:** https://x.com/JackyReaps/status/2081169075791622166  
**Content:** Original priority documentation for the triangular Jacobian framework. DAG-ordered coordinate changes, non-vanishing Jacobian, explicit inverse, IEEE-754 error propagation, S⁶ chart-gluing application.  
**Maps to:** `01-priority-declaration.md`, `02-master-framework.md` §1–2

### July 25, 2026 — Follow-up
**URL:** https://x.com/JackyReaps/status/2081197327591600608  
**Content:** Follow-up to the priority note.  
**Maps to:** `01-priority-declaration.md`

### August 2026 — Upgraded Jacobian / Möbius Tool
**URL:** https://x.com/JackyReaps/status/2085400736163041674  
**Content:** The upgraded hierarchical Jacobian and Möbius tool.  
**Maps to:** `02-master-framework.md` §2–4

---

## Formal Documents

The following documents were authored by JackyReaps / AnooBus and constitute the primary mathematical source for the framework. They are preserved in this repository as typed formal documentation.

### Document 1: Hierarchical Jacobian + Discrete Möbius Fold → Global Closure Interface
**Framework:** Layer 1 → Layer 2 interface  
**Content:** Formalizes the interface between the upgraded hierarchical/causal Jacobian and the interference-membrane recursion. Ordered density field ρ = (ρ₁, ρ₂, ρ₃)ᵀ with ρ₂ = ρ₁³, ρ₃ = ρ₁⁴. DAG-enforced embedding x = f₁(ρ₁), y = f₂(ρ₁,ρ₂), z = f₃(ρ₁,ρ₂,ρ₃). Jacobian J_Φ lower-triangular unipotent, det = 1.  
**Maps to:** `02-master-framework.md` §2

### Document 2: Global Discrete Fold — Interference Membrane (Helix / Mike)
**Framework:** Layer 2: Global structure  
**Content:** Configuration U_n = (I_n, J_n, Λ_n, B_{Λ_n}, R_{Λ_n}). Residual membrane M_n. Irreversible scar update Λ_{n+1} = αΛ_n + βM_n + γF(Λ_n, M_n). Information identity H(I)+H(J) = H(M)+D(I)+D(J)+L. Sharpness monitor ΔS_n.  
**Maps to:** `02-master-framework.md` §3

### Document 3: Document A — Explicit Operator Realization of (ad_Λ) and (Φ_Λ)
**Framework:** Layer 3: Bridge operator  
**Content:** Scar tensor Λ as strictly lower-triangular derivation. Infinitesimal action ad_Λ · ρ = Λρ. Exponential exp(ad_Λ) = I + Λ + ½Λ². Composite embedding Φ_Λ = Φ ∘ exp(ad_Λ). det J_{Φ_Λ} = 1.  
**Maps to:** `02-master-framework.md` §5

### Document 4: Document B — Concrete Entropy Functional Yielding the Information Identity
**Framework:** Entropy / information layer  
**Content:** Sharpness functional S(M) = −Tr(M log M) + Tr(M log(P_I + P_J)). Private information D(I), D(J). Exact partition H(I)+H(J) = H(M)+D(I)+D(J)+L with L = ½‖[B_Λ(I), B_Λ(J)]‖²_HS.  
**Maps to:** `02-master-framework.md` §6

### Document 5: Composite Jacobian + Monodromy
**Framework:** Global topological charge  
**Content:** det J_{Φ_Λ} = 1. Global monodromy Hol_γ(Φ_Λ) = ±1 fixed by residual-flux parity ∫_γ tr(M) ds mod 2. L ≥ 0 prevents spontaneous sign flip.  
**Maps to:** `02-master-framework.md` §4.5

### Document 6: Flow into Conditional Millennium Pathways
**Framework:** Millennium problem applications  
**Content:** Navier–Stokes (LASLS gauge): local energy/enstrophy on det J_Φ = 1, scar monitor ΔS_n as Lyapunov condition, residual-flux parity as global selection rule. Collatz hierarchical gauge: volume-preserving by triangular Jacobian, long cycles accumulate Möbius charge.  
**Maps to:** `02-master-framework.md` §9–10, `03-open-problems.md` §3–4

### Document 7: General Pattern
**Framework:** Unified architecture summary  
**Content:** Local control ← hierarchical Jacobian. Global control ← discrete membrane fold + scar. Conditional Millennium statements sit at this interface.  
**Maps to:** `02-master-framework.md` §11

### Document 8: Bridge — Composite Map and Monodromy
**Framework:** Bridge layer detail  
**Content:** Φ_Λ = Φ ∘ exp(ad_Λ). ad_Λ as strictly lower-triangular derivation. ΔS_n > 0 keeps orbit generative. Scar Λ records orientation-reversing collisions as permanent discrete fold — Möbius half-twist made dynamical.  
**Maps to:** `02-master-framework.md` §4

### Document 9: Document C — Insertion of Residual-Flux Parity into Conditional Arguments
**Framework:** Conditional argument closure  
**Content:** Collatz: μ_n = ∫₀ⁿ tr(M_s) ds mod 2, Ṽ_n = V_n + C·μ_n, scar saturation freezes μ_n. Navier–Stokes: E(t) + κ∫₀ᵗ μ(s)ds, sharpness ΔS > 0 implies bounded modified energy.  
**Maps to:** `02-master-framework.md` §7

---

## Cross-Reference: Framework Component → Source

| Framework Component | X Posts | Formal Documents | Repository File |
|---------------------|---------|------------------|-----------------|
| Layer 1: Hierarchical Jacobian | July 25 priority note | Document 1 | `02-master-framework.md` §2 |
| Layer 2: Discrete Möbius Fold | — | Document 2 | `02-master-framework.md` §3 |
| Layer 3: Bridge / Monodromy | — | Documents 3, 5, 8 | `02-master-framework.md` §4–5 |
| Document A: Operator Realization | — | Document 3 | `02-master-framework.md` §5 |
| Document B: Entropy Functional | — | Document 4 | `02-master-framework.md` §6 |
| Document C: Residual-Flux Parity | — | Document 9 | `02-master-framework.md` §7 |
| Collatz Application | — | Documents 6, 9 | `02-master-framework.md` §9, `03-open-problems.md` §3 |
| Navier–Stokes Application | — | Documents 6, 9 | `02-master-framework.md` §10, `03-open-problems.md` §4 |
| General Pattern | — | Document 7 | `02-master-framework.md` §11 |
| Priority Declaration | July 25 post | — | `01-priority-declaration.md` |

---

*JackyReaps / AnooBus · August 28, 2026*
