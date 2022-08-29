#include <stdlib.h>
#include <string.h>
#include "matrix.h"

int fixColumnIndex(const Matrix *m, int idx);
Matrix* getColumnContent(const Matrix *src, int col);
int getDatumIndex(const Matrix *m, int row, int col);



Matrix* matrix_new(int nrows, int ncols) {
  Matrix  *p = NULL;
  // Allocate memory for the data:
  double *pd = calloc((size_t)(nrows * ncols), sizeof(*pd));

  // Allocate memory for the matrix: 
  if (pd) {
    p = malloc(sizeof(Matrix));

    if (p) {
      p->nrows = nrows;
      p->ncols = ncols;
      p->data = pd;
    }
    else {
      free((void*) pd);
    }
  }

  return p;
}


Matrix* matrix_copy(const Matrix* src)
{
  Matrix *dest = matrix_new(src->nrows, src->ncols);
  if (dest) {
    memcpy((void *) dest->data, (void * ) src->data, src->nrows * src->ncols * sizeof(src->data[0]));
  }

  return dest;
}

double matrix_get_determinant(const Matrix* m) {
  double det = 0;
  // START HERE:


}


void matrix_free(Matrix **pp) {
  Matrix *pm = *pp;
  if (pm) {
    // Free data storage:
    if (pm->data) {
      free(pm->data);
    }

    // Free struct storage:
    free(*pp);

    // Set pointer to NULL:
    *pp = NULL;
  } 
}


double matrix_get_value(const Matrix *p, int row, int col) {
  int idx = getDatumIndex(p, row, col);

  double value = p->data[idx];

  return value;
}


void matrix_set_value(Matrix *p, int row, int col, double value) {
  int idx = getDatumIndex(p, row, col);

  p->data[idx] = value;
}


int fixColumnIndex(const Matrix *m, int idx) {
  int fixed = idx;
  while (fixed >= m->ncols) {
    fixed -= m->ncols;
  }
  while (fixed < 0) {
    fixed += m->ncols;
  }

  return fixed;
}


Matrix* getColumnContent(const Matrix *src, int col) {
  Matrix *dest = matrix_new(src->nrows, 1);
  double value = 0.0;

  for (int row = 0; row < src->nrows; row++) {
    value = matrix_get_value(src, row, col);
    matrix_set_value(dest, row, col, value);
  }  

  return dest;
}


int getDatumIndex(const Matrix *m, int row, int col) {
  int idx = row * m->ncols + col;

  return idx;
}


void setColumnContent(Matrix *dest, const Matrix *src, int col) {
  double value = 0.0;

  for (int row = 0; row < dest->nrows; row++) {
     value = matrix_get_value(src, row, 0);
     matrix_set_value(dest, row, col, value);
  }
}


