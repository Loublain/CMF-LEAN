import Mathlib
import RequestProject.CMF
import RequestProject.SuperCMF

/-!
# The ζ(5) Recurrence: Predictions from the Anticommutative CMF Framework

This file formalizes recurrence-shaped predictions for a possible Apéry-style
irrationality proof of `ζ(5)`.
-/

/-! ## The general degree-d recurrence structure -/

/-- A three-term recurrence of degree `d` satisfied by a denominator sequence
`a`, a numerator sequence `b`, and a coefficient polynomial `A`.

The intended recurrence is

`n^d * u n = A n * u (n - 1) - (n - 1)^d * u (n - 2)`.
-/
structure ThreeTermRec (d : ℕ) where
  A : ℤ → ℤ
  a : ℕ → ℤ
  b : ℕ → ℚ
  rec_a : ∀ n : ℕ, n ≥ 2 →
    (n : ℤ)^d * a n = A n * a (n - 1) - ((n - 1 : ℕ) : ℤ)^d * a (n - 2)
  rec_b : ∀ n : ℕ, n ≥ 2 →
    (n : ℚ)^d * b n = (A n : ℚ) * b (n - 1) - ((n - 1 : ℕ) : ℚ)^d * b (n - 2)

/-! ## Apéry's coefficient polynomial for ζ(3) -/

/-- Apéry's coefficient polynomial `A(n) = 34n^3 - 51n^2 + 27n - 5`. -/
def apery3_A (n : ℤ) : ℤ :=
  34 * n^3 - 51 * n^2 + 27 * n - 5

lemma apery3_at_1 : apery3_A 1 = 5 := by norm_num [apery3_A]
lemma apery3_at_2 : apery3_A 2 = 117 := by norm_num [apery3_A]
lemma apery3_at_3 : apery3_A 3 = 535 := by norm_num [apery3_A]

lemma apery3_leading_coeff (n : ℤ) :
    apery3_A n = 34 * n^3 - 51 * n^2 + 27 * n - 5 := rfl

/-! ## The Poincaré-Perron condition -/

/-- The characteristic equation `x^2 - αx + 1 = 0`, with one dominant and one
subdominant positive root.

The field names avoid the `λ` character because it is reserved syntax in Lean.
-/
structure PoincarePeron (α : ℝ) (d : ℕ) where
  lambda_pos : ℝ
  lambda_neg : ℝ
  char_pos : lambda_pos^2 - α * lambda_pos + 1 = 0
  char_neg : lambda_neg^2 - α * lambda_neg + 1 = 0
  product_one : lambda_pos * lambda_neg = 1
  dominant : lambda_pos > Real.exp d
  subdominant : 0 < lambda_neg ∧ lambda_neg < 1

