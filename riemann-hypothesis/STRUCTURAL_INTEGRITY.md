# Structural integrity — live-path obstruction

**Archive:** leanprover-community/riemann-hypothesis @ `40e56bab`  
**X-files CI:** Mathlib v4.30.0 (green)

## Live-path inputs at `SiegelEisensteinSecondTermHypotheses.lean`

| Target | Location | Live-path content |
|--------|----------|-------------------|
| `anyGeometry` | OverIx.lean | `fun _ _ _ => True` (vacuous; transport only) |
| `CovolumeBoundOfX` / hX | LiftLambdaBound.lean | Classical eventual L³ bound |
| `ThetaIntegralsAgree` / hA | WeilTensorModels | Literature (EisBL + Siegel–Weil) |
| `LocalMatching` / hM | WeilTensorModels | Literature (same package) |
| `DefiniteSideCondition` | DefiniteSideCondition.lean | Analytic; **no GeoP reference** |
| `BoundAtTwoThreeFamilyFonAlt` | BoundAtTwoThreeFamilyFon.lean | Slope / two-three family bound |
| `VWin` + `green_of_regular` | TopPlug.lean | Windowed Green → EveryCharacter |

## Division of labour

- **Arithmetic / automorphic setup** (`UnitaryGroupThirdPlaceHypotheses`): local-global, RecT, green characters — not geometry.
- **Local theta data** (`ThetaLocalInputs`): period integrals, Howe, test vectors — not geometry.
- **Numerical control**: BoundAtTwoThreeFamilyFonAlt + CovolumeBoundOfX.
- **Final bridge**: VWin + green_of_regular → EveryCharacter.
- **Geometry**: `geoCl anyGeometry` is pure transport on the live path.

## X-files formal status

- Vacuous comparison: **closed** (`vacuous_theta_bounded`, FormalObstruction).
- `challenge_lemma_theta_layering`: **open** (one `sorry`) — needs real force from the three archive-shaped constraints.
- `Disproof.lean`: countermodel with all slots `True` and mass ≫ bound → unrestricted challenge lemma is false.
- Kernel acceptance of archive `riemannHypothesis`: **untouched**.
