# X-Files

**A public collection of independent mathematical theories, structural frameworks, and formal verification methods**

**Author:** JackyReaps / AnooBus  
**Priority date (core framework):** July 25, 2026  
**Compiled:** August 28, 2026  
**Last audit update:** November 25, 2026

---

## What This Repository Is

This repository is a public, timestamped research log. It collects original theories, structural mechanisms, conditional templates, numerical modules, and Lean 4 formalisation artefacts developed independently and released into the public domain of ideas.

The material has been used or is intended for use in other projects, formalisation efforts, and research contexts. The goal is transparent priority documentation, clear separation of claims, and reproducible artefacts.

The contents fall into several distinct but related strands:

1. **Hierarchical Jacobian + Discrete Möbius Fold framework** — a three-layer architecture: a local unipotent Jacobian, a global discrete fold and scar tensor, and a monitored bridge.
2. **Conditional templates** for classical open problems, including Navier–Stokes regularity, the S⁶ complex structure, and Collatz-type gauges.
3. **Prime Tower Drift Hypothesis** — a self-contained numerical and transcendental module.
4. **LASLS constructions and corrections**.
5. **Lean 4 formalisation work** for filters, volume preservation, unforced boundaries, and LASLS correctness.
6. **Meta-layer verification methodology** for ultra-large formalisation efforts, including proof irrelevance, hollow wrappers, and scaffolding audits.
7. **Riemann Hypothesis continuum-gap case study** — extraction of a concrete live dependency path, architectural audit, and a sorry-free interface countermodel.

All claims that depend on unverified embeddings or regularity hypotheses are explicitly marked as conditional.

---

## Core Framework: Hierarchical Jacobian + Discrete Möbius Fold

**Priority date:** July 25, 2026

The framework has three layers:

1. **Local:** a hierarchical triangular, unipotent Jacobian with determinant one and an explicit inverse.
2. **Global:** a discrete Möbius fold mediated by an interference membrane and scar tensor \(\Lambda\).
3. **Bridge:** a composite map

   \[
   \Phi_{\Lambda}=\Phi\circ\exp(\operatorname{ad}_{\Lambda}),
   \]

   whose monodromy is monitored by residual-flux parity.

### Important corrections

- Monodromy built solely from unit lower-triangular Jacobians is always \(+1\). A sign of \(-1\) requires an orientation-reversing gluing outside the unipotent group; this framework does not construct one.
- The information-theoretic leakage term \(L\) is not non-negative in general. A condition such as \(L\geq 0\) must be stated explicitly as a hypothesis on the joint distribution.

Primary documents: `01-priority-declaration.md`, `02-master-framework.md`, and `03-open-problems.md`.

---

## Status of Major Directions

| Direction | Status | Notes |
|---|---|---|
| Hierarchical triangular Jacobian | Complete and elementary | Determinant \(1\); explicit inverse |
| Discrete Möbius / scar tensor | Definitional with formalisation gaps | See the gap analysis |
| Residual-flux parity | Defined; control of monodromy not proved | — |
| Navier–Stokes | Conditional template only | Requires unverified embedding hypotheses |
| S⁶ complex structure | Exploratory / conditional | Embedding not constructed |
| Collatz-type gauge | Heuristic | — |
| **Prime Tower Drift Hypothesis** | Numerically solid for \(n\leq 10^5\) | Self-contained module |
| LASLS constructions | Classical correctness with corrections | See the Lean files |
| Meta-layer verification methodology | Documented with a reference implementation | `META_VERIFICATION.md`; `ScaffoldingAudit.lean` |
| RH continuum-gap case study | Sorry-free countermodel and architectural audit | `riemann-hypothesis/` |

---

## Repository Contents

### Priority and framework documents

| File | Description |
|---|---|
| `01-priority-declaration.md` | Dated priority statement for the core framework |
| `02-master-framework.md` | Mathematical exposition of the three-layer architecture |
| `03-open-problems.md` | Mapping of the framework to established open problems |
| `04-x-posts-index.md` | Chronological index of public X posts used as source material |
| `05-OpenAI-structural-correspondence.md` | Notes on structural correspondence with other work |

