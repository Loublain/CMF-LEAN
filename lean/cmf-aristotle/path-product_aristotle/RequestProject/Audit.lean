import RequestProject.CMF
import RequestProject.PathProducts
import RequestProject.PathIndep
import RequestProject.PolyCMF
import RequestProject.SuperCMF
import RequestProject.PauliCMF

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
