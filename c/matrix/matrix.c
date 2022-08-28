#include <stdlib.h>
#include "matrix.h"


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


/*--
Matrix* matrix_copy(const Matrix* src);

double matrix_determinant(const Matrix* m);
--*/

void matrix_free(Matrix **p) {
    Matrix *pm = *p;
    if (pm) {
        // Free data storage:
        if (pm->data) {
            free(pm->data);
        }

        // Free struct storage:
        free(*p);

        // Set pointer to NULL:
        *p = NULL;
    }
 
}


