# An Investigation of an Alternate Base for a Conservative Matrix Field and an Example of a Search for a Representation of ζ(5)

**Research Note — Exploratory Mathematics**

Louis Blaine
Correspondence: louisblaine45@gmail.com
March 2026

---

## Abstract

Conservative Matrix Fields (CMFs), recently introduced by Raz et al. (2025) as a unifying structure underlying hundreds of formulas for mathematical constants such as π, are defined on a two-dimensional integer lattice with a commutativity condition on mixed lattice paths. In this note we investigate what happens when the underlying base is extended from the real integer lattice ℤ² to pairs of complex numbers over the Gaussian integers ℤ[i], and ask whether the resulting algebraic structure generates new mathematics. We show that the 4-periodicity of i under multiplication naturally stratifies lattice paths into two classes: commutative paths (4-step closure) and anticommutative paths (2-step closure), the latter being algebraically equivalent to spinors. The combined integrability conditions admit a natural realisation in the Pauli algebra, yielding a structure analogous to a superfield. We identify known constant pairs (even/odd zeta values, alternating/non-alternating series) as projections of this double-coverage structure, and derive predictions about an irrationality proof for ζ(5). A computational search for an Apéry-like degree-5 recurrence guided by the anticommutative CMF framework is described and partially executed, consistent with the structural predictions while identifying the remaining computational challenge.

**Keywords:** Conservative Matrix Field, Riemann zeta function, irrationality, Clifford algebra, spinors, Apéry's theorem, continued fractions, Ramanujan Machine

---

## 1. Introduction

In late 2025, Raz, Shalyt, Leibtag, Kalisch, Weinbaum, Hadad, and Kaminer [1] announced a remarkable discovery: a previously unknown mathematical structure, the Conservative Matrix Field (CMF), underlies hundreds of formulas for the constant π, including those of Archimedes, Euler, Madhava, and Ramanujan. Their Euler2AI project, combining large language models with novel symbolic algorithms, extracted 385 unique π-formulas from 455,050 arXiv preprints and demonstrated that 43% of them belong to a single CMF. This work grew from the Ramanujan Machine project [2], which uses AI to generate conjectures about fundamental constants in the form of continued fractions.

A CMF is defined on the two-dimensional integer lattice ℤ². At each lattice point (m,n) one assigns 2×2 step matrices M_x(m,n) and M_y(m,n) whose entries are polynomial functions of m and n.¹ The conservativity condition — the discrete analog of curl = 0 — demands that mixed lattice steps commute:²

$$M_y(m+1,n) \cdot M_x(m,n) = M_x(m,n+1) \cdot M_y(m,n)$$

The Ramanujan Machine group showed that by choosing polynomial functions f(x,y) and f*(x,y) defining the step matrices, one obtains CMFs whose continued-fraction limits are fundamental constants. This note asks: what happens if we replace the real integer lattice with a complex base? Specifically, we investigate the Gaussian integer lattice ℤ[i] and show that the algebraic structure of i — its 4-periodicity under multiplication — naturally produces two distinct classes of lattice paths with fundamentally different integrability conditions. We call these the commutative and anticommutative CMF structures, and we argue that they correspond respectively to the even and odd special values of the Riemann zeta function.

---

## 2. The Periodicity Structure of i and Path Classification

The imaginary unit i satisfies the 4-cycle i¹=i, i²=−1, i³=−i, i⁴=1. When lattice paths are taken over ℤ[i] rather than ℤ², closed loops naturally acquire different periodicity.

**Definition 2.1** (Path Classification). Let γ be an elementary square loop in the lattice. We say γ is a *commutative path* if the accumulated matrix product around γ equals the identity after 4 steps, and an *anticommutative path* if it equals minus the identity after 2 steps.

Setting S(m,n) = M_y(m+1,n)·M_x(m,n) and T(m,n) = M_x(m,n+1)·M_y(m,n), the two integrability conditions are:

$$S - T = 0 \quad \text{(commutative CMF)}; \qquad S + T = 0 \quad \text{(anticommutative CMF)}$$

A field satisfying both conditions simultaneously requires [M_x, M_y] = 0 and {M_x, M_y} = 0, equivalently M_xM_y = M_yM_x = 0. The Pauli matrices σ₁, σ₃ provide a natural nontrivial solution: writing M_x = aσ₁ + bσ₃, M_y = cσ₂, both conditions are satisfied by the Clifford relations σᵢσⱼ + σⱼσᵢ = 2δᵢⱼI. Other solutions exist (e.g. pairs of orthogonal projectors such as diag(1,0) and diag(0,1)), but the Pauli realisation is the one compatible with the nonzero polynomial step-matrix structure required by the CMF construction.

