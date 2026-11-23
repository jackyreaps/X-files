# Citations and provenance

**Provenance rule.** Rows marked `[project notes]` come from this
project's working notes about the Alpöge 2026 archive. They have not
been independently verified by the maintainer of this repository.
Rows marked `[repo]` are internal to this repository and are
verifiable directly.

## A. The 8-edge kernel path [project notes]

Source: project notes, referencing commit `40e56bab`.

| Dist | Declaration | Source file |
|---:|---|---|
| 0 | `riemannHypothesis` | `src/Main.lean` |
| 1 | `rhOfAll` | `src/Supplements/Kernels/MainTheorems.lean` |
| 2 | `allChi` | `src/Supplements/Kernels/MainTheorems.lean` |
| 3 | `UpperTheory.FinalTheorems.everyCharacter` | `…/CharacterBoxes/MainConclusion.lean` |
| 4 | `everyCharacter_of_row` | `…/CharacterBoxes/MainConclusion.lean` |
| 5 | `every_character_of_literature_of_vWin` | `…/ThetaPairLifts/ThirdPlaceSeries/EveryCharacterOfLiteratureOfVWin.lean` |
| 6 | `every_character_of_theta_integrals_local_matching` | `…/SiegelEisensteinSecondTermHypotheses.lean` |
| 7 | `GlobalTheory.Mem.Top.Bl.parametersOfDependence` | `…/Prm1.lean` |
| 8 | `GlobalTheory.Mem.Top.Bl.anyGeometry` | `…/OverIx.lean` (`fun _ _ _ => True`) |

Alternate 8-edge path (project notes): via
`nonempty_hyps_definite_side_of_closed_bound`.

## B. Claimed audit facts [project notes]

These have not been independently verified by this repository. They
are recorded because they inform the shape of the challenge; they are
not load-bearing for any Lean theorem in this repo.

- `anyGeometry` in kernel closure of all five headline theorems (mask 31).
- 29 direct references; 48 transitive dependents; 24 in the RH cone.
- Only inhabitants of `GeoP` on the live path: constant-`True` and
  its `GeoCl` closure.
- In `OAt`, content-bearing field is `lam : LamAre …`; `geo` is vestigial.

## C. Repo-internal facts [repo]

These are machine-checked in this repository with no `sorry`:

- `ContinuumGapChallenge.multiplicity_of_vacuous_le_classical`
- `ContinuumGapChallenge.challenge_consequence_live_path`
- `ContinuumGapChallenge.general_bound_fails_unrestricted`
- `ThetaConstraints.vacuous_theta_bounded`
- `ThetaConstraints.disproof_obligation_refutes`

These are the honest "closed" results. Everything above them depends
on instantiating `ThetaLiftMultiplicity` fields from the archive.

## D. Open

- Instantiation of `slope_bound_holds`, `relative_trace_holds`,
  `character_avg_holds` from the archive's actual theta constraints.
- A countermodel that satisfies those constraints and violates the
  classical bound (deciding `DisproofObligation`).
- A circularity argument showing one of the "classical" inputs is of
  RH strength.

## E. What this repository does not claim

- It does not claim the certified theorem is false.
- It does not claim the archive exists at any particular commit.
- It does not present any `[project notes]` row as independently
  verified. Downstream users should verify from the archive source.
