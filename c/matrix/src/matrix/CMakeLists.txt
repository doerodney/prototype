message("/src/matrix/CMakeLists.txt")

set(SOURCES matrix.c)
message("SOURCES: " ${SOURCES}) 
# message("HEADER_FILES: " ${HEADER_FILES})

add_library(matrix ${SOURCES} ${HEADER_FILES})
target_include_directories(matrix PRIVATE ${PROJECT_SOURCE_DIR}/src/include) 

