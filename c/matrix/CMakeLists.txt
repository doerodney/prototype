# Set the minimum version of cmake:
cmake_minimum_required(VERSION 3.0.0)

# Set the project version:
project(MtrxTest VERSION 1.0 LANGUAGES C)

# Specify the C standard to use:
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)

# Add the executable and the source file(s):
add_executable(MtrxTest 
    main.c
    matrix.c
)

# Add the math library:
target_link_libraries(MtrxTest PRIVATE m)
