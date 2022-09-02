# message("root/src CMakeLists.txt")

# Add the executable and the source file(s):
add_executable(MtrxTest 
    main.c
    matrix.c
)

# Add the math library:
target_link_libraries(MtrxTest PRIVATE m)
