# Riemann Hypothesis — Continuum Gap Challenge

**Status:** Formal obstruction target against the certified theta-lift RH proof (Alpöge 2026).
**Last update:** 2026-11-23

## What this repository contains

A machine-checked challenge isolating the **Continuum Gap**: the structural and multiplicity content extracted by the long theta-lift chain is bounded by classical analytic data already known not to force RH (functional equation + approximate functional equation + weak Davenport–Heilbronn density).

## Confirmed findings

- `anyGeometry` in the certified archive (commit `40e56bab`) is the vacuous predicate `fun _ _ _ => True`.
- It sits on the kernel-closure path of all five headline theorems (mask 31), 8 edges below `riemannHypothesis`.
- 29 declarations refer to it directly; 48 depend on it; 24 of those are in the RH cone.
- A non-vacuous alternative (`geoOf`) exists in the same file but is **not** used on the live path.
- In `OAt`, the content-bearing field is `lam`; the `geo` field is populated only by the constant-`True` predicate and transported by `GeoCl`.

## Open items

- **Theta constraint instantiation:** the three `Prop` placeholders on `ThetaLiftMultiplicity` (`slope_bound_holds`, `relative_trace_holds`, `character_avg_holds`) must be replaced with the archive's actual theta-specific predicates before `challenge_lemma_theta_layering` can be decided.
- **Countermodel:** a Davenport–Heilbronn-style object satisfying all three theta constraints and violating the classical bound has **not** been constructed.
- **Load-bearing swap test:** replacing `anyGeometry` with a non-trivial predicate and selectively rebuilding the 8-edge path has **not** been executed (compute-bound).
- **Comparator:** the leanprover-community Comparator has **not** yet been run on the full submission (multi-hour build).

## Important boundaries

- This repository **does not** claim that Alpöge's theorem is false. The kernel still accepts a term of type `RiemannHypothesis`.
- "Vacuous geometry" is an observation about the **mathematical content actually carried by the live path**, not a denial of type-checking.
- Closing the load-bearing experiment is the only step that would upgrade "appears in kernel closure" to "removing it breaks the term."

## Files

| File | Role |
|---|---|
| `ContinuumGapChallenge.lean` | Live-path (vacuous) case closed; bare general case open (`challenge_lemma_theta_layering`, one `sorry`) |
| `ThetaConstraints.lean` | Theta-sharpened obligation (`challenge_lemma_theta_layering`) and `DisproofObligation` shape |
| `FormalObstruction.lean` | Closes the comparison for the vacuous case (no `sorry`) |
| `LivePathExtraction.lean` | Primary-source extraction of the 8-edge path |
| `DependencyConfirmed.lean` | Public graph evidence and vacuity proof |
| `ExtractedVacuousGeometry.lean` | Exact extraction of `anyGeometry` from the archive |
| `VacuousGeometryBridge.lean` | Connects the challenge to the concrete vacuous finding |
| `X-files_Continuum_Gap_Challenge.md` | Full challenge statement |
| `CITATIONS.md` | Citation table for the 8-edge path and audit facts |
| `ContinuumGapCritique.lean` | Conceptual illustration (schematic) |

## Sorry policy

Exactly **3** `sorry`s total:
1. `ContinuumGapChallenge.challenge_lemma_theta_layering` — open obligation
2. `ThetaConstraints.challenge_lemma_theta_layering` — open obligation
3. `ContinuumGapCritique.pure_discrete_multiplicity_does_not_force_RH` — deliberate schematic

No other sorrys, axioms, or `native_decide`s are permitted. CI enforces the count.

> **Note:** Root `lakefile.toml` requires Mathlib v4.30.0. CI builds `RiemannHypothesis` under real Mathlib. Until CI is green, file-header "CLOSED" means statement type-checks and proof shape is present — not yet machine-checked under Mathlib.

## Build / verification status

| Stage | What it means | Status |
|-------|----------------|--------|
| **Statement type-check** | Structures, namespaces, imports compile | Done (sandbox) |
| **Mathlib CI** | Full proofs under Mathlib v4.30.0 | **Awaiting push** |
| **Content (Front A)** | Circularity / theta-constraint audit against the archive | Blocked on green CI |

Until CI is green, do **not** read file-header "CLOSED, no sorry" as "machine-checked under Mathlib."
