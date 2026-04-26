import Mathlib
import RequestProject.CMF
import RequestProject.PathProducts
import RequestProject.PathIndep
import RequestProject.PolyCMF
import RequestProject.SuperCMF

/-!
# Pauli CMF: Concrete Verification

## Scope

This file constructs the explicit Pauli step matrices from §2.2 of the paper
and verifies that they satisfy the anticommutative CMF condition S + T = 0.

The example is the constant c₁ (§2.2):

  Mx(m, n) = [[m, 1], [1, -m]]   (= m·σ_z + σ_x, trace-zero)
  My(m, n) = [[0, 1], [-1, 0]]   (= i·σ_y up to phase)

The paper verifies by direct computation:
  S = My(m+1, n) * Mx(m, n) = [[1, -m], [-m, -1]]
  T = Mx(m, n+1) * My(m, n) = [[-1, m], [m, 1]]
  S + T = 0  ✓

This file makes that verification machine-checkable.

## What this establishes

- The Pauli step matrices form a valid `AntiCMF ℤ`
- They do NOT form a `CommCMF` (S ≠ T in general)
- The anticommutative condition is verified by `decide`-style computation

## Note

The Pauli matrices are defined over ℤ here since all entries are integers.
For analysis (convergence, limits) the base ring would be extended to ℝ or ℂ.
-/

open Matrix

/-! ## The Pauli basis matrices over ℤ -/

/-- σ_x = [[0, 1], [1, 0]] -/
def σ_x : Matrix (Fin 2) (Fin 2) ℤ :=
  !![0, 1; 1, 0]

/-- σ_y_real = [[0, 1], [-1, 0]] = i·σ_y up to phase -/
def σ_y_real : Matrix (Fin 2) (Fin 2) ℤ :=
  !![0, 1; -1, 0]

/-- σ_z = [[1, 0], [0, -1]] -/
def σ_z : Matrix (Fin 2) (Fin 2) ℤ :=
  !![1, 0; 0, -1]

/-! ## The c₁ step matrices -/

/-- Horizontal step matrix for c₁:
    Mx(m, n) = m·σ_z + σ_x = [[m, 1], [1, -m]]
    Note: independent of n. -/
def Mx_c1 (p : ℤ × ℤ) : Matrix (Fin 2) (Fin 2) ℤ :=
  !![p.1, 1; 1, -p.1]

/-- Vertical step matrix for c₁:
    My(m, n) = [[0, 1], [-1, 0]]
    Constant — independent of both m and n. -/
def My_c1 (_ : ℤ × ℤ) : Matrix (Fin 2) (Fin 2) ℤ :=
  !![0, 1; -1, 0]

/-! ## Verification of the anticommutative condition -/

/-- Direct computation: S(m, n) = My(m+1, n) * Mx(m, n) = [[1, -m], [-m, -1]] -/
lemma S_c1 (m n : ℤ) :
    My_c1 (m + 1, n) * Mx_c1 (m, n) = !![1, -m; -m, -1] := by
  simp [My_c1, Mx_c1]

/-- Direct computation: T(m, n) = Mx(m, n+1) * My(m, n) = [[-1, m], [m, 1]] -/
lemma T_c1 (m n : ℤ) :
    Mx_c1 (m, n + 1) * My_c1 (m, n) = !![(-1), m; m, 1] := by
  simp [My_c1, Mx_c1]

/-- S + T = 0: the anticommutative condition holds for the c₁ Pauli matrices. -/
lemma S_plus_T_c1 (m n : ℤ) :
    My_c1 (m + 1, n) * Mx_c1 (m, n) + Mx_c1 (m, n + 1) * My_c1 (m, n) = 0 := by
  rw [S_c1, T_c1]
  ext i j
  fin_cases i <;> fin_cases j <;> simp [Matrix.add_apply, Matrix.zero_apply]

/-- The c₁ Pauli matrices form a valid AntiCMF over ℤ. -/
def pauliAntiCMF : AntiCMF ℤ where
  Mx := Mx_c1
  My := My_c1
  anti m n := S_plus_T_c1 m n

/-! ## The c₁ matrices do NOT satisfy the commutative condition -/

/-- S ≠ T for the c₁ matrices: they are not a CommCMF.
    Verified at (m, n) = (0, 0). -/
lemma not_comm_c1 :
    ¬ ∀ m n : ℤ, My_c1 (m + 1, n) * Mx_c1 (m, n) = Mx_c1 (m, n + 1) * My_c1 (m, n) := by
  intro h
  have := h 0 0
  simp [My_c1, Mx_c1] at this

/-! ## The Möbius action on ℂℙ¹ (scalar recursion, §2.2) -/

/-- The Möbius step z ↦ (m·z + 1)/(z - m) arises from the projective
    action of Mx_c1(m, 0) on ℂℙ¹.

    This is stated as a property of the matrix entries rather than
    as a formal projective action, keeping the formalization concrete.

    The paper notes: p(k) = 1, r(k) = k in the notation of Theorem 2.1
    of the companion paper. -/
lemma mobius_step (m : ℤ) :
    Mx_c1 (m, 0) = !![m, 1; 1, -m] := by
  simp [Mx_c1]

/-! ## Summary

The file establishes:
1. Explicit Pauli step matrices for c₁ over ℤ  ✓
2. S + T = 0 verified by direct matrix computation  ✓
3. `pauliAntiCMF : AntiCMF ℤ` constructed  ✓
4. c₁ matrices are NOT a CommCMF  ✓
5. Möbius step matches paper §2.2  ✓

Next: SuperCMF instance requires both conditions simultaneously.
The paper notes the Pauli basis σ₁, σ₃ satisfies both via Clifford
relations — that construction is in SuperCMF_Pauli.lean (future).
-/
