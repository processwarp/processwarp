find_package(PkgConfig)

# socket.io
if(NOT SIO_DIR)
  message("SIO_DIR must be set.")
  return()
endif()
include_directories("${SIO_DIR}/include")
link_directories("${SIO_DIR}/lib/Release")
list(APPEND extra_libs "sioclient_tls")
list(APPEND extra_libs "pthread")

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

# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWORKER_DUMMY")

# C++ options
list(APPEND extra_libs "dl")

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

add_executable(daemon
  ${HEADER_FILES}
  connector.cpp
  daemon.cpp
  frontend_connector.cpp
  router.cpp
  server_connector.cpp
  worker_connector.cpp
  worker_dummy.cpp
  )
add_dependencies(daemon const_daemon)
set_property(TARGET daemon PROPERTY CXX_STANDARD 11)
set_property(TARGET daemon PROPERTY CXX_STANDARD_REQUIRED ON)
target_link_libraries(daemon
  ${extra_libs}
  pwcore
  )

add_executable(worker
  ${HEADER_FILES}
  worker.cpp
  )
add_dependencies(worker const_daemon)
set_property(TARGET worker PROPERTY CXX_STANDARD 11)
set_property(TARGET worker PROPERTY CXX_STANDARD_REQUIRED ON)
target_link_libraries(worker
  ${extra_libs}
  pwcore
  )
