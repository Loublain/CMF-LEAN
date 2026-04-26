import RequestProject.CMF
import RequestProject.PathProducts

/-! # Path independence for conservative matrix fields on ℤ²

Any two paths on ℤ² with the same start and end point have the same
matrix product under a conservative matrix field `F : CMF.ZZ R`.

## Proof strategy

1. Define the **canonical path** `canonPath nx ny` = `replicate nx X ++ replicate ny Y`.
2. Show that swapping an adjacent `(Y, X)` pair preserves the product (by `F.conserv`).
3. Show by induction that every path has the same product as its canonical form
   (bubble the leading `Y` past all `X`'s).
4. Conclude: same endpoints ⟹ same counts ⟹ same canonical form ⟹ same product.
-/

set_option autoImplicit false
set_option relaxedAutoImplicit false
set_option maxHeartbeats 800000

open CMF Step

variable {R : Type*} [CommRing R]

/-! ## Canonical path -/

/-- The canonical path: `nx` steps right, then `ny` steps up. -/
def canonPath (nx ny : ℕ) : List Step :=
  List.replicate nx Step.X ++ List.replicate ny Step.Y

/-! ## Swapping adjacent Y,X preserves the product -/

/-- The conservativity condition reformulated as: at any grid point,
    the two-step product `Y;X` equals the two-step product `X;Y`. -/
theorem swap_yx_eq_xy (F : CMF.ZZ R) (p : ℤ × ℤ) :
    pathProd F p [Step.Y, Step.X] = pathProd F p [Step.X, Step.Y] := by
  simp +decide [pathProd, pathStateFull, foldGen]
  exact (F.conserv p).symm

/-
Swapping an adjacent `(Y,X)` pair in the middle of a path preserves
    the overall product.
-/
theorem pathProd_swap_mid (F : CMF.ZZ R) (p : ℤ × ℤ)
    (l₁ l₂ : List Step) :
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

/-! ## Bubbling Y past a block of X's -/

/-
Bubbling one `Y` step past `k` consecutive `X` steps preserves the product.
-/
theorem bubble_y_past_xs (F : CMF.ZZ R) (p : ℤ × ℤ) (k : ℕ)
    (tail : List Step) :
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

/-! ## Every path has the same product as its canonical form -/

/-
Core lemma: the product along any path equals the product along its
    canonical rearrangement (all X's first, then all Y's).
-/
theorem pathProd_eq_canon (F : CMF.ZZ R) (p : ℤ × ℤ) (l : List Step) :
    pathProd F p l = pathProd F p (canonPath (l.count Step.X) (l.count Step.Y)) := by
  induction' l with s l ih generalizing p
  · rfl
  · cases s with
    | X =>
        calc
          pathProd F p (Step.X :: l)
              = pathProd F (p + (1, 0)) l * pathProd F p [Step.X] := by
                  simpa [pathEnd_eq_start_add_counts] using
                    (pathProd_append F p [Step.X] l)
          _ = pathProd F (p + (1, 0))
                (canonPath (l.count Step.X) (l.count Step.Y)) * pathProd F p [Step.X] := by
                  rw [ih (p + (1, 0))]
          _ = pathProd F p (Step.X :: canonPath (l.count Step.X) (l.count Step.Y)) := by
                simpa [pathEnd_eq_start_add_counts] using
                  (pathProd_append F p [Step.X] (canonPath (l.count Step.X) (l.count Step.Y))).symm
          _ = pathProd F p (canonPath ((Step.X :: l).count Step.X) ((Step.X :: l).count Step.Y)) := by
                calc
                  pathProd F p (Step.X :: canonPath (l.count Step.X) (l.count Step.Y))
                      = pathProd F p (List.replicate (l.count Step.X + 1) Step.X ++ List.replicate (l.count Step.Y) Step.Y) := by
                          simp [canonPath, List.replicate_succ, List.cons_append]
                  _ = pathProd F p (canonPath ((Step.X :: l).count Step.X) ((Step.X :: l).count Step.Y)) := by
                        have hx : (Step.X :: l).count Step.X = l.count Step.X + 1 := by
                          have hxx : (Step.X == Step.X) = true := by decide
                          simp [List.count_cons, hxx]
                        have hy : (Step.X :: l).count Step.Y = l.count Step.Y := by
                          have hxy : (Step.X == Step.Y) = false := by decide
                          simp [List.count_cons, hxy]
                        rw [canonPath, hx, hy]
    | Y =>
        have hcanon :
            pathProd F p (Step.Y :: l) =
            pathProd F p (Step.Y :: canonPath (l.count Step.X) (l.count Step.Y)) := by
          calc
            pathProd F p (Step.Y :: l)
                = pathProd F (p + (0, 1)) l * pathProd F p [Step.Y] := by
                    simpa [pathEnd_eq_start_add_counts] using
                      (pathProd_append F p [Step.Y] l)
            _ = pathProd F (p + (0, 1))
                  (canonPath (l.count Step.X) (l.count Step.Y)) * pathProd F p [Step.Y] := by
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
                calc
                  pathProd F p (List.replicate (l.count Step.X) Step.X ++ Step.Y :: List.replicate (l.count Step.Y) Step.Y)
                      = pathProd F p (List.replicate (l.count Step.X) Step.X ++ List.replicate (l.count Step.Y + 1) Step.Y) := by
                          simp [List.replicate_succ]
                  _ = pathProd F p (canonPath ((Step.Y :: l).count Step.X) ((Step.Y :: l).count Step.Y)) := by
                        have hx : (Step.Y :: l).count Step.X = l.count Step.X := by
                          have hyx : (Step.Y == Step.X) = false := by decide
                          simp [List.count_cons, hyx]
                        have hy : (Step.Y :: l).count Step.Y = l.count Step.Y + 1 := by
                          have hyy : (Step.Y == Step.Y) = true := by decide
                          simp [List.count_cons, hyy]
                        rw [canonPath, hx, hy]

/-! ## Same endpoints imply same counts -/

theorem counts_of_pathEnd_eq (F : CMF.ZZ R) (p : ℤ × ℤ) (l₁ l₂ : List Step)
    (h : pathEnd F p l₁ = pathEnd F p l₂) :
    l₁.count Step.X = l₂.count Step.X ∧ l₁.count Step.Y = l₂.count Step.Y := by
  simp_all +decide [ pathEnd_eq_start_add_counts ]

/-! ## Main theorem: path independence -/

/-- **Path independence**: if two paths start at the same point and end at the
    same point, they have the same matrix product under any conservative matrix
    field. -/
theorem pathIndep (F : CMF.ZZ R) (p : ℤ × ℤ) (l₁ l₂ : List Step)
    (h : pathEnd F p l₁ = pathEnd F p l₂) :
    pathProd F p l₁ = pathProd F p l₂ := by
  rw [pathProd_eq_canon F p l₁, pathProd_eq_canon F p l₂]
  obtain ⟨hx, hy⟩ := counts_of_pathEnd_eq F p l₁ l₂ h
  rw [hx, hy]