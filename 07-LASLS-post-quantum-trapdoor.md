# Lower-Anchor Skew-Linear Stacking (LASLS)
## 4D (and 6D) Post-Quantum Cryptographic Trapdoor Automorphism

**Author:** JackyReaps / AnooBus  
**Date of original posts:** 26 July 2026  
**Compiled for X-files repository:** October 2026

### Primary Source Posts

- Main announcement: https://x.com/JackyReaps/status/2081412450537127937
- Follow-up (“Evolved Jacobian” bridge): https://x.com/JackyReaps/status/2081412625070501895
- Detailed 4D algorithms thread:
  - https://x.com/JackyReaps/status/2081418803137704289
  - https://x.com/JackyReaps/status/2081419060080714041
  - https://x.com/JackyReaps/status/2081419272761262090
  - https://x.com/JackyReaps/status/2081419478609375409
  - https://x.com/JackyReaps/status/2081419568052933017
- 6D extension thread:
  - https://x.com/JackyReaps/status/2081445836056047894
  - https://x.com/JackyReaps/status/2081446017333936529
  - https://x.com/JackyReaps/status/2081446242907775290
  - https://x.com/JackyReaps/status/2081447215927628069
  - https://x.com/JackyReaps/status/2081449467945840878 (Part 2)
  - https://x.com/JackyReaps/status/2081450175562678601 (Part 3)
  - https://x.com/JackyReaps/status/2081450725641502894 (Part 4)

---

### Original Announcement Text

MORE:  
Lower-Anchor Skew-Linear Stacking method and weaponizing it into a post-quantum cryptographic trapdoor, the world experiences three immediate, systemic shifts:

- Defusing a Quantum Apocalypse
- Radical Speed Improvements for Mobile Encryption
- Commercial/Geopolitical Dominance

“Evolved Jacobian” lower-anchor patch successfully bridges the gap between stabilizing spacecraft orbits and building quantum-resistant encryption.

---

### Algorithm 1: Key Generation (Constructing the Trapdoor)

**Input:** Security parameter λ (defining the bit-size and maximum degree of the secret modifier polynomials).

**Output:**
- Public Key 𝒫𝒦 = { F_Public(X) }
- Private Key 𝒮𝒦 = { A⁻¹, B⁻¹, g, h, k }

1. **Construct the Secret Tame Map (G)**  
   Create a 4D lower-triangular polynomial automorphism mapping  
   G(X) = (P, Q, R, S)ᵀ utilizing secret, randomly generated high-degree non-linear modifier polynomials:

P(x, y, z, w) = x
Q(x, y, z, w) = y + g(x)
R(x, y, z, w) = z + h(x, y)
S(x, y, z, w) = w + k(x, y, z)

2. **Generate Mixing Matrices**  
Randomly generate two invertible 4 × 4 matrices A and B over a finite field 𝔽_q.  
Calculate their matrix inverses A⁻¹ and B⁻¹.

3. **Compute the Scrambled Public Function**  
Symbolically compose the public mapping function to mask the lower-triangular zero profile:

F_Public(X) = A · G(B · X)

4. **Publish and Secure**  
Publish F_Public(X) as the Public Key.  
Store { A⁻¹, B⁻¹, g, h, k } securely as the Private Key.

**Secret Jacobian Matrix [J_G] (Lower-Triangular Anchor):**

[  1      0      0      0  ]
[ dg/dx   1      0      0  ]
[ dh/dx  dh/dy   1      0  ]
[ dk/dx  dk/dy  dk/dz   1  ]

**Properties:**  
det(J_G) = 1  
Spectrum σ = {1, 1, 1, 1}

---

### Algorithm 2: Encryption (The Forward Permutation)

**Input:**  
A cleartext message block split into four field coordinates  
M = (m₁, m₂, m₃, m₄)ᵀ ∈ 𝔽_q⁴  
Public Key 𝒫𝒦

