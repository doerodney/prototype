message("reading /test/CMakeLists.txt")

project(MatrixTests LANGUAGES CXX)

# Specify the C++ standard to use:
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED True)

enable_testing()

# Set the minimum version of cmake:
cmake_minimum_required(VERSION 3.0.0)

set(SOURCES unit_tests.cpp)

add_executable(unit_tests ${SOURCES})

target_include_directories(unit_tests PRIVATE ../src/include ../src/googletest/googletest/include/gtest)

target_link_libraries(unit_tests PRIVATE matrix)
target_link_libraries(unit_tests PRIVATE gtest)
