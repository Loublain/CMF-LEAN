import Mathlib
import RequestProject.CMF
import RequestProject.PathProducts
import RequestProject.PathIndep
import RequestProject.PolyCMF

/-!
# Commutative and Anticommutative Conservative Matrix Fields
-/

variable {R : Type*} [CommRing R]

def S (Mx My : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R) (m n : ℤ) :
    Matrix (Fin 2) (Fin 2) R :=
  My (m + 1, n) * Mx (m, n)

def T (Mx My : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R) (m n : ℤ) :
    Matrix (Fin 2) (Fin 2) R :=
  Mx (m, n + 1) * My (m, n)

structure CommCMF (R : Type*) [CommRing R] where
  Mx : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  My : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  comm : ∀ m n : ℤ, S Mx My m n = T Mx My m n

def CommCMF.toCMF {R : Type*} [CommRing R] (F : CommCMF R) : CMF.ZZ R where
  Mx := F.Mx
  My := F.My
  conserv := fun ⟨m, n⟩ => by
    simp only [Prod.mk_add_mk]
    norm_num
    exact F.comm m n

instance (R : Type*) [CommRing R] : Coe (CommCMF R) (CMF.ZZ R) :=
  ⟨CommCMF.toCMF⟩

structure AntiCMF (R : Type*) [CommRing R] where
  Mx : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  My : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  anti : ∀ m n : ℤ, S Mx My m n + T Mx My m n = 0

namespace AntiCMF

variable {R : Type*} [CommRing R] (F : AntiCMF R)

lemma anti_eq (m n : ℤ) :
    F.My (m + 1, n) * F.Mx (m, n) = -(F.Mx (m, n + 1) * F.My (m, n)) := by
  have h := F.anti m n
  simp only [S, T] at h
  exact eq_neg_of_add_eq_zero_left h

lemma two_step_closure (m n : ℤ) :
    (F.My (m + 1, n) * F.Mx (m, n)) * (F.My (m + 1, n) * F.Mx (m, n)) =
    (F.Mx (m, n + 1) * F.My (m, n)) * (F.Mx (m, n + 1) * F.My (m, n)) := by
  rw [F.anti_eq m n]
  simp [neg_mul, mul_neg]

end AntiCMF

structure SuperCMF (R : Type*) [CommRing R] where
  Mx : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  My : ℤ × ℤ → Matrix (Fin 2) (Fin 2) R
  comm : ∀ m n : ℤ, S Mx My m n = T Mx My m n
  anti : ∀ m n : ℤ, S Mx My m n + T Mx My m n = 0

namespace SuperCMF

variable {R : Type*} [CommRing R] [CharZero R] [NoZeroDivisors R] (F : SuperCMF R)

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

def toCommCMF {R : Type*} [CommRing R] (F : SuperCMF R) : CommCMF R where
  Mx := F.Mx
  My := F.My
  comm := F.comm

def toAntiCMF {R : Type*} [CommRing R] (F : SuperCMF R) : AntiCMF R where
  Mx := F.Mx
  My := F.My
  anti := F.anti

end SuperCMF
