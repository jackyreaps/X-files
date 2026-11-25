# Riemann Hypothesis — Continuum Gap Challenge

**Status:** Lean-verified formal disproof that the classical + literature + theta-shaped boundary interfaces (extracted from commit `40e56bab`, with vacuous geometry dropped) are insufficient to force the claimed multiplicity bound.  
**Last update:** 2026-11-24

## Additional verification status

| File | Status | Role |
| :--- | :--- | :--- |
| `riemann-hypothesis/Disproof.lean` | **Complete (`sorry`-free)** | Proves `challenge_lemma_false`, constructing a concrete boundary realization (`survivingMass = 100 > 2`) that satisfies the modeled classical + literature + vacuous-geometry constraints while violating the claimed multiplicity bound. |
| `riemann-hypothesis/ModeledRowsU.lean` | **Complete (`sorry`-free)** | Proves `two_lattices_same_rowsu_shadow`, `unidentifiable_lattice_structure`, and `ambient_dimension_unidentifiable`, showing that non-isomorphic higher-dimensional graph lattices (`rank = 8, dim = 24` vs. `rank = 16, dim = 48`) share the same non-vacuous Harder–Narasimhan analytic shadow. |
| `riemann-hypothesis/ScaffoldingAudit.lean` | **Complete (`sorry`-free)** | Zero-dependency Lean 4 metaprogramming tool (`import Lean` only) providing `#audit_theorem`, which traces transitive dependency cones and reports definitions whose bodies peel to the syntactic constant `True` (a review lead, not a verdict of unsoundness). |
| `riemann-hypothesis/ScaffoldingAuditDemo.lean` | **Complete (`sorry`-free)** | Self-contained 1-second demonstration of `#audit_theorem` running on a minimal layered witness with a vacuous `True` invariant. |
| `riemann-hypothesis/ThetaConstraints.lean` | **Modeled boundary (`1 sorry` placeholder)** | Formalizes the extracted live-path statement shapes (`ThetaIntegralsAgree`, `LocalMatching`, `CovolumeBoundOfX`, `anyGeometry := fun _ _ _ => True`). |
| `riemann-hypothesis/COUNTERMODEL.md` | **Documentation** | Walkthrough of `Disproof.lean`, `ModeledRowsU.lean`, interface fidelity, and scope boundaries. |
| `riemann-hypothesis/STRUCTURAL_INTEGRITY.md` | **Documentation** | Bottom-to-top architectural audit of commit `40e56bab` and archive `main` (`TopPlug.lean` 19-line bottleneck, `HypsAlt` zero-`GeoP` cone of 14,473 constants, and `RowsU` Harder–Narasimhan content audit). |
| `META_VERIFICATION.md` | **Documentation** | Note on the meta-layer verification gap (`P ∧ True` / proof irrelevance / `.olean` replay anomalies such as `leanprover/lean4#16730` and `#14576`). |
| `RECURSIVE_TOPOLOGY_PARADOX.md` | **Documentation** | Conceptual synthesis of the "looks true" paradox in recursive topology, linking internal type consistency to the three `sorry`-free Lean modules. |

> **Formal Status.** This repository contains a **`sorry`-free, Lean 4 kernel-verified disproof** (`Disproof.challenge_lemma_false`) showing that the classical and literature boundary interfaces extracted from commit `40e56bab`—once the vacuous geometry (`anyGeometry := fun _ _ _ => True`) is dropped—do not logically imply the claimed theta-lift multiplicity bound.
>
> **What this does *not* claim.** This repository does **not** claim that Mathlib’s `RiemannHypothesis` is false, nor does it dispute that Lean’s kernel accepted a term of type `RiemannHypothesis` in the target archive. It refutes the *sufficiency of the extracted/modeled live-path boundary interface*. The non-vacuous general case remains explicitly open.

## What this repository contains

A machine-checked formal countermodel and architectural audit isolating the **Continuum Gap**: once `anyGeometry` reduces the geometric payload to `True` on the live execution path, the remaining classical, literature, slope, and windowed Green interfaces (`ClassicalBoundaryPackage`, `BoundAtTwoThreeFamilyFonShape`, `ThetaLocalInputShape`, and `VWinGreenBridgeShape`) admit an explicit witness (`fakeMultiplicity`) that violates the surviving multiplicity bound.

