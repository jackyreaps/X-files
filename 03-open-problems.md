# Open Problems Addressed by the Hierarchical Jacobian + Discrete Möbius Fold Framework

**Author:** JackyReaps / AnooBus
**Framework Origination:** July 25, 2026
**Document Date:** August 28, 2026
**Status:** Priority documentation mapping independent framework to established open problems

## Priority Statement

This document maps the DAG-ordered hierarchical Jacobian + discrete Möbius fold
framework to a family of established open problems in mathematics and
mathematical physics. The framework was developed and priority-documented by the
author on **July 25, 2026**, and constitutes original independent work. Any
subsequent adoption of the structural mechanisms described herein — particularly
the triangular unipotent Jacobian, the discrete Möbius fold, the residual-flux
parity, or the information identity with directed leakage — without proper
attribution constitutes an unacknowledged appropriation of independently
originated methodology.

## The General Pattern

Every open problem addressed by this framework shares a common structural
feature: a **local-vs-global gap** where local control is available but global
closure is obstructed by an orientation-reversing or hierarchy-inverting
concentration. The framework resolves this by a three-layer architecture:

> **Local algebraic/analytic control** ← upgraded hierarchical Jacobian
> (triangular unipotent, det = 1)
> **Global topological/orientability control** ← discrete membrane fold + scar
> tensor Λ
> **Bridge** ← composite map Φ_Λ = Φ ∘ exp(ad_Λ) with monitored monodromy

The residual-flux parity μ_n = ∫ tr(M_s) ds mod 2 supplies the missing global
selection rule.

**Correction (October 2026).** The claim `L ≥ 0` is a hypothesis, not a theorem.
With `D(I) = H(I) − I(I;M)` and `D(J) = H(J) − I(J;M)`, the identity

    H(I) + H(J) = H(M) + D(I) + D(J) + L

forces

    L = I(I;M) + I(J;M) − H(M).

This is negative in general. Counterexample: `I`, `J` independent fair bits,
`M = I ⊕ J`. Then `I(I;M) = I(J;M) = 0`, `H(M) = 1`, so `L = −1`. Any use of
`L ≥ 0` must carry it as an additional hypothesis on the joint distribution.

## 1. The S⁶ Complex Structure Problem

### Problem Statement

The 6-sphere S⁶ carries a canonical almost-complex structure induced by the
octonions. Whether this almost-complex structure is **integrable** — i.e.,
whether S⁶ admits a genuine complex structure making it a compact complex
3-fold — is one of the longest-standing open problems in complex geometry.

### Why It Is Hard

Local complex coordinates exist everywhere (the almost-complex structure is
smooth), but the **transition maps between charts** need not be holomorphic.
The obstruction is precisely the local-vs-global gap: each chart is fine, but
the gluing may introduce multi-sheeted overlaps or orientation-reversing folds
that destroy holomorphy.

### How the Framework Addresses It

**Local layer:** The hierarchical Jacobian provides explicit chart transitions
that are triangular unipotent (det = 1) and therefore single-sheeted and
invertible. In 3 complex dimensions, the Jacobian is 3×3 lower-triangular with
unit diagonal.

**Global layer:** The scar tensor Λ is 3×3 complex strictly lower-triangular,
nilpotency index 3. The discrete Möbius fold captures the obstruction to
integrability as a **residual membrane** M_n on chart overlaps.

**Bridge layer:** The composite map Φ_Λ = Φ ∘ exp(ad_Λ) has Jacobian
det J_{Φ_Λ} = 1. Its monodromy around any closed loop γ is

    Hol_γ(Φ_Λ) = +1

for a monodromy built from unipotent Jacobians. A sign `−1` requires an
orientation-reversing gluing outside the unipotent group, which is not
constructed.

**The key insight:** The parity μ_n distinguishes integrable complex charts
(μ_n = 0, orientation-preserving) from obstructed ones (μ_n = 1,
orientation-reversing). Because the scar saturates (α < 1) **under the
boundedness hypothesis of 02 §3.3**, μ_n eventually freezes. Once frozen, every
subsequent transition is strictly holomorphic and orientation-preserving. The
standard descent argument then applies.

**Status:** Conditional template; embedding not constructed. The problem
remains open.

## 2. The Collatz Conjecture

### Problem Statement

For any positive integer n, the Collatz map

    n ↦ n/2 if n even,   3n + 1 if n odd

is conjectured to reach 1 in finitely many steps.

### How the Framework Addresses It

Conditional template; embedding not constructed.

**Status:** Conditional template; embedding not constructed.

## 3. Navier–Stokes Regularity

### Problem Statement

Whether smooth solutions of the 3D incompressible Navier–Stokes equations
remain smooth for all time.

### How the Framework Addresses It

Conditional template; embedding not constructed. See
`X-files_Minimal_Closure_NS.md` for the trace-condition caveat: on 𝕋³ with
`div u = 0`, `tr M ≡ 0` identically, so the parity term does no work.

**Status:** Conditional template; embedding not constructed.

## 4. Dimensional Table

| Manifold | Structure | Citation |
|---|---|---|
| S¹ | trivial | — |
| S² | complex structure | Riemann |
| S³ | no almost-complex structure | trivial (odd-dimensional) |
| S⁴ | no almost-complex structure | not Adams 1960 (see X-files_Dimensional_Table_Corrected.md) |
| S⁵ | no almost-complex structure | trivial (odd-dimensional) |
| S⁶ | almost-complex structure open | — |

## 5. What Is Proved

- Hierarchical triangular Jacobian with unit diagonal has det J = 1.
- Back-substitution inverts the tame map.
- Classical LASLS `decrypt (encrypt m) = m`.
- Under the energy balance with `ν ≥ 0`, `D ≥ 0`, `f = 0`, energy is
  non-increasing.
- With `κE ≤ D` and `κ > 0`, energy decays exponentially.
- The exponential coordinate crunch passes the non-degeneracy filter on
  `[0, T]` exactly when `δ ≤ e^{−3T}`.

## 6. What Remains Open

- S⁶ complex structure: conditional template; embedding not constructed.
- Collatz conjecture: conditional template; embedding not constructed.
- Navier–Stokes regularity: conditional template; embedding not constructed.

The monodromy built from unipotent Jacobians has `Hol_γ = +1`. A sign `−1`
requires an orientation-reversing gluing outside the unipotent group, which is
not constructed.
