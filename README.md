# \# cmf-lean



Lean 4 formalization of structural theorems for the Conservative Matrix Field (CMF)

research program: integrability conditions on lattice path products, their algebraic

realizations, and the family of mathematical constants they generate.



The current work is on the Gaussian integer lattice ℤ\[i] with the Pauli (Cl(2))

algebra. The framework is intended to extend to other imaginary quadratic rings of

integers and higher Clifford algebras Cl(p,q); this repository will be the durable

home for the formalization as the program evolves.



\## Companion materials



\- \*\*Paper 1\*\* — \*An Investigation of an Alternate Base for a Conservative Matrix

&#x20; Field and an Example of a Search for a Representation of ζ(5)\* — Blaine (2026)

\- \*\*Paper 2\*\* — \*On the Tangent of the Argument: Closed Forms for Constants Arising

&#x20; from Anticommutative Pauli CMF Matrix Products\* — Blaine (2026)

\- \*\*Paper 3\*\* — \*A Family of Mathematical Constants Indexed by Gaussian Primes\* —

&#x20; Blaine (2026)

\- \*\*Computational support\*\* (Python/mpmath PSLQ searches and numerical verification):

&#x20; https://github.com/Loublain/cmf-gaussian-primes



The CMF framework itself is due to Raz, Shalyt, Leibtag, Kalisch, Weinbaum, Hadad,

and Kaminer (NeurIPS 2025; arXiv:2502.17533); the present work investigates an

alternate base for that framework.



\## What's formalized



Machine-verified proofs (Lean 4 + Mathlib) of:



\- The CMF integrability condition `M\_y(m+1,n) · M\_x(m,n) = M\_x(m,n+1) · M\_y(m,n)`

&#x20; (`CMF.lean`, `PathIndep.lean`, `PathProducts.lean`)

\- The Pauli realization for the c₁ constant: explicit step matrices

&#x20; `M\_x = m·σ\_z + σ\_x`, `M\_y = σ\_y`-scaled, with the anticommutative condition

&#x20; `S + T = 0` (`PauliCMF.lean`)

\- The polynomial CMF case (`PolyCMF.lean`)

\- The superfield-like decomposition (`SuperCMF.lean`)

\- Even/odd zeta pairing structure (`ZetaPairs.lean`)

\- The Apéry-style recurrence search predicates and Prediction 4.3 of Paper 1

&#x20; (`Recurrence.lean`)



All theorems are verified `sorry`-free against the standard Mathlib axioms

(`propext`, `Classical.choice`, `Quot.sound`). Axiom dependencies for each

theorem are tracked in `Audit.lean`.



\## Building



Requires Lean 4 (via `elan`) and `lake`. From the project root:



&#x20;   cd lean/cmf-aristotle/path-product\_aristotle

&#x20;   lake exe cache get   # downloads Mathlib (one-time, \~10 minutes)

&#x20;   lake build



\## Audit policy



A pre-commit hook (`scripts/check-sorry.ps1`) blocks commits that introduce `sorry`

placeholders into Lean source files. Doc-only commits skip this check.



\## License



MIT

