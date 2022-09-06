message("root/src CMakeLists.txt")

# Add the executable and the source file(s):
add_executable(${CMAKE_PROJECT_NAME} 
    main.c
    matrix.c
)

# Add the math library:
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE m)