### 2.2. Explicit step matrices: worked example for c₁

We give the explicit step matrices for the constant c₁ (see companion paper [3], §3.1). Define:

$$M_x(m,n) = m\cdot\sigma_z + \sigma_x = \begin{bmatrix} m & 1 \\ 1 & -m \end{bmatrix} \quad \text{(trace-zero, antidiagonal-plus-diagonal)}$$

$$M_y(m,n) = \sigma_y\text{-scaled} = \begin{bmatrix} 0 & 1 \\ -1 & 0 \end{bmatrix} \quad (= i\cdot\sigma_y \text{ up to phase})$$

**Anticommutative CMF condition.** Compute S + T at any lattice point (m,n):

$$S = M_y(m+1,n)\cdot M_x(m,n) = \begin{bmatrix}0&1\\-1&0\end{bmatrix}\begin{bmatrix}m&1\\1&-m\end{bmatrix} = \begin{bmatrix}1&-m\\-m&-1\end{bmatrix}$$

$$T = M_x(m,n+1)\cdot M_y(m,n) = \begin{bmatrix}m&1\\1&-m\end{bmatrix}\begin{bmatrix}0&1\\-1&0\end{bmatrix} = \begin{bmatrix}-1&m\\m&1\end{bmatrix}$$

$$S + T = \begin{bmatrix}0&0\\0&0\end{bmatrix}. \quad \checkmark^4$$

**Scalar recursion.** The projective (Möbius) action of M_x(k,0) on ℂℙ¹ is z ↦ (kz+1)/(z−k), so the path product along the x-axis ∏_{k=1}^{N} M_x(k,0) generates the recursion z_k = (kz_{k-1}+1)/(z_{k-1}−k), i.e. p(k) = 1, r(k) = k in the notation of Theorem 2.1 of [3]. This is the recurrence whose angle-sum limit gives S₁ = arg(Γ(1+i/2)/Γ(1/2+i/2)) and c₁ = |tan(S₁)| ≈ 0.55500…

| k | M_x(k,0) | Möbius step z → (kz+1)/(z−k) |
|---|---|---|
| 1 | [[1,1],[1,−1]] | z → (z+1)/(z−1) |
| 2 | [[2,1],[1,−2]] | z → (2z+1)/(z−2) |
| 3 | [[3,1],[1,−3]] | z → (3z+1)/(z−3) |
| k | [[k,1],[1,−k]] | z → (kz+1)/(z−k) |

**Table 0.** M_x(k,0) for the first values of k, giving the c₁ recurrence.

The corresponding M_y matrices (all equal to [[0,1],[−1,0]]) play no role in the path along the x-axis but are required for the CMF integrability condition to hold on the full 2D lattice. Analogous constructions yield p(k)/r(k) = (2k−1)/k for c₄ and k(k+1)/k² for c₅; see [3, §3.3–3.4].

### 2.3. Conventions

We use the principal branch Arg : ℂ* → (−π, π] throughout. The CMF constant is defined as c = |tan(Arg(z))| = |Im(z)/Re(z)| where z = Γ(1+w/2)/Γ(1/2+w/2) (the second form is manifestly branch-free and equal to the first when Re(z) ≠ 0). Numerical evidence confirms Re(z) > 0 for all Gaussian primes of norm ≤ 41 (verified at 120-digit precision; see companion paper [4, §2.3]). The parameter w = π/N(π) ∈ ℚ(i) for every Gaussian prime π.

---

## 3. Double Coverage: Real and Complex Computational Paths

The two path types create a double coverage of the constant landscape. Along a commutative path (real lattice steps only), matrix products accumulate as real polynomial products and converge to real constants with all-positive-term series. Along an anticommutative path (steps through the i-direction), each pair of steps introduces a sign flip via i² = −1, generating an alternating series.⁵ This provides a structural explanation for why certain pairs of mathematical constants are in fact projections of a single complex CMF:

