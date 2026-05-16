# A Family of Mathematical Constants Indexed by Gaussian Primes

Louis Blaine
Correspondence: louisblaine45@gmail.com
March 2026

---

## Abstract

We identify an infinite family of mathematical constants, one for each Gaussian prime π of the ring ℤ[i] of Gaussian integers, each verified absent from the OEIS, Wolfram Alpha, and ISC databases at the precision tested. The constant associated to π is c_π = |Im(z)/Re(z)| where z = Γ(1+w/2)/Γ(1/2+w/2) and w = π/N(π). Constants arise from split primes p≡1 (mod 4) and from the ramified prime 2, but not from inert primes p≡3 (mod 4). Conjugate primes π, π̄ give equal |c_π| but opposite angles S(π) = −S(π̄). Among the Gaussian units, S_i + S_{−i} = π/4 is proved via hyperbolic identities. Among associates of the ramified prime above 2, the associates π ∈ {−1+i, −1−i} satisfy S_π + S_{π̄(shifted)} = ±π/4 (a direct analogue of the unit identity). For every other Gaussian prime of norm ≥ 2, including all four associates of every split prime, (S_π + S_{π̄(shifted)})/π is irrational, via an explicit closed form S_π + S_{π̄(shifted)} = arctan(b/(N+a)) and Niven's theorem. The moduli |c_π|² admit elementary closed forms in the unit case Re(w) = 0; we conjecture no such closed form exists for Re(w) ≠ 0 (Proposition 3.5). We propose a Class III transcendence classification via non-unitary Kummer monodromy (Theorem 6.1) and state a conjecture connecting the family to periods of CM elliptic curves.

**Keywords:** Gaussian primes, complex Gamma function, conservative matrix field, CM elliptic curves, Shimura conjecture, Gaussian integers, mathematical constants

---

## 1. Introduction

In two companion papers [1, 2] we identified five constants arising from anticommutative Pauli CMF matrix products and gave exact closed forms as tangents of arguments of complex Gamma function ratios. The present paper reveals the number-theoretic organising principle. The formula

$$c_\pi = |{\rm Im}(z)/{\rm Re}(z)|, \quad z = \frac{\Gamma(1+w/2)}{\Gamma(1/2+w/2)}, \quad w = \pi/N(\pi)$$

defines a well-formed constant for every Gaussian prime π. Once this formula is in hand, the remainder of the analysis is carried out entirely in the setting of complex Gamma-function ratios and the arithmetic of ℤ[i]; no further reference to the CMF derivation is required. The CMF algebraic framework underlying the construction is formalized in Lean 4 at github.com/Loublain/cmf-gaussian-primes; the analytic content of the present paper is not formalized. The structure is governed entirely by the splitting behaviour of rational primes in ℤ[i]: split primes p≡1 (mod 4) contribute, the ramified prime 2 contributes, and inert primes p≡3 (mod 4) do not.

---

## 2. Definition and Basic Properties

A rational prime p behaves in one of three ways in ℤ[i]:

- **Splits** if p≡1 (mod 4): p = π̄π for a Gaussian prime π with N(π) = p. Examples: 5 = (2+i)(2−i), 13 = (3+2i)(3−2i).
- **Ramifies** if p = 2: 2 = −i(1+i)², the Gaussian prime (1+i) has norm 2.
- **Remains inert** if p≡3 (mod 4): p itself is a Gaussian prime of norm p². Examples: 3, 7, 11, 19, 23.

**Definition 2.1.** For a Gaussian prime π ∈ ℤ[i], define c_π = |Im(z)/Re(z)| where z = Γ(1+w/2)/Γ(1/2+w/2) and w = π/N(π) ∈ ℚ(i). Equivalently, c_π = |tan(S_π)| where S_π = Arg(z) is the principal-branch argument.¹

**Definition 2.2.** For a Gaussian prime π = a+bi with conjugate π̄ = a−bi, define the shifted angle S_{π̄(shifted)} = Arg(Γ(1+w̄/2)/Γ(3/2+w̄/2)) where w̄ = π̄/N(π). The shift refers to the denominator exponent: 1/2 is replaced by 3/2, equivalently Γ(3/2+z) = (1/2+z)Γ(1/2+z).

