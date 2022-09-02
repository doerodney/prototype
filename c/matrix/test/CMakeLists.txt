add_executable(	unit_tests
                unit_tests.c
               	matrix_test.c
		        ../src/matrix.c)

target_include_directories(unit_tests PRIVATE ../src)

add_test(NAME TestIsSingular COMMAND unit_tests 1)
add_test(NAME TestIsNotSingular COMMAND unit_tests 2)
