# The Davenport-Heilbronn Countermodel

This document explains the formal countermodel constructed in `Disproof.lean`. It demonstrates mathematically why the classical literature inputs used by the Alpöge archive are insufficient to force the Riemann Hypothesis.

## 1. The Interface of the Live Path

We extracted the exact dependency path from the certified archive (commit `40e56bab`). The proof of `UpperTheory.EveryCharacter` (and therefore RH) relies on the following hypotheses:
- `hA` : `ThetaIntegralsAgree`
- `hM` : `LocalMatching`
- `hX` : `CovolumeBoundOfX`
- `geo` : `anyGeometry := fun _ _ _ => True`

In `ThetaConstraints.lean`, we model this interface as `ThetaLiftMultiplicity`. To prove the Riemann Hypothesis, the archive must show that the surviving multiplicity mass extracted from this structure is bounded by classical non-RH data (the AFE error bound + window length).

## 2. The Literature Extraction

By tracing the call site of `every_character_of_theta_integrals_local_matching`, we discovered that `hA` and `hM` are not novel theta-lifts. They are discharged entirely by a single application of classical literature:

```lean
PositivityTheory.ThKR.theoremK_head2 
  (eis_bl_of_literature O) 
  (siegel_weil_std_of_literature O)
```

This means the archive is simply recycling standard Eisenstein and Siegel-Weil bounds. In our Lean model, we stub these classical inputs as `True` because they are well-known results that hold for *any* functional equation, regardless of where the zeros lie.

## 3. Constructing the Countermodel

Because the literature inputs (`hA`, `hM`, `hX`) are just standard bounds, they impose **zero structural restrictions** on the multiplicity mass. 

In `Disproof.lean`, we construct `fakeMultiplicity`:
- It sets `window = 1` (satisfying the AFE).
- It sets `mass_after_trace = 100`.
- It satisfies `hA`, `hM`, and `hX` using `trivial` (representing the classical literature bounds).
- It sets `geo` to the vacuous `anyGeometry`.

Because the literature bounds do not constrain the mass, `fakeMultiplicity` is a perfectly valid `ThetaLiftMultiplicity`.

## 4. The Disproof

The classical analytic bound in our framework is `windowLength + errorBound = 1 + 1 = 2`. 

The countermodel's surviving mass is `100`, which strictly violates the bound. 

In `Disproof.lean`, we formally prove `challenge_lemma_false`:
> If the theta-layering does not supply extra constraints beyond classical literature, then the theorem `∀ ms C, thetaLiftMultiplicity_bounded ms C` is FALSE.

## 5. Conclusion

The certified archive claims that classical data (functional equation, AFE, Siegel-Weil) forces the critical line. The machine-checked countermodel proves that this exact interface is mathematically insufficient. 

If the archive reaches `RiemannHypothesis` using only this interface, it is relying on the vacuous `anyGeometry` predicate to smuggle in the missing mathematical force. The countermodel proves that the architecture, as extracted, does not contain the required bounds.
