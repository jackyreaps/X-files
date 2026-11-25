# Structural Integrity in Ultra-Large Formalizations

## The Verification Gap

The Lean kernel guarantees axiomatic validity: if a term type-checks, the theorem is mathematically true relative to the axioms.

However, the kernel does not check architectural intent.

When a formalization scales to hundreds of thousands of lines, human line-by-line review becomes impossible. Automated refactoring, tactic synthesis, or degenerate parameter choices can route an intended theorem through a logically valid but mathematically uninformative path.

The resulting proof may be logically valid, but mathematically hollow. A deep dependency tree of recursive structures looks like a complex geometric engine, but the live execution path might simply pass a `True` predicate through layers of scaffolding.

## The Scaffolding Audit Tool

To catch these "continuum gaps," we introduce `ScaffoldingAudit.lean`. It is a general-purpose Lean 4 metaprogramming linter designed to catch architectural hollowness.

Using `#audit_theorem`, the tool performs three checks:

1. **Live Dependency Cone Walk:** It traverses the transitive dependencies reachable from a target theorem to find the exact shortest path to anomalies.
2. **Triviality Normalization:** It detects definitions that evaluate to `True` (like `fun _ _ _ => True`), even if they are hidden behind lambda binders or intermediate definitions.
3. **Pass-Through Transport Detection:** It inspects proof terms to check if a hypothesis is merely a "pass-through payload" passed into structure constructors without ever being mathematically eliminated.

## The Alpöge Case Study

Running the audit against the 2026 Alpöge formalization of the Riemann Hypothesis reveals exactly how this hollowing occurs:

- The 17-million-line proof uses `anyGeometry := fun _ _ _ => True` eight edges below the top-level theorem.
- The massive recursive theta-layering machinery simply transports this vacuous base up the chain.
- The critical analytic hypotheses (`hA`, `hM`, `hX`) are discharged by classical literature (Eisenstein / Siegel–Weil), not by a novel continuum mechanism on the live path.

By extracting the exact boundary interface and constructing a countermodel (`Disproof.lean`), we formally show that even when the non-trivial analytic *signatures* hold as structure fields, the abstract interface is insufficient to imply the claimed multiplicity bound. This is a statement about the extracted/modelled interface, not a refutation of the archive's kernel-checked theorem or an exhaustive audit of every module in the archive.

This is the future of formal verification: checking not just if a proof compiles, but if it actually means what it claims to mean.

## Live-path anchors (archive commit `40e56bab`)

These are the concrete drop-offs that the audit and the continuum-gap modules isolate. They document *what the live path carries*, not a claim that the kernel rejects `riemannHypothesis`.

| Target | Role on the live path |
|--------|------------------------|
| `anyGeometry` | Vacuous (`fun _ _ _ => True`); pure transport via `geoCl` |
| `CovolumeBoundOfX` | Classical eventual L³ bound |
| `ThetaIntegralsAgree` / `LocalMatching` | Literature hypotheses (EisBL + Siegel–Weil) |
| `DefiniteSideCondition` | Analytic condition; **no `GeoP` reference** in its definition file |
| `BoundAtTwoThreeFamilyFonAlt` | Slope / two-three family numerical control |
| `VWin` + `green_of_regular` | Windowed Green bridge into `EveryCharacter` |

Kernel acceptance of the original `riemannHypothesis` term remains untouched. The open formal work is to instantiate the archive-shaped constraints tightly enough to either force the multiplicity bound or exhibit a countermodel satisfying them.

## Extracted Live-Path Bottleneck (`TopPlug.lean`, Commit `40e56bab`)

An audit of the extracted dependency path from `SiegelEisensteinSecondTermHypotheses.lean` into `TopPlug.lean` (19 lines) shows how the lower theta-layering cascade connects to the top-level reduction:

1. **Upper Analytic Reduction (`TopPlug.lean`):** `every_character_of_green_v_win` is a non-circular reduction from `(Green, VWin, Nonempty (HypsAlt (fun 𝒞 => Closed 𝒞 fun Fm _ => LinkN Fm) DefiniteSideCondition))` to `ZeroFreeAll` (`zeroFreeAll_of_topG` at `la := 3 / 2`) and `EveryCharacter` (`imprimitive`), making zero reference to `GeoP`, `GeoCl`, or `anyGeometry`.
2. **Single Extracted Interface Bottleneck:** On the extracted live path, the lower theta-layering cascade enters `TopPlug.lean` exclusively through the single existential witness `Nonempty (HypsAlt ... DefiniteSideCondition)` produced by `nonempty_hyps_definite_side_of_closed_bound`.
3. **Architectural Implication on the Extracted Path:** Because `nonempty_hyps_definite_side_of_closed_bound` inhabits that `HypsAlt` witness while threading `geoCl anyGeometry` (`fun _ _ _ => True`) alongside classical literature (`hA`, `hM`) and eventual $L^3$ covolume thresholds (`hX`), the geometric tower performs no elimination along this path—indicating that, on the extracted dependency cone, the active analytic reduction sits in the `TopPlug` / `LinkN` / `DefiniteSideCondition` interface rather than in recursive geometric multiplicity.
