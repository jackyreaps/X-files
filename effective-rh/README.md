# effective-rh — Two-Stage Effective Reduction Framework

This folder isolates a **methodological contract** for effective results in
prime-number theory. It does **not** contain a proof of the Riemann
Hypothesis, nor a disproof of any theorem of analytic number theory.

## Stage 1 — Obstruction Filter (already formalized elsewhere)

Arguments that rely on:

* an unbridged asymptotic quantifier (`∀ᶠ x in atTop` / non-constructive
  existence of a threshold), or
* an uncoupled higher-dimensional lattice projection whose fibers are
  forgotten,

cannot by themselves deliver fully effective finite-scale control.
Those obstructions are formalized in the continuum-gap and lattice-underdetermination modules of the parent repository.

## Stage 2 — Explicit Finite-Scale Contract

`EffectiveBridge.lean` defines the structure:

```lean
EffectivePrimeBound (ψ : ℝ → ℝ)
```

modeling a Schoenfeld-type bound:

$$|\psi(x)-x| < C\sqrt{x}\,(\log x)^2 \qquad\text{for all explicit }x\ge X_0\ge 73.2.$$

- The single theorem proved (`effective_bound_eliminates_finite_gap`) is immediate from the definition: any inhabitant of the contract is immune, by construction, to a finite-scale violation beyond its own explicit threshold.
- **Open problem**: produce a `sorry`-free term of type `EffectivePrimeBound ψ` for the Chebyshev function $\psi$. Any such term would constitute an effective proof of the Riemann Hypothesis (and conversely, RH implies the existence of such constants).

## Status

| Claim | Status |
| :--- | :--- |
| Defines a clean, machine-checkable target of Schoenfeld strength | Yes |
| Proves that any such target is free of the non-effective `atTop` gap | Yes (`sorry`-free) |
| Constructs the target for the actual Chebyshev function | No — open |
| Disproves RH or any theorem of analytic number theory | No |
| Claims a completed solution | No |
