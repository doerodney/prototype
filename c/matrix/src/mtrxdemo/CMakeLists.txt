message("reading /src/mtrxdemo/CMakeLists.txt")

set(SOURCES main.c)

add_executable(${CMAKE_PROJECT_NAME} ${SOURCES})

target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ../include) 

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE m)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE matrix)
