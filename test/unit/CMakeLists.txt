if(NOT GTEST_DIR)
  message("GTEST_DIR bust be set.")
  return()
endif()
include_directories("../../src")
include_directories("${GTEST_DIR}/include")

add_executable(
  test_all
  ../../src/convert.cpp
  test_convert.cpp
  )

target_link_libraries(
  test_all
  "pthread"
  "${GTEST_DIR}/libgtest.a"
  "${GTEST_DIR}/libgtest_main.a"
  )
