message("root/test CMakeLists.txt")

project(MatrixTests LANGUAGES C)
enable_testing()

# Set the minimum version of cmake:
cmake_minimum_required(VERSION 3.0.0)
add_executable(	unit_tests
                unit_tests.c
               	matrix_test.c
		        ../src/matrix.c)

target_include_directories(unit_tests PRIVATE ../src)

add_test(NAME TestIsSingular COMMAND unit_tests 1)
add_test(NAME TestIsNotSingular COMMAND unit_tests 2)
