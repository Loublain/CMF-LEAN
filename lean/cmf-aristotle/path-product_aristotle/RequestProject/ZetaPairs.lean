import Mathlib
import RequestProject.CMF
import RequestProject.PathProducts
import RequestProject.PathIndep
import RequestProject.PolyCMF
import RequestProject.SuperCMF

/-!
# Zeta Value Pairing via Commutative and Anticommutative CMFs

## Scope

This file formalizes the structural claim of §3 of the paper:

  Commutative CMF paths generate even zeta values ζ(2n).
  Anticommutative CMF paths generate odd zeta values ζ(2n-1).

## What is proved here (algebraic, no analysis required)

1. `ZetaPair` — structure bundling a commutative and anticommutative CMF
   sharing the same underlying polynomial data.
2. `AntiCMF.sign_flip` — S = -T at every plaquette. This is the algebraic
   mechanism that produces alternating signs in the scalar recursion.
3. `ZetaPair.fromSuper` — a SuperCMF canonically produces a ZetaPair.

## What is not proved here

- Convergence of path product ratios to specific zeta values.
  This requires analytic number theory infrastructure not in Mathlib.

- The connection between the sign flip and alternating series requires
  a transport hypothesis linking T(m,n) to S(m+1,n), which depends on
  the specific polynomial form of the step matrices. This is not a
  consequence of the abstract AntiCMF structure alone.

## Design note on det_sign_flip

For 2×2 matrices, det(-A) = det(A) since dim is even. So det(S) = det(-T) = det(T),
NOT -det(T). This lemma is omitted — the sign flip lives at the matrix level,
not the determinant level.

-- Future: convergence proofs when Mathlib analytic infrastructure is sufficient.
--         Transport hypothesis connecting T(m,n) to S(m+1,n) for specific PolyCMFs.
-/

open CMF

/-! ## The pairing structure -/

/-- A ZetaPair bundles a commutative CMF (generating even zeta values)
    with an anticommutative CMF (generating odd zeta values) that share
    the same step matrix data.

    The pairing is the central structural claim of §3 of the paper. -/
structure ZetaPair (R : Type*) [CommRing R] where
  /-- The commutative component — path-independent, generates even zeta values -/
  comm : CommCMF R
  /-- The anticommutative component — sign-flipping, generates odd zeta values -/
  anti : AntiCMF R
  /-- They share the same horizontal step matrix data -/
  shared_Mx : comm.Mx = anti.Mx
  /-- They share the same vertical step matrix data -/
  shared_My : comm.My = anti.My

namespace ZetaPair

variable {R : Type*} [CommRing R]

attribute [simp] shared_Mx shared_My

/-- Extensionality: two ZetaPairs are equal if their comm and anti components agree. -/
@[ext]
lemma ext {P Q : ZetaPair R} (h_comm : P.comm = Q.comm) (h_anti : P.anti = Q.anti) :
    P = Q := by
  cases P; cases Q; subst h_comm; subst h_anti; rfl

/-- A SuperCMF canonically produces a ZetaPair: the same matrices
    satisfy both conditions simultaneously. -/
def fromSuper (F : SuperCMF R) : ZetaPair R where
  comm := F.toCommCMF
  anti := F.toAntiCMF
  shared_Mx := by
    dsimp [SuperCMF.toCommCMF, SuperCMF.toAntiCMF]
  shared_My := by
    dsimp [SuperCMF.toCommCMF, SuperCMF.toAntiCMF]

end ZetaPair

/-! ## The sign flip: algebraic origin of alternating signs -/

namespace AntiCMF

variable {R : Type*} [CommRing R] (F : AntiCMF R)

/-- The anticommutative condition forces S = -T at every plaquette.
    This is the sign flip that is the algebraic origin of alternating signs
    in the scalar recursion.

    Note: `anti_eq` gives My(m+1,n)*Mx(m,n) = -(Mx(m,n+1)*My(m,n)),
    which is exactly S(m,n) = -T(m,n). -/
@[simp]
lemma sign_flip (m n : ℤ) :
    S F.Mx F.My m n = -(T F.Mx F.My m n) := by
  simp [S, T, F.anti_eq]

/-- The sign flip stated additively: S + T = 0.
    This is the direct form of the anticommutative condition. -/
@[simp]
lemma sign_flip_add (m n : ℤ) :
    S F.Mx F.My m n + T F.Mx F.My m n = 0 := by
  simp [sign_flip]

/-- The squared plaquette product is symmetric:
    S² = T². This follows from S = -T by squaring.
    Squaring eliminates the sign — this is why even powers of the
    anticommutative operator behave like the commutative operator. -/
lemma sq_symmetric (m n : ℤ) :
    S F.Mx F.My m n * S F.Mx F.My m n =
    T F.Mx F.My m n * T F.Mx F.My m n := by
  simp [sign_flip]

-- Note on det_sign_flip (deliberately omitted):
--   For 2×2 matrices, det(-A) = (-1)^2 · det(A) = det(A).
--   Therefore det(S) = det(-T) = det(T), NOT -det(T).
--   The sign flip is a matrix-level phenomenon, invisible at the
--   determinant level for even-dimensional matrices.

end AntiCMF

/-! ## Table 1 instances

The known pairs from Table 1 of the paper are recorded as named documentation.
These record the mathematical content without claiming formal proofs
of the convergence statements, which require analytic infrastructure.
-/

/-- The fundamental even/odd zeta pair at weight 2.
    Commutative limit: ζ(2) = π²/6.
    Anticommutative limit: π/4 = 1 - 1/3 + 1/5 - ⋯ (Leibniz formula).
    The degree drop π² → π reflects 4-step vs 2-step closure. -/
def Table1.weight2 : String :=
  "ζ(2) = π²/6 (comm) ↔ π/4 (anti) — degree drop reflects closure periodicity"

/-- The general even/odd zeta pair at weight 2n.
    ζ(2n) has a closed form in π^(2n) (commutative path).
    ζ(2n-1) has no known closed form (anticommutative path).
    The absence of a closed form for odd zeta values is structural,
    not accidental — they live on the anticommutative path. -/
def Table1.general (n : ℕ) : String :=
  s!"ζ({2*n}) closed form in π^{2*n} (comm) ↔ ζ({2*n-1}) no closed form (anti)"

/-- The exponential pair.
    e = Σ 1/n! (all positive terms, commutative path).
    1/e = Σ (-1)^n/n! (alternating terms, anticommutative path).
    Forward path vs reverse path through the same CMF. -/
def Table1.exp : String :=
  "e (comm, forward path) ↔ 1/e (anti, reverse path)"

/-! ## Summary

Proved algebraically (complete proofs, no analysis):
- `AntiCMF.sign_flip`      — S = -T, the sign flip mechanism           ✓
- `AntiCMF.sign_flip_add`  — S + T = 0 equivalent form                 ✓
- `AntiCMF.sq_symmetric`   — S² = T², squaring eliminates sign          ✓
- `ZetaPair.fromSuper`     — SuperCMF produces a ZetaPair               ✓

Correctly omitted:
- `det_sign_flip`        — FALSE for even-dimensional matrices
- `alternating_steps`    — requires transport hypothesis not in abstract AntiCMF
- convergence theorems   — require analytic infrastructure not in Mathlib

Table 1 instances recorded as documentation strings.
-/
