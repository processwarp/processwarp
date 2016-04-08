find_package(PkgConfig)

# Boost
if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
  set(Boost_USE_STATIC_LIBS ON)
  set(Boost_USE_MULTITHREADED ON)
  set(Boost_USE_STATIC_RUNTIME OFF)
endif()
find_package(Boost REQUIRED COMPONENTS system date_time random)
include_directories(${Boost_INCLUDE_DIRS})
link_directories(${Boost_LIBRARY_DIRS})
list(APPEND extra_libs ${Boost_LIBRARIES})

# libffi
pkg_search_module(FFI libffi)
if(FFI_FOUND)
  include_directories(${FFI_INCLUDE_DIRS})
  string(REPLACE ";" " " FFI_CFLAGS_STR "${FFI_CFLAGS}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FFI_CFLAGS_STR}")
  list(APPEND extra_libs ${FFI_LIBRARIES})
else()
  find_library(FFI_LIBRARY NAMES ffi)
  list(APPEND extra_libs ${FFI_LIBRARY})
endif()

# OpenSSL
find_package(OpenSSL)
include_directories(${OPENSSL_INCLUDE_DIR})
list(APPEND extra_libs ${OPENSSL_LIBRARIES})

# libuv
pkg_search_module(UV libuv)
if(UV_FOUND)
  include_directories(${UV_INCLUDE_DIRS})
  string(REPLACE ";" " " UV_CFLAGS_STR "${UV_CFLAGS}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${UV_CFLAGS_STR}")
  list(APPEND extra_libs ${UV_LIBRARIES})
else()
  include_directories(${UV_INCLUDE_DIRS})
  list(APPEND extra_libs ${UV_LIBRARIES})
endif()

# RE2
if(WITH_RE2)
  include_directories(${PROJECT_SOURCE_DIR}/lib/re2)
  link_directories(${PROJECT_SOURCE_DIR}/tmp/re2/src/RE2-build)
  list(APPEND extra_libs re2)
endif()

# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWORKER_DUMMY")

# C++ options
list(APPEND extra_libs "crypto")
list(APPEND extra_libs "dl")
list(APPEND extra_libs "ssl")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wno-unused-parameter")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0")

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # MaxOSX

elseif(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
  # FreeBSD

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # Linux

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
  # Windows
endif()

# Compile & link
file(GLOB HEADER_FILES "*.hpp")
file(GLOB DAEMON_FILES "*.cpp")

add_executable(processwarp
  ${HEADER_FILES}
  connector.cpp
  daemon.cpp
  frontend_connector.cpp
  router.cpp
  server_connector.cpp
  worker_connector.cpp
  worker_dummy.cpp
  )
add_dependencies(processwarp const_processwarp)
target_link_libraries(processwarp
  ${extra_libs}
  pwcore
  sioclient_tls
  )

add_executable(worker
  ${HEADER_FILES}
  worker.cpp
  )
add_dependencies(worker const_processwarp)
target_link_libraries(worker
  ${extra_libs}
  pwcore
  )

# Install
if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  install(TARGETS processwarp DESTINATION ${PROJECT_SOURCE_DIR}/bin)
  install(TARGETS worker DESTINATION ${PROJECT_SOURCE_DIR}/bin)
endif()