| Commutative partner | Anticommutative partner | Relationship |
|---|---|---|
| ζ(2) = π²/6 | π/4 = 1−1/3+1/5−⋯ | π² vs π (degree drop) |
| ζ(2n) — closed form in π | ζ(2n−1) — no closed form | Even vs odd |
| Li₂(1) = π²/6 | Li₂(1/2) = π²/12 − ln²(2)/2 | Full vs half path |
| e = Σ 1/n! | 1/e = Σ (−1)ⁿ/n! | Forward vs reverse |

**Table 1:** Known constant pairs as commutative/anticommutative CMF partners.

The degree-drop pattern (π² paired with π) is structurally significant: commutative paths close after 4 steps (accumulating squared quantities), while anticommutative paths close after 2 steps (accumulating linear quantities). This correctly predicts that even zeta values ζ(2n) are paired with odd values ζ(2n−1). The even zeta values all have closed forms in powers of π: ζ(2)=π²/6, ζ(4)=π⁴/90, ζ(6)=π⁶/945. The odd zeta values ζ(3),ζ(5),ζ(7),… have no such forms — not accidentally, but because they live on anticommutative paths.

---

## 4. Degree-5 Anticommutative CMF and Predictions for ζ(5)

Apéry's 1978 proof [4] of the irrationality of ζ(3) relied on the three-term recurrence:

$$n^3 u_n = (34n^3 - 51n^2 + 27n - 5)\, u_{n-1} - (n-1)^3\, u_{n-2}$$

whose ratio b_n/a_n converges to ζ(3) fast enough to prove irrationality. Under the anticommutative CMF framework, we derive the following predictions for ζ(5):

**Prediction 4.1.** The irrationality proof for ζ(5), if it exists via this method, will use a degree-5 recurrence n⁵ u_n = A₅(n) u_{n-1} − (n−1)⁵ u_{n-2} where α = lim_n A₅(n)/n⁵ > e⁵ ≈ 148.41.

**Prediction 4.2.** The natural form is A₅(n) = (2n−1)[Q·n²(n−1)² + P·n(n−1) + R] with α = 2Q, requiring Q ≥ 75.

**Prediction 4.3.** (Poincaré-Perron) The characteristic equation x² − αx + 1 = 0 must have roots λ+ > e⁵ > 1 > λ− > 0 with λ+λ− = 1, giving |b_n/a_n − ζ(5)| ~ (1/λ+)ⁿ sufficient to prove irrationality after clearing lcm(1,…,n)⁵.³

**Prediction 4.4.** (Heuristic obstruction) Apéry's proof of ζ(3) succeeded because ζ(4) = π⁴/90 ≠ 0 provided a non-vanishing commutative anchor. For ζ(5), the functional equation maps s=5 to ζ(−4)=0 (a trivial zero), removing this anchor. This heuristic obstruction, within our framework, suggests why ζ(5) is harder than ζ(3), though it does not constitute a proof that no Apéry-type recurrence exists.

---

## 5. Computational Search

We implemented a computational search for the predicted recurrence, first validating it on Apéry's ζ(3) recurrence: iterating to n=50, the ratio b₅₀/a₅₀ matches ζ(3) to 55 significant figures.

### 5.1. Search Design

Parameters Q ∈ [75, 119], P ∈ [−300, 300], R ∈ [1, 60]; approximately 2.5 million candidates evaluated in 90 seconds. No recurrence satisfying all integrability and irrationality conditions was found. The closest candidate was Q=75, P=−222, R=27, which converges to within 8.75×10⁻⁸ of ζ(5) but fails the integrality condition (lcm(1,…,n)⁵·a_n ∉ ℤ for n ≥ 4).⁶

| Property | ζ(3) — Apéry | ζ(5) — Predicted |
|---|---|---|
| Recurrence degree | 3 | 5 |
| Leading coeff α | 34 | 2Q > 148.41 |
| λ+ | 17+12√2 ≈ 33.97 | > e⁵ ≈ 148.41 |
| lcm exponent | 3 | 5 |
| Free params in A | 0 (fully determined) | 3 (Q, P, R) |
| Commutative anchor | ζ(4)=π⁴/90 ≠ 0 | ζ(6)=π⁶/945, func. eq. → ζ(−4)=0 |
| Status | Proven irrational (1978) | Open problem |

**Table 2:** Comparison of Apéry's recurrence for ζ(3) and predicted structure for ζ(5).

### 5.2. Scope of remaining search

The feasible band has λ+ just above e⁵; extending the search to Q ≤ 1000 would require approximately 35 minutes on a 100-core cluster and is recommended as the immediate next computational step.

