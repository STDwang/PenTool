//
// File: test.cpp
//
// MATLAB Coder version            : 4.0
// C/C++ source code generated on  : 03-Apr-2022 17:54:13
//

// Include Files
#include <cmath>
#include "rt_nonfinite.h"
#include "test.h"
#include "test_emxutil.h"
#include "fft1.h"

// Function Definitions

//
// Arguments    : const emxArray_real_T *Id1
//                const emxArray_real_T *Qd1
//                emxArray_creal_T *fp
// Return Type  : void
//
void test(const emxArray_real_T *Id1, const emxArray_real_T *Qd1,
          emxArray_creal_T *fp)
{
  emxArray_creal_T *x;
  int pmin;
  int nn1m1;
  emxArray_creal_T *b_y1;
  emxArray_real_T *costab1q;
  emxArray_real_T *costab;
  emxArray_real_T *sintab;
  emxArray_real_T *sintabinv;
  boolean_T useRadix2;
  int N2blue;
  int pmax;
  double e;
  boolean_T exitg1;
  int pow2p;
  int b_x[1];
  int c_x[1];
  emxArray_creal_T d_x;
  emxInit_creal_T(&x, 2);

  //  fft
  pmin = x->size[0] * x->size[1];
  x->size[0] = 1;
  x->size[1] = Id1->size[1];
  emxEnsureCapacity_creal_T(x, pmin);
  nn1m1 = Id1->size[0] * Id1->size[1];
  for (pmin = 0; pmin < nn1m1; pmin++) {
    x->data[pmin].re = Id1->data[pmin] + 0.0 * Qd1->data[pmin];
    x->data[pmin].im = Qd1->data[pmin];
  }

  emxInit_creal_T1(&b_y1, 1);
  emxInit_real_T(&costab1q, 2);
  emxInit_real_T(&costab, 2);
  emxInit_real_T(&sintab, 2);
  emxInit_real_T(&sintabinv, 2);
  if (x->size[1] == 0) {
    nn1m1 = x->size[1];
    pmin = b_y1->size[0];
    b_y1->size[0] = nn1m1;
    emxEnsureCapacity_creal_T1(b_y1, pmin);
  } else {
    useRadix2 = ((x->size[1] & (x->size[1] - 1)) == 0);
    N2blue = 1;
    if (useRadix2) {
      nn1m1 = x->size[1];
    } else {
      nn1m1 = (x->size[1] + x->size[1]) - 1;
      pmax = 31;
      if (nn1m1 <= 1) {
        pmax = 0;
      } else {
        pmin = 0;
        exitg1 = false;
        while ((!exitg1) && (pmax - pmin > 1)) {
          N2blue = (pmin + pmax) >> 1;
          pow2p = 1 << N2blue;
          if (pow2p == nn1m1) {
            pmax = N2blue;
            exitg1 = true;
          } else if (pow2p > nn1m1) {
            pmax = N2blue;
          } else {
            pmin = N2blue;
          }
        }
      }

      N2blue = 1 << pmax;
      nn1m1 = N2blue;
    }

    e = 6.2831853071795862 / (double)nn1m1;
    pmax = nn1m1 / 2 / 2;
    pmin = costab1q->size[0] * costab1q->size[1];
    costab1q->size[0] = 1;
    costab1q->size[1] = pmax + 1;
    emxEnsureCapacity_real_T(costab1q, pmin);
    costab1q->data[0] = 1.0;
    nn1m1 = pmax / 2;
    for (pmin = 1; pmin <= nn1m1; pmin++) {
      costab1q->data[pmin] = std::cos(e * (double)pmin);
    }

    for (pmin = nn1m1 + 1; pmin < pmax; pmin++) {
      costab1q->data[pmin] = std::sin(e * (double)(pmax - pmin));
    }

    costab1q->data[pmax] = 0.0;
    if (!useRadix2) {
      nn1m1 = costab1q->size[1] - 1;
      pmax = (costab1q->size[1] - 1) << 1;
      pmin = costab->size[0] * costab->size[1];
      costab->size[0] = 1;
      costab->size[1] = pmax + 1;
      emxEnsureCapacity_real_T(costab, pmin);
      pmin = sintab->size[0] * sintab->size[1];
      sintab->size[0] = 1;
      sintab->size[1] = pmax + 1;
      emxEnsureCapacity_real_T(sintab, pmin);
      costab->data[0] = 1.0;
      sintab->data[0] = 0.0;
      pmin = sintabinv->size[0] * sintabinv->size[1];
      sintabinv->size[0] = 1;
      sintabinv->size[1] = pmax + 1;
      emxEnsureCapacity_real_T(sintabinv, pmin);
      for (pmin = 1; pmin <= nn1m1; pmin++) {
        sintabinv->data[pmin] = costab1q->data[nn1m1 - pmin];
      }

      for (pmin = costab1q->size[1]; pmin <= pmax; pmin++) {
        sintabinv->data[pmin] = costab1q->data[pmin - nn1m1];
      }

      for (pmin = 1; pmin <= nn1m1; pmin++) {
        costab->data[pmin] = costab1q->data[pmin];
        sintab->data[pmin] = -costab1q->data[nn1m1 - pmin];
      }

      for (pmin = costab1q->size[1]; pmin <= pmax; pmin++) {
        costab->data[pmin] = -costab1q->data[pmax - pmin];
        sintab->data[pmin] = -costab1q->data[pmin - nn1m1];
      }
    } else {
      nn1m1 = costab1q->size[1] - 1;
      pmax = (costab1q->size[1] - 1) << 1;
      pmin = costab->size[0] * costab->size[1];
      costab->size[0] = 1;
      costab->size[1] = pmax + 1;
      emxEnsureCapacity_real_T(costab, pmin);
      pmin = sintab->size[0] * sintab->size[1];
      sintab->size[0] = 1;
      sintab->size[1] = pmax + 1;
      emxEnsureCapacity_real_T(sintab, pmin);
      costab->data[0] = 1.0;
      sintab->data[0] = 0.0;
      for (pmin = 1; pmin <= nn1m1; pmin++) {
        costab->data[pmin] = costab1q->data[pmin];
        sintab->data[pmin] = -costab1q->data[nn1m1 - pmin];
      }

      for (pmin = costab1q->size[1]; pmin <= pmax; pmin++) {
        costab->data[pmin] = -costab1q->data[pmax - pmin];
        sintab->data[pmin] = -costab1q->data[pmin - nn1m1];
      }

      pmin = sintabinv->size[0] * sintabinv->size[1];
      sintabinv->size[0] = 1;
      sintabinv->size[1] = 0;
      emxEnsureCapacity_real_T(sintabinv, pmin);
    }

    if (useRadix2) {
      c_x[0] = x->size[1];
      d_x = *x;
      d_x.size = (int *)&c_x;
      d_x.numDimensions = 1;
      r2br_r2dit_trig_impl(&d_x, x->size[1], costab, sintab, b_y1);
    } else {
      b_x[0] = x->size[1];
      d_x = *x;
      d_x.size = (int *)&b_x;
      d_x.numDimensions = 1;
      dobluesteinfft(&d_x, N2blue, x->size[1], costab, sintab, sintabinv, b_y1);
    }
  }

  emxFree_real_T(&sintabinv);
  emxFree_real_T(&sintab);
  emxFree_real_T(&costab);
  emxFree_real_T(&costab1q);
  pmin = fp->size[0] * fp->size[1];
  fp->size[0] = 1;
  fp->size[1] = x->size[1];
  emxEnsureCapacity_creal_T(fp, pmin);
  nn1m1 = x->size[1];
  emxFree_creal_T(&x);
  for (pmin = 0; pmin < nn1m1; pmin++) {
    fp->data[pmin] = b_y1->data[pmin];
  }

  emxFree_creal_T(&b_y1);
}

//
// File trailer for test.cpp
//
// [EOF]
//
