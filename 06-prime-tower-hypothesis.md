# On the Dynamical Coupling of Exponential Systems and Asymptotic Prime Distributions: The Prime Tower Drift Hypothesis

# The Prime Tower Drift Hypothesis  
**(Cipolla-Normalised Form)**

**Author:** JackyReaps  
**Date:** 23 September 2026  
**Status:** Formal conjecture + numerical verification up to \(n=10^5\)

---

## Abstract

We couple the transcendental system \(x^x=y\) to a nested-division tower built from primes normalised by the three-term Cipolla approximant. Inside the window \(n\le 10^5\) the tower stabilises to a reciprocal pair of values. Because \(x^{x-1}\ge 1\) for all real \(x>0\), only the even branch (\(L\approx 1.060\)) yields real solutions; the odd branch is domain-forbidden. The residual slow drift of the product quantifies the higher-order discrepancy between \(p_k\) and the truncated Cipolla expansion.

---

## 1. Definitions

Let \(p_k\) be the \(k\)-th prime. For \(k\ge 3\) define the three-term Cipolla approximant
\[
D_k = k\Biggl(\ln k + \ln\ln k - 1 + \frac{\ln\ln k-2}{\ln k}\Biggr).
\]
The normalised terms are \(S_k = p_k/D_k\).  
The tower is the recurrence
\[
T(2)=S_2,\qquad T(n)=\frac{S_n}{T(n-1)}\quad(n\ge 3).
\]

## 2. Empirical Behaviour (\(n\le 10^5\))

The even and odd subsequences remain within \(O(10^{-2})\) of the reciprocal pair
\[
L_{\mathrm{even}}\approx 1.060,\qquad L_{\mathrm{odd}}\approx 0.943.
\]
The consecutive product \(T_{\mathrm{odd}}\times T_{\mathrm{even}}\) approaches 1 from above at a very slow rate.

## 3. Coupling to \(x^x=y\)

Impose \(y=x\cdot T(n)\). The system reduces at once to
\[
x^{x-1}=T(n).
\]

### Domain wall
The function \(f(x)=x^{x-1}\) (\(x>0\)) has global minimum value 1 attained only at \(x=1\). Consequently:

- \(L_{\mathrm{odd}}\approx 0.943<1\) produces **no real positive roots**;
- \(L_{\mathrm{even}}\approx 1.060>1\) produces **exactly two** real positive roots:
  \[
  \begin{align*}
  x_+&\approx 1.255811, & y_+&\approx 1.331159,\\
  x_-&\approx 0.773324, & y_-&\approx 0.819723.
  \end{align*}
  \]

These are the only real positive target states inside the verified window.

## 4. Nature of the Drift

Absolute convergence of \(\prod S_k\) would require \(\sum|\log S_k|<\infty\). The remainder after the three-term truncation satisfies
\[
|\log S_k|\asymp\frac{(\ln\ln k)^2}{(\ln k)^2},
\]
whose series diverges (integral test). The divergence is extremely slow; inside \(n\le 10^5\) the practical effect is a frozen dual-state engine whose residual motion tracks the size of the Cipolla error term.

## 5. Scope and Limitations

- Fully verified by direct computation to \(n=10^5\) (see `prime_tower.py`).
- No claim of absolute convergence or of a true mathematical limit is made.
- Extension to higher power towers is immediate and inherits the same domain restriction \(L\ge 1\).

---

*JackyReaps · 23 September 2026*The Prime Tower Drift Hypothesis provides a bridge between discrete prime fluctuations and smooth transcendental equations. Future investigations will extend this framework to higher power towers (e.g., $x^{x^x} = y$), where the domain constraints $L \ge 1$ will continue to enforce strict parity conditions on complex mathematical structures.