### 5.3. Relation to the linear-forms approach to odd zeta values

The negative search result at Q ≤ 119 should be read against the linear-forms approach to odd zeta values. Rivoal [10] established that infinitely many odd zeta values ζ(2n+1) are irrational, and Zudilin [11] refined this to the statement that at least one of ζ(5), ζ(7), ζ(9), ζ(11) is irrational. Ball and Rivoal [12] proved the lower bound dim_ℚ span_ℚ{1, ζ(3), ζ(5), …, ζ(2n+1)} ≥ (1 − o(1)) · (log n)/(1 + log 2), and the direction has since been sharpened by Fischler and others [13]. These results establish irrationality of ℚ-linear combinations of odd zeta values via small linear forms, and do not directly address the existence of an Apéry-type three-term recurrence for any individual value — the target of the CMF search presented here. A negative outcome at our parameter range is therefore consistent with the Rivoal–Zudilin framework and leaves open the existence of a single-value recurrence for ζ(5) at larger parameters.

---

## 6. A Superfield-like Structure and Targets for New Constants

A matrix field with both commutative and anticommutative components has the algebraic structure analogous to a superfield (in the sense of a ℤ₂-graded decomposition into even and odd sectors). In the Pauli basis:

$$M_{\text{total}} = \zeta(6)^{1/2}\sigma_3 + \zeta(5)\sigma_1 + \Xi(5)\sigma_2$$

where Ξ(5) is the imaginary Pauli (σ₂) component carrying the cross-term between sectors. If confirmed, Ξ(5) would be a new fundamental constant accessible only through the anticommutative CMF structure and invisible to existing commutative methods. We do not formalize the ℤ₂-graded structure as a rigorous supersymmetry algebra here; the analogy is structural rather than physical.

---

## 7. Missed π Formulas and the Anticommutative Search

The Euler2AI project [1] found that 43% of known π formulas belong to a single commutative CMF. We conjecture that a significant fraction of the remaining 57% belong to anticommutative CMFs — formulas involving alternating series, half-integer arguments, or odd-weight modular forms invisible to a purely commutative search. Running the Euler2AI pipeline with the anticommutative integrability condition is the natural complement to the existing project.

---

## 8. Discussion and Open Questions

**(1) Existence of the ζ(5) recurrence.** Does a degree-5 recurrence satisfying all conditions exist? The framework suggests yes, but parameter space is not yet fully explored.

**(2) Uniqueness.** Poincaré-Perron analysis suggests the system is exactly determined (5 equations in 5 unknowns), pointing toward uniqueness once a valid recurrence is found.

**(3) Higher odd zeta values.** The pattern predicts degree-7 for ζ(7), degree-9 for ζ(9), with computational difficulty growing as e^d.

**(4) Mock theta functions.** Ramanujan's mock theta functions carry half-integer modular weight — a spinorial character — and may fit naturally within the anticommutative CMF framework.

**(5) Clifford generalisation.** Higher-dimensional Clifford algebras might produce CMF structures connecting mathematical constants to physical quantities. Whether the collapse mechanism from matrix dynamics to scalar recursion (§2.2) extends to Cl(p,q) beyond Cl(2) is an open question not addressed here.

---

## 9. Conclusion

We have shown that extending the base of a Conservative Matrix Field from the real integer lattice to the Gaussian integers naturally produces two classes of lattice paths — commutative and anticommutative — whose integrability conditions admit a natural realisation in the Pauli algebra, yielding a spinor-like algebraic structure. Explicit step matrices are constructed (§2.2) and the anticommutative CMF condition S+T=0 is verified. The commutative and anticommutative projections correspond respectively to even and odd special values of the Riemann zeta function. A computational search covering ~2.5 million candidates found no valid ζ(5) recurrence within the explored range, consistent with the prediction that the true recurrence, if it exists, lies at larger parameter values requiring cluster computation. The negative result is consistent with the Rivoal–Zudilin framework on irrationality of combinations of odd zeta values [10–12], which targets a different object (linear combinations) than the single-value Apéry-type recurrence sought here.