## Confirmed findings

- **Vacuous live-path geometry.** `anyGeometry` in the certified archive (commit `40e56bab`, `…/OverIx.lean`) is the constant predicate `fun _ _ _ => True`. Consistent with parallel community audits and ablation tests, it sits on the kernel-closure path of all five headline theorems (mask 31), eight edges below `riemannHypothesis`.
- **Dependency footprint.** 29 declarations refer to `anyGeometry` directly; 48 depend on it; 24 of those sit inside the RH cone. A non-vacuous alternative (`geoOf`) exists in the same file but is **not** used on the live path.
- **Pass-through transport.** In `OAt`, the content-bearing field is `lam`; the `geo` field is populated only by `anyGeometry` and transported through `GeoCl` across `nonempty_hyps_definite_side_of_closed_bound` without being eliminated into non-trivial analytic inequalities.
- **Classical & literature extraction (`40e56bab`).**
  - `hA` (`ThetaIntegralsAgree`) and `hM` (`LocalMatching`) are discharged via `PositivityTheory.ThKR.theoremK_head2` applied strictly to classical literature (`eis_bl_of_literature` + `siegel_weil_std_of_literature`).
  - `hX` (`CovolumeBoundOfX`, `GlobalTheory.CovTop`) is modeled as an existential eventual $L^3$ covolume bound coupled to surviving mass (`∃ C0 ≥ 0, survivingMass ≤ C0`). Because `C0` is existentially quantified rather than bounded by `errorBound + windowLength`, `fakeMultiplicity` satisfies `hX` with `C0 = 100` while violating the RH-strength bound (`100 > 2`).
  - `BoundAtTwoThreeFamilyFonAlt` (`…/BoundAtTwoThreeFamilyFon.lean`) is an existential large-$x$ family bound (`∃ C x0, ∀ x ≥ x0, …`) with zero `GeoP` dependence.
  - `DefiniteSideCondition` (`…/DefiniteSideCondition.lean`) and `VWin` + `green_of_regular` (`…/TopPlug.lean`) carry the analytic definite-side and windowed Green positivity bridge with zero `GeoP` references.
- **Extracted Upper Bottleneck (`TopPlug.lean`).** Auditing the extracted path above `nonempty_hyps_definite_side_of_closed_bound` confirms that `every_character_of_green_v_win` (`TopPlug.lean`, 19 lines) makes zero reference to `GeoP` or `anyGeometry`: the lower geometric tower enters `TopPlug.lean` only through a single existential witness `Nonempty (HypsAlt … DefiniteSideCondition)`.
- **Verified interface disproof (`Disproof.lean`).** Instantiating `ThetaConstraints.lean` with faithful statement shapes for all extracted live-path interfaces admits a `sorry`-free countermodel (`fakeMultiplicity`, surviving mass `100 > errorBound + windowLength = 2`), proving `Disproof.challenge_lemma_false`.
- **Swap test versus non-empty countermodel.** Setting `anyGeometry := False` empties the filtered object collection, breaking downstream `Nonempty` obligations while reducing universal claims over the empty collection to vacuous truth (documented as an architectural observation in `SWAP_TEST.md`). Conversely, `Disproof.lean` evaluates the multiplicity bound on the non-empty singleton containing `fakeMultiplicity`, proving that even with an inhabited witness satisfying every extracted constraint, the multiplicity bound fails.

## Open items

- **Non-vacuous general case.** `ContinuumGapChallenge.challenge_lemma_general` remains explicitly open. The extracted classical/literature boundary interface is the part closed by `Disproof.challenge_lemma_false`.
- **Direct `.olean` binding.** `ThetaConstraints.lean` models the exact quantifier and type shapes of the extracted archive predicates without importing the multi-million-line archive `.olean` tree.
- **Comparator.** The `leanprover-community` Comparator has not yet been run on the full 17 M-line submission.

