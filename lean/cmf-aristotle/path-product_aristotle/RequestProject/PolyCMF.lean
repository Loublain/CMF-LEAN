import Mathlib
import RequestProject.CMF
import RequestProject.PathProducts

/-!
# Polynomial Conservative Matrix Fields

## Scope

This file defines `PolyCMF R d` — a conservative matrix field on ℤ²
whose step matrix entries are polynomial functions of the lattice
coordinates, with total degree bounded by `d : ℕ`.

## Design note on dimension

`PolyCMF` is pinned to 2×2 matrices (`n = 2`). The underlying `CMF.ZZ`
is dimension-generic, but the three current papers concern 2×2 matrices
specifically. Higher-dimensional generalizations are left for future work.

-- Future: CMF over GL(n) for n > 2, root lattices, E₈, etc.
--         See CMF.ZZ for the generic framework.

## Coercion

`PolyCMF R d` coerces to `CMF.ZZ R 2` automatically, so every theorem
proved for `CMF.ZZ` — including `pathIndep` — applies to any `PolyCMF`
without additional proof.

## Definition note

`Mx` and `My` are matrices of polynomials:
  `Matrix (Fin 2) (Fin 2) (MvPolynomial (Fin 2) R)`
Evaluation at a lattice point uses `Matrix.map (MvPolynomial.eval v)`.
This is the correct representation: store the polynomial, evaluate on demand.
-/

open MvPolynomial Matrix
open CMF

/-- A polynomial CMF: a conservative matrix field on ℤ² whose step matrix
    entries are polynomials in two variables (the lattice coordinates m, n),
    with total degree bounded by `d`.

    Variables: index `0` = m coordinate, index `1` = n coordinate. -/
structure PolyCMF (R : Type*) [CommRing R] (d : ℕ) where
  /-- Horizontal step matrix, entries polynomial in (m, n) -/
  Mx : Matrix (Fin 2) (Fin 2) (MvPolynomial (Fin 2) R)
  /-- Vertical step matrix, entries polynomial in (m, n) -/
  My : Matrix (Fin 2) (Fin 2) (MvPolynomial (Fin 2) R)
  /-- Degree bound: each entry of Mx has total degree ≤ d -/
  deg_Mx : ∀ i j, (Mx i j).totalDegree ≤ d
  /-- Degree bound: each entry of My has total degree ≤ d -/
  deg_My : ∀ i j, (My i j).totalDegree ≤ d
  /-- Conservativity in the same shape as `CMF.ZZ.conserv`. -/
  conserv : ∀ p : ℤ × ℤ,
    let v10 : Fin 2 → R := fun i => match i with | 0 => (p.1 + 1 : R) | 1 => (p.2 : R)
    let v01 : Fin 2 → R := fun i => match i with | 0 => (p.1 : R) | 1 => (p.2 + 1 : R)
    let v00 : Fin 2 → R := fun i => match i with | 0 => (p.1 : R) | 1 => (p.2 : R)
    (My.map (MvPolynomial.eval v10)) * (Mx.map (MvPolynomial.eval v00)) =
    (Mx.map (MvPolynomial.eval v01)) * (My.map (MvPolynomial.eval v00))

namespace PolyCMF

variable {R : Type*} [CommRing R] {d : ℕ}

/-- Evaluate a polynomial CMF at an integer lattice point,
    producing a pair of concrete 2×2 matrices. -/
def eval (F : PolyCMF R d) (m n : ℤ) :
    Matrix (Fin 2) (Fin 2) R × Matrix (Fin 2) (Fin 2) R :=
  let v : Fin 2 → R := fun i => match i with | 0 => (m : R) | 1 => (n : R)
  (F.Mx.map (MvPolynomial.eval v), F.My.map (MvPolynomial.eval v))

/-- Coercion from PolyCMF to CMF.ZZ: evaluate at each lattice point.
    This makes pathIndep and all CMF.ZZ theorems available for free. -/
def toCMF (F : PolyCMF R d) : CMF.ZZ R where
  Mx p := (F.eval p.1 p.2).1
  My p := (F.eval p.1 p.2).2
  conserv p := by
    simpa [PolyCMF.eval, Prod.fst, Prod.snd] using F.conserv p

/-- Coercion instance so PolyCMF can be used wherever CMF.ZZ is expected. -/
instance : CoeOut (PolyCMF R d) (CMF.ZZ R) := ⟨toCMF⟩

end PolyCMF
