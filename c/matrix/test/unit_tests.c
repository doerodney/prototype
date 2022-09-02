#include <stdio.h>
#include <string.h>

void TestIsSingular();
void TestIsNotSingular();

int main(int argc, char *argv[]) {
    
    if (argc < 2 && !strcmp(argv[1], "1") ) {
        TestIsSingular();
    }
    
    if (argc < 2 && !strcmp(argv[1], "2") ) {
        TestIsSingular();
    }
}
