
option(WITH_WORKER_DEBUG "For debug, worker process has not generate bug run on the same process of main." OFF)
option(WITH_WEBRTC_DEBUG "For debug, subprocess of WebRTC has not generate but run on the same process of main." OFF)

find_package(PkgConfig)

# WebRTC
include_directories(${WEBRTC_INCLUDE_DIR})
link_directories(${WEBRTC_LIBRARY_DIR})

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # macOS
  list(APPEND webrtc_libs "audioproc_debug_proto")
  list(APPEND webrtc_libs "opus")
  list(APPEND webrtc_libs "rtc_event_log_proto")
  list(APPEND webrtc_libs "usrsctp")
  list(APPEND webrtc_libs "boringssl")
  list(APPEND webrtc_libs "processwarp_webrtc")
  list(APPEND webrtc_libs "rtc_task_queue")
  list(APPEND webrtc_libs "vpx")
  list(APPEND webrtc_libs "protobuf_lite")
  list(APPEND webrtc_libs "simd")
  list(APPEND webrtc_libs "vpx_yasm")
  list(APPEND webrtc_libs "expat")
  list(APPEND webrtc_libs "rtc_base")
  list(APPEND webrtc_libs "simd_asm")
  list(APPEND webrtc_libs "yuv")
  list(APPEND webrtc_libs "jpeg")
  list(APPEND webrtc_libs "rtc_base_approved")
  list(APPEND webrtc_libs "srtp")
  list(APPEND webrtc_libs "openmax_dl")

  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWEBRTC_MAC=1 -DWEBRTC_POSIX=1")
  find_library(CORE_FOUNDATION CoreFoundation)
  list(APPEND webrtc_libs ${CORE_FOUNDATION})
  find_library(FOUNDATION Foundation)
  list(APPEND webrtc_libs ${FOUNDATION})
  find_library(CORE_AUDIO CoreAudio)
  list(APPEND webrtc_libs ${CORE_AUDIO})
  find_library(AUDIO_TOOLBOX AudioToolbox)
  list(APPEND webrtc_libs ${AUDIO_TOOLBOX})
  find_library(CORE_GRAPHICS CoreGraphics)
  list(APPEND webrtc_libs ${CORE_GRAPHICS})

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # Linux
  list(APPEND webrtc_libs "audioproc_debug_proto")
  list(APPEND webrtc_libs "protobuf_lite")
  list(APPEND webrtc_libs "srtp")
  list(APPEND webrtc_libs "boringssl")
  list(APPEND webrtc_libs "rtc_base")
  list(APPEND webrtc_libs "usrsctp")
  list(APPEND webrtc_libs "dl")
  list(APPEND webrtc_libs "rtc_base_approved")
  list(APPEND webrtc_libs "vpx")
  list(APPEND webrtc_libs "event")
  list(APPEND webrtc_libs "rtc_event_log_proto")
  list(APPEND webrtc_libs "vpx_yasm")
  list(APPEND webrtc_libs "jpeg")
  list(APPEND webrtc_libs "rtc_task_queue")
  list(APPEND webrtc_libs "yuv")
  list(APPEND webrtc_libs "opus")
  list(APPEND webrtc_libs "simd")
  list(APPEND webrtc_libs "processwarp_webrtc")
  list(APPEND webrtc_libs "simd_asm")
  list(APPEND webrtc_libs "openmax_dl")

  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWEBRTC_LINUX=1 -DWEBRTC_POSIX=1")
  pkg_search_module(GDK REQUIRED gdk-x11-2.0)
  list(APPEND webrtc_libs ${GDK_LIBRARIES})
  pkg_search_module(GTHREAD REQUIRED gthread-2.0)
  list(APPEND webrtc_libs ${GTHREAD_LIBRARIES})
  pkg_search_module(GTK REQUIRED gtk+-2.0)
  list(APPEND webrtc_libs ${GTK_LIBRARIES})
  pkg_search_module(X11 REQUIRED x11)
  list(APPEND webrtc_libs ${X11_LIBRARIES})
endif()

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
if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  include_directories("/usr/local/opt/openssl/include")
  link_directories("/usr/local/opt/openssl/lib")
  list(APPEND ssl_libs "crypto")
  list(APPEND ssl_libs "ssl")
