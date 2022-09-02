message("root CMakeLists.txt")

# Set the minimum version of cmake:
cmake_minimum_required(VERSION 3.0.0)

# Set the project version:
project(MtrxTest VERSION 1.0 LANGUAGES C)

# Specify the C standard to use:
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)

# Notify CMake of subdirectories:
add_subdirectory(src)
add_subdirectory(build)
add_subdirectory(test)

# Set output directories:
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/build)
message("CMAKE_BINARY_DIR is " ${CMAKE_BINARY_DIR})
message("CMAKE_ARCHIVE_OUTPUT_DIRECTORY is " ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
message("CMAKE_LIBRARY_OUTPUT_DIRECTORY is " ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
message("CMAKE_RUNTIME_OUTPUT_DIRECTORY is " ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})