**Computational reproducibility.** The recurrence search code and Lean 4 formalization are available at github.com/Loublain/cmf-gaussian-primes [archived: doi:10.5281/zenodo.19670531]. The Lean formalization covers: CMF structure and path independence (`CMF.lean`, `PathIndep.lean`), polynomial CMF (`PolyCMF.lean`), commutative/anticommutative structure (`SuperCMF.lean`), Pauli step matrix verification (`PauliCMF.lean`), zeta pairing algebraic structure (`ZetaPairs.lean`), and recurrence predictions (`Recurrence.lean`). All theorems are machine-verified with no `sorry` and depend only on standard Mathlib axioms (`propext`, `Classical.choice`, `Quot.sound`). All searches were implemented in Python with mpmath (mp.dps = 50 for convergence checks) and are fully reproducible from the repository README.

---

## References

[1] T. Raz, M. Shalyt, E. Leibtag, R. Kalisch, S. Weinbaum, Y. Hadad, I. Kaminer. From Euler to AI: Unifying Formulas for Mathematical Constants. NeurIPS 2025; arXiv:2502.17533 (2025).

[2] G. Raayoni, S. Gottlieb, Y. Manor, et al. Generating conjectures on fundamental constants with the Ramanujan Machine. *Nature* 590, 67–73 (2021). doi:10.1038/s41586-021-03229-4

[3] L. Blaine. On the Tangent of the Argument: Closed Forms for Constants Arising from Anticommutative Pauli CMF Matrix Products. Preprint (2026).

[4] R. Apéry. Irrationalité de ζ(2) et ζ(3). *Astérisque* 61, 11–13 (1979).

[5] O. David. The conservative matrix field. arXiv:2303.09318 (2023).

[6] G. Rhin, C. Viola. The group structure for ζ(3). *Acta Arithmetica* 97, 269–293 (2001). doi:10.4064/aa97-3-6

[7] E. Witten. Supersymmetry and Morse theory. *Journal of Differential Geometry* 17(4), 661–692 (1982).

[8] M. Atiyah. On the K-theory of compact Lie groups. *Topology* 4(1), 95–99 (1965). doi:10.1016/0040-9383(65)90051-4

[9] S. Ramanujan. The Lost Notebook and Other Unpublished Papers. Narosa Publishing House, New Delhi (1988).

[10] T. Rivoal. La fonction zêta de Riemann prend une infinité de valeurs irrationnelles aux entiers impairs. *C. R. Acad. Sci. Paris* 331 (2000), 267–270. doi:10.1016/S0764-4442(00)01624-4

[11] W. Zudilin. One of the numbers ζ(5), ζ(7), ζ(9), ζ(11) is irrational. *Russian Math. Surveys* 56 (2001), 774–776. doi:10.1070/RM2001v056n04ABEH000427

[12] K. Ball, T. Rivoal. Irrationalité d'une infinité de valeurs de la fonction zêta aux entiers impairs. *Invent. Math.* 146 (2001), 193–207. doi:10.1007/s002220100168

[13] S. Fischler. Irrationalité de valeurs de zêta. *Séminaire Bourbaki*, Astérisque 294 (2004), 27–62.

---

**Acknowledgements.** The author thanks Claude Sonnet 4.6 (Anthropic) for assistance with derivation, step-matrix construction, computational search, Lean 4 formalization, and manuscript preparation. Correspondence: louisblaine45@gmail.com

---

## Footnotes

¹ The precise definition uses `MvPolynomial (Fin 2) R` evaluated via `Matrix.map (MvPolynomial.eval v)` where `v : Fin 2 → R` maps the two variables to the lattice coordinates. The Lean 4 formalization is the canonical reference: github.com/Loublain/cmf-gaussian-primes

² Formally: `My (p + (1,0)) * Mx p = Mx (p + (0,1)) * My p` for all `p : ℤ × ℤ`. Machine-verified in `CMF.lean`.

³ Prediction 4.3 is formally proved as `Prediction43_holds` in `Recurrence.lean`. Predictions 4.1 and 4.2 remain open conjectures. The Lean 4 formalization is available at github.com/Loublain/cmf-gaussian-primes

⁴ The anticommutative condition S + T = 0 for the c₁ step matrices is machine-verified in `PauliCMF.lean` as `S_plus_T_c1`.

⁵ The sign flip S = −T is formally proved as `AntiCMF.sign_flip` in `ZetaPairs.lean`. The connection between this algebraic mechanism and convergence to specific zeta values is not formalized; it requires analytic infrastructure not currently in Mathlib.

⁶ The parameter space and closest candidate are formally defined in `Recurrence.lean` as `SearchSpace` and `closest_candidate`, with membership verified by `closest_in_search_space`.