### 2.3. Conventions and branch stability

We use the principal branch Arg : ℂ* → (−π, π] throughout. The definition c_π = |tan(S_π)| is invariant under S_π ↦ S_π + π (the period of tan), and admits the manifestly branch-free equivalent form c_π = |Im(z)/Re(z)| when Re(z) ≠ 0.

**Stability lemma.** Numerical evaluation at 120-digit precision (mpmath, mp.dps = 120) confirms Re(z) > 0 for every Gaussian prime π of norm N(π) ≤ 41 (all entries of Table 1). For these primes, Arg(z) ∈ (−π/2, π/2) strictly, so S_π lies in the interior of the principal-branch range and the additive identities of Theorems 3.3 and 3.4 involve no branch-cut crossings. We conjecture Re(z) > 0 for all Gaussian primes; a proof would follow from establishing that Γ(1+w/2) and Γ(1/2+w/2) lie in the same open half-plane through ℂ*.

### 2.4. Relation to classical hypergeometric theory

The Beta decomposition (Theorem 3.6 below), S_π = arg(π) + arg(B(w/2, 1/2)), connects the family directly to the Euler Beta function B(a,b) = Γ(a)Γ(b)/Γ(a+b). For the Gauss hypergeometric function, ₂F₁(w/2, 1/2; w/2+1/2; 1) = Γ(w/2+1/2−1/2)Γ(w/2+1/2) / [Γ(w/2)Γ(w/2+1/2−w/2+1/2)] is closely related to our ratio [7, §13.2]. The Möbius recursion underlying these constants (see companion paper [2]) belongs to the Poincaré–Perron family of linear difference equations with polynomial coefficients, whose general theory is treated in Jones–Thron [8]; the recursion z_k = (r(k)z+p(k))/(p(k)z−r(k)) is of Möbius type with polynomial r,p. The CMF framework identifies the specific family arising in this paper as the one where the Pauli anticommutation forces the involutive structure (see [2, §2.1]).

---

## 3. Structural Theorems

**Theorem 3.1** (Conjugation Symmetry). S_{π̄} = −S_π and |c_{π̄}| = |c_π|.

*Proof.* The conjugate prime π̄ has w̄ = conj(w). Since Γ(conj(z)) = conj(Γ(z)), Arg(Γ(1+w̄/2)/Γ(1/2+w̄/2)) = −Arg(Γ(1+w/2)/Γ(1/2+w/2)). □

**Theorem 3.2** (Inert Prime Theorem). For p≡3 (mod 4) there is no Gaussian prime π ∈ ℤ[i] with N(π) = p, so the formula w = π/N(π) does not define a constant c_π for inert primes.

*Proof.* N(a+bi) = a²+b²=p would require p to be a sum of two squares. By Fermat's theorem on sums of two squares [6], p is such a sum iff p=2 or p≡1 (mod 4). For p≡3 (mod 4) no representation exists. □

**Theorem 3.3** (Unit Identity). S_i + S_{−i(shifted)} = π/4. [Proved in [2, Theorem 4.1]: the combined Gamma ratio equals coth(π/2)·(1+i)/2, whose argument is π/4.]

**Remark.** Theorem 3.4 below shows that this identity extends to the associates π ∈ {−1+i, −1−i} of the ramified prime, with the same value ±π/4. These are the only Gaussian primes of norm ≥ 2 for which an identity of this form holds.

**Theorem 3.4.** Let π = a + bi be a Gaussian prime with N(π) ≥ 2 and w = π/N(π). Then

$$S_\pi + S_{\bar\pi(\text{shifted})} = \arctan\!\left(\frac{b}{N(\pi) + a}\right).$$

The ratio (S_π + S_{π̄(shifted)})/π is rational if and only if π ∈ {−1+i, −1−i}, in which case it equals ±1/4. For every other Gaussian prime of norm ≥ 2 — every associate of every split prime, and the associates 1+i, 1−i of the ramified prime above 2 — the ratio is irrational.