/-- For Apéry's ζ(3) recurrence: `α = 34`, `λ+ = 17 + 12√2`. -/
noncomputable def apery3_PP
    (h_dom : (17 : ℝ) + 12 * Real.sqrt 2 > Real.exp 3) :
    PoincarePeron 34 3 where
  lambda_pos := 17 + 12 * Real.sqrt 2
  lambda_neg := 17 - 12 * Real.sqrt 2
  char_pos := by
    have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
    nlinarith [h2]
  char_neg := by
    have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
    nlinarith [h2]
  product_one := by
    have h2 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
    nlinarith [h2]
  dominant := h_dom
  subdominant := by
    constructor
    · have hlt : Real.sqrt 2 < (17 : ℝ) / 12 := by
        rw [Real.sqrt_lt' (by norm_num)]
        norm_num
      linarith
    · have hgt : (4 : ℝ) / 3 < Real.sqrt 2 := by
        exact Real.lt_sqrt_of_sq_lt (by norm_num)
      linarith

/-! ## The predicted form of `A₅(n)` -/

/-- The CMF-predicted form of the degree-5 coefficient polynomial. -/
def A5_form (Q P R : ℤ) (n : ℤ) : ℤ :=
  (2*n - 1) * (Q * n^2 * (n - 1)^2 + P * n * (n - 1) + R)

lemma A5_leading_coeff (Q P R n : ℤ) :
    A5_form Q P R n =
    2*Q*n^5 - 5*Q*n^4 + (4*Q + 2*P)*n^3 +
    (-Q - 3*P)*n^2 + (P + 2*R)*n - R := by
  simp [A5_form]
  ring

lemma A5_alpha_bound (Q : ℤ) (hQ : Q ≥ 75) : 2 * Q ≥ 150 := by
  linarith

/-! ## Predictions 4.1-4.4 -/

/-- Prediction 4.1: an Apéry-type proof for `ζ(5)` uses a degree-5 recurrence
with coefficient polynomial of the predicted form and `Q ≥ 75`. -/
def Prediction41 : Prop :=
  ∃ (rec : ThreeTermRec 5) (Q P R : ℤ), Q ≥ 75 ∧
    ∀ n : ℤ, rec.A n = A5_form Q P R n

/-- Prediction 4.2: the coefficient polynomial has the predicted form for some
parameters `Q, P, R`, with `Q ≥ 75`. -/
def Prediction42 : Prop :=
  ∃ (Q P R : ℤ), Q ≥ 75 ∧
    ∃ rec : ThreeTermRec 5, ∀ n : ℤ, rec.A n = A5_form Q P R n

/-- Prediction 4.3: for any `α ≥ 150`, the characteristic equation has a
dominant root greater than `e^5`. -/
def Prediction43 : Prop :=
  ∀ α : ℝ, α ≥ 150 →
    ∃ pp : PoincarePeron α 5, pp.lambda_pos > Real.exp 5

/-- A concrete numerical bound used in `Prediction43_holds`. -/
lemma exp5_lt_149 : Real.exp 5 < 149 := by
  have he_le : Real.exp 1 ≤ (2.7183 : ℝ) := by
    have h := Real.exp_bound' (x := (1 : ℝ)) (n := 12)
      (by norm_num) (by norm_num) (by norm_num)
    norm_num at h ⊢
    linarith
  have h5 : Real.exp 5 = Real.exp 1 ^ 5 := by
    simp
  rw [h5]
  have hpow : Real.exp 1 ^ 5 ≤ (2.7183 : ℝ)^5 := by
    exact pow_le_pow_left₀ (le_of_lt (Real.exp_pos 1)) he_le 5
  have hnum : (2.7183 : ℝ)^5 < 149 := by norm_num
  exact lt_of_le_of_lt hpow hnum

lemma Prediction43_holds : Prediction43 := by
  intro α hα
  have hdisc : α^2 - 4 ≥ 0 := by nlinarith
  have hsqrt_sq : Real.sqrt (α^2 - 4) ^ 2 = α^2 - 4 := Real.sq_sqrt hdisc
  have hsqrt_lt : Real.sqrt (α^2 - 4) < α := by
    rw [Real.sqrt_lt' (by linarith)]
    nlinarith
  have hsqrt_gt : α - 1 < Real.sqrt (α^2 - 4) := by
    rw [Real.lt_sqrt (by linarith)]
    nlinarith
  have hdominant : (α + Real.sqrt (α^2 - 4)) / 2 > Real.exp 5 := by
    have hlower : (α + Real.sqrt (α^2 - 4)) / 2 > α - 1 / 2 := by
      linarith
    have hαbound : α - 1 / 2 ≥ 149 := by
      linarith
    linarith [exp5_lt_149]
  refine ⟨{
    lambda_pos := (α + Real.sqrt (α^2 - 4)) / 2
    lambda_neg := (α - Real.sqrt (α^2 - 4)) / 2
    char_pos := by
      field_simp
      nlinarith [hsqrt_sq]
    char_neg := by
      field_simp
      nlinarith [hsqrt_sq]
    product_one := by
      field_simp
      nlinarith [hsqrt_sq]
    dominant := hdominant
    subdominant := by
      constructor <;> linarith
  }, hdominant⟩

/-- Prediction 4.4: `ζ(-4) = 0`, a trivial zero of the Riemann zeta function. -/
def Prediction44 : Prop :=
  riemannZeta (-4) = 0

lemma zeta_neg4_zero : Prediction44 := by
  have h := riemannZeta_neg_two_mul_nat_add_one 1
  norm_num at h
  exact h

/-! ## Computational search -/

/-- The searched parameter space:
`Q ∈ [75, 119]`, `P ∈ [-300, 300]`, `R ∈ [1, 60]`. -/
def SearchSpace : Finset (ℤ × ℤ × ℤ) :=
  (Finset.Icc 75 119 ×ˢ Finset.Icc (-300) 300 ×ˢ Finset.Icc 1 60).image
    (fun p => (p.1, p.2.1, p.2.2))

lemma search_space_bound :
    SearchSpace.card ≤ 45 * 601 * 60 := by
  apply le_trans Finset.card_image_le
  simp only [Finset.card_product]
  have h1 : (Finset.Icc (75 : ℤ) 119).card = 45 := by
    have h : ((Finset.Icc (75 : ℤ) 119).card : ℤ) = 45 := by
      rw [Int.card_Icc_of_le] <;> norm_num
    exact_mod_cast h
  have h2 : (Finset.Icc (-300 : ℤ) 300).card = 601 := by
    have h : ((Finset.Icc (-300 : ℤ) 300).card : ℤ) = 601 := by
      rw [Int.card_Icc_of_le] <;> norm_num
    exact_mod_cast h
  have h3 : (Finset.Icc (1 : ℤ) 60).card = 60 := by
    have h : ((Finset.Icc (1 : ℤ) 60).card : ℤ) = 60 := by
      rw [Int.card_Icc_of_le] <;> norm_num
    exact_mod_cast h
  rw [h1, h2, h3]

/-- The closest candidate reported by the computational search. -/
def closest_candidate : ℤ × ℤ × ℤ :=
  (75, -222, 27)

lemma closest_in_search_space : closest_candidate ∈ SearchSpace := by
  simp [SearchSpace, closest_candidate]