### Independent modules

| File | Description |
|---|---|
| `06-prime-tower-hypothesis.md` | Prime Tower Drift Hypothesis in Cipolla-normalised form, with numerical verification |
| `07-LASLS-post-quantum-trapdoor.md` | LASLS construction with later corrections |
| `prime_tower.py` | Supporting numerical script |

### Gap analyses, closures, and corrections

| File | Description |
|---|---|
| `X-files_Formalisation_Gap_Analysis.md` | Proven, missing, and currently unformalisable claims |
| `X-files_Dimensional_Table_Corrected.md` | Corrected dimensional scaling table |
| `X-files_Minimal_Closure_NS.md` | Conditional Navier–Stokes theorem |
| `X-files_Minimal_Closure_S6.md` | Conditional theorem for the S⁶ complex structure |
| `Structural_Obstructions.md` | Scaling obstructions and practical filters |
| `Euler_Discrepancy_Audit.md` | Methodological parallels: forcing dependency and coordinate degeneracy |

### Lean 4 formalisation artefacts

| File | Status |
|---|---|
| `X-files_Filters.lean` | Proven: coordinate non-degeneracy, rotational inertia, and energy parity |
| `X-files_Unforced_Boundary.lean` | Proven: `IsStrictlyUnforced` classifier |
| `VolumePreservation.lean` | Statements only; two `sorry`s pending the Jacobi module |
| `VolumePreservationLemmas.lean` | Algebraic support |
| `LASLS_Correctness.lean` | Proven: classical correctness and explicit refutations |
| `LASLS_Anchor.lean` | Proven: exact bijectivity criterion and repaired family |

### Meta-layer verification and large-scale audit work

| File or directory | Description |
|---|---|
| `META_VERIFICATION.md` | General analysis of proof irrelevance, hollow wrappers, and the need for external scaffolding audits in ultra-large Lean 4 developments |
| `riemann-hypothesis/` | Concrete case study: extraction of a large RH formalisation's live dependency path (commit `40e56bab`), the `ScaffoldingAudit.lean` linter, and the sorry-free `Disproof.lean` interface countermodel |

---

## Quick Reference

Hierarchical Jacobian:

```text
P_i(x₁, …, x_i) = x_i + g_i(x₁, …, x_{i-1})
det J = 1
```

Information identity:

```text
H(I) + H(J) = H(M) + D(I) + D(J) + L
L := I(I;M) + I(J;M) - H(M)
```

Here \(L\geq 0\) is a hypothesis on the joint distribution, not a theorem.

Composite map:

```text
Phi_Lambda = Phi ∘ exp(ad_Lambda)
```

Monodromy in the unipotent case:

```text
Hol_gamma(Phi_Lambda) = +1
```

A sign of \(-1\) requires an orientation-reversing gluing outside the unipotent group; none is constructed here.

---

## Build and Verification

Lean toolchain: v4.30.0, with Mathlib pinned in `lake-manifest.json`.

```bash
lake build
```

The `riemann-hypothesis/` subdirectory contains closed theorems in `Disproof.lean` and `ScaffoldingAudit.lean` that compile independently of the multi-million-line archive they analyse.

---

## Philosophy of the Collection

The major ideas in this repository were made public by the author through dated priority documents, public posts, Lean artefacts, and reproducible scripts. The repository is intended to:

- establish clear temporal priority;
- keep conditional claims explicitly conditional;
- provide reproducible formal and numerical artefacts; and
- serve as a stable reference for structural mechanisms that may be reused or extended by others.

Attribution is requested when these mechanisms are adopted elsewhere, including the hierarchical unipotent Jacobian, discrete Möbius fold and scar tensor, residual-flux parity, meta-layer scaffolding audits, and continuum-gap methodology.
