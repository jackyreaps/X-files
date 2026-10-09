module

public import Mathlib

/-!
# X-files unforced boundary

**Status: proved (definitions restated; the energy statements are conditional on
an energy balance supplied as a hypothesis).**

The X-files repository has a short Lean file `X-files_Unforced_Boundary.lean`
whose `lasls_viscous_arrest_isolated` concludes `True` (vacuous). This module
restates it for the current Mathlib and adds content. Nothing is copied.

* `IsStrictlyUnforced`, `forced_fails_unforced`: as in the repository.
* `unforced_energy_antitone`: given an energy balance
  `E′(t) = −ν D(t) + ⟨f(t), u(t)⟩` with dissipation `D ≥ 0` and `ν ≥ 0`, a strictly
  unforced system has non-increasing energy.
* `viscous_decay`: with a Poincaré-type bound `κ E ≤ D` and `κ > 0`, the energy
  decays exponentially: `E(t) ≤ E(0) e^{−νκt}` for `t ≥ 0`.

The energy balance itself (that Navier–Stokes solutions satisfy it) is a
hypothesis here, as it is in the repository; it is not derived from a PDE.

**Note.** The filter content here is independent of the trace identity in
`X-files_Minimal_Closure_NS.md`; that identity is not used.
-/

@[expose] public section

set_option autoImplicit false

open Set MeasureTheory

namespace Xfiles.Unforced

variable {V : Type*} [NormedAddCommGroup V]

/-- Strictly unforced: the external force vanishes for all time. -/
def IsStrictlyUnforced (f : ℝ → V) : Prop := ∀ t, f t = 0

/-- A force that is nonzero at one time fails the unforced criterion. -/
theorem forced_fails_unforced (f : ℝ → V) (t₀ : ℝ) (hf : f t₀ ≠ 0) :
    ¬ IsStrictlyUnforced f := fun h => hf (h t₀)

variable [InnerProductSpace ℝ V]

/-- The energy balance `E′(t) = −ν D(t) + ⟨f(t), u(t)⟩` (dissipation plus the power of
the force), taken as a hypothesis. -/
def EnergyBalance (E D : ℝ → ℝ) (ν : ℝ) (f u : ℝ → V) : Prop :=
  ∀ t, HasDerivAt E (-(ν * D t) + inner ℝ (f t) (u t)) t

/-- **Unforced energy antitone.** Under the energy balance, an unforced system with
nonnegative viscosity and dissipation has non-increasing energy. -/
theorem unforced_energy_antitone {E D : ℝ → ℝ} {ν : ℝ} {f u : ℝ → V}
    (hbal : EnergyBalance E D ν f u) (hf : IsStrictlyUnforced f) (hν : 0 ≤ ν)
    (hD : ∀ t, 0 ≤ D t) : Antitone E := by
  have hd : ∀ t, HasDerivAt E (-(ν * D t)) t := fun t => by simpa [hf t] using hbal t
  exact antitone_of_deriv_nonpos (fun t => (hd t).differentiableAt)
    (fun t => by rw [(hd t).deriv]; nlinarith [hD t])

/-- **Exponential decay.** With a Poincaré-type bound `κ E ≤ D` and `κ > 0`, an
unforced system's energy satisfies `E(t) ≤ E(0) e^{−νκt}` for `t ≥ 0`. -/
theorem viscous_decay {E D : ℝ → ℝ} {ν κ : ℝ} {f u : ℝ → V}
    (hbal : EnergyBalance E D ν f u) (hf : IsStrictlyUnforced f) (hν : 0 ≤ ν)
    (hκ : 0 < κ) (hP : ∀ t, κ * E t ≤ D t) {t : ℝ} (ht : 0 ≤ t) :
    E t ≤ E 0 * Real.exp (-(ν * κ) * t) := by
  have hd : ∀ t, HasDerivAt E (-(ν * D t)) t := fun t => by simpa [hf t] using hbal t
  set G : ℝ → ℝ := fun s => E s * Real.exp (ν * κ * s)
  have hG : ∀ s, HasDerivAt G (-(ν * D s) * Real.exp (ν * κ * s) +
      E s * (Real.exp (ν * κ * s) * (ν * κ))) s := by
    intro s
    have h2 : HasDerivAt (fun s => Real.exp (ν * κ * s)) (Real.exp (ν * κ * s) * (ν * κ)) s := by
      simpa using ((hasDerivAt_id s).const_mul (ν * κ)).exp
    exact (hd s).mul h2
  have hanti : Antitone G := antitone_of_deriv_nonpos (fun s => (hG s).differentiableAt)
    (fun s => by
      rw [(hG s).deriv]
      have he := Real.exp_pos (ν * κ * s)
      have : ν * (κ * E s) ≤ ν * D s := mul_le_mul_of_nonneg_left (hP s) hν
      nlinarith)
  have h0 := hanti ht
  simp only [G, mul_zero, Real.exp_zero, mul_one] at h0
  have : E t = E t * Real.exp (ν * κ * t) * Real.exp (-(ν * κ) * t) := by
    rw [mul_assoc, ← Real.exp_add]; ring_nf; simp
  rw [this]
  exact mul_le_mul_of_nonneg_right h0 (Real.exp_pos _).le

end Xfiles.Unforced
