cmake_minimum_required(VERSION 2.8)
project(processwarp)

include(ExternalProject)

# Options.
if (NOT CMAKE_BUILD_TYPE)
  message("CMAKE_BUILD_TYPE was not set, Automatically set to Release." )
  set(CMAKE_BUILD_TYPE Release )

elseif (NOT (${CMAKE_BUILD_TYPE} STREQUAL "Release" OR ${CMAKE_BUILD_TYPE} STREQUAL "Debug" ))
  message("CMAKE_BUILD_TYPE must be either Release or Debug.")
  return()
endif ()

if (NOT PROCESSWARP_BUILD_TYPE)
  message("PROCESSWARP_BUILD_TYPE was not set, Automatically set to Client.")
  set(PROCESSWARP_BUILD_TYPE Client)

elseif (NOT (${PROCESSWARP_BUILD_TYPE} STREQUAL "Client" OR ${PROCESSWARP_BUILD_TYPE} STREQUAL "Server"))
  message("PROCESSWARP_BUILD_TYPE must be ether Client or Server.")
  return()
endif ()

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
option(WITH_DOCUMENT "Generate document by doxygen" OFF)
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
if (${PROCESSWARP_BUILD_TYPE} STREQUAL "Client")
  add_subdirectory(${PROJECT_SOURCE_DIR}/lib/socket.io-client-cpp)
endif ()

# RE2
option(WITH_RE2 "Use RE2 library for regular expression instead of standerd C++ library" OFF)
if (WITH_RE2)
  if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    # Linux
    ExternalProject_Add(
      RE2
      PREFIX ${PROJECT_SOURCE_DIR}/tmp/re2
      SOURCE_DIR ${PROJECT_SOURCE_DIR}/lib/re2
      CMAKE_ARGS -DEXTRA_TARGET_LINK_LIBRARIES="rt"
      INSTALL_COMMAND echo "Nothing for install RE2."
      )
  else ()
    ExternalProject_Add(
      RE2
      PREFIX ${PROJECT_SOURCE_DIR}/tmp/re2
      SOURCE_DIR ${PROJECT_SOURCE_DIR}/lib/re2
      INSTALL_COMMAND echo "Nothing for install RE2."
      )
  endif ()

  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWITH_RE2=1")
  include_directories(${PROJECT_SOURCE_DIR}/lib/re2)
  link_directories(${PROJECT_SOURCE_DIR}/tmp/re2/src/RE2-build)
endif (WITH_RE2)

# C++ compile options
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D PICOJSON_USE_LOCALE=0")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wno-unused-parameter")

set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0")

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # MaxOSX
  include_directories(/usr/local/include)

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  # Emscripten
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-warn-absolute-paths")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --bind -s EXPORT_ALL=1")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s DISABLE_EXCEPTION_CATCHING=0")
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -s ASSERTIONS=2")
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -s DEMANGLE_SUPPORT=1")
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g4")

elseif(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
  # FreeBSD
  list(APPEND extra_libs pthread)

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # Linux
  list(APPEND extra_libs "pthread")
  list(APPEND extra_libs "dl")

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
  # Windows
  add_definitions(-DUNICODE)
  add_definitions(-D_UNICODE)
endif()

# AddressSnitizer.
option(WITH_ADDRESS_SANITIZE "Enable AddressSanitizer" OFF)
if (WITH_ADDRESS_SANITIZE)
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fsanitize=address -fno-omit-frame-pointer")
  set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=address")
  set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS} -fsanitize=address")
  set(CMAKE_MODULE_LINKER_FLAGS_DEBUG "${CMAKE_MODULE_LINKER_FLAGS} -fsanitize=address")
endif (WITH_ADDRESS_SANITIZE)

# Debug log options.
option(WITH_DEBUG_VERBOSE "Output debug log with verbose mode" OFF)
if (WITH_DEBUG_VERBOSE)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D DEBUG_VM=1 -D DEBUG_MEM=1 -D DEBUG_NET=1")
endif (WITH_DEBUG_VERBOSE)

# Log output destination.
option(WITH_LOG_FLUENTD "Enable fluentd for destination of log output." ON)
if (WITH_LOG_FLUENTD)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWITH_LOG_FLUENTD")
endif (WITH_LOG_FLUENTD)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWITH_LOG_STDOUT")

option(WITH_LOG_SYSLOG "Enable syslog for destination of log output." ON)
if (WITH_LOG_SYSLOG)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWITH_LOG_SYSLOG")
endif (WITH_LOG_SYSLOG)

# Enable pthread module
option(WITH_PTHREAD "Use pthread mutex and cond instead of stdc++'s it." OFF)
if (WITH_PTHREAD)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWITH_PTHREAD=1")
endif ()

include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${PROJECT_SOURCE_DIR}/lib/picojson)
include_directories(${PROJECT_SOURCE_DIR}/lib/safeint)
include_directories(${PROJECT_SOURCE_DIR}/lib/socket.io-client-cpp/src)
include_directories(${PROJECT_SOURCE_DIR}/local/include)
include_directories(${PROJECT_SOURCE_DIR}/src)
include_directories(${PROJECT_SOURCE_DIR}/src/const)
include_directories(${PROJECT_SOURCE_DIR}/src/core)

link_directories(${PROJECT_SOURCE_DIR}/local/lib)

add_subdirectory(src/const)
add_subdirectory(src/core)
add_subdirectory(src/net/webrtc)

if (${PROCESSWARP_BUILD_TYPE} STREQUAL "Client")
  add_subdirectory(src/daemon)
elseif (${PROCESSWARP_BUILD_TYPE} STREQUAL "Server")
  add_subdirectory(src/loader)
endif ()

# Sample
add_custom_target(sample
  COMMAND python ${PROJECT_SOURCE_DIR}/script/compile.py -s ${PROJECT_SOURCE_DIR}/include/libc -I {PROJECT_SOURCE_DIR}/include/processwarp ${PROJECT_SOURCE_DIR}/sample
  )

# Test
if (NOT ${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  option(WITH_TEST "Compile test program" ON)
  if (WITH_TEST)
    enable_testing()
    add_subdirectory(test)
  endif (WITH_TEST)
endif ()
