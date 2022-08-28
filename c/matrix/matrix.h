#ifndef INC_MATRIX_H
#define INC_MATRIX_H

#define MATRIX_NO_ERR 0
#define MATRIX_MEMORY_ERR 1
#define MATRIX_NULL_ARG 2

typedef struct {
  int nrows;
  int ncols;
  double *data;

} Matrix;



Matrix* matrix_new(int nrows, int ncols);

Matrix* matrix_copy(const Matrix* src);

double matrix_determinant(const Matrix* m);

void matrix_free(Matrix **p);

#endif


