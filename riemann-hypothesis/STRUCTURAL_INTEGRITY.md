# Structural Integrity in Ultra-Large Formalizations

## Verification and Architectural Review

Lean's kernel checks that a proof term has its declared type under the project's axioms. That establishes formal correctness relative to those definitions; it does not, by itself, establish that a proof follows its author's intended mathematical narrative. At large scale, inspecting the active declarations and interfaces can help reviewers understand what a result actually depends on.

Architectural audits are complementary diagnostics. A reported dependency or trivial definition is a lead for review, not evidence that a theorem is false, unsound, or invalid. Likewise, a scan that finds no suspicious names does not prove that no semantic dependency exists.

## Current Scaffolding Audit Tool

`ScaffoldingAudit.lean` defines the command:

```lean
#audit_theorem SomeNamespace.someTheorem
```

The implementation walks a transitive cone by following constants in declaration values, excludes selected standard-library prefixes, and reports definitions whose leading lambda binders can be peeled to reveal the syntactic body `True`.

The current implementation does **not** implement shortest-path reporting, `whnf` normalization, pass-through analysis, or mutual-inductive metadata checks. It also does not determine whether a reported constant is mathematically load-bearing. See `META_VERIFICATION.md` for the precise scope and the runnable example in `ScaffoldingAuditDemo.lean`.

## Modeled Countermodel and Scope

`Disproof.lean` proves a countermodel result for the explicitly modeled boundary interface. It does not import the archive's `.olean` tree and does not refute the archive's internal terms under their exact definitions. See `COUNTERMODEL.md` for the interface-fidelity qualification.

## Option 2 Closure: Direct-Import Probe

The following findings are from the reported direct-import probe against the archive's own declarations on `main`. The probe printed the relevant declarations and traversed the declaration dependency cone for `GlobalTheory.Fc.HypsAlt` and `GlobalTheory.Fc.DefiniteSideCondition`.

- The reported cone contains **14,473** active non-stdlib constants.
- The name scan reports **zero** `GeoP`, `GeoCl`, or `anyGeometry` references. Four `ReciprocityTheory.ChartRestriction.G.Geo.Tor.*` chart-type names matched the broader `Geo` substring scan; these are not the named geometric predicates being sought.
- The printed `DefiniteSideCondition` is not a `True` collapse: it ends in the substantive row-data obligation `Formalism.L2.RowDataTransport.RowsU`.
- `Closed 𝒞 P` is quantified over families and their members; emptiness of an indexing family alone is not a reduction of the declaration to `True`.
- The non-geometric analytic target identified at this `TopPlug` input is `RowsU`, together with the `Closed` / `LinkN` indexing.

These observations refine the earlier extracted-path discussion: on the checked declarations, the named geometric predicate payload is absent from this interface, while the row-data package is the substantive obligation. The name-based dependency scan is not a semantic proof that all geometric content is absent, and the result does not establish whether `RowsU` itself is true, sufficient, or independently justified. Further content-level analysis should focus on `RowsU` and its indexing.

Kernel acceptance of the archive's `riemannHypothesis` term remains untouched. Option 2 closes the direct-import inspection of the stated interface; it does not upgrade the separate modeled countermodel into a refutation of the archive theorem.
