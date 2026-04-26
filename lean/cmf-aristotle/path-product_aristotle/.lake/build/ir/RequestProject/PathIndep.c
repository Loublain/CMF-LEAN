// Lean compiler output
// Module: RequestProject.PathIndep
// Imports: public import Init public import RequestProject.CMF public import RequestProject.PathProducts
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
LEAN_EXPORT lean_object* lp_RequestProject_canonPath(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PathIndep_0__CMF_foldGen_match__1_splitter___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_List_replicateTR___redArg(lean_object*, lean_object*);
lean_object* l_List_appendTR___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PathIndep_0__CMF_foldGen_match__1_splitter___redArg(uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PathIndep_0__CMF_foldGen_match__1_splitter(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PathIndep_0__CMF_foldGen_match__1_splitter___redArg___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_RequestProject_canonPath(lean_object* x_1, lean_object* x_2) {
_start:
{
uint8_t x_3; lean_object* x_4; lean_object* x_5; uint8_t x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; 
x_3 = 0;
x_4 = lean_box(x_3);
x_5 = l_List_replicateTR___redArg(x_1, x_4);
x_6 = 1;
x_7 = lean_box(x_6);
x_8 = l_List_replicateTR___redArg(x_2, x_7);
x_9 = l_List_appendTR___redArg(x_5, x_8);
return x_9;
}
}
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PathIndep_0__CMF_foldGen_match__1_splitter___redArg(uint8_t x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
if (x_1 == 0)
{
lean_object* x_4; lean_object* x_5; 
lean_dec(x_3);
x_4 = lean_box(0);
x_5 = lean_apply_1(x_2, x_4);
return x_5;
}
else
{
lean_object* x_6; lean_object* x_7; 
lean_dec(x_2);
x_6 = lean_box(0);
x_7 = lean_apply_1(x_3, x_6);
return x_7;
}
}
}
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PathIndep_0__CMF_foldGen_match__1_splitter___redArg___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
uint8_t x_4; lean_object* x_5; 
x_4 = lean_unbox(x_1);
x_5 = lp_RequestProject___private_RequestProject_PathIndep_0__CMF_foldGen_match__1_splitter___redArg(x_4, x_2, x_3);
return x_5;
}
}
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PathIndep_0__CMF_foldGen_match__1_splitter(lean_object* x_1, uint8_t x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = lp_RequestProject___private_RequestProject_PathIndep_0__CMF_foldGen_match__1_splitter___redArg(x_2, x_3, x_4);
return x_5;
}
}
LEAN_EXPORT lean_object* lp_RequestProject___private_RequestProject_PathIndep_0__CMF_foldGen_match__1_splitter___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
uint8_t x_5; lean_object* x_6; 
x_5 = lean_unbox(x_2);
x_6 = lp_RequestProject___private_RequestProject_PathIndep_0__CMF_foldGen_match__1_splitter(x_1, x_5, x_3, x_4);
return x_6;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_RequestProject_RequestProject_CMF(uint8_t builtin);
lean_object* initialize_RequestProject_RequestProject_PathProducts(uint8_t builtin);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_RequestProject_RequestProject_PathIndep(uint8_t builtin) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(builtin);
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