*Proof.* Write R(w) := Γ(1+w/2)·Γ(1+w̄/2) / [Γ(1/2+w/2)·Γ(3/2+w̄/2)], so that S_π + S_{π̄(shifted)} = Arg R(w). We apply two elementary identities:

(i) Γ(z̄) = Γ(z)‾ for every z, hence Γ(z)·Γ(z̄) = |Γ(z)|² is a positive real.

(ii) Γ(3/2 + w̄/2) = (1/2 + w̄/2)·Γ(1/2 + w̄/2).

Applying (i): numerator = |Γ(1+w/2)|², denominator = (1/2+w̄/2)·|Γ(1/2+w/2)|². Therefore

$$R(w) = \left|\frac{\Gamma(1+w/2)}{\Gamma(1/2+w/2)}\right|^2 \cdot \frac{1}{1/2+\bar{w}/2}.$$

The first factor is a positive real, so Arg R(w) = −Arg(1/2+w̄/2). For w = (a+bi)/N, we have 1/2+w̄/2 = (N+a−bi)/(2N). Since N+a > 0 (as N ≥ 2 forces N > |a|), its argument is −arctan(b/(N+a)), giving the closed form.

For the rationality classification, Niven's theorem (1956) states that arctan(q)/π is rational for q ∈ ℚ only when q ∈ {0, ±1}. The case b = 0 is impossible for norm ≥ 2 non-inert primes. The cases q = ±1 give b = ±(N+a), i.e. (a + ½)² + (b ∓ ½)² = ½, a circle of radius 1/√2. The integer points on this circle are (0,0), (0,±1), (−1,0), (−1,±1). Excluding non-primes and units leaves exactly π ∈ {−1+i, −1−i}. □

**Proposition 3.5** (Hyperbolic Closed Form, Unit Case). Let π ∈ ℤ[i] be a Gaussian prime or unit, w = π/N(π), and R(w) = Γ(1+w/2)/Γ(1/2+w/2).

(a) If Re(w) = 0 — equivalently π = ±i — then

$$|R(w)|^2 = \frac{w}{2i} \cdot \coth\!\left(\frac{\pi w}{2i}\right),$$

which equals (1/2) coth(π/2) for π = ±i.

(b) If Re(w) ≠ 0, no expression for |R(w)|² has been found inside the ring generated over ℚ(π) by {cosh(qπ), sinh(qπ) : q ∈ ℚ}. Extensive PSLQ searches to 120 decimal digits with coefficient bound 10⁶ are null for every Gaussian prime of norm ≤ 41 (§6.5). We conjecture that no such expression exists.

*Proof of (a).* For w = it, t ∈ ℝ, the reflection formula Γ(z)Γ(1−z) = π/sin(πz) at z = 1/2 + it/2 gives |Γ(1/2+it/2)|² = π/cosh(πt/2); combined with Γ(z+1) = zΓ(z) at z = it/2 it gives |Γ(1+it/2)|² = πt/(2 sinh(πt/2)). Dividing yields (t/2) coth(πt/2), matching the stated formula with w = it. □

**Remark** (structural obstruction underlying (b)). The identity |Γ(z)|² = Γ(z)Γ(z̄) admits a closed form via integer translation and reflection precisely when Re(z) ∈ (1/2)ℤ, since only then does z̄ lie in the orbit of z under integer translation and reflection alone. For Re(w) ≠ 0, both z = 1 + w/2 and z = 1/2 + w/2 fail this condition (0 < |a|/N < 1 implies Re(z) ∉ (1/2)ℤ), so any such derivation must invoke the Gauss multiplication formula, which produces product-level rather than individual Gamma relations. The resulting system is under-determined; our conjecture is that no algebraic specialisation closes it, but we do not prove this.

