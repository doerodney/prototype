#include <stdio.h>
#include <string.h>
#include "matrix_test.h"

int main(int argc, char *argv[]) {
    
    if (argc < 2 && !strcmp(argv[1], "1") ) {
        TestIsSingular();
    }
    
    if (argc < 2 && !strcmp(argv[1], "2") ) {
        TestIsNotSingular();
    }
    
    if (argc < 2 && !strcmp(argv[1], "3") ) {
        TestDeterminantOfNonSquareMatrix();
    }

    if (argc < 2 && !strcmp(argv[1], "4") ) {
        TestDeterminantOfEmptyMatrix();
    }
    
}
