message("/CMakeLists.txt")

# Set the minimum version of cmake:
cmake_minimum_required(VERSION 3.0.0)

# Define the project:
set(CMAKE_PROJECT_NAME MtrxDemo )
project(${CMAKE_PROJECT_NAME} VERSION 1.0 LANGUAGES C)
message("CMAKE_PROJECT_NAME:  " ${CMAKE_PROJECT_NAME})

# Specify the C standard to use:
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED True)

# Notify CMake of subdirectories:
add_subdirectory(src)
# add_subdirectory(test)

