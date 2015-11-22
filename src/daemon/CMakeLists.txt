
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

file(GLOB HEADER_FILES "*.hpp")
set(DAEMON_FILES
  daemon.cpp
  )

add_executable(daemon ${DAEMON_FILES} ${HEADER_FILES})
target_link_libraries(daemon)