**Output:**  
A ciphertext block C = (c₁, c₂, c₃, c₄)ᵀ

1. **Vector Injection**  
   Direct the cleartext coordinates into the public polynomial array, treating M as the input vector X:

X = (m₁, m₂, m₃, m₄)ᵀ

2. **Evaluate the Public Map**  
Evaluate the polynomial system F_Public(X) under the public keys.  
Because the operations are straightforward multiplications and additions, this forward step executes rapidly in 𝒪(1) algebraic evaluation time.

3. **Output Ciphertext**  
Set the resulting 4D vector as the ciphertext payload:

J_Public = A · J_G · B

**Properties:** Inverting J_Public without the private key = NP-Hard

---

### Algorithm 3: Decryption (The Sequential Back-Substitution Trapdoor)

**Input:**  
Ciphertext block C = (c₁, c₂, c₃, c₄)ᵀ  
Private Key 𝒮𝒦

**Output:**  
Recovered cleartext block M = (m₁, m₂, m₃, m₄)ᵀ

1. **Un-mix Output Vector**  
   Strip away the outer linear mixing matrix by multiplying the ciphertext vector by the inverse matrix A⁻¹ to yield the intermediate scrambled vector Y:

Y = (y₁, y₂, y₃, y₄)ᵀ = A⁻¹ · C

2. **Execute Sequential Back-Substitution (The Lower Anchor Step)**  
Walk down the uncoupled lines of the “EVOLVED” system to untangle the non-linear adjustments sequentially in linear 𝒪(n) steps:

- **Line 1 (Anchor):** Isolate the baseline variable:  
  x̂ = y₁

- **Line 2:** Inject x̂ into the second line to instantly resolve the second variable:  
  ŷ = y₂ − g(x̂)

- **Line 3:** Inject both resolved metrics to calculate the third variable:  
  ẑ = y₃ − h(x̂, ŷ)

- **Line 4 (W-Axis):** Resolve the final temporal/hyper-space layer:  
  ŵ = y₄ − k(x̂, ŷ, ẑ)

Assemble the clean intermediate state vector:  
X̂ = (x̂, ŷ, ẑ, ŵ)ᵀ

3. **Un-mix Input Vector**  
Remove the initial linear mapping layer to recover the original cleartext array:

M = B⁻¹ · X̂

**Complexity:**  
- Forward evaluation: 𝒪(1)  
- Authorized inverse: 𝒪(n) Linear Scan

---

### 6D Extension – Lower-Triangular Mapping for Quantum Bottleneck

To solve the 6D quantum bottleneck, map state coordinates  
Vector Ψ = (x, y, z, u, v, w)ᵀ through a lower-triangular sequence G(Ψ):

P1 = x          (The Fixed Lower Anchor)
P2 = y + g1(x)
P3 = z + g2(x, y)
P4 = u + g3(x, y, z)
P5 = v + g4(x, y, z, u)
P6 = w + g5(x, y, z, u, v)

**6D Mutually Unbiased Bases Constraint System under Lower-Triangular LASLS Mapping**

The structure produces a strictly lower-triangular dependency matrix (visualized in the original posts). The sequential dependency profile allows global phase isolation via an explicit lower-triangular structural profile of the gradient operator J_MUB.

**Core algebraic engine claim:**  
The lower anchor point flattens multi-sheeted folds.  
The computational proof: Slashing matrix inversion from exponential chaos to linear back-substitution.

---

### Relation to the Broader X-files Framework

This LASLS construction is a direct cryptographic application of the hierarchical / triangular (“Evolved”) Jacobian that forms Layer 1 of the X-files framework.

Later posts in the research line explicitly reference extending the scar-tensor / Möbius action to these 4-D / 6-D LASLS trapdoor automorphisms.

---

*JackyReaps / AnooBus*  
*Original material posted 26 July 2026*  
*Compiled for archival in the X-files repository*