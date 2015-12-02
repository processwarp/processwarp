
set(SRC_CORE_DIR "${PROJECT_SOURCE_DIR}/src/core")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wno-unused-parameter")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")

# convert
add_executable(test_convert_0
  test_convert.cpp
  )
target_link_libraries(test_convert_0
  pwcore
  gtest
  gtest_main
  pthread
  )
add_test(
  NAME test_convert
  COMMAND $<TARGET_FILE:test_convert_0>
  )
