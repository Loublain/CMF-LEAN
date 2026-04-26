import Mathlib

/-!
# Connection Matrix Functions (CMFs) on ℤ²

A CMF on ℤ² assigns to each lattice point a pair of 2×2 matrices
(one for each lattice direction) satisfying a flatness/conservation
condition around every elementary plaquette.
-/

namespace CMF

/-- A Connection Matrix Function on ℤ × ℤ.
    `Mx p` is the connection matrix for a step in the x-direction from `p`.
    `My p` is the connection matrix for a step in the y-direction from `p`.
    `conserv` asserts flatness: the ordered product around every unit square is trivial,
    i.e., the two paths from `p` to `p + (1,1)` yield the same matrix product. -/
structure ZZ (R : Type*) [CommRing R] where
  Mx : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  My : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  conserv : ∀ p : ℤ × ℤ,
    My (p + (1, 0)) * Mx p = Mx (p + (0, 1)) * My p

end CMF
