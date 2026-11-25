# The Davenport–Heilbronn Countermodel & `ModeledRowsU` Unidentifiability

This document explains the formal countermodel in `Disproof.lean` and the related
structural unidentifiability result in `ModeledRowsU.lean`.

Both concern **verification of modeled interfaces**. They do not claim that the
analytic Riemann hypothesis is false, or that Lean’s kernel is unsound.

## 1. The Interface of the Live Path

We extracted the dependency path from the certified archive (commit `40e56bab`).
The proof of `UpperTheory.EveryCharacter` relies on hypotheses including:

- `hA`: `ThetaIntegralsAgree`
- `hM`: `LocalMatching`
- `hX`: `CovolumeBoundOfX` (modeled as a classical eventual / covolume-style bound)
- `geo`: `anyGeometry := fun _ _ _ => True`

In `ThetaConstraints.lean` this is modeled as `ThetaLiftMultiplicity`.
Claims in this repository are limited to that extracted and modeled interface.

## 2. The Literature Extraction

Call-site tracing shows that `hA` and `hM` are discharged through classical
literature (for example `PositivityTheory.ThKR.theoremK_head2` on Eisenstein /
Siegel–Weil packages), not as novel geometric elimination on the live path.

## 3. Constructing the Countermodel (`Disproof.lean`)

In `Disproof.lean`, `fakeMultiplicity` instantiates the modeled boundary package with:

- `windowLength = 1` and `errorBound = 1`
- `survivingMass = 100`
- `hX := ⟨100, by norm_num, le_rfl⟩` (satisfying the modeled covolume bound)
- modeled `hA`, `hM`, slope, and windowed-Green shapes satisfied
- vacuous geometry (`anyGeometry := fun _ _ _ => True`) where carried on the extracted path

The modeled analytic bound is:

```text
windowLength + errorBound = 1 + 1 = 2
```

Because `survivingMass = 100 > 2`, `Disproof.lean` proves (`sorry`-free):

```lean
challenge_lemma_false
```

That means the modeled classical + literature + theta-shaped boundary does not force the claimed multiplicity bound.

## 4. `ModeledRowsU` (Structural Unidentifiability)

Direct inspection of `GlobalTheory.Fc.HypsAlt` and `DefiniteSideCondition` on archive `main` confirmed **0** `GeoP` / `anyGeometry` constants across **14,473** transitive non-stdlib constants, isolating `Formalism.L2.RowDataTransport.RowsU` (**10,092** constants, **0** custom `True` stubs) as a genuine Harder–Narasimhan lattice statement.

`ModeledRowsU.lean` formalizes why a non-vacuous existential Harder–Narasimhan shadow still fails to identify which higher-dimensional graph lattice produced it:

- `two_lattices_same_rowsu_shadow`: non-isomorphic `latticeA` (`rank = 8, dim = 24`) and `latticeB` (`rank = 16, dim = 48`) share the exact same modeled analytic inequalities.
- `unidentifiable_lattice_structure` and `ambient_dimension_unidentifiable`: no structural property separating those lattices is forced by the existential modeled interface alone.

## 5. Interface Fidelity & Relation to Field-Excision Ablations

- `ThetaConstraints.lean`, `Disproof.lean`, and `ModeledRowsU.lean` formalize modeled statement shapes without importing the archive’s `.olean` tree.
- Community field-excision / ablation experiments show that deleting the geometric payload leaves `RiemannHypothesis` intact for kernel acceptance; `Disproof.lean` and `ModeledRowsU.lean` show that the remaining boundary shapes do not force the multiplicity bound or uniquely pin down the underlying higher-dimensional lattice.

## 6. Scope of the Conclusion

- Results concern extracted, modeled dependency interfaces.
- This is not an exhaustive audit of the full archive.
- Kernel acceptance of the archive’s `riemannHypothesis` term is not disputed.
- Vacuous geometry and existential unidentifiability are architectural findings about the live path, not a standalone proof or disproof of RH.
