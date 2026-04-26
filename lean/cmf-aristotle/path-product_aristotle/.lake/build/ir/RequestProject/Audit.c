// Lean compiler output
// Module: RequestProject.Audit
// Imports: public import Init public import RequestProject.CMF public import RequestProject.PathProducts public import RequestProject.PathIndep public import RequestProject.PolyCMF public import RequestProject.SuperCMF public import RequestProject.PauliCMF
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
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_RequestProject_RequestProject_CMF(uint8_t builtin);
lean_object* initialize_RequestProject_RequestProject_PathProducts(uint8_t builtin);
lean_object* initialize_RequestProject_RequestProject_PathIndep(uint8_t builtin);
lean_object* initialize_RequestProject_RequestProject_PolyCMF(uint8_t builtin);
lean_object* initialize_RequestProject_RequestProject_SuperCMF(uint8_t builtin);
lean_object* initialize_RequestProject_RequestProject_PauliCMF(uint8_t builtin);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_RequestProject_RequestProject_Audit(uint8_t builtin) {
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
res = initialize_RequestProject_RequestProject_PathIndep(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_RequestProject_RequestProject_PolyCMF(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_RequestProject_RequestProject_SuperCMF(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_RequestProject_RequestProject_PauliCMF(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
