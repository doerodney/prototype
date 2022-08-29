#ifndef INC_MATRIX_H
#define INC_MATRIX_H

#define MATRIX_NO_ERR 0
#define MATRIX_MEMORY_ERR 1
#define MATRIX_NULL_ARG 2
#define MATRIX_DATA_NOT_SQUARE 3
#define MATRIX_UNEQUAL_ROW_COUNTS 4
#define MATRIX_INVALID_COLUMN_COUNT 5

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

void matrix_load_by_row(Matrix *m, double in[]);

void matrix_set_value(Matrix *p, int row, int col, double value);

int matrix_solve_simeq(const Matrix *a, const Matrix* x, Matrix *b);

#define MATRIX_LOAD_BY_COLUMN(mtrx, ...) matrix_load_by_column(mtrx, (double[]) {__VA_ARGS__, NAN})

#define MATRIX_LOAD_BY_ROW(mtrx, ...) matrix_load_by_row(mtrx, (double[]) {__VA_ARGS__, NAN})

#endif


