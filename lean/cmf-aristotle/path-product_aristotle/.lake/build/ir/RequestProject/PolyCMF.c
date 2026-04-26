// Lean compiler output
// Module: RequestProject.PolyCMF
// Imports: public import Init public import Mathlib public import RequestProject.CMF public import RequestProject.PathProducts
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
lean_object* lp_mathlib_MvPolynomial_eval___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_toCMF___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_instCoeOutZZ(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_instCoeOutZZ___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PolyCMF_0__PolyCMF_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_toCMF(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_eval___redArg___lam__1(lean_object*, lean_object*, lean_object*);
lean_object* lp_mathlib_Ring_toAddGroupWithOne___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_eval(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_toCMF___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PolyCMF_0__PolyCMF_match__1_splitter___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PolyCMF_0__PolyCMF_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_toCMF___redArg___lam__0(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* lp_mathlib_Matrix_map(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PolyCMF_0__PolyCMF_match__1_splitter___redArg___boxed(lean_object*, lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_eval___redArg___lam__0(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_eval___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_eval___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_toCMF___redArg___lam__1(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_eval___redArg___lam__0___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_eval___redArg___lam__0(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; uint8_t x_6; 
x_5 = lean_unsigned_to_nat(0u);
x_6 = lean_nat_dec_eq(x_4, x_5);
if (x_6 == 1)
{
lean_object* x_7; 
lean_dec(x_3);
x_7 = lean_apply_1(x_1, x_2);
return x_7;
}
else
{
lean_object* x_8; lean_object* x_9; uint8_t x_10; lean_object* x_11; 
lean_dec(x_2);
x_8 = lean_unsigned_to_nat(1u);
x_9 = lean_nat_sub(x_4, x_8);
x_10 = lean_nat_dec_eq(x_9, x_5);
lean_dec(x_9);
x_11 = lean_apply_1(x_1, x_3);
return x_11;
}
}
}
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_eval___redArg___lam__0___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = lp_RequestProject_PolyCMF_eval___redArg___lam__0(x_1, x_2, x_3, x_4);
lean_dec(x_4);
return x_5;
}
}
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_eval___redArg___lam__1(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; lean_object* x_5; 
x_4 = lp_mathlib_MvPolynomial_eval___redArg(x_1, x_2);
x_5 = lean_apply_1(x_4, x_3);
return x_5;
}
}
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_eval___redArg(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; lean_object* x_6; lean_object* x_7; uint8_t x_8; 
lean_inc_ref(x_1);
x_5 = lp_mathlib_Ring_toAddGroupWithOne___redArg(x_1);
x_6 = lean_ctor_get(x_5, 0);
lean_inc(x_6);
lean_dec_ref(x_5);
x_7 = lean_ctor_get(x_1, 0);
lean_inc_ref(x_7);
lean_dec_ref(x_1);
x_8 = !lean_is_exclusive(x_2);
if (x_8 == 0)
{
lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; 
x_9 = lean_ctor_get(x_2, 0);
x_10 = lean_ctor_get(x_2, 1);
x_11 = lean_alloc_closure((void*)(lp_RequestProject_PolyCMF_eval___redArg___lam__0___boxed), 4, 3);
lean_closure_set(x_11, 0, x_6);
lean_closure_set(x_11, 1, x_3);
lean_closure_set(x_11, 2, x_4);
x_12 = lean_alloc_closure((void*)(lp_RequestProject_PolyCMF_eval___redArg___lam__1), 3, 2);
lean_closure_set(x_12, 0, x_7);
lean_closure_set(x_12, 1, x_11);
lean_inc_ref(x_12);
x_13 = lean_alloc_closure((void*)(lp_mathlib_Matrix_map), 8, 6);
lean_closure_set(x_13, 0, lean_box(0));
lean_closure_set(x_13, 1, lean_box(0));
lean_closure_set(x_13, 2, lean_box(0));
lean_closure_set(x_13, 3, lean_box(0));
lean_closure_set(x_13, 4, x_9);
lean_closure_set(x_13, 5, x_12);
x_14 = lean_alloc_closure((void*)(lp_mathlib_Matrix_map), 8, 6);
lean_closure_set(x_14, 0, lean_box(0));
lean_closure_set(x_14, 1, lean_box(0));
lean_closure_set(x_14, 2, lean_box(0));
lean_closure_set(x_14, 3, lean_box(0));
lean_closure_set(x_14, 4, x_10);
lean_closure_set(x_14, 5, x_12);
lean_ctor_set(x_2, 1, x_14);
lean_ctor_set(x_2, 0, x_13);
return x_2;
}
else
{
lean_object* x_15; lean_object* x_16; lean_object* x_17; lean_object* x_18; lean_object* x_19; lean_object* x_20; lean_object* x_21; 
x_15 = lean_ctor_get(x_2, 0);
x_16 = lean_ctor_get(x_2, 1);
lean_inc(x_16);
lean_inc(x_15);
lean_dec(x_2);
x_17 = lean_alloc_closure((void*)(lp_RequestProject_PolyCMF_eval___redArg___lam__0___boxed), 4, 3);
lean_closure_set(x_17, 0, x_6);
lean_closure_set(x_17, 1, x_3);
lean_closure_set(x_17, 2, x_4);
x_18 = lean_alloc_closure((void*)(lp_RequestProject_PolyCMF_eval___redArg___lam__1), 3, 2);
lean_closure_set(x_18, 0, x_7);
lean_closure_set(x_18, 1, x_17);
lean_inc_ref(x_18);
x_19 = lean_alloc_closure((void*)(lp_mathlib_Matrix_map), 8, 6);
lean_closure_set(x_19, 0, lean_box(0));
lean_closure_set(x_19, 1, lean_box(0));
lean_closure_set(x_19, 2, lean_box(0));
lean_closure_set(x_19, 3, lean_box(0));
lean_closure_set(x_19, 4, x_15);
lean_closure_set(x_19, 5, x_18);
x_20 = lean_alloc_closure((void*)(lp_mathlib_Matrix_map), 8, 6);
lean_closure_set(x_20, 0, lean_box(0));
lean_closure_set(x_20, 1, lean_box(0));
lean_closure_set(x_20, 2, lean_box(0));
lean_closure_set(x_20, 3, lean_box(0));
lean_closure_set(x_20, 4, x_16);
lean_closure_set(x_20, 5, x_18);
x_21 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_21, 0, x_19);
lean_ctor_set(x_21, 1, x_20);
return x_21;
}
}
}
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_eval(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
lean_object* x_7; 
x_7 = lp_RequestProject_PolyCMF_eval___redArg(x_2, x_4, x_5, x_6);
return x_7;
}
}
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_eval___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
lean_object* x_7; 
x_7 = lp_RequestProject_PolyCMF_eval(x_1, x_2, x_3, x_4, x_5, x_6);
lean_dec(x_3);
return x_7;
}
}
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PolyCMF_0__PolyCMF_match__1_splitter___redArg(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; uint8_t x_5; 
x_4 = lean_unsigned_to_nat(0u);
x_5 = lean_nat_dec_eq(x_1, x_4);
if (x_5 == 1)
{
lean_object* x_6; lean_object* x_7; 
lean_dec(x_3);
x_6 = lean_box(0);
x_7 = lean_apply_1(x_2, x_6);
return x_7;
}
else
{
lean_object* x_8; lean_object* x_9; uint8_t x_10; lean_object* x_11; lean_object* x_12; 
lean_dec(x_2);
x_8 = lean_unsigned_to_nat(1u);
x_9 = lean_nat_sub(x_1, x_8);
x_10 = lean_nat_dec_eq(x_9, x_4);
lean_dec(x_9);
x_11 = lean_box(0);
x_12 = lean_apply_1(x_3, x_11);
return x_12;
}
}
}
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PolyCMF_0__PolyCMF_match__1_splitter___redArg___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = lp_RequestProject___private_RequestProject_PolyCMF_0__PolyCMF_match__1_splitter___redArg(x_1, x_2, x_3);
lean_dec(x_1);
return x_4;
}
}
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PolyCMF_0__PolyCMF_match__1_splitter(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = lp_RequestProject___private_RequestProject_PolyCMF_0__PolyCMF_match__1_splitter___redArg(x_2, x_3, x_4);
return x_5;
}
}
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PolyCMF_0__PolyCMF_match__1_splitter___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = lp_RequestProject___private_RequestProject_PolyCMF_0__PolyCMF_match__1_splitter(x_1, x_2, x_3, x_4);
lean_dec(x_2);
return x_5;
}
}
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_toCMF___redArg___lam__0(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5) {
_start:
{
lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; 
x_6 = lean_ctor_get(x_3, 0);
lean_inc(x_6);
x_7 = lean_ctor_get(x_3, 1);
lean_inc(x_7);
lean_dec_ref(x_3);
x_8 = lp_RequestProject_PolyCMF_eval___redArg(x_1, x_2, x_6, x_7);
x_9 = lean_ctor_get(x_8, 0);
lean_inc(x_9);
lean_dec_ref(x_8);
x_10 = lean_apply_2(x_9, x_4, x_5);
return x_10;
}
}
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_toCMF___redArg___lam__1(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5) {
_start:
{
lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; 
x_6 = lean_ctor_get(x_3, 0);
lean_inc(x_6);
x_7 = lean_ctor_get(x_3, 1);
lean_inc(x_7);
lean_dec_ref(x_3);
x_8 = lp_RequestProject_PolyCMF_eval___redArg(x_1, x_2, x_6, x_7);
x_9 = lean_ctor_get(x_8, 1);
lean_inc(x_9);
lean_dec_ref(x_8);
x_10 = lean_apply_2(x_9, x_4, x_5);
return x_10;
}
}
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_toCMF___redArg(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; lean_object* x_4; lean_object* x_5; 
lean_inc_ref(x_2);
lean_inc_ref(x_1);
x_3 = lean_alloc_closure((void*)(lp_RequestProject_PolyCMF_toCMF___redArg___lam__0), 5, 2);
lean_closure_set(x_3, 0, x_1);
lean_closure_set(x_3, 1, x_2);
x_4 = lean_alloc_closure((void*)(lp_RequestProject_PolyCMF_toCMF___redArg___lam__1), 5, 2);
lean_closure_set(x_4, 0, x_1);
lean_closure_set(x_4, 1, x_2);
x_5 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_5, 0, x_3);
lean_ctor_set(x_5, 1, x_4);
return x_5;
}
}
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_toCMF(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = lp_RequestProject_PolyCMF_toCMF___redArg(x_2, x_4);
return x_5;
}
}
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_toCMF___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = lp_RequestProject_PolyCMF_toCMF(x_1, x_2, x_3, x_4);
lean_dec(x_3);
return x_5;
}
}
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_instCoeOutZZ___redArg(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = lean_alloc_closure((void*)(lp_RequestProject_PolyCMF_toCMF___boxed), 4, 3);
lean_closure_set(x_3, 0, lean_box(0));
lean_closure_set(x_3, 1, x_1);
lean_closure_set(x_3, 2, x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* lp_RequestProject_PolyCMF_instCoeOutZZ(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = lean_alloc_closure((void*)(lp_RequestProject_PolyCMF_toCMF___boxed), 4, 3);
lean_closure_set(x_4, 0, lean_box(0));
lean_closure_set(x_4, 1, x_2);
lean_closure_set(x_4, 2, x_3);
return x_4;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_mathlib_Mathlib(uint8_t builtin);
lean_object* initialize_RequestProject_RequestProject_CMF(uint8_t builtin);
lean_object* initialize_RequestProject_RequestProject_PathProducts(uint8_t builtin);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_RequestProject_RequestProject_PolyCMF(uint8_t builtin) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_mathlib_Mathlib(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_RequestProject_RequestProject_CMF(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_RequestProject_RequestProject_PathProducts(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
