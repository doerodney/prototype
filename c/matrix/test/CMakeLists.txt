message("/test/CMakeLists.txt")

project(MatrixTests LANGUAGES C)
enable_testing()

# Set the minimum version of cmake:
cmake_minimum_required(VERSION 3.0.0)

set(SOURCES unit_tests.c matrix_test.c)
message("SOURCES: " ${SOURCES})

add_executable(unit_tests ${SOURCES})

target_include_directories(unit_tests PRIVATE ../src/include)

target_link_libraries(unit_tests PRIVATE matrix)

add_test(NAME TestIsSingular COMMAND unit_tests 1)
add_test(NAME TestIsNotSingular COMMAND unit_tests 2)
add_test(NAME TestDeterminantOfNonSquareMatrix COMMAND unit_tests 3)
add_test(NAME TestDeterminantOfEmptyMatrix COMMAND unit_tests 4)
add_test(NAME TestDeterminantOfValidMatrix COMMAND unit_tests 5)
