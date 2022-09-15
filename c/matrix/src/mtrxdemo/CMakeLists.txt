message("/src/mtrxdemo/CMakeLists.txt")

set(SOURCES main.c)
message("SOURCES: " ${SOURCES})

add_executable(${CMAKE_PROJECT_NAME} ${SOURCES} ${HEADER_FILES})

target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/src/include) 

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE m)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE matrix)

