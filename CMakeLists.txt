cmake_minimum_required(VERSION 2.8)
project(processwarp-core)

if(NOT CMAKE_BUILD_TYPE)
  message("CMAKE_BUILD_TYPE was not set, Automatically set to Release." )
  set(CMAKE_BUILD_TYPE Release )

elseif(NOT (${CMAKE_BUILD_TYPE} STREQUAL "Release" OR ${CMAKE_BUILD_TYPE} STREQUAL "Debug" ))
  message("CMAKE_BUILD_TYPE must be either Release or Debug.")
  return()
endif()

# Check for Google Coding Style.
add_custom_target(cpplint
  python
  `which cpplint.py`
  --extensions=cpp,h,hpp
  --linelength=100
  --filter=-legal/copyright,-runtime/references,-build/c++11
  ${PROJECT_SOURCE_DIR}/src/core/*.cpp ${PROJECT_SOURCE_DIR}/src/core/*.hpp
  ${PROJECT_SOURCE_DIR}/src/daemon/*.cpp ${PROJECT_SOURCE_DIR}/src/daemon/*.hpp
  )

# Generate develop document.
find_package(Doxygen)

if (DOXYGEN_FOUND)
  set(DOXYGEN_INPUT "Doxyfile")
  set(DOXYGEN_OUTPUT "doc")
    
  add_custom_target(doc
    COMMAND ${CMAKE_COMMAND} -E echo_append "Building API Documentation..."
    COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_INPUT}
    COMMAND ${CMAKE_COMMAND} -E echo "Done."
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    DEPENDS ${DOXYGEN_INPUT}
    )
endif (DOXYGEN_FOUND)

# include_directories(include)

add_subdirectory(src)