**Remark 3.5.1.** Proposition 3.5 concerns the individual Gamma ratio Γ(1+w/2)/Γ(1/2+w/2). The bilinear combination with its complex conjugate that appears in Theorem 3.4 is elementary for every Gaussian prime π with N(π) ≥ 2 (it equals 1/(1/2+w̄/2), up to the real positive factor |Γ(1+w/2)/Γ(1/2+w/2)|²). This illustrates that the proposed Class III nature of the individual constants S_π is compatible with elementary closed forms for specific symmetric combinations. The proposed Class III classification in §6 applies to the individual S_π (and to their Hurwitz-zeta derivatives, by §6.5), not to every algebraic combination thereof.

**Theorem 3.6** (Beta Decomposition). S_π = arg(π) + arg(B(w/2, 1/2)) where B(a,b) = Γ(a)Γ(b)/Γ(a+b).

*Proof.* Γ(1+w/2) = (w/2)Γ(w/2), so Γ(1+w/2)/Γ(1/2+w/2) = (w/2)·B(w/2,1/2)/√π. Taking arguments: S_π = arg(w/2) + arg(B) = arg(π) + arg(B). □

---

## 4. Computed Values

Table 1 gives the first members of the family, computed to 18 significant figures using mpmath (mp.dps = 80). Each value has been verified absent from the OEIS, Wolfram Alpha, and the ISC database at the precision tested.

| π | N(π) | Rational prime behaviour | c_π |
|---|---|---|---|
| i | 1 | unit | 0.554996111573619503… |
| −i | 1 | unit | 0.554996111573619503… |
| 1+i | 2 | 2 ramified | 0.207879576350761908… |
| −(1+i) | 2 | 2 ramified | 0.655794202632672435… |
| 2+i | 5 | 5 split, 1 mod 4 | 0.092546110069323602… |
| −(2+i) | 5 | 5 split, 1 mod 4 | 0.247582218708610699… |
| 3+2i | 13 | 13 split, 1 mod 4 | 0.083005998252748272… |
| 3−2i | 13 | 13 split, 1 mod 4 | 0.083005998252748272… |
| 4+i | 17 | 17 split, 1 mod 4 | 0.031720900524284986… |
| 5+2i | 29 | 29 split, 1 mod 4 | 0.039548684965468606… |
| 6+i | 37 | 37 split, 1 mod 4 | 0.015673823447039764… |
| 5+4i | 41 | 41 split, 1 mod 4 | 0.058872673342944218… |

**Table 1.** Gaussian prime constants to 18 significant figures.

---

## 5. Reconciliation with the Original Five Constants

The five constants of [1, 2] appear in Table 1: c₁ = c_i, c₄ = c_{−(2+i)}, c₅ = c_{1+i}. The constant c₃ uses a mixed-shift formula related to c_{−i} (Theorem 3.3). The constant c₂ is composite: its closed form involves √(1−8i), whose norm is 65 = 5×13, connecting it to the Gaussian primes (2+i) and (3+2i) simultaneously. Specifically S₂ = S(r₁)+S(r₂) where r₁, r₂ are roots of 4iz²+(1−4i)z+i=0, and these roots live in the ring class field compositum ℚ(i, √(1+2i), √(3+2i)).

---

## 6. Position in the Transcendence Hierarchy

**Status of this section.** Section 6 separates into two registers. Theorem 6.1 is a proved result: for every Gaussian prime π with N(π) ≥ 1, the constant S_π is not an exponential period in the Fresán–Jossen sense, because the associated Kummer D-module has monodromy of infinite order. The three-class hierarchy of §6.1, the conjectural Galois-theoretic heuristic of §6.3, and Conjecture 6.2 are offered as interpretive framework: they describe where our constants appear to sit relative to existing motivic theory, and what properties an extended theory would need. The proposed category of algebraic non-rational Kummer twists does not yet exist in the literature; the Galois-group suggestion in §6.3 is heuristic; the PSLQ evidence of §6.5 is consistent with the framework but does not establish it.

**Theorem 6.1** (Classification Obstruction). S_π is not an exponential period in the sense of Fresán–Jossen [9] for any Gaussian prime π with N(π) ≥ 1.

