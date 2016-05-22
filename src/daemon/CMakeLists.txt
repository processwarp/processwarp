find_package(PkgConfig)

# WebRTC
include_directories(${WEBRTC_INCLUDE_DIRS})
link_directories(${WEBRTC_LIBRARY_DIRS})
list(APPEND extra_libs "jingle_peerconnection")
list(APPEND extra_libs "field_trial_default")
list(APPEND extra_libs "jsoncpp")
list(APPEND extra_libs "rtc_media")
list(APPEND extra_libs "rtc_base_approved")
list(APPEND extra_libs "webrtc_common")
list(APPEND extra_libs "webrtc")
list(APPEND extra_libs "system_wrappers")
if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  list(APPEND extra_libs "cpu_features_linux")
endif()
list(APPEND extra_libs "voice_engine")
list(APPEND extra_libs "common_audio")
list(APPEND extra_libs "openmax_dl")
list(APPEND extra_libs "common_audio_sse2")
list(APPEND extra_libs "audio_coding_module")
list(APPEND extra_libs "cng")
list(APPEND extra_libs "audio_encoder_interface")
list(APPEND extra_libs "g711")
list(APPEND extra_libs "pcm16b")
list(APPEND extra_libs "ilbc")
list(APPEND extra_libs "webrtc_opus")
list(APPEND extra_libs "opus")
list(APPEND extra_libs "g722")
list(APPEND extra_libs "isac")
list(APPEND extra_libs "audio_decoder_interface")
list(APPEND extra_libs "isac_common")
list(APPEND extra_libs "red")
list(APPEND extra_libs "rtc_event_log")
list(APPEND extra_libs "rtc_event_log_proto")
list(APPEND extra_libs "protobuf_lite")
list(APPEND extra_libs "neteq")
list(APPEND extra_libs "builtin_audio_decoder_factory")
list(APPEND extra_libs "audio_decoder_factory_interface")
list(APPEND extra_libs "rent_a_codec")
list(APPEND extra_libs "audio_conference_mixer")
list(APPEND extra_libs "audio_processing")
list(APPEND extra_libs "audioproc_debug_proto")
list(APPEND extra_libs "audio_processing_sse2")
list(APPEND extra_libs "webrtc_utility")
list(APPEND extra_libs "media_file")
list(APPEND extra_libs "audio_device")
list(APPEND extra_libs "bitrate_controller")
list(APPEND extra_libs "paced_sender")
list(APPEND extra_libs "rtp_rtcp")
list(APPEND extra_libs "remote_bitrate_estimator")
list(APPEND extra_libs "congestion_controller")
list(APPEND extra_libs "common_video")
list(APPEND extra_libs "yuv")
list(APPEND extra_libs "jpeg_turbo")
list(APPEND extra_libs "video_capture_module")
list(APPEND extra_libs "video_processing")
list(APPEND extra_libs "video_processing_sse2")
list(APPEND extra_libs "webrtc_video_coding")
list(APPEND extra_libs "webrtc_h264")
list(APPEND extra_libs "webrtc_i420")
list(APPEND extra_libs "video_coding_utility")
list(APPEND extra_libs "webrtc_vp8")
list(APPEND extra_libs "vpx")
list(APPEND extra_libs "vpx_intrinsics_mmx")
list(APPEND extra_libs "vpx_intrinsics_sse2")
list(APPEND extra_libs "vpx_intrinsics_ssse3")
list(APPEND extra_libs "vpx_intrinsics_sse4_1")
list(APPEND extra_libs "vpx_intrinsics_avx")
list(APPEND extra_libs "vpx_intrinsics_avx2")
list(APPEND extra_libs "webrtc_vp9")
list(APPEND extra_libs "metrics_default")
list(APPEND extra_libs "rtc_xmllite")
list(APPEND extra_libs "rtc_base")
list(APPEND extra_libs "boringssl")
list(APPEND extra_libs "boringssl_asm")
list(APPEND extra_libs "rtc_xmpp")
list(APPEND extra_libs "rtc_p2p")
list(APPEND extra_libs "usrsctplib")
list(APPEND extra_libs "video_capture_module_internal_impl")
list(APPEND extra_libs "rtc_pc")
list(APPEND extra_libs "srtp")

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
find_package(OpenSSL REQUIRED)
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

# C++ options
list(APPEND extra_libs "crypto")
list(APPEND extra_libs "dl")
list(APPEND extra_libs "ssl")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wno-unused-parameter")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0")

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # MaxOSX
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWEBRTC_MAC=1 -DWEBRTC_POSIX=1")
  find_library(CORE_FOUNDATION CoreFoundation)
  list(APPEND extra_libs ${CORE_FOUNDATION})
  find_library(FOUNDATION Foundation)
  list(APPEND extra_libs ${FOUNDATION})
  find_library(CORE_AUDIO CoreAudio)
  list(APPEND extra_libs ${CORE_AUDIO})
  find_library(AUDIO_TOOLBOX AudioToolbox)
  list(APPEND extra_libs ${AUDIO_TOOLBOX})
  find_library(CORE_GRAPHICS CoreGraphics)
  list(APPEND extra_libs ${CORE_GRAPHICS})

elseif(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
  # FreeBSD
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWEBRTC_POSIX=1")

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # Linux
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWEBRTC_LINUX=1")
  list(APPEND extra_libs "pthread")

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
  # Windows
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWEBRTC_WIN=1")
endif()

# Compile & link
file(GLOB HEADER_FILES "*.hpp")
file(GLOB DAEMON_FILES "*.cpp")

add_executable(processwarp
  ${HEADER_FILES}
  connector.cpp
  daemon.cpp
  frontend_connector.cpp
  network_connector.cpp
  router.cpp
  webrtc_bundle.cpp
  webrtc_connector.cpp
  worker_connector.cpp
  )
add_dependencies(processwarp
  const_processwarp
  const_core_constant
  )
target_link_libraries(processwarp
  pwcore
  ${extra_libs}
  sioclient_tls
  )

add_executable(worker
  ${HEADER_FILES}
  worker.cpp
  )
add_dependencies(worker
  const_processwarp
  const_core_constant
  )
target_link_libraries(worker
  pwcore
  ${extra_libs}
  )

# Install
if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  install(TARGETS processwarp DESTINATION ${PROJECT_SOURCE_DIR}/bin)
  install(TARGETS worker DESTINATION ${PROJECT_SOURCE_DIR}/bin)
endif()

