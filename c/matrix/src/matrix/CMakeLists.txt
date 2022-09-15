message("/src/matrix/CMakeLists.txt")

set(SOURCES matrix.c)
message("SOURCES: " ${SOURCES}) 
target_include_directories(matrix PRIVATE ../include) 

add_library(matrix ${SOURCES} ${HEADER_FILES})
