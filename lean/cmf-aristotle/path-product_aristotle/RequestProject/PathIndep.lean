import RequestProject.CMF
import RequestProject.PathProducts

set_option autoImplicit false
set_option relaxedAutoImplicit false
set_option maxHeartbeats 800000

open CMF Step

variable {R : Type*} [CommRing R]

def canonPath (nx ny : ℕ) : List Step :=
  List.replicate nx Step.X ++ List.replicate ny Step.Y

theorem swap_yx_eq_xy (F : CMF.ZZ R) (p : ℤ × ℤ) :
    pathProd F p [Step.Y, Step.X] = pathProd F p [Step.X, Step.Y] := by
  simp [pathProd, pathStateFull, foldGen]
  exact (F.conserv p).symm

theorem pathProd_swap_mid (F : CMF.ZZ R) (p : ℤ × ℤ) (l₁ l₂ : List Step) :
    pathProd F p (l₁ ++ [Step.Y, Step.X] ++ l₂) =
    pathProd F p (l₁ ++ [Step.X, Step.Y] ++ l₂) := by
  let m := pathEnd F p l₁
  have h_inner :
      pathProd F m ([Step.Y, Step.X] ++ l₂) =
      pathProd F m ([Step.X, Step.Y] ++ l₂) := by
    have hx : List.count Step.X [Step.Y, Step.X] = List.count Step.X [Step.X, Step.Y] := by decide
    have hy : List.count Step.Y [Step.Y, Step.X] = List.count Step.Y [Step.X, Step.Y] := by decide
    have h_end : pathEnd F m [Step.Y, Step.X] = pathEnd F m [Step.X, Step.Y] := by
      simp [pathEnd_eq_start_add_counts, hx, hy]
    calc
      pathProd F m ([Step.Y, Step.X] ++ l₂)
          = pathProd F (pathEnd F m [Step.Y, Step.X]) l₂ * pathProd F m [Step.Y, Step.X] := by
              simpa using pathProd_append F m [Step.Y, Step.X] l₂
      _ = pathProd F (pathEnd F m [Step.X, Step.Y]) l₂ * pathProd F m [Step.X, Step.Y] := by
            rw [h_end, swap_yx_eq_xy]
      _ = pathProd F m ([Step.X, Step.Y] ++ l₂) := by
            simpa using (pathProd_append F m [Step.X, Step.Y] l₂).symm
  calc
    pathProd F p (l₁ ++ [Step.Y, Step.X] ++ l₂)
        = pathProd F m ([Step.Y, Step.X] ++ l₂) * pathProd F p l₁ := by
            simpa [m, List.append_assoc] using pathProd_append F p l₁ ([Step.Y, Step.X] ++ l₂)
    _ = pathProd F m ([Step.X, Step.Y] ++ l₂) * pathProd F p l₁ := by rw [h_inner]
    _ = pathProd F p (l₁ ++ [Step.X, Step.Y] ++ l₂) := by
          simpa [m, List.append_assoc] using
            (pathProd_append F p l₁ ([Step.X, Step.Y] ++ l₂)).symm

theorem bubble_y_past_xs (F : CMF.ZZ R) (p : ℤ × ℤ) (k : ℕ) (tail : List Step) :
    pathProd F p (Step.Y :: List.replicate k Step.X ++ tail) =
    pathProd F p (List.replicate k Step.X ++ Step.Y :: tail) := by
  induction' k with k ih generalizing p
  · rfl
  · calc
      pathProd F p (Step.Y :: List.replicate (k + 1) Step.X ++ tail)
          = pathProd F p (Step.X :: Step.Y :: List.replicate k Step.X ++ tail) := by
              simpa [List.replicate_succ, List.cons_append] using
                pathProd_swap_mid F p [] (List.replicate k Step.X ++ tail)
      _ = pathProd F (p + (1, 0)) (Step.Y :: List.replicate k Step.X ++ tail) * pathProd F p [Step.X] := by
            simpa [pathEnd_eq_start_add_counts] using
              (pathProd_append F p [Step.X] (Step.Y :: List.replicate k Step.X ++ tail))
      _ = pathProd F (p + (1, 0)) (List.replicate k Step.X ++ Step.Y :: tail) * pathProd F p [Step.X] := by
            rw [ih (p + (1, 0))]
      _ = pathProd F p (Step.X :: (List.replicate k Step.X ++ Step.Y :: tail)) := by
            simpa [pathEnd_eq_start_add_counts] using
              (pathProd_append F p [Step.X] (List.replicate k Step.X ++ Step.Y :: tail)).symm
      _ = pathProd F p (List.replicate (k + 1) Step.X ++ Step.Y :: tail) := by
            simp [List.replicate_succ, List.cons_append]

