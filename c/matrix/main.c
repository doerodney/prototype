#include <stdio.h>
#include "matrix.h"


int main(int argc, char *argv[]) {
  int ncols = 3, nrows = 3;
  
  Matrix* a = matrix_new(nrows, ncols);
 
  MATRIX_LOAD_BY_ROW(a, 1.0, 1.0, 1.0, 2.0, 3.0, 4.0, 0.0, 1.0, 2.0);

  double det = matrix_get_determinant(a);

  printf("Determinant: %g\n", det);


  return 0;
}
