# On the Dynamical Coupling of Exponential Systems and Asymptotic Prime Distributions: The Prime Tower Drift Hypothesis

# The Prime Tower Drift Hypothesis

**(Cipolla-Normalised Form)**

**Author:** JackyReaps
**Date:** 23 September 2026
**Status:** Formal conjecture + numerical verification up to n = 10⁵

## Abstract

We couple the transcendental system `x^x = y` to a nested-division tower built
from primes normalised by the three-term Cipolla approximant. Inside the window
`n ≤ 10⁵` the tower stabilises to a reciprocal pair of values. Because
`x^{x−1} ≥ 1` for all real `x > 0`, only the even branch (`L ≈ 1.060`) yields
real solutions; the odd branch is domain-forbidden. The residual slow drift of
the product quantifies the higher-order discrepancy between `p_k` and the
truncated Cipolla expansion.

## 1. Definitions

Let `p_k` be the `k`-th prime. For `k ≥ 3` define the three-term Cipolla
approximant

    D_k = k ( ln k + ln ln k − 1 + (ln ln k − 2) / ln k ).

The normalised terms are `S_k = p_k / D_k`.

**Correction (October 2026).** The numerical script `prime_tower.py` uses

    S₁ = p₁ / 2
    S₂ = p₂ / 3
    D_k = the Cipolla approximant for k ≥ 3,

and starts the Cipolla formula at `k = 3` (0-indexed position 2). With these
conventions the tower terms `T(n)` are positive for all `n` in the computed
range `n ≤ 10⁵`.

The originally printed values of `D₂`, `D₃`, `D₄` were negative, which made the
printed tower negative from `n = 4` onward and the equation `x^{x−1} = T(n)`
insoluble. The document now follows the script.

The tower is the recurrence

    T(2) = S₂,   T(n) = S_n / T(n−1)   (n ≥ 3).

## 2. Empirical Behaviour (n ≤ 10⁵)

The even and odd subsequences remain within O(10⁻²) of the reciprocal pair

    L_even ≈ 1.060,   L_odd ≈ 0.943.

**Correction (October 2026).** The sequences `L_even` and `L_odd` depend on the
starting convention: rescaling the start by a factor `c` multiplies every even
term by `c` and divides every odd term by `c`. The only intrinsic quantity is
the product

    T(n) · T(n−1) = S_n.

The "dual state" is therefore automatic once `S_n → 1`: the two limits, if they
exist, are reciprocal.

## 3. Coupling to x^x = y

Impose `y = x · T(n)`. The system reduces at once to

    x^{x−1} = T(n).

### Domain wall

The function `f(x) = x^{x−1}` (`x > 0`) has global minimum value 1 attained
only at `x = 1`. Consequently:

- `L_odd ≈ 0.943 < 1` produces **no real positive roots**;
- `L_even ≈ 1.060 > 1` produces **exactly two** real positive roots:

      x_+ ≈ 1.255811,  y_+ ≈ 1.331159,
      x_- ≈ 0.773324,  y_- ≈ 0.819723.

These are the only real positive target states inside the verified window.

## 4. Nature of the Drift

Absolute convergence of `∏ S_k` would require `∑|log S_k| < ∞`.

**Correction (October 2026).** Cipolla's next term gives

    S_k − 1 ≈ −((ln ln k)² − 6 ln ln k + 11) / (2 (ln k)³).

The size is therefore `(ln ln k)² / (ln k)³`, not `/(ln k)²` as previously
stated. The divergence conclusion survives: the series still diverges (integral
test). The quadratic numerator is always positive for `ln ln k ∈ ℝ`, so
asymptotically `S_k < 1`, and "approaches 1 from above" holds only in the
computed window.

## 5. Scope and Limitations

- Fully verified by direct computation to `n = 10⁵` (see `prime_tower.py`).

- **Correction (October 2026).** `S_k → 1` is a theorem (it follows from the
  prime number theorem). The open question is whether the separate even and odd
  limits exist, not whether the product converges.

- Extension to higher power towers is immediate and inherits the same domain
  restriction `L ≥ 1`.

*JackyReaps · 23 September 2026*

The Prime Tower Drift Hypothesis provides a bridge between discrete prime
fluctuations and smooth transcendental equations. Future investigations will
extend this framework to higher power towers (e.g., `x^{x^x} = y`), where the
domain constraints `L ≥ 1` will continue to apply.
