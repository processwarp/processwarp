cmake_minimum_required(VERSION 2.8)
project(processwarp-core)

if(NOT CMAKE_BUILD_TYPE)
  message("CMAKE_BUILD_TYPE was not set, Automatically set to Release." )
  set(CMAKE_BUILD_TYPE Release )

elseif(NOT (${CMAKE_BUILD_TYPE} STREQUAL "Release" OR ${CMAKE_BUILD_TYPE} STREQUAL "Debug" ))
  message("CMAKE_BUILD_TYPE must be either Release or Debug.")
  return()
endif()

# include_directories(include)

add_subdirectory(src)