theorem pathProd_eq_canon (F : CMF.ZZ R) (p : ℤ × ℤ) (l : List Step) :
    pathProd F p l = pathProd F p (canonPath (l.count Step.X) (l.count Step.Y)) := by
  induction' l with s l ih generalizing p
  · rfl
  · cases s with
    | X =>
        calc
          pathProd F p (Step.X :: l)
              = pathProd F (p + (1, 0)) l * pathProd F p [Step.X] := by
                  simpa [pathEnd_eq_start_add_counts] using (pathProd_append F p [Step.X] l)
          _ = pathProd F (p + (1, 0)) (canonPath (l.count Step.X) (l.count Step.Y)) * pathProd F p [Step.X] := by
                rw [ih (p + (1, 0))]
          _ = pathProd F p (Step.X :: canonPath (l.count Step.X) (l.count Step.Y)) := by
                simpa [pathEnd_eq_start_add_counts] using
                  (pathProd_append F p [Step.X] (canonPath (l.count Step.X) (l.count Step.Y))).symm
          _ = pathProd F p (canonPath ((Step.X :: l).count Step.X) ((Step.X :: l).count Step.Y)) := by
                have hXX : (Step.X == Step.X) = true := by decide
                have hXY : (Step.X == Step.Y) = false := by decide
                have hx : (Step.X :: l).count Step.X = l.count Step.X + 1 := by
                  simp [List.count_cons, hXX]
                have hy : (Step.X :: l).count Step.Y = l.count Step.Y := by
                  simp [List.count_cons, hXY]
                have hlist :
                    Step.X :: (List.replicate (l.count Step.X) Step.X ++ List.replicate (l.count Step.Y) Step.Y) =
                      List.replicate (l.count Step.X + 1) Step.X ++ List.replicate (l.count Step.Y) Step.Y := by
                    simp [List.cons_append, List.replicate_succ]
                simp [canonPath, hx, hy, hlist]
    | Y =>
        have hcanon :
            pathProd F p (Step.Y :: l) =
            pathProd F p (Step.Y :: canonPath (l.count Step.X) (l.count Step.Y)) := by
          calc
            pathProd F p (Step.Y :: l)
                = pathProd F (p + (0, 1)) l * pathProd F p [Step.Y] := by
                    simpa [pathEnd_eq_start_add_counts] using (pathProd_append F p [Step.Y] l)
            _ = pathProd F (p + (0, 1)) (canonPath (l.count Step.X) (l.count Step.Y)) * pathProd F p [Step.Y] := by
                  rw [ih (p + (0, 1))]
            _ = pathProd F p (Step.Y :: canonPath (l.count Step.X) (l.count Step.Y)) := by
                  simpa [pathEnd_eq_start_add_counts] using
                    (pathProd_append F p [Step.Y] (canonPath (l.count Step.X) (l.count Step.Y))).symm
        rw [hcanon]
        calc
          pathProd F p (Step.Y :: canonPath (l.count Step.X) (l.count Step.Y))
              = pathProd F p (List.replicate (l.count Step.X) Step.X ++ Step.Y :: List.replicate (l.count Step.Y) Step.Y) := by
                  simpa [canonPath, List.cons_append] using
                    bubble_y_past_xs F p (l.count Step.X) (List.replicate (l.count Step.Y) Step.Y)
          _ = pathProd F p (canonPath ((Step.Y :: l).count Step.X) ((Step.Y :: l).count Step.Y)) := by
                have hYX : (Step.Y == Step.X) = false := by decide
                have hYY : (Step.Y == Step.Y) = true := by decide
                have hx : (Step.Y :: l).count Step.X = l.count Step.X := by
                  simp [List.count_cons, hYX]
                have hy : (Step.Y :: l).count Step.Y = l.count Step.Y + 1 := by
                  simp [List.count_cons, hYY]
                have hlist :
                    List.replicate (l.count Step.X) Step.X ++ Step.Y :: List.replicate (l.count Step.Y) Step.Y =
                      List.replicate (l.count Step.X) Step.X ++ List.replicate (l.count Step.Y + 1) Step.Y := by
                    simp [List.replicate_succ]
                simp [canonPath, hx, hy, hlist]

theorem counts_of_pathEnd_eq (F : CMF.ZZ R) (p : ℤ × ℤ) (l₁ l₂ : List Step)
    (h : pathEnd F p l₁ = pathEnd F p l₂) :
    l₁.count Step.X = l₂.count Step.X ∧ l₁.count Step.Y = l₂.count Step.Y := by
  simp_all [pathEnd_eq_start_add_counts]

theorem pathIndep (F : CMF.ZZ R) (p : ℤ × ℤ) (l₁ l₂ : List Step)
    (h : pathEnd F p l₁ = pathEnd F p l₂) :
    pathProd F p l₁ = pathProd F p l₂ := by
  rw [pathProd_eq_canon F p l₁, pathProd_eq_canon F p l₂]
  obtain ⟨hx, hy⟩ := counts_of_pathEnd_eq F p l₁ l₂ h
  rw [hx, hy]
