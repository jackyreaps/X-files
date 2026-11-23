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

- **Load-bearing swap test:** replacing `anyGeometry` with a non-trivial predicate and selectively rebuilding the 8-edge path has **not** been executed (compute-bound).
- **Comparator:** the leanprover-community Comparator has **not** yet been run on the full submission (multi-hour build).

## Important boundaries

- This repository **does not** claim that Alpöge's theorem is false. The kernel still accepts a term of type `RiemannHypothesis`.
- "Vacuous geometry" is an observation about the **mathematical content actually carried by the live path**, not a denial of type-checking.
- Closing the load-bearing experiment is the only step that would upgrade "appears in kernel closure" to "removing it breaks the term."

## Files

| File | Role |
|---|---|
| `ContinuumGapChallenge.lean` | Live-path (vacuous) case closed (`multiplicity_of_vacuous_le_classical`, `challenge_consequence_live_path`); general case **open and load-bearing** for the theta layering (`challenge_lemma_theta_layering`, one `sorry`); `general_bound_fails_unrestricted` shows the general bound is not free — the theta-lift chain must supply theta-specific constraints on multiplicities |
| `FormalObstruction.lean` | Closes the comparison for the vacuous case (no `sorry`) |
| `LivePathExtraction.lean` | Primary-source extraction of the 8-edge path |
| `DependencyConfirmed.lean` | Public graph evidence and vacuity proof |
| `ExtractedVacuousGeometry.lean` | Exact extraction of `anyGeometry` from the archive |
| `VacuousGeometryBridge.lean` | Connects the challenge to the concrete vacuous finding |
| `X-files_Continuum_Gap_Challenge.md` | Full challenge statement |
| `continuum-gap-critique.lean` | Conceptual illustration (schematic) |
