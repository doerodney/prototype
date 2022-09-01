#include <stdio.h>
#include "matrix.h"


int main(int argc, char *argv[]) {
  int ncols = 3, nrows = 3;
  
  Matrix* a = matrix_new(nrows, ncols);
 
  // From https://www.mathsisfun.com/algebra/matrix-determinant.html
  MATRIX_LOAD_BY_ROW(a, 6.0, 1.0, 1.0, 4.0, -2.0, 5.0, 2.0, 8.0, 7.0);
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


  return 0;
}
