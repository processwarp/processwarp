find_package(PkgConfig)

# socket.io
if(NOT SIO_DIR)
  message("SIO_DIR must be set.")
  return()
endif()
include_directories("${SIO_DIR}/include")
link_directories("${SIO_DIR}/lib/Release")
list(APPEND extra_libs "sioclient_tls")

# Boost
find_package(Boost REQUIRED COMPONENTS system date_time random)
include_directories(${Boost_INCLUDE_DIRS})
link_directories(${Boost_LIBRARY_DIRS})
list(APPEND extra_libs ${Boost_LIBRARIES})

# OpenSSL
find_package(OpenSSL)
include_directories(${OPENSSL_INCLUDE_DIR})
list(APPEND extra_libs ${OPENSSL_LIBRARIES})

# libuv
pkg_search_module(UV libuv REQUIRED)
if(UV_FOUND)
  include_directories(${UV_INCLUDE_DIRS})
  string(REPLACE ";" " " UV_CFLAGS_STR "${UV_CFLAGS}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${UV_CFLAGS_STR}")
  list(APPEND extra_libs ${UV_LIBRARIES})
endif()

# C++ options
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wno-unused-parameter")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0")

# Compile & link
file(GLOB HEADER_FILES "*.hpp")
file(GLOB DAEMON_FILES "*.cpp")

add_executable(daemon
  ${HEADER_FILES}
  connector.cpp
  daemon.cpp
  frontend_connector.cpp
  router.cpp
  socketio.cpp
  worker_connector.cpp
  )
target_link_libraries(daemon
  ${extra_libs}
  pwcore
  )

add_executable(worker
  ${HEADER_FILES}
  worker.cpp
  )
target_link_libraries(worker
  ${extra_libs}
  pwcore
  )
