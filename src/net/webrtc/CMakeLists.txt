
# WebRTC
include_directories(${WEBRTC_INCLUDE_DIR})

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # MaxOSX
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWEBRTC_MAC=1 -DWEBRTC_POSIX=1")

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  # Emscripten
elseif(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
  # FreeBSD
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # Linux
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWEBRTC_LINUX=1 -DWEBRTC_POSIX=1")

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
  # Windows
endif()

# Header files
file(GLOB HEADER_FILES "*.hpp")
set(PWWEBRTC_FILES
  routing.cpp
  server_connector.cpp
  webrtc_bundle.cpp
  webrtc_connector.cpp
  webrtc_edge.cpp
  )

add_library(pwwebrtc STATIC
  ${HEADER_FILES}
  ${PWWEBRTC_FILES}
  )
add_dependencies(pwwebrtc
  const_processwarp
  const_core_constant
  )
