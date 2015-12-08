
set(SRC_CORE_DIR "${PROJECT_SOURCE_DIR}/src/core")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wno-unused-parameter")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")

# OpenSSL
find_package(OpenSSL)
include_directories(${OPENSSL_INCLUDE_DIR})
list(APPEND extra_libs ${OPENSSL_LIBRARIES})

# google test
list(APPEND extra_libs gtest)
list(APPEND extra_libs gtest_main)
list(APPEND extra_libs pthread)

# core
list(APPEND extra_libs pwcore)

# convert
add_executable(test_convert_0
  test_convert.cpp
  )
target_link_libraries(test_convert_0 ${extra_libs})
add_test(
  NAME test_convert
  COMMAND $<TARGET_FILE:test_convert_0>
  )

# util
add_executable(test_util_0
  test_util.cpp
  )
target_link_libraries(test_util_0 ${extra_libs})
add_test(
  NAME test_util
  COMMAND $<TARGET_FILE:test_util_0>
  )