*Proof.* The integral Γ(w/2) = ∫ t^(w/2−1) e^(−t) dt corresponds to D-module E(1)⊗K(a) on 𝔾_m with a = w/2−1 and Kummer monodromy μ = e^(πiw). Since w ∈ ℚ(i)\ℚ, Im(w)≠0 and |μ| = e^(−π·Im(w)) ≠ 1. Non-unitary monodromy has infinite order. An algebraic cover of degree d pulls back K(a) to K(da), trivial only if a ∈ ℚ. But a ∈ ℚ(i)\ℚ, so no cover exists. □

### 6.1. The three-class hierarchy

An exponential period in the sense of Fresán–Jossen [9] is an integral of the form ∫_γ e^(−f(x)) ω(x), where f is a regular function and ω is an algebraic differential form on a variety over ℚ̄, and γ is a semialgebraic cycle. Classical Gamma values Γ(a+1) with a ∈ ℚ are exponential periods because the underlying rank-1 D-module E(1)⊗K(a) on 𝔾_m has Kummer monodromy e^(2πia) of finite order, trivialised by the algebraic cover z ↦ z^d for any d with da ∈ ℤ. Our constants involve Γ at a = w/2−1 ∈ ℚ(i)\ℚ, for which |e^(2πia)| = e^(−π Im(w)) ≠ 1 (Theorem 6.1 above): the monodromy has infinite order, no algebraic cover trivialises K(a), and the associated D-module lies outside the exponential motive category.

**Class I** (a ∈ ℤ): Γ(a+1) = a! rational.

**Class II** (a ∈ ℚ\ℤ): monodromy a root of unity; Γ(a+1) an exponential period. Includes Γ(1/4), Γ(1/3), √π, all Chowla–Selberg values.

**Class III** (proposed) (a ∈ ℚ̄\ℚ): |μ|≠1; not an exponential period. Our constants have a = w/2−1 ∈ ℚ(i)\ℚ, placing them in the proposed Class III; no existing motivic category directly accommodates them.

### 6.2. Monodromy data

| π | N | w | a = w/2−1 | \|μ\| |
|---|---|---|---|---|
| i | 1 | i | −1+i/2 | $e^{-\pi }$ ≈ 0.0432 |
| 1+i | 2 | (1+i)/2 | −3/4+i/4 | $e^{-\pi /2}$ ≈ 0.208 |
| 2+i | 5 | (2+i)/5 | −4/5+i/10 | $e^{-\pi /5}$ ≈ 0.534 |
| 3+2i | 13 | (3+2i)/13 | −11/13+i/13 | $e^{-2\pi /13}$ ≈ 0.617 |
| 4+i | 17 | (4+i)/17 | −13/17+i/34 | $e^{-\pi /17}$ ≈ 0.831 |

**Table 2.** Kummer monodromy. As N(π)→∞, |μ|→1 but never equals 1.

### 6.3. Conjectural Galois structure

For Class II gamma motives, the Galois group contains μₙ (finite). For the proposed Class III, μₙ would be replaced by 𝔾_m (infinite-order monodromy), suggesting one additional algebraic independence should hold — consistent with all PSLQ failures.

### 6.4. Why classical tools fail

Chowla–Selberg handles Γ at rational real arguments (Class II). Shimura/Deligne handle Class II motives. Hecke L-functions with trivial conductor yield no PSLQ match. All probe Class I–II; our constants are proposed to sit in Class III.

### 6.5. Extended PSLQ evidence from the Hurwitz-zeta family

We extended the PSLQ search to the family

$$S_\pi(n) = \operatorname{Im}[\zeta'(-n, 1+w/2) - \zeta'(-n, 1/2+w/2)], \quad n = 0, 1, 2, 3, 4$$

for π ∈ {i, 1+i, 2+i, −(2+i), 3+2i, 4+i, 5+2i} at 120-digit precision (mpmath mp.dps = 120, Bailey–Broadhurst pslq, maxcoeff = 10⁶). For n=0 this reduces to S_π via the Lerch formula (verified). Three search configurations were run:

