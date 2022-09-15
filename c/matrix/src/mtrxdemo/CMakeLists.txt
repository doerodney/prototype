message("/src/mtrxdemo/CMakeLists.txt")

add_executable( ${CMAKE_PROJECT_NAME} main.c)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE m)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE matrix)

