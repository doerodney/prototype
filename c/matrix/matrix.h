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

double matrix_get_determinant(const Matrix* p);

void matrix_free(Matrix **pp);

double matrix_get_value(const Matrix *p, int row, int col);

void matrix_set_value(Matrix *p, int row, int col, double value);

void matrix_solve_simeq(const Matrix *a, Matrix* x, const Matrix *b);

#endif


