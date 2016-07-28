cmake_minimum_required(VERSION 2.8)
project(processwarp)

include(ExternalProject)

# Options.
if(NOT CMAKE_BUILD_TYPE)
  message("CMAKE_BUILD_TYPE was not set, Automatically set to Release." )
  set(CMAKE_BUILD_TYPE Release )

elseif(NOT (${CMAKE_BUILD_TYPE} STREQUAL "Release" OR ${CMAKE_BUILD_TYPE} STREQUAL "Debug" ))
  message("CMAKE_BUILD_TYPE must be either Release or Debug.")
  return()
endif()

option(WITH_DOCUMENT "Generate document by doxygen" OFF)
option(WITH_RE2 "Use RE2 library for regular expression instead of standerd C++ library" OFF)
option(WITH_PTHREAD "Use pthread mutex and cond instead of stdc++'s it." OFF)

# Check for Google Coding Style.
add_custom_target(cpplint
  python
  `which cpplint.py`
  --extensions=cpp,h,hpp
  --linelength=100
  --filter=-legal/copyright,-runtime/references,-build/c++11
  ${PROJECT_SOURCE_DIR}/src/core/*.cpp ${PROJECT_SOURCE_DIR}/src/core/*.hpp
  ${PROJECT_SOURCE_DIR}/src/daemon/*.cpp ${PROJECT_SOURCE_DIR}/src/daemon/*.hpp
  ${PROJECT_SOURCE_DIR}/include/processwarp/*.h ${PROJECT_SOURCE_DIR}/include/processwarp/*.hpp
  ${PROJECT_SOURCE_DIR}/test/unit/core/*.cpp ${PROJECT_SOURCE_DIR}/test/unit/core/*.hpp
  ${PROJECT_SOURCE_DIR}/src/android/app/src/main/jni/*.cpp
  ${PROJECT_SOURCE_DIR}/src/android/app/src/main/jni/*.hpp
  )

# Generate develop document.
if (WITH_DOCUMENT)
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
endif (WITH_DOCUMENT)

# Socket.io
add_subdirectory(${PROJECT_SOURCE_DIR}/lib/socket.io-client-cpp)

# RE2
if (WITH_RE2)
  if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    # Linux
    ExternalProject_Add(
      RE2
      PREFIX ${PROJECT_SOURCE_DIR}/tmp/re2
      SOURCE_DIR ${PROJECT_SOURCE_DIR}/lib/re2
      CMAKE_ARGS -DEXTRA_TARGET_LINK_LIBRARIES="rt"
      INSTALL_COMMAND echo "Nothing for install RE2."
      )
  else()
    ExternalProject_Add(
      RE2
      PREFIX ${PROJECT_SOURCE_DIR}/tmp/re2
      SOURCE_DIR ${PROJECT_SOURCE_DIR}/lib/re2
      INSTALL_COMMAND echo "Nothing for install RE2."
      )
  endif()
endif (WITH_RE2)

# Compile.
option(DEBUG_VERBOSE "Output debug log with verbose mode" OFF)
if (DEBUG_VERBOSE)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D DEBUG_VM=1 -D DEBUG_MEM=1")
endif()
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D PICOJSON_USE_LOCALE=0")

# AddressSnitizer
option(DEBUG_ADDRESS_SANITIZE "Enable AddressSanitizer" OFF)
if (DEBUG_ADDRESS_SANITIZE)
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fsanitize=address -fno-omit-frame-pointer")
  set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=address")
  set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS} -fsanitize=address")
  set(CMAKE_MODULE_LINKER_FLAGS_DEBUG "${CMAKE_MODULE_LINKER_FLAGS} -fsanitize=address")
endif (DEBUG_ADDRESS_SANITIZE)

# Enable pthread module
if(WITH_PTHREAD)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWITH_PTHREAD=1")
endif()

include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${PROJECT_SOURCE_DIR}/src/const)
include_directories(${PROJECT_SOURCE_DIR}/src/core)
include_directories(${PROJECT_SOURCE_DIR}/lib/picojson)
include_directories(${PROJECT_SOURCE_DIR}/lib/safeint)
include_directories(${PROJECT_SOURCE_DIR}/lib/socket.io-client-cpp/src)

add_subdirectory(src)

# Sample
add_custom_target(sample
  COMMAND python ${PROJECT_SOURCE_DIR}/script/compile.py -s ${PROJECT_SOURCE_DIR}/include/libc -I {PROJECT_SOURCE_DIR}/include/processwarp ${PROJECT_SOURCE_DIR}/sample
  )

# Test
if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  option(WITH_TEST "Compile test program" ON)
  if (WITH_TEST)
    enable_testing()
    add_subdirectory(test)
  endif (WITH_TEST)
endif()
