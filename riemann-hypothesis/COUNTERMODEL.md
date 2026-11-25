# The Davenport-Heilbronn Countermodel

This document explains the formal countermodel constructed in `Disproof.lean`. It demonstrates mathematically why the classical literature inputs used by the Alpöge archive are insufficient to force the multiplicity bound at the modeled interface.

## 1. The Interface of the Live Path

We extracted the dependency path from the certified archive (commit `40e56bab`). The proof of `UpperTheory.EveryCharacter` relies on the following hypotheses:

- `hA`: `ThetaIntegralsAgree`
- `hM`: `LocalMatching`
- `hX`: `CovolumeBoundOfX`
- `geo`: `anyGeometry := fun _ _ _ => True`

In `ThetaConstraints.lean`, we model this interface as `ThetaLiftMultiplicity`. Our claim is limited to that extracted and modeled interface.

## 2. The Literature Extraction

By tracing the call site of `every_character_of_theta_integrals_local_matching`, we found that `hA` and `hM` are discharged through classical literature, including:

```lean
PositivityTheory.ThKR.theoremK_head2
  (eis_bl_of_literature O)
  (siegel_weil_std_of_literature O)
```

This means those fields are not represented here as novel geometric elimination. In the Lean model, the classical inputs are stated as the corresponding extracted signatures and packages.

## 3. Constructing the Countermodel

In `Disproof.lean`, the model constructs `fakeMultiplicity`:

- It sets `window = 1`.
- It sets `mass_after_trace = 100`.
- It satisfies the modeled `hA`, `hM`, `hX`, and slope/windowed-Green shapes.
- It uses the vacuous `anyGeometry` where that field is carried on the extracted path.

The countermodel is an inhabited witness for the modeled package, not a claim that the archive's own exact interfaces are internally empty or inconsistent.

## 4. The Disproof

The modeled analytic bound is:

```text
windowLength + errorBound = 1 + 1 = 2
```

The countermodel's surviving mass is `100`, which strictly violates that bound.

In `Disproof.lean`, we therefore prove:

```lean
challenge_lemma_false
```

This says that the modeled classical + literature + slope + windowed-Green boundary does not force the claimed multiplicity bound.

## Interface Fidelity & Relation to Field-Excision Ablations

Formal verification engineers correctly observe that a countermodel built against locally redefined interfaces (`ThetaIntegralsAgree`, `LocalMatching`, `CovolumeBoundOfX`, `BoundAtTwoThreeFamilyFonAlt`, ...) does not automatically refute the archive's own Lean types unless the two interfaces are proven equivalent.

This repository deliberately adopts the weaker, transparent claim:

- `ThetaConstraints.lean` and `Disproof.lean` formalize statement shapes extracted from commit `40e56bab` (quantifiers, existential bounds, literature discharge via `theoremK_head2`, and zero `GeoP` dependence after `parametersOfDependence → anyGeometry`).
- They do **not** import the archive's `.olean` tree.
- Consequently, `challenge_lemma_false` refutes the modeled boundary interface, not the archive's internal terms under their exact definitions.

This is the same methodological posture used by community field-excision or ablation experiments: deleting or replacing the geometric payload (`anyGeometry := fun _ _ _ => True`) leaves the top-level type `RiemannHypothesis` intact. Those experiments show that the geometric field is not load-bearing for kernel acceptance. The present countermodel shows that the remaining classical + literature + slope + windowed-Green shapes, once the vacuous geometry is dropped, do not force the claimed multiplicity bound.

## 5. Scope of the Conclusion

The conclusion is intentionally narrow:

- It is a result about the extracted, modeled dependency path.
- It is not an exhaustive audit of all modules in the 17-million-line archive.
- It does not dispute kernel acceptance of the archive's `RiemannHypothesis` term.
- It does not claim that `anyGeometry` or another field, by itself, is proof of the Riemann Hypothesis.

The formal result isolates where additional constraints would be needed in this modeled interface and keeps that limitation explicit.
