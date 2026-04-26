import Mathlib
import RequestProject.CMF
import RequestProject.PathProducts
import RequestProject.PathIndep
import RequestProject.PolyCMF

/-!
# Commutative and Anticommutative Conservative Matrix Fields

## Scope

This file defines the two integrability conditions that arise when the CMF
base is extended from ℤ² to the Gaussian integers ℤ[i].

The 4-periodicity of i under multiplication stratifies lattice paths into
two classes (Definition 2.1 of the paper):

- **Commutative paths**: `S - T = 0`, i.e. `My(m+1,n) * Mx(m,n) = Mx(m,n+1) * My(m,n)`
  This is the standard CMF conservativity condition.
  Closed loops have 4-step closure. Generates even zeta values ζ(2n).

- **Anticommutative paths**: `S + T = 0`, i.e. `My(m+1,n) * Mx(m,n) = -(Mx(m,n+1) * My(m,n))`
  Closed loops have 2-step closure (spinor-like).
  Generates odd zeta values ζ(2n-1) and alternating series.

A `SuperCMF` satisfies both conditions simultaneously.

## Note on formalisation scope

The paper (§6) states: "We do not formalize the ℤ₂-graded structure as a
rigorous supersymmetry algebra here; the analogy is structural rather than
physical." This file formalises exactly what the paper claims — the algebraic
structure — and nothing more.

-- Future: ℤ[i] base, full Gaussian integer lattice, higher Clifford algebras.
--         See CMF.lean design note on lattice generality.
-/

open MvPolynomial Matrix

/-! ## The S and T operators -/

variable {R : Type*} [CommRing R]

/-- S(m,n) = My(m+1, n) * Mx(m, n) — vertical-after-horizontal transport -/
def S (Mx My : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R) (m n : ℤ) :
    Matrix (Fin 2) (Fin 2) R :=
  My (m + 1, n) * Mx (m, n)

/-- T(m,n) = Mx(m, n+1) * My(m, n) — horizontal-after-vertical transport -/
def T (Mx My : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R) (m n : ℤ) :
    Matrix (Fin 2) (Fin 2) R :=
  Mx (m, n + 1) * My (m, n)

/-! ## Commutative CMF -/

/-- A commutative CMF satisfies S - T = 0 at every lattice point.
    This is exactly the standard CMF conservativity condition. -/
structure CommCMF (R : Type*) [CommRing R] where
  Mx : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  My : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  comm : ∀ m n : ℤ, S Mx My m n = T Mx My m n

/-- CommCMF is definitionally equal to CMF.ZZ: conservativity is S = T. -/
def CommCMF.toCMF {R : Type*} [CommRing R] (F : CommCMF R) : CMF.ZZ R where
  Mx := F.Mx
  My := F.My
  conserv p := by
    rcases p with ⟨m, n⟩
    simpa [S, T] using (F.comm m n)

instance (R : Type*) [CommRing R] : Coe (CommCMF R) (CMF.ZZ R) :=
  ⟨CommCMF.toCMF⟩

/-! ## Anticommutative CMF -/

/-- An anticommutative CMF satisfies S + T = 0 at every lattice point.
    Each pair of steps introduces a sign flip, generating alternating series.
    Algebraically equivalent to spinors (2-step closure). -/
structure AntiCMF (R : Type*) [CommRing R] where
  Mx : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  My : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  anti : ∀ m n : ℤ, S Mx My m n + T Mx My m n = 0

namespace AntiCMF

variable {R : Type*} [CommRing R] (F : AntiCMF R)

/-- The anticommutative condition stated as My*Mx = -(Mx*My). -/
lemma anti_eq (m n : ℤ) :
    F.My (m + 1, n) * F.Mx (m, n) = -(F.Mx (m, n + 1) * F.My (m, n)) := by
  have h := F.anti m n
  simp only [S, T] at h
  exact eq_neg_of_add_eq_zero_left h

/-- Two anticommutative steps cancel: going right-up-left-down returns
    to the identity up to sign. -/
lemma two_step_closure (m n : ℤ) :
    (F.My (m + 1, n) * F.Mx (m, n)) * (F.My (m + 1, n) * F.Mx (m, n)) =
    (F.Mx (m, n + 1) * F.My (m, n)) * (F.Mx (m, n + 1) * F.My (m, n)) := by
  rw [F.anti_eq m n]
  simp [neg_mul, mul_neg]

end AntiCMF

/-! ## SuperCMF: satisfies both conditions simultaneously -/

/-- A SuperCMF satisfies both S - T = 0 and S + T = 0 simultaneously.
    This forces S = 0 and T = 0: the step matrices anticommute and commute,
    requiring [Mx, My] = 0 and {Mx, My} = 0, i.e. Mx*My = My*Mx = 0.

    The Pauli matrices provide the natural nontrivial solution (§2 of paper). -/
structure SuperCMF (R : Type*) [CommRing R] where
  Mx : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  My : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  comm : ∀ m n : ℤ, S Mx My m n = T Mx My m n
  anti : ∀ m n : ℤ, S Mx My m n + T Mx My m n = 0

namespace SuperCMF

variable {R : Type*} [CommRing R] [CharZero R] [NoZeroDivisors R] (F : SuperCMF R)

/-- Both S and T vanish for a SuperCMF (over a domain of characteristic zero). -/
lemma S_eq_zero (m n : ℤ) : S F.Mx F.My m n = 0 := by
  have hcomm := F.comm m n
  have hanti := F.anti m n
  rw [hcomm] at hanti
  ext i j
  have : (T F.Mx F.My m n) i j + (T F.Mx F.My m n) i j = 0 := by
    have := congr_fun (congr_fun hanti i) j
    simpa [Matrix.add_apply, Matrix.zero_apply] using this
  rw [show S F.Mx F.My m n = T F.Mx F.My m n from hcomm]
  have := add_self_eq_zero.mp this
  simp [Matrix.zero_apply, this]

lemma T_eq_zero (m n : ℤ) : T F.Mx F.My m n = 0 := by
  have hcomm := F.comm m n
  rw [← hcomm]
  exact F.S_eq_zero m n

/-- The commutative component of a SuperCMF. -/
def toCommCMF {R : Type*} [CommRing R] (F : SuperCMF R) : CommCMF R where
  Mx := F.Mx
  My := F.My
  comm := F.comm

/-- The anticommutative component of a SuperCMF. -/
def toAntiCMF {R : Type*} [CommRing R] (F : SuperCMF R) : AntiCMF R where
  Mx := F.Mx
  My := F.My
  anti := F.anti

end SuperCMF
