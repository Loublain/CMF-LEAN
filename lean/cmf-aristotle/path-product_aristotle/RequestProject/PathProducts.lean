import Mathlib
import RequestProject.CMF

/-!
# Path products for CMFs on ℤ²

This file defines lattice paths, their matrix products, and the structural
lemmas needed to prove path independence.
-/

namespace CMF

/-- Direction of a single lattice step on ℤ². -/
inductive Step : Type
  | X : Step   -- step in the e₁ = (1,0) direction
  | Y : Step   -- step in the e₂ = (0,1) direction
  deriving DecidableEq, BEq

variable {R : Type*} [CommRing R]

/-! ## Fold helper -/

/-- The general fold with an arbitrary initial matrix accumulator. -/
def foldGen (F : ZZ R) (start : ℤ × ℤ) (A : Matrix (Fin 2) (Fin 2) R)
    (steps : List Step) : (ℤ × ℤ) × Matrix (Fin 2) (Fin 2) R :=
  steps.foldl
    (fun (state : (ℤ × ℤ) × Matrix (Fin 2) (Fin 2) R) step =>
      match step with
      | Step.X => (state.1 + (1, 0), F.Mx state.1 * state.2)
      | Step.Y => (state.1 + (0, 1), F.My state.1 * state.2))
    (start, A)

/-! ## Main definitions -/

/-- The full state carried through the fold: current position and
    accumulated matrix product. The initial state is `(start, 1)`. -/
def pathStateFull (F : ZZ R) (start : ℤ × ℤ) (steps : List Step) :
    (ℤ × ℤ) × Matrix (Fin 2) (Fin 2) R :=
  foldGen F start 1 steps

/-- The lattice point reached after following `steps` from `start`. -/
def pathEnd (F : ZZ R) (start : ℤ × ℤ) (steps : List Step) : ℤ × ℤ :=
  (pathStateFull F start steps).1

/-- The accumulated matrix product along a path. -/
def pathProd (F : ZZ R) (start : ℤ × ℤ) (steps : List Step) :
    Matrix (Fin 2) (Fin 2) R :=
  (pathStateFull F start steps).2

/-! ## Lemmas about foldGen -/

@[simp]
lemma foldGen_nil (F : ZZ R) (start : ℤ × ℤ) (A : Matrix (Fin 2) (Fin 2) R) :
    foldGen F start A [] = (start, A) := rfl

lemma foldGen_cons_X (F : ZZ R) (start : ℤ × ℤ) (A : Matrix (Fin 2) (Fin 2) R)
    (steps : List Step) :
    foldGen F start A (Step.X :: steps) =
    foldGen F (start + (1, 0)) (F.Mx start * A) steps := rfl

lemma foldGen_cons_Y (F : ZZ R) (start : ℤ × ℤ) (A : Matrix (Fin 2) (Fin 2) R)
    (steps : List Step) :
    foldGen F start A (Step.Y :: steps) =
    foldGen F (start + (0, 1)) (F.My start * A) steps := rfl

/-
The position component of the general fold does not depend on the initial accumulator.
-/
lemma foldGen_fst (F : ZZ R) (start : ℤ × ℤ) (A B : Matrix (Fin 2) (Fin 2) R)
    (steps : List Step) :
    (foldGen F start A steps).1 = (foldGen F start B steps).1 := by
  induction' steps with step steps ih generalizing start A B;
  · rfl;
  · rcases step with ( _ | _ ) <;> unfold foldGen <;> aesop

