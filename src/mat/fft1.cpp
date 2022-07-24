//
// File: fft1.cpp
//
// MATLAB Coder version            : 4.0
// C/C++ source code generated on  : 03-Apr-2022 17:54:13
//

// Include Files
#include <cmath>
#include "rt_nonfinite.h"
#include "test.h"
#include "fft1.h"
#include "test_emxutil.h"

// Function Definitions

//
// Arguments    : const emxArray_creal_T *x
//                int N2
//                int n1
//                const emxArray_real_T *costab
//                const emxArray_real_T *sintab
//                const emxArray_real_T *sintabinv
//                emxArray_creal_T *y
// Return Type  : void
//
void dobluesteinfft(const emxArray_creal_T *x, int N2, int n1, const
                    emxArray_real_T *costab, const emxArray_real_T *sintab,
                    const emxArray_real_T *sintabinv, emxArray_creal_T *y)
{
  emxArray_creal_T *wwc;
  int nInt2m1;
  int nInt2;
  int idx;
  int rt;
  int ihi;
  int istart;
  double twid_im;
  double twid_re;
  double r;
  double temp_im;
  double wwc_re;
  emxArray_creal_T *fy;
  double fv_im;
  int nRowsD2;
  int nRowsD4;
  int i;
  boolean_T tst;
  emxArray_creal_T *fv;
  double fv_re;
  double b_fv_im;
  emxInit_creal_T1(&wwc, 1);
  nInt2m1 = (n1 + n1) - 1;
  nInt2 = wwc->size[0];
  wwc->size[0] = nInt2m1;
  emxEnsureCapacity_creal_T1(wwc, nInt2);
  idx = n1;
  rt = 0;
  wwc->data[n1 - 1].re = 1.0;
  wwc->data[n1 - 1].im = 0.0;
  nInt2 = n1 << 1;
  for (ihi = 1; ihi < n1; ihi++) {
    istart = (ihi << 1) - 1;
    if (nInt2 - rt <= istart) {
      rt += istart - nInt2;
    } else {
      rt += istart;
    }

    twid_im = -3.1415926535897931 * (double)rt / (double)n1;
    if (twid_im == 0.0) {
      twid_re = 1.0;
      twid_im = 0.0;
    } else {
      twid_re = std::cos(twid_im);
      twid_im = std::sin(twid_im);
    }

    wwc->data[idx - 2].re = twid_re;
    wwc->data[idx - 2].im = -twid_im;
    idx--;
  }

  idx = 0;
  for (ihi = nInt2m1 - 1; ihi >= n1; ihi--) {
    wwc->data[ihi] = wwc->data[idx];
    idx++;
  }

  rt = x->size[0];
  if (n1 < rt) {
    rt = n1;
  }

  nInt2 = y->size[0];
  y->size[0] = n1;
  emxEnsureCapacity_creal_T1(y, nInt2);
  if (n1 > x->size[0]) {
    idx = y->size[0];
    nInt2 = y->size[0];
    y->size[0] = idx;
    emxEnsureCapacity_creal_T1(y, nInt2);
    for (nInt2 = 0; nInt2 < idx; nInt2++) {
      y->data[nInt2].re = 0.0;
      y->data[nInt2].im = 0.0;
    }
  }

  idx = 0;
  for (ihi = 0; ihi < rt; ihi++) {
    twid_re = wwc->data[(n1 + ihi) - 1].re;
    twid_im = wwc->data[(n1 + ihi) - 1].im;
    r = x->data[idx].re;
    temp_im = x->data[idx].im;
    wwc_re = x->data[idx].im;
    fv_im = x->data[idx].re;
    y->data[ihi].re = twid_re * r + twid_im * temp_im;
    y->data[ihi].im = twid_re * wwc_re - twid_im * fv_im;
    idx++;
  }

  while (rt + 1 <= n1) {
    y->data[rt].re = 0.0;
    y->data[rt].im = 0.0;
    rt++;
  }

  nInt2m1 = y->size[0];
  if (!(nInt2m1 < N2)) {
    nInt2m1 = N2;
  }

  emxInit_creal_T1(&fy, 1);
  nRowsD2 = N2 / 2;
  nRowsD4 = nRowsD2 / 2;
  nInt2 = fy->size[0];
  fy->size[0] = N2;
  emxEnsureCapacity_creal_T1(fy, nInt2);
  if (N2 > y->size[0]) {
    idx = fy->size[0];
    nInt2 = fy->size[0];
    fy->size[0] = idx;
    emxEnsureCapacity_creal_T1(fy, nInt2);
    for (nInt2 = 0; nInt2 < idx; nInt2++) {
      fy->data[nInt2].re = 0.0;
      fy->data[nInt2].im = 0.0;
    }
  }

  rt = 0;
  nInt2 = 0;
  idx = 0;
  for (i = 1; i < nInt2m1; i++) {
    fy->data[idx] = y->data[rt];
    idx = N2;
    tst = true;
    while (tst) {
      idx >>= 1;
      nInt2 ^= idx;
      tst = ((nInt2 & idx) == 0);
    }

    idx = nInt2;
    rt++;
  }

  fy->data[idx] = y->data[rt];
  if (N2 > 1) {
    for (i = 0; i <= N2 - 2; i += 2) {
      r = fy->data[i + 1].re;
      temp_im = fy->data[i + 1].im;
      fy->data[i + 1].re = fy->data[i].re - fy->data[i + 1].re;
      fy->data[i + 1].im = fy->data[i].im - fy->data[i + 1].im;
      fy->data[i].re += r;
      fy->data[i].im += temp_im;
    }
  }

  idx = 2;
  rt = 4;
  nInt2 = 1 + ((nRowsD4 - 1) << 2);
  while (nRowsD4 > 0) {
    for (i = 0; i < nInt2; i += rt) {
      r = fy->data[i + idx].re;
      temp_im = fy->data[i + idx].im;
      fy->data[i + idx].re = fy->data[i].re - r;
      fy->data[i + idx].im = fy->data[i].im - temp_im;
      fy->data[i].re += r;
      fy->data[i].im += temp_im;
    }

    istart = 1;
    for (nInt2m1 = nRowsD4; nInt2m1 < nRowsD2; nInt2m1 += nRowsD4) {
      twid_re = costab->data[nInt2m1];
      twid_im = sintab->data[nInt2m1];
      i = istart;
      ihi = istart + nInt2;
      while (i < ihi) {
        r = twid_re * fy->data[i + idx].re - twid_im * fy->data[i + idx].im;
        temp_im = twid_re * fy->data[i + idx].im + twid_im * fy->data[i + idx].
          re;
        fy->data[i + idx].re = fy->data[i].re - r;
        fy->data[i + idx].im = fy->data[i].im - temp_im;
        fy->data[i].re += r;
        fy->data[i].im += temp_im;
        i += rt;
      }

      istart++;
    }

    nRowsD4 /= 2;
    idx = rt;
    rt += rt;
    nInt2 -= idx;
  }

  emxInit_creal_T1(&fv, 1);
  r2br_r2dit_trig_impl(wwc, N2, costab, sintab, fv);
  nInt2 = fy->size[0];
  emxEnsureCapacity_creal_T1(fy, nInt2);
  idx = fy->size[0];
  for (nInt2 = 0; nInt2 < idx; nInt2++) {
    r = fy->data[nInt2].re;
    temp_im = fy->data[nInt2].im;
    fv_re = fv->data[nInt2].re;
    b_fv_im = fv->data[nInt2].im;
    fy->data[nInt2].re = r * fv_re - temp_im * b_fv_im;
    fy->data[nInt2].im = r * b_fv_im + temp_im * fv_re;
  }

  r2br_r2dit_trig_impl(fy, N2, costab, sintabinv, fv);
  emxFree_creal_T(&fy);
  if (fv->size[0] > 1) {
    r = 1.0 / (double)fv->size[0];
    nInt2 = fv->size[0];
    emxEnsureCapacity_creal_T1(fv, nInt2);
    idx = fv->size[0];
    for (nInt2 = 0; nInt2 < idx; nInt2++) {
      fv->data[nInt2].re *= r;
      fv->data[nInt2].im *= r;
    }
  }

  idx = 0;
  for (ihi = n1 - 1; ihi < wwc->size[0]; ihi++) {
    r = wwc->data[ihi].re;
    fv_re = fv->data[ihi].re;
    temp_im = wwc->data[ihi].im;
    b_fv_im = fv->data[ihi].im;
    wwc_re = wwc->data[ihi].re;
    fv_im = fv->data[ihi].im;
    twid_re = wwc->data[ihi].im;
    twid_im = fv->data[ihi].re;
    y->data[idx].re = r * fv_re + temp_im * b_fv_im;
    y->data[idx].im = wwc_re * fv_im - twid_re * twid_im;
    idx++;
  }

  emxFree_creal_T(&fv);
  emxFree_creal_T(&wwc);
}

