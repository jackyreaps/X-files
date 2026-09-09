# Structural Invariants and Scaling Obstructions for Navier-Stokes and the Three-Body Problem

This note collects scaling heuristics and classical invariant constraints that any claimed finite-time singularity in the 3D incompressible Navier-Stokes equations or the Newtonian three-body problem must confront. The emphasis is on intrinsic balances (dissipation versus stretching, angular momentum versus potential) versus extrinsic mechanisms (velocity-dependent forcing, degenerate coordinates, artificial parameter tuning).

The arguments are **obstructions and necessary filters**, not completed regularity theorems.

---

## 1. Navier-Stokes: Viscous versus Stretching Scales

Consider a smooth, divergence-free solution of the unforced 3D Navier-Stokes equations:

du/dt + (u · ∇)u = -∇p + ν Δu,   ∇ · u = 0

The vorticity formulation is:

dω/dt + (u · ∇)ω = (ω · ∇)u + ν Δω

### Scaling for a filamentary geometry

Suppose a localized vortex structure of characteristic core radius r(t) going to 0 and peak vorticity Ω(t). Under the assumption that the structure remains roughly filamentary, the two competing terms scale as:

|(ω · ∇)u|  ~  Ω² / r

|ν Δω|      ~  ν Ω / r²

Their ratio therefore satisfies:

|ν Δω| / |(ω · ∇)u|  ~  ν / (r Ω)

By the Beale-Kato-Majda criterion, a singularity at time T* requires the integral of Ω(t) from 0 to T* to be infinite.

If Ω(t) does not grow faster than roughly 1/r(t), the ratio tends to infinity and viscous dissipation dominates. This supplies a scaling obstruction for certain filament-type geometries in the unforced equations.

This is not a proof that no singularity can form. It only constrains the admissible relative growth rates of Ω and r.

### Necessary filters for any claimed singularity

1. Force structure (if the claim is forced)  
   The external force f must belong to a clearly stated function class. If f depends on u in a way that cancels or overpowers the viscous term, the problem is reduced to a driven Euler system.

2. Coordinate non-degeneracy  
   Any change of coordinates used in the construction must keep the Jacobian determinant bounded away from zero. Otherwise the singularity may only be a coordinate collapse.

3. Caffarelli-Kohn-Nirenberg compatibility  
   The singular set of a suitable weak solution has parabolic Hausdorff dimension at most 1. A long-lived filament of positive length is in tension with this theorem.

---

## 2. Three-Body Problem: Angular Momentum versus Potential

The Newtonian three-body equations are:

m_i * q_i'' = sum_{j ≠ i} G * m_i * m_j * (q_j - q_i) / |q_j - q_i|³

Let I(t) be the moment of inertia about the centre of mass. The Lagrange-Jacobi identity is:

(1/2) I'' = 2K - U = 2E + U

A singularity can be a collision or a non-collision singularity in which I(t) goes to infinity in finite time while distances stay positive.

Angular momentum J supplies a barrier:

K ≥ |J|² / (2I)

Any construction that drives I to infinity while keeping distances positive must overcome this rotational barrier.

This is an obstruction and a filter, not a theorem that rules out all non-collision singularities.

---

## 3. Comparison Table

| Role                          | Navier-Stokes                    | Three-Body Problem                     |
|-------------------------------|----------------------------------|----------------------------------------|
| Destabilising mechanism       | Vorticity stretching (ω · ∇)u    | Potential-driven acceleration I''      |
| Stabilising mechanism         | Viscous term ν Δω                | Angular momentum barrier |J|²/(2I)     |
| Singular behaviour            | Vorticity or enstrophy → ∞       | I(t) → ∞ or minimum distance → 0       |
| Common loopholes              | Velocity-dependent force, det J → 0 | Suppressing angular momentum, grid tuning |

---

## 4. Practical Pre-Filter Script

```python
import re
import sys

def structural_filter(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        text = f.read()

    print("=== Structural filter on:", file_path, "===")
    flags = []

    if re.search(r'(f\s*`\(\s*u|force.*depend.*velocity|cancel.*viscos|shadow.*laplacian)', text, re.I):
        flags.append("Possible velocity-dependent or viscosity-cancellingn force")

    if re.search(r'(det\s*`\(?\s*J\s*\)`?\s*(→|->|to)\s*0|collaps(e|ing)\s+(chart|coord|mesh|grid))', text, re.I):
        flags.append("Possible coordinate or mesh degeneracy")

    if re.search(r'(angular\s+momentum\s*=\s*0|set\s+J\s*=\s*0|neglect.*rotation)', text, re.I):
        flags.append("Possible suppression of angular momentum")

    if not flags:
        print("No common loophole keywords detected.")
    else:
        print("Flags raised:")
        for item in flags:
            print(" -", item)
        print("\nManual mathematical inspection required.")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python structural_filter.py <manuscript.txt>")
    else:
        structural_filter(sys.argv[1])
```

---

## 5. Summary

| Point                             | Statement                                                                 |
|-----------------------------------|---------------------------------------------------------------------------|
| Type of document                  | Heuristic scaling obstructions and necessary filters                      |
| Main Navier-Stokes obstruction    | Viscosity can dominate stretching as the core radius goes to zero         |
| Main Three-Body obstruction       | Angular momentum acts as a barrier against certain singularities          |
| Required checks for any claim     | Force class, non-degenerate coordinates, CKN dimension bounds             |
| What this document does not claim | A full proof of regularity or complete exclusion of singularities         |no

- Unforced Navier-Stokes and the Newtonian three-body problem possess intrinsic stabilising mechanisms (viscosity and angular momentum).
- Any claimed singularity must still clear the classical filters listed above.
- These are useful tools for scrutiny, not finished existence or non-existence theorems.
