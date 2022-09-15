#include <stdlib.h>
#include <math.h>

#include "matrix.h"
#include "matrix_test.h"

static const double epsilon = 0.001;

int dcmp(double a, double b) {
  int result = (a < b) ? -1 : 1;

  if (fabs(a - b) < epsilon) {
    result = 0;
  }

  return result;
}


void TestIsSingular() {
  int nrows = 3, ncols = 3;
  Matrix *a = matrix_new(nrows, ncols);
  MATRIX_LOAD_BY_ROW(a, 0, 0, 0, 1, 1, 1, 2, 2, 2);
  int isSingular = matrix_test_singular(a);
  if (!isSingular) {
    exit(1);
  }
}

void TestIsNotSingular() {
  int nrows = 3, ncols = 3;
  Matrix *a = matrix_new(nrows, ncols);
  MATRIX_LOAD_BY_ROW(a, 6, 1, 1, 4, -2, 5, 2, 8, 7);
  int isSingular = matrix_test_singular(a);
  if (isSingular) {
    exit(1);
  }
}

void TestDeterminantOfNonSquareMatrix() {
  int nrows = 2, ncols = 3;
  Matrix *a = matrix_new(nrows, ncols);
  MATRIX_LOAD_BY_ROW(a, 6, 1, 1, 4, -2, 5);
  double det = 0.0;
  int failure = matrix_get_determinant(a, &det);
  matrix_free(&a);

  if (failure != MATRIX_DATA_NOT_SQUARE) {
    exit(1);
  }
}

void TestDeterminantOfEmptyMatrix() {
  int nrows = 0, ncols = 0;
  double det = 0.0;
  Matrix *a = matrix_new(nrows, ncols);
  int failure = matrix_get_determinant(a, &det);

  if (failure != MATRIX_NULL_POINTER) {
    exit(1);
  }
}


void TestDeterminantOfValidMatrix() {
  int nrows = 0, ncols = 0;
  double det = 0.0;
  double target = -306;
  Matrix *a = matrix_new(nrows, ncols);
  MATRIX_LOAD_BY_ROW(a, 6, 1, 1, 4, -2, 5, 2, 8, 7);
  int failure = matrix_get_determinant(a, &det);

  if (failure != MATRIX_NO_ERR) {
    exit(1);
  }

  if (dcmp(det, target)) {
    exit(1);
  }

}