//
// Arguments    : const emxArray_creal_T *x
//                int unsigned_nRows
//                const emxArray_real_T *costab
//                const emxArray_real_T *sintab
//                emxArray_creal_T *y
// Return Type  : void
//
void r2br_r2dit_trig_impl(const emxArray_creal_T *x, int unsigned_nRows, const
  emxArray_real_T *costab, const emxArray_real_T *sintab, emxArray_creal_T *y)
{
  int j;
  int nRowsD2;
  int nRowsD4;
  int iy;
  int iDelta;
  int ix;
  int ju;
  int i;
  boolean_T tst;
  double temp_re;
  double temp_im;
  double twid_re;
  double twid_im;
  int ihi;
  j = x->size[0];
  if (!(j < unsigned_nRows)) {
    j = unsigned_nRows;
  }

  nRowsD2 = unsigned_nRows / 2;
  nRowsD4 = nRowsD2 / 2;
  iy = y->size[0];
  y->size[0] = unsigned_nRows;
  emxEnsureCapacity_creal_T1(y, iy);
  if (unsigned_nRows > x->size[0]) {
    iDelta = y->size[0];
    iy = y->size[0];
    y->size[0] = iDelta;
    emxEnsureCapacity_creal_T1(y, iy);
    for (iy = 0; iy < iDelta; iy++) {
      y->data[iy].re = 0.0;
      y->data[iy].im = 0.0;
    }
  }

  ix = 0;
  ju = 0;
  iy = 0;
  for (i = 1; i < j; i++) {
    y->data[iy] = x->data[ix];
    iDelta = unsigned_nRows;
    tst = true;
    while (tst) {
      iDelta >>= 1;
      ju ^= iDelta;
      tst = ((ju & iDelta) == 0);
    }

    iy = ju;
    ix++;
  }

  y->data[iy] = x->data[ix];
  if (unsigned_nRows > 1) {
    for (i = 0; i <= unsigned_nRows - 2; i += 2) {
      temp_re = y->data[i + 1].re;
      temp_im = y->data[i + 1].im;
      y->data[i + 1].re = y->data[i].re - y->data[i + 1].re;
      y->data[i + 1].im = y->data[i].im - y->data[i + 1].im;
      y->data[i].re += temp_re;
      y->data[i].im += temp_im;
    }
  }

  iDelta = 2;
  iy = 4;
  ix = 1 + ((nRowsD4 - 1) << 2);
  while (nRowsD4 > 0) {
    for (i = 0; i < ix; i += iy) {
      temp_re = y->data[i + iDelta].re;
      temp_im = y->data[i + iDelta].im;
      y->data[i + iDelta].re = y->data[i].re - temp_re;
      y->data[i + iDelta].im = y->data[i].im - temp_im;
      y->data[i].re += temp_re;
      y->data[i].im += temp_im;
    }

    ju = 1;
    for (j = nRowsD4; j < nRowsD2; j += nRowsD4) {
      twid_re = costab->data[j];
      twid_im = sintab->data[j];
      i = ju;
      ihi = ju + ix;
      while (i < ihi) {
        temp_re = twid_re * y->data[i + iDelta].re - twid_im * y->data[i +
          iDelta].im;
        temp_im = twid_re * y->data[i + iDelta].im + twid_im * y->data[i +
          iDelta].re;
        y->data[i + iDelta].re = y->data[i].re - temp_re;
        y->data[i + iDelta].im = y->data[i].im - temp_im;
        y->data[i].re += temp_re;
        y->data[i].im += temp_im;
        i += iy;
      }

      ju++;
    }

    nRowsD4 /= 2;
    iDelta = iy;
    iy += iy;
    ix -= iDelta;
  }
}

//
// File trailer for fft1.cpp
//
// [EOF]
//
