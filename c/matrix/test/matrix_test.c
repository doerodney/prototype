#include "../src/matrix.h"
#include <stdlib.h>

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
