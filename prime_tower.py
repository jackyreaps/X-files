#!/usr/bin/env python3
"""
Prime Tower Drift Hypothesis - High-Precision Sieve & Simulation Tool
Verifies the stable window data up to n = 10^5 and calculates the real targets.
"""

import numpy as np
from scipy.optimize import fsolve

def generate_primes_to_n_counts(target_count):
    """Generates the first N prime numbers using an optimized block sieve."""
    # Estimating upper bound using prime number theorem safely
    if target_count < 6:
        return [2, 3, 5, 7, 11][:target_count]
    
    limit = int(target_count * (np.log(target_count) + np.log(np.log(target_count))))
    sieve = np.ones(limit, dtype=bool)
    sieve[0:2] = False
    
    for index in range(2, int(np.sqrt(limit)) + 1):
        if sieve[index]:
            sieve[index*index::index] = False
            
    primes = np.where(sieve)[0]
    return primes[:target_count]

def compute_cipolla_tower(primes_list):
    """Computes the Cipolla-normalized sequence and builds the nested division tower."""
    total_primes = len(primes_list)
    S = np.zeros(total_primes)
    
    # Base cases for early index offsets
    S[0] = primes_list[0] / 2.0  # p_1 = 2
    S[1] = primes_list[1] / 3.0  # p_2 = 3
    
    # Apply 3-term Cipolla denominator from index k=3 onward (0-indexed position 2)
    for idx in range(2, total_primes):
        k = idx + 1  # 1-based index
        ln_k = np.log(k)
        ln_ln_k = np.log(ln_k)
        
        D_k = k * (ln_k + ln_ln_k - 1.0 + (ln_ln_k - 2.0) / ln_k)
        S[idx] = primes_list[idx] / D_k
        
    # Build recursive nested tower: T(n) = S(n) / T(n-1)
    T = np.zeros(total_primes)
    T[0] = S[0]
    for idx in range(1, total_primes):
        T[idx] = S[idx] / T[idx-1]
        
    return T

def solve_exponential_system(L_target):
    """Solves the transcendental target equation x^(x-1) = L."""
    def target_equation(x):
        return x**(x-1) - L_target
    
    # Finding upper and lower real roots via fsolve optimization
    root_upper = fsolve(target_equation, 1.5)[0]
    root_lower = fsolve(target_equation, 0.5)[0]
    
    return root_upper, root_lower

def main():
    print("="*70)
    print(" PRIME TOWER DRIFT HYPOTHESIS: HIGH-PRECISION RUN ")
    print("="*70)
    
    max_primes = 100000
    print(f"[+] Generating the first {max_primes:,} prime numbers...")
    primes = generate_primes_to_n_counts(max_primes)
    
    print("[+] Simulating the alternating nested division tower...")
    T = compute_cipolla_tower(primes)
    
    # Milestones to check the secular drift velocity
    milestones = [100, 1000, 10000, 100000]
    
    print("\n--- Empirical Verification Data ---")
    for m in milestones:
        # Subtract 1 for 0-indexed positioning arrays
        even_idx = m - 1 if m % 2 == 0 else m - 2
        odd_idx = m - 1 if m % 2 != 0 else m - 2
        
        t_even = T[even_idx]
        t_odd = T[odd_idx]
        prod = t_even * t_odd
        
        print(f"At n = {m:6,}:  T_even = {t_even:.6f}  |  T_odd = {t_odd:.6f}  |  Product = {prod:.6f}")
        
    # Solve system using the finalized stable empirical window bounds
    L_even_stable = T[max_primes - 1] # Accurate even edge boundary
    x_plus, x_minus = solve_exponential_system(L_even_stable)
    
    print("\n--- Real Domain Window Solutions (Even Branch) ---")
    print(f"Using L_even Bound ≈ {L_even_stable:.6f}")
    print(f" -> Upper Real State: x+ = {x_plus:.6f},  y+ = {x_plus * L_even_stable:.6f}")
    print(f" -> Lower Real State: x- = {x_minus:.6f},  y- = {x_minus * L_even_stable:.6f}")
    print("="*70)

if __name__ == "__main__":
    main()
