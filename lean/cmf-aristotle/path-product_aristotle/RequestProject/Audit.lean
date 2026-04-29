/-
# CMF Formalization Project
Repository: https://github.com/Loublain/cmf-gaussian-primes
All theorems machine-verified in Lean 4 / Mathlib4.
Axioms: propext, Classical.choice, Quot.sound only.
-/

import RequestProject.CMF
import RequestProject.PathProducts
import RequestProject.PathIndep
import RequestProject.PolyCMF
import RequestProject.SuperCMF
import RequestProject.PauliCMF
import RequestProject.ZetaPairs
import RequestProject.Recurrence

/-!
# Axiom Audit

This file contains no proofs. Its sole purpose is to enumerate
the axioms every main theorem depends on, for use by the CI
axiom checker in the pre-push git hook.

Allowed axioms (standard Mathlib baseline):
  - propext
  - Classical.choice
  - Quot.sound

Any axiom outside this list is a build failure.

Update this file whenever a new main theorem is added.
-/

-- CMF.lean
#print axioms CMF.ZZ

-- PathProducts.lean
#print axioms CMF.pathProd_append
#print axioms CMF.pathEnd_append
#print axioms CMF.pathEnd_eq_start_add_counts

-- PathIndep.lean
#print axioms pathIndep

-- PolyCMF.lean
-- Note: PolyCMF.toCMF exists but pathIndep is inherited via pathIndep
#print axioms PolyCMF.toCMF

-- SuperCMF.lean
#print axioms AntiCMF.anti_eq
#print axioms AntiCMF.two_step_closure
#print axioms SuperCMF.S_eq_zero
#print axioms SuperCMF.T_eq_zero

-- PauliCMF.lean
#print axioms pauliAntiCMF
#print axioms S_plus_T_c1
#print axioms not_comm_c1

-- ZetaPairs.lean
#print axioms ZetaPair.fromSuper
#print axioms AntiCMF.sign_flip
#print axioms AntiCMF.sign_flip_add
#print axioms AntiCMF.sq_symmetric

-- Recurrence.lean
#print axioms apery3_A
#print axioms A5_form
#print axioms A5_leading_coeff
#print axioms A5_alpha_bound
#print axioms exp5_lt_149
#print axioms Prediction43_holds
#print axioms zeta_neg4_zero
#print axioms closest_in_search_space
