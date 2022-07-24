//
// File: test_types.h
//
// MATLAB Coder version            : 4.0
// C/C++ source code generated on  : 03-Apr-2022 17:54:13
//
#ifndef TEST_TYPES_H
#define TEST_TYPES_H

// Include Files
#include "rtwtypes.h"

// Type Definitions
typedef struct {
  creal_T *data;
  int *size;
  int allocatedSize;
  int numDimensions;
  boolean_T canFreeData;
} emxArray_creal_T;

#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  double *data;
  int *size;
  int allocatedSize;
  int numDimensions;
  boolean_T canFreeData;
};

#endif                                 //struct_emxArray_real_T
#endif

//
// File trailer for test_types.h
//
// [EOF]
//
