// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// rcpp_hello_world
List rcpp_hello_world();
RcppExport SEXP _VAFclusterEM_rcpp_hello_world() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(rcpp_hello_world());
    return rcpp_result_gen;
END_RCPP
}
// ReadParentVector
string ReadParentVector(string file_path, size_t mutation_count);
RcppExport SEXP _VAFclusterEM_ReadParentVector(SEXP file_pathSEXP, SEXP mutation_countSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< string >::type file_path(file_pathSEXP);
    Rcpp::traits::input_parameter< size_t >::type mutation_count(mutation_countSEXP);
    rcpp_result_gen = Rcpp::wrap(ReadParentVector(file_path, mutation_count));
    return rcpp_result_gen;
END_RCPP
}
// GetChains
NumericVector GetChains(NumericVector parent_vector);
RcppExport SEXP _VAFclusterEM_GetChains(SEXP parent_vectorSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type parent_vector(parent_vectorSEXP);
    rcpp_result_gen = Rcpp::wrap(GetChains(parent_vector));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_VAFclusterEM_rcpp_hello_world", (DL_FUNC) &_VAFclusterEM_rcpp_hello_world, 0},
    {"_VAFclusterEM_ReadParentVector", (DL_FUNC) &_VAFclusterEM_ReadParentVector, 2},
    {"_VAFclusterEM_GetChains", (DL_FUNC) &_VAFclusterEM_GetChains, 1},
    {NULL, NULL, 0}
};

RcppExport void R_init_VAFclusterEM(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
