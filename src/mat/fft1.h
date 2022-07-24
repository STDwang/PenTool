//
// File: fft1.h
//
// MATLAB Coder version            : 4.0
// C/C++ source code generated on  : 03-Apr-2022 17:54:13
//
#ifndef FFT1_H
#define FFT1_H

// Include Files
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "test_types.h"

// Function Declarations
extern void dobluesteinfft(const emxArray_creal_T *x, int N2, int n1, const
  emxArray_real_T *costab, const emxArray_real_T *sintab, const emxArray_real_T *
  sintabinv, emxArray_creal_T *y);
extern void r2br_r2dit_trig_impl(const emxArray_creal_T *x, int unsigned_nRows,
  const emxArray_real_T *costab, const emxArray_real_T *sintab, emxArray_creal_T
  *y);

#endif

//
// File trailer for fft1.h
//
// [EOF]
//