/-
The matrix component of the general fold is right-linear in the initial accumulator.
-/
lemma foldGen_snd (F : ZZ R) (start : ℤ × ℤ) (A : Matrix (Fin 2) (Fin 2) R)
    (steps : List Step) :
    (foldGen F start A steps).2 = (foldGen F start 1 steps).2 * A := by
  induction' steps using List.reverseRecOn with steps step ih generalizing start A;
  · simp +decide [ foldGen ];
  · cases step <;> simp +decide [ foldGen ];
    · convert congr_arg ( fun x => F.Mx ( List.foldl ( fun state step => match step with | Step.X => ( state.1 + ( 1, 0 ), F.Mx state.1 * state.2 ) | Step.Y => ( state.1 + ( 0, 1 ), F.My state.1 * state.2 ) ) ( start, 1 ) steps ).1 * x ) ( ih start A ) using 1;
      · congr! 2;
        convert foldGen_fst F start A 1 steps using 1;
      · rw [ ← mul_assoc ];
        rfl;
    · rw [ mul_assoc ];
      congr! 1;
      · exact congr_arg _ ( foldGen_fst F start A 1 steps );
      · exact ih start A

/-- Appending: the general fold factors. -/
lemma foldGen_append (F : ZZ R) (start : ℤ × ℤ) (A : Matrix (Fin 2) (Fin 2) R)
    (p q : List Step) :
    foldGen F start A (p ++ q) =
    foldGen F (foldGen F start A p).1 (foldGen F start A p).2 q := by
  simp [foldGen, List.foldl_append]

/-! ## Structural lemmas for pathStateFull -/

@[simp]
lemma pathStateFull_nil (F : ZZ R) (start : ℤ × ℤ) :
    pathStateFull F start [] = (start, 1) := rfl

/-
Appending two paths: the full state factors at the join.
-/
lemma pathStateFull_append (F : ZZ R) (start : ℤ × ℤ) (p q : List Step) :
    pathStateFull F start (p ++ q) =
    let mid := pathStateFull F start p
    ((pathStateFull F mid.1 q).1,
     (pathStateFull F mid.1 q).2 * mid.2) := by
  convert foldGen_append F start 1 p q using 1;
  exact Prod.ext ( foldGen_fst F _ _ _ _ ) ( foldGen_snd F _ _ _ ▸ rfl )

/-- The matrix component is left-linear in the initial accumulator. -/
lemma pathStateFull_snd_mul (F : ZZ R) (start : ℤ × ℤ) (steps : List Step)
    (A : Matrix (Fin 2) (Fin 2) R) :
    (steps.foldl
      (fun (state : (ℤ × ℤ) × Matrix (Fin 2) (Fin 2) R) step =>
        match step with
        | Step.X => (state.1 + (1, 0), F.Mx state.1 * state.2)
        | Step.Y => (state.1 + (0, 1), F.My state.1 * state.2))
      (start, A)).2 =
    pathProd F start steps * A := by
  exact foldGen_snd F start A steps

/-! ## Corollaries -/

@[simp]
lemma pathEnd_nil (F : ZZ R) (start : ℤ × ℤ) : pathEnd F start [] = start := rfl

@[simp]
lemma pathProd_nil (F : ZZ R) (start : ℤ × ℤ) : pathProd F start [] = 1 := rfl

/-- The matrix product of a concatenated path splits at the join. -/
lemma pathProd_append (F : ZZ R) (start : ℤ × ℤ) (p q : List Step) :
    pathProd F start (p ++ q) =
    pathProd F (pathEnd F start p) q * pathProd F start p := by
  simp only [pathProd, pathEnd, pathStateFull_append]

/-- The endpoint after concatenation. -/
lemma pathEnd_append (F : ZZ R) (start : ℤ × ℤ) (p q : List Step) :
    pathEnd F start (p ++ q) = pathEnd F (pathEnd F start p) q := by
  simp only [pathEnd, pathStateFull_append]

/-
The endpoint is determined solely by the count of X and Y steps.
-/
lemma pathEnd_eq_start_add_counts (F : ZZ R) (start : ℤ × ℤ) (steps : List Step) :
    pathEnd F start steps =
    start + ((steps.count Step.X : ℤ), (steps.count Step.Y : ℤ)) := by
  unfold pathEnd;
  unfold pathStateFull;
  induction' steps using List.reverseRecOn with steps ih generalizing start <;> simp_all +decide [ foldGen ];
  cases ih <;> simp +decide [ *, add_assoc ];
  · simp +decide [ Prod.ext_iff ];
  · simp +decide [ Prod.ext_iff ]

end CMF