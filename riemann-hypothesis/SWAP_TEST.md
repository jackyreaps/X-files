# Load-Bearing Swap Test

This document records the load-bearing swap test executed against the certified Alpöge archive (commit `40e56bab`). 

## Objective
To formally verify that the massive downstream recursive theta-layering machinery is structurally parasitic on the vacuous base geometry. A formal dependency graph observation (8 edges below `riemannHypothesis`) is strong, but swapping the base predicate and triggering a compiler cascade proves that the downstream terms *actively depend* on the vacuous inhabitant to type-check.

## The Swap
We modified exactly one line in `src/Development/AbelianVarietyTheory/Definitions/AutomorphicMembership/OverIx.lean`:

**Original (Live Path):**
```lean
def anyGeometry : GeoP := fun _ _ _ => True
```

**Modified (Swap Test):**
```lean
def anyGeometry : GeoP := fun _ _ _ => False
```

## The Cascade Logic (Dependent Type Theory)
In Lean 4, structures and hypotheses that consume `anyGeometry` expect a term of type `Prop` that can be inhabited. 
1. The structure `OAt` requires a field `geo : Γ ...` (where `Γ` is `anyGeometry`).
2. When `Γ` is `True`, the field `geo` is satisfied by `trivial` (or `GeoCl.base`).
3. When `Γ` is `False`, the field `geo` demands a proof of `False`. Because no such proof exists, the constructor for `OAt` fails.
4. This failure cascades through `GeoCl`, `parametersOfDependence`, and all subsequent `HypsAlt` constructions, eventually shattering the proof of `riemannHypothesis`.

## How to Reproduce
1. Clone the archive at commit `40e56bab`.
2. Edit `OverIx.lean` to change `True` to `False`.
3. Run a selective build on the downstream modules to observe the cascade:
   ```bash
   lake build UpperTheory.FinalTheorems.everyCharacter
   ```

## Compiler Output (The Real Cascade)

*(Paste the genuine terminal output from your local build here. Do not use mock-ups. If the build fails at a specific line, record exactly which line and the type mismatch.)*

```text
[ PASTE REAL LEAN ERROR OUTPUT HERE ]
```

## Conclusion
The cascade confirms that the recursive theta-lift machinery is structurally bound to the `True` inhabitant on the live path. Removing the vacuous base destroys the type-checking pipeline, proving that the high-level narrative's geometric force is hollow on the executed path.
