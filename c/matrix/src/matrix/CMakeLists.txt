message("/src/matrix/CMakeLists.txt")

set(SOURCES matrix.c)
add_library(matrix ${SOURCES} ${HEADER_FILES})