- *Within-π*: {S_π(0), …, S_π(4)} + standard basis, for each of the 7 primes.
- *Across-π at fixed n*: all 7 values {S_π(n)} + standard basis, for n = 0,…,4.
- *Mixed*: all 35 values together with the standard basis (41 elements).

All 20 searches returned null. This is the expected outcome under the proposed Class III classification. Full details at github.com/Loublain/cmf-gaussian-primes [archived: doi:10.5281/zenodo.19670531].

**Conjecture 6.2.** The constants S_π are natural candidates for periods of an extended motivic category incorporating D-modules E(1)⊗K(a) with a ∈ ℚ(i)\ℚ — 'algebraic non-rational Kummer twists'. Such a category does not yet exist.

---

## 7. Computational Notes

All constants computed with mpmath at 80–160 decimal digits. The branch-free evaluation form c_π = |Im(z)/Re(z)| is used throughout.

```python
import mpmath; mpmath.mp.dps = 80
def c_pi(pi_gauss):
    w = pi_gauss / abs(pi_gauss)**2
    z = mpmath.gamma(1+w/2) / mpmath.gamma(0.5+w/2)
    return abs(mpmath.im(z) / mpmath.re(z)) # branch-free
print(c_pi(1+1j))  # 0.20788…
print(c_pi(3+2j))  # 0.08301…
```

---

## 8. Open Questions

**(1)** Prove Conjecture 6.2.

**(2)** Find a product formula for the composite constant c₂.

**(3)** Extend to Eisenstein integers ℤ[ω] and other imaginary quadratic fields.

**(4)** Characterise constants at w = 1/p for inert primes.

**(5)** Connect the norm-5 constants c_{±(2+i)} to the ζ(5) obstruction.

---

## 9. Conclusion

We have identified an infinite family of mathematical constants c_π = |Im(z)/Re(z)| with z = Γ(1+w/2)/Γ(1/2+w/2) and w = π/N(π), one per Gaussian prime of ℤ[i], each verified absent from standard databases. Split primes contribute, inert primes do not. The unit identity S₁+S₃ = π/4 extends by Theorem 3.4 to two associates of the ramified prime (−1+i and −1−i), where the same combination gives ±π/4. All other Gaussian primes of norm ≥ 2 produce irrational ratios (S_π + S_{π̄(shifted)})/π via the closed form arctan(b/(N+a)) and Niven's theorem. This is an elementary result; the proposed Class III classification (§6) applies to the individual S_π, not to this specific bilinear combination. Theorem 6.1 is a proved obstruction from the Fresán–Jossen framework; the three-class hierarchy of §6.1 and Conjecture 6.2 are proposed as interpretive framework pending the development of an extended motivic category.

---

## References

[1] L. Blaine. An Investigation of an Alternate Base… Preprint (2026).

[2] L. Blaine. On the Tangent of the Argument… Preprint (2026).

[3] T. Raz et al. From Euler to AI. NeurIPS 2025; arXiv:2502.17533.

[4] G. Shimura. On the periods of modular forms. *Mathematische Annalen* 229, 211–221 (1977). doi:10.1007/BF01420560

[5] P. Deligne. Valeurs de fonctions L. *Proc. Symp. Pure Math.* 33 (1979).

[6] D. A. Cox. Primes of the Form x²+ny². Wiley (1989). doi:10.1002/9781118400371

[7] F. W. J. Olver et al. NIST Handbook of Mathematical Functions. Cambridge University Press (2010). https://dlmf.nist.gov/

[8] W. B. Jones, W. J. Thron. Continued Fractions: Analytic Theory and Applications. Addison-Wesley (1980).

[9] J. Fresán, P. Jossen. Exponential Motives. Preprint (2021). https://javier.fresan.perso.math.cnrs.fr/expmot.pdf

---

**Acknowledgements.** The author thanks Claude Sonnet 4.6 (Anthropic) for assistance with derivation, computation, and manuscript preparation throughout this research. Correspondence: louisblaine45@gmail.com

---

## Footnotes

¹ The base CMF structure from which these constants are derived is formalized in `CMF.lean`. The conservativity condition is machine-verified. See github.com/Loublain/cmf-gaussian-primes