## Independent verification

You do not need to build the 17 M-line archive to verify this repository. Under the pinned Mathlib v4.30.0 toolchain:

```bash
lake build
```

All closed theorems in `Disproof.lean` and `ScaffoldingAudit.lean` compile with zero `sorry`s and depend only on the standard Lean axioms (`propext`, `Classical.choice`, `Quot.sound`).

## Files

| File | Role |
|------|------|
| `Disproof.lean` | Lean-verified countermodel (`challenge_lemma_false`) proving the extracted classical + literature + theta-shaped boundary interface does not force the multiplicity bound (no `sorry`) |
| `ThetaConstraints.lean` | Formalizes `ClassicalBoundaryPackage` and archive-shaped predicates together with the open challenge statement (`challenge_lemma_theta_layering`, one `sorry`) |
| `ScaffoldingAudit.lean` | Standalone Lean 4 metaprogramming linter that walks live dependency cones via BFS, normalizes under `whnf`, traces shortest paths to `True` definitions, and flags pass-through `Prop` carriers (no `sorry`) |
| `ContinuumGapChallenge.lean` | Bare general case open (`challenge_lemma_general`, one `sorry`) |
| `SWAP_TEST.md` | Architectural observation documenting the compiler cascade when `anyGeometry` is swapped to `False` |
| `STRUCTURAL_INTEGRITY.md` | Architectural analysis of pass-through scaffolding in ultra-large formalizations |
| `COUNTERMODEL.md` | Human-readable explanation of the formal Davenport–Heilbronn-style countermodel |
| `ModeledRowsU.lean` | Sorry-free modeled structural unidentifiability: non-isomorphic lattices share the same modeled HN shadow; the existential interface does not recover rank or dimension (`two_lattices_same_rowsu_shadow`, `unidentifiable_lattice_structure`). This modeled result is not a claim about archive `RowsU` or that RH is false. |
| `FormalObstruction.lean` | Closes the comparison for the vacuous case (no `sorry`) |
| `LivePathExtraction.lean` | Primary-source extraction of the 8-edge path |
| `DependencyConfirmed.lean` | Public graph evidence and vacuity proof |
| `ExtractedVacuousGeometry.lean` | Exact extraction of `anyGeometry` from the archive |
| `VacuousGeometryBridge.lean` | Connects the challenge to the concrete vacuous finding |
| `X-files_Continuum_Gap_Challenge.md` | Full challenge statement |
| `CITATIONS.md` | Citation table for the 8-edge path and audit facts |
| `ContinuumGapCritique.lean` | Conceptual illustration (schematic, one `sorry`) |

## Sorry policy

Exactly three `sorry`s total (all confined to open challenge targets and schematic illustration; zero `sorry`s in `Disproof.lean` and `ScaffoldingAudit.lean`):

1. `ContinuumGapChallenge.challenge_lemma_general` — open obligation
2. `ThetaConstraints.challenge_lemma_theta_layering` — open obligation (formally refuted for the extracted boundary class by `Disproof.challenge_lemma_false`)
3. `ContinuumGapCritique.pure_discrete_multiplicity_does_not_force_RH` — deliberate schematic

No other `sorry`s, custom axioms, or `native_decide`s are permitted. CI enforces the count.

Root `lakefile.toml` requires Mathlib v4.30.0. CI builds all modules under real Mathlib.

## Build / verification status

| Stage | What it means | Status |
|-------|---------------|--------|
| Statement type-check | Structures, namespaces, imports compile | Done |
| Mathlib CI | Full proofs under Mathlib v4.30.0 | Verified (Green) |
| Interface disproof (`Disproof.lean`) | `sorry`-free refutation of extracted boundary sufficiency | Verified (Green) |
| Architectural linter (`ScaffoldingAudit.lean`) | Core Lean 4 BFS + `whnf` + pass-through checker | Verified (Green) |
| Content (Front A) | Circularity / theta-constraint audit against commit `40e56bab` | Extracted & Modeled |
| Cascade test | Architectural dependence on vacuous geometry | Documented (`SWAP_TEST.md`) |
