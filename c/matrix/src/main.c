#include <stdio.h>
#include "matrix.h"


int main(int argc, char *argv[]) {
  int ncols = 3, nrows = 3;
  
  Matrix* a = matrix_new(nrows, ncols);
 
  // From https://www.mathsisfun.com/algebra/matrix-determinant.html
  MATRIX_LOAD_BY_ROW(a, 6, 1, 1, 4, -2, 5, 2, 8, 7);
  // D = -306

  printf("MATRIX_LOAD_BY_ROW(a, 6, 1, 1, 4, -2, 5, 2, 8, 7)\n");

  double n = 0.0;
  for (int row = 0; row < nrows; row++) {
      for (int col = 0; col < ncols; col++) {
        n = matrix_get_value(a, row, col);
        printf("Value at (%d, %d) is %2g\n", row, col, n);
      }
  }

  double det = matrix_get_determinant(a);

  printf("Determinant: %g\n", det);

  Matrix *b = matrix_new(nrows, 1);
  MATRIX_LOAD_BY_COLUMN(b, 21, 44, 112);

  printf("\nMATRIX_LOAD_BY_COLUMN(b, 21, 44, 112)\n");

  for (int row = 0, col = 0; row < nrows; row++) {
      n = matrix_get_value(b, row, col);
      printf("Value at (%d, %d) is %2g\n", row, col, n);
  }


  Matrix *x = matrix_new(nrows, 1);
  #ifdef NOT_YET
  int failure = matrix_solve_simeq(a, x, b);

  printf("\nSolution error: %d\n", failure);

  for (int row = 0, col = 0; row < nrows; row++) {
      n = matrix_get_value(x, row, col);
      printf("Value at (%d, %d) is %2g\n", row, col, n);
  }
  #endif

  matrix_free(&a);
  matrix_free(&x);
  matrix_free(&b);
  
  return 0;
}
