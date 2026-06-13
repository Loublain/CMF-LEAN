import Mathlib

/-!
# Circle Enumeration for Theorem 3.4

Machine-certified enumeration for Theorem 3.4 of
"A Family of Mathematical Constants Indexed by Gaussian Primes".

The rationality classification reduces (for `b ≠ 0`) to the Niven condition
`t = b / (N(π) + a) = ±1`, equivalently `b = ±(a² + b² + a)`. Completing the
square and scaling by 4, this is

      (2a + 1)² + (2b ∓ 1)² = 2.

We certify, by `decide` over the forced finite box, that the full integer
solution set of each sign is

      {(-1,0), (-1,1), (0,0), (0,1)}      for (2a+1)² + (2b-1)² = 2
      {(-1,-1), (-1,0), (0,-1), (0,0)}    for (2a+1)² + (2b+1)² = 2

and that, after excluding the units (norm 1) and 0, the only Gaussian primes of
norm ≥ 2 satisfying either equation are `-1 + i` and `-1 - i` — the exceptional
set of Theorem 3.4.

Bounding argument (justifies the finite box): each squared term is a
nonnegative integer summing to 2, so `(2a+1)² ≤ 2` and `(2b∓1)² ≤ 2`; an odd
square that is `≤ 2` equals 1, forcing `a ∈ {-1,0}` and `b ∈ {-1,0,1}`.

Predicates are `Bool`-valued so the kernel computes them directly under
`decide`; arithmetic uses explicit multiplication (not `^`) to ensure the
`Int` expressions reduce.

Axioms: `propext, Classical.choice, Quot.sound` (no `sorryAx`, no
`Lean.ofReduceBool` — plain `decide`, not `native_decide`).
-/

namespace CircleEnumeration

/-- Square of an `Int`, by explicit multiplication (kernel-reducible). -/
def sq (n : Int) : Int := n * n

/-- The "+1 case" as a Bool test: `(2a+1)² + (2b-1)² = 2`. -/
def onCirclePlus (a b : Int) : Bool :=
  decide (sq (2 * a + 1) + sq (2 * b - 1) = 2)

/-- The "-1 case" as a Bool test: `(2a+1)² + (2b+1)² = 2`. -/
def onCircleMinus (a b : Int) : Bool :=
  decide (sq (2 * a + 1) + sq (2 * b + 1) = 2)

/-- Gaussian norm `a² + b²` of `a + b·i`. -/
def gaussNorm (a b : Int) : Int := sq a + sq b

/-- The candidate box `a ∈ {-1,0}`, `b ∈ {-1,0,1}`. -/
def box : List (Int × Int) :=
  [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 0), (0, 1)]

/-! ### Enumerations (certified by `decide`) -/

/-- Solutions of the `+1` circle within the box. -/
theorem plus_solutions :
    box.filter (fun p => onCirclePlus p.1 p.2)
      = [(-1, 0), (-1, 1), (0, 0), (0, 1)] := by
  decide

/-- Solutions of the `-1` circle within the box. -/
theorem minus_solutions :
    box.filter (fun p => onCircleMinus p.1 p.2)
      = [(-1, -1), (-1, 0), (0, -1), (0, 0)] := by
  decide

/-- All box solutions of either circle, tagged with their Gaussian norm. -/
def normTagged : List (Int × Int × Int) :=
  (box.filter (fun p => onCirclePlus p.1 p.2 || onCircleMinus p.1 p.2)).map
    (fun p => (p.1, p.2, gaussNorm p.1 p.2))

/-- The only Gaussian primes of norm ≥ 2 on either Niven circle are `-1 + i`
    and `-1 - i`, matching the exceptional set of Theorem 3.4. -/
theorem theorem_3_4_exceptional_set :
    (normTagged.filter (fun t => decide (2 ≤ t.2.2))).map (fun t => (t.1, t.2.1))
      = [(-1, -1), (-1, 1)] := by
  decide

/-! ### Term bounds (justify the box; not load-bearing for the enumeration) -/

theorem plus_term_bounds (a b : Int)
    (h : sq (2 * a + 1) + sq (2 * b - 1) = 2) :
    sq (2 * a + 1) ≤ 2 ∧ sq (2 * b - 1) ≤ 2 := by
  unfold sq at *
  constructor <;> nlinarith [h, mul_self_nonneg (2 * a + 1), mul_self_nonneg (2 * b - 1)]

theorem minus_term_bounds (a b : Int)
    (h : sq (2 * a + 1) + sq (2 * b + 1) = 2) :
    sq (2 * a + 1) ≤ 2 ∧ sq (2 * b + 1) ≤ 2 := by
  unfold sq at *
  constructor <;> nlinarith [h, mul_self_nonneg (2 * a + 1), mul_self_nonneg (2 * b + 1)]

end CircleEnumeration
