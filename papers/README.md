# CMF v4 Bundle — 2026-05-18

All three papers as a single deliverable, plus the verification script.
Generated for v4 release (post-Shvets review corrections, second revision).

## Contents

| File | Purpose |
|---|---|
| `cmf_zeta5_paper.md`             | Paper 1, markdown source |
| `cmf_zeta5_paper.tex`            | Paper 1, LaTeX (self-contained, full preamble inline) |
| `cmf_zeta5_paper.pdf`            | Paper 1, compiled PDF |
| `cmf_constants_paper2.md`        | Paper 2, markdown source |
| `cmf_constants_paper2.tex`       | Paper 2, LaTeX (self-contained, full preamble inline) |
| `cmf_constants_paper2.pdf`       | Paper 2, compiled PDF |
| `cmf_gaussian_primes_paper3.md`  | Paper 3, markdown source |
| `cmf_gaussian_primes_paper3.tex` | Paper 3, LaTeX (self-contained, full preamble inline) |
| `cmf_gaussian_primes_paper3.pdf` | Paper 3, compiled PDF |
| `verify_S1_S3.py`                | Independent mpmath verification of all Paper 2 numerical content |

## What changed from the previous v4 bundle (2026-05-16)

**Paper 1 (`cmf_zeta5_paper`)** — five additional prose changes tightening the
algebraic language of the commutative/anticommutative split. All five concern
how the two integrability conditions are described, not the underlying math;
none affect any proven theorem, any computational result, or the Lean
formalization.

1. *Abstract* — the sentence describing the split is rewritten in terms of the
   two integrability conditions S − T = 0 (commutative, the original
   Raz–Kaminer setting) and S + T = 0 (anticommutative, naturally realised in
   the Pauli algebra). The earlier "(4-step closure) / (2-step closure)"
   phrasing was misleading: the lattice plaquette is 4-edge in both branches;
   what differs is the sign of the closure, not the step count.

2. *Section 2 opener* — parallel rewrite. "Closed loops acquire different
   periodicity" → "the unit-plaquette closure admits two algebraically
   distinct integrability conditions, depending on whether the two paths
   around the plaquette have equal or opposite-sign matrix products."

3. *Definition 2.1* — retitled "Two integrability conditions" and rewritten to
   define the commutative and anticommutative families directly in terms of
   S − T = 0 and S + T = 0, without reference to "after N steps."

4. *Section 3 degree-drop paragraph* — the heuristic motivation for why
   π² pairs with π is rewritten. Instead of "commutative paths close after 4
   steps, anticommutative paths close after 2 steps," the paragraph now points
   to the matrix algebra of the Pauli step matrix: M = rσ_z + pσ_x satisfies
   M² = (r² + p²)·I, so matrix-level squaring produces a scalar in the
   polynomial entries. The paragraph now also explicitly states that the
   heuristic does not by itself constitute a proof.

5. *Section 2 heading* — "The Periodicity Structure of i and Path
   Classification" → "Two Integrability Conditions on ℤ[i]" for consistency
   with the rewritten Definition 2.1.

The Pauli §2 paragraph correction (Shvets's main paper-1 correction) is
unchanged from the 2026-05-16 bundle.

**Paper 2 (`cmf_constants_paper2`)** — unchanged from the 2026-05-16 bundle.

**Paper 3 (`cmf_gaussian_primes_paper3`)** — unchanged from the 2026-05-16 bundle.

**`verify_S1_S3.py`** — substantially extended and made numerically robust.
Now verifies all five constants from Paper 2 §3 (c_1 through c_5) in addition
to the §4 numerical block (S_1, S_3, S_1+S_3). All complex inputs to the
Gamma function are constructed via `mp.mpc(mp.mpf(p)/q, mp.mpf(r)/s)` with
exact rationals — no Python complex literals (`1j`) or floating-point
literals (`0.5`) anywhere in the numerical path. The previous version used
`mpc(0, 0.5)`, which is safe only because 1/2 happens to be binary-exact;
any other half-integer denominator would have silently leaked
double-precision roundoff at digit ~16 of the final answer.

## What changed from v3 (Zenodo) — historical record

**Paper 1 (`cmf_zeta5_paper`)** — §2 Pauli paragraph rewritten. The previous
version claimed the Pauli realisation (M_x = aσ₁+bσ₃, M_y = cσ₂) satisfied
both the commutative (S − T = 0) and anticommutative (S + T = 0)
integrability conditions. This is wrong: the Clifford anticommutation only
forces {M_x, M_y} = 0; the commutator [M_x, M_y] = 2ic(aσ₃ − bσ₁) is
generically nonzero. The §2.2 worked example for c₁ verifies only S + T = 0,
consistent with the corrected paragraph. The two CMF branches are now treated
as distinct families on ℤ[i], with the Pauli realisation specific to the
anticommutative branch. Reported by Alex Shvets, May 2026.

**Paper 2 (`cmf_constants_paper2`)** — §2.3 Leibniz framing rewritten. The
previous version claimed the alternating arctangent sum converges by
Leibniz's criterion for all five constants. This is wrong for four of the
five: p(k)/r(k) → ∞ for c₂ and c₃, → 2 for c₄, → 1 for c₅. The criterion
applies only to c₁ (where p/r = 1/k → 0). Convergence for c₂–c₅ is supplied
by the Gamma-ratio identification of Lemma 2.2 (the even-N limit of the
Weierstrass product), not by Leibniz. Reported by Alex Shvets, May 2026.

**Paper 2 Table 1** — reformatted. Added a `lim p/r` column showing the
convergence behaviour of each constant at a glance (→ 0, → ∞, → ∞, → 2, → 1).
Each constant now occupies two rows: the data row, then an indented `value
= ...` row with 23 digits of precision (consolidated from §3.1–3.5).
Horizontal rules between entries.

**Paper 3 (`cmf_gaussian_primes_paper3`)** — unchanged. No issues raised by
Shvets or in internal review for this paper.

## Self-contained LaTeX

All three `.tex` files are self-contained: full preamble + body in one file.
No separate `preamble.tex` is required. Compile with:

    xelatex cmf_zeta5_paper.tex
    xelatex cmf_constants_paper2.tex
    xelatex cmf_gaussian_primes_paper3.tex

## Independent numerical verification

`verify_S1_S3.py` recomputes all eight numerical quantities in Paper 2
(five constants from §3, S_1 / S_3 / S_1+S_3 from §4) at 50, 80, 100,
150, and 200 digit precision, using exact rationals throughout.

Reference values (from `cmf_constants_paper2.md`):

    c_1 = 0.55499611157361950342640...
    c_2 = 0.74328645390177619968660...
    c_3 = 0.28617684964886955539522...
    c_4 = 0.24758221870861069889236...
    c_5 = 0.20787957635076190854695...

    S_1     = 0.50667090321662298198525580478358151247284354734702058292000...
    S_3     = 0.27872726018082532763040504103629420857644880249675587232373...
    S_1+S_3 = 0.78539816339744830961566084581987572104929234984377645524373...
    pi/4    = 0.78539816339744830961566084581987572104929234984377645524373...

At each precision level, every computed value must agree with its reference
truncation through min(reference_length, mp.dps − 5) digits. The script
reports "ALL CHECKS PASSED" on success.

Run: `python3 verify_S1_S3.py`