else()
  find_package(OpenSSL REQUIRED)
  include_directories(${OPENSSL_INCLUDE_DIR})
  list(APPEND ssl_libs ${OPENSSL_LIBRARIES})
endif()

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

# libfluent
if (WITH_LOG_FLUENTD)
  list(APPEND extra_libs "fluent")
  link_directories(${PROCESSWARP_SOURCE_DIR}/local/lib)
endif (WITH_LOG_FLUENTD)

# RE2
if(WITH_RE2)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWITH_RE2=1")
  include_directories(${PROCESSWARP_SOURCE_DIR}/lib/re2)
  link_directories(${PROCESSWARP_SOURCE_DIR}/tmp/re2/src/RE2-build)
  list(APPEND extra_libs re2)
endif()

# C++ options
list(APPEND extra_libs "crypto")
list(APPEND extra_libs "dl")
list(APPEND extra_libs "ssl")

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # MaxOSX

elseif(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
  # FreeBSD
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWEBRTC_POSIX=1")

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # Linux
  list(APPEND extra_libs "pthread")

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
  # Windows
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWEBRTC_WIN=1")
endif()

if(WITH_WEBRTC_DEBUG)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWITH_WEBRTC_DEBUG=1")
endif()

if(WITH_WORKER_DEBUG)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWITH_WORKER_DEBUG=1")
endif()

# Compile & link
file(GLOB HEADER_FILES "*.hpp")

set(WEBRTC_FILES
  subprocess.cpp
  webrtc_subprocess.cpp
  )

set(WORKER_FILES
  subprocess.cpp
  worker_subprocess.cpp
  )

set(MAIN_FILES
  daemon.cpp
  frontend_connector.cpp
  router.cpp
  worker_connector.cpp
  )

if(WITH_WEBRTC_DEBUG)
  list(APPEND MAIN_FILES "${WEBRTC_FILES}")
  list(APPEND extra_libs "${webrtc_libs}")
endif()

if(WITH_WORKER_DEBUG)
  list(APPEND MAIN_FILES "${WORKER_FILES}")
endif()

# Compile webrtc_subprocess
if(NOT WITH_WEBRTC_DEBUG)
  add_executable(webrtc_subprocess
    ${HEADER_FILES}
    ${WEBRTC_FILES}
    )
  add_dependencies(webrtc_subprocess
    const_processwarp
    const_core_constant
    )
  if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    target_link_libraries(webrtc_subprocess
      pwcore
      pwwebrtc
      ${webrtc_libs}
      ${extra_libs}
      )
  else()
    target_link_libraries(webrtc_subprocess
      pwcore
      pwwebrtc
      -Wl,--start-group
      ${webrtc_libs}
      -Wl,--end-group
      ${extra_libs}
      )
  endif()
endif(NOT WITH_WEBRTC_DEBUG)

# Compile worker_subprocess
if(NOT WITH_WORKER_DEBUG)
  add_executable(worker_subprocess
    ${HEADER_FILES}
    ${WORKER_FILES}
    )
  add_dependencies(worker_subprocess
    const_processwarp
    const_core_constant
    )
  target_link_libraries(worker_subprocess
    pwcore
    ${extra_libs}
    )
endif(NOT WITH_WORKER_DEBUG)

# Compile processwarp
add_executable(processwarp
  ${HEADER_FILES}
  ${MAIN_FILES}
  )
add_dependencies(processwarp
  const_processwarp
  const_core_constant
  )
target_link_libraries(processwarp
  pwcore
  pwwebrtc
  ${extra_libs}
  ${ssl_libs}
  sioclient_tls
  )

# Install
if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  install(TARGETS processwarp DESTINATION ${PROCESSWARP_SOURCE_DIR}/bin)

  if(NOT WITH_WEBRTC_DEBUG)
    install(TARGETS webrtc_subprocess DESTINATION ${PROCESSWARP_SOURCE_DIR}/bin)
  endif(NOT WITH_WEBRTC_DEBUG)

  if(NOT WITH_WORKER_DEBUG)
    install(TARGETS worker_subprocess DESTINATION ${PROCESSWARP_SOURCE_DIR}/bin)
  endif(NOT WITH_WORKER_DEBUG)
endif()

