#include <math.h> //NAN
#include <stdlib.h>
#include <string.h>
#include "matrix.h"

// local functions;
int fixColumnIndex(const Matrix *m, int idx);
Matrix* getColumnContent(Matrix *dest, const Matrix *src, int col);
int getDatumIndex(const Matrix *m, int row, int col);
void setColumnContent(Matrix *dest, const Matrix *src, int col);


// Matrix constructor:
Matrix* matrix_new(int nrows, int ncols) {
  Matrix  *out = NULL;
  // Allocate memory for the data:
  double *pd = calloc((size_t)(nrows * ncols), sizeof(*pd));

  // Allocate memory for the matrix:
  if (pd) {
    out = malloc(sizeof(Matrix));

    if (out) {
      *out = (Matrix) {.nrows = nrows, .ncols = ncols, .data = pd};
    }
    else {
      free((void*) pd);
    }
  }

  return out;
}


// Create a copy of a matrix:
Matrix* matrix_copy(const Matrix* src)
{
  Matrix *dest = matrix_new(src->nrows, src->ncols);
  if (dest) {
    memcpy((void *) dest->data, (void * ) src->data, src->nrows * src->ncols * sizeof(src->data[0]));
  }

  return dest;
}


// Calculate the determinant of a matrix:
double matrix_get_determinant(const Matrix* m) {
  double det, diag, value = 0;
  int col, row, fixed = 0;

  // Apply the sum of the left->right diagonals:
  for (col = 0; col < m->ncols; col++) {
    diag = 1.0;
    for (row = 0; row < m->nrows; row++) {
      fixed = fixColumnIndex(m, col + row);
      value = matrix_get_value(m, row, fixed);
      diag *= value;
    }
    det += diag;
  }

  // Apply the sum of the right->left diagonals:
  for (col = m->ncols - 1; col >= 0; col--) {
    diag = 1.0;
    for (row = 0; row < m->nrows; row++) {
      fixed = fixColumnIndex(m, col - row);
      value = matrix_get_value(m, row, fixed);
      diag *= value;
    }
    det -= diag;
  }

  return det;
}


// Matrix destructor:
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


// Get the value of a location in a matrix:
double matrix_get_value(const Matrix *m, int row, int col) {
  int idx = getDatumIndex(m, row, col);

  double value = m->data[idx];

  return value;
}


// Load the data into a matrix by columns:
void matrix_load_by_column(Matrix *m, double in[]) {
  int idx = 0;
  for (int col = 0; col < m->ncols && !isnan(in[idx]); col++) {
    for (int row = 0; row < m->nrows; row++) {
      idx = getDatumIndex(m, row, col);
      m->data[idx] = in[idx];
      idx++;
    }
  }
}


// Load the data into a matrix by rows:
void matrix_load_by_row(Matrix *m, double in[]) {
  int idx = 0;
  for (int row = 0; row < m->nrows && !isnan(in[idx]); row++) {
    for (int col = 0; col < m->ncols; col++) {
      idx = getDatumIndex(m, row, col);
      m->data[idx] = in[idx];
      idx++;
    }
  }
}


// Set the value of a location in a matrix:
void matrix_set_value(Matrix *p, int row, int col, double value) {
  int idx = getDatumIndex(p, row, col);

  p->data[idx] = value;
}


// Solve a set of simultaneous equations of the form AX = B:
int matrix_solve_simeq(const Matrix *a, Matrix *x, const Matrix *b) {
  int failure = MATRIX_NO_ERR;

  // Validate incoming matrices:
  if (a->nrows != a->ncols) {
    failure = MATRIX_DATA_NOT_SQUARE;
  } else if (a->nrows != x->nrows) {
    failure = MATRIX_UNEQUAL_ROW_COUNTS;
  } else if (a->nrows != b->nrows) {
    failure = MATRIX_UNEQUAL_ROW_COUNTS;
  } else if (matrix_test_singular(a)) {
    failure = MATRIX_SINGULAR;
  }
  else {
    // Set the determinant of matrix a as the denominator:
    double denom = matrix_get_determinant(a);
    double det = 0.0;

    Matrix *aprime = matrix_copy(a);
    Matrix *content = matrix_new(a->nrows, 1);


    // Iterate through columns in a matrix.
    // Substitute the b matrix for the column col.
    // Take the determinant of the resultant matrix.
    // Implement Cramer's Rule.
    for (int col = 0; col < a->ncols; col++) {
      // Preserve matrix a column content:
      getColumnContent(content, aprime, col);

      // Substitute b matrix for the column in aprime:
      setColumnContent(aprime, b, col);

      // Take determinant of resultant matrix:
      det = matrix_get_determinant(aprime);

      // Record result in x matrix:
      matrix_set_value(x, col, 0, det/denom);

      // Restore column in matrix a':
      setColumnContent(aprime, content, col);
    }

    matrix_free(&aprime);
    matrix_free(&content);

  }

  return failure;
}


// Test if the matrix is singular:
int matrix_test_singular(const Matrix *m) {
  int singular = 0;

  double det = matrix_get_determinant(m);
  if (det == 0.0) {
    singular = 1;
  }

  return singular;
}


// Fix the column value to be within 0 <= col < ncols:
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


// Get the content of a column in a matrix.
// This is returned as an nrows x 1 matrix.
Matrix* getColumnContent(Matrix *dest, const Matrix *src, int col) {
  double value = 0.0;

  for (int row = 0; row < src->nrows; row++) {
    value = matrix_get_value(src, row, col);
    matrix_set_value(dest, row, 0, value);
  }

}


// Get the index of a specified row/column in the matrix data field:
int getDatumIndex(const Matrix *m, int row, int col) {
  int idx = row * m->ncols + col;

  return idx;
}


// Set the content of a column in a matrix:
void setColumnContent(Matrix *dest, const Matrix *src, int col) {
  double value = 0.0;

  for (int row = 0; row < dest->nrows; row++) {
     value = matrix_get_value(src, row, 0);
     matrix_set_value(dest, row, col, value);
  }
}


