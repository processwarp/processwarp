find_package(PkgConfig)

if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  # libffi
  pkg_search_module(FFI libffi)
  if(FFI_FOUND)
    include_directories(${FFI_INCLUDE_DIRS})
    string(REPLACE ";" " " FFI_CFLAGS_STR "${FFI_CFLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FFI_CFLAGS_STR}")
    list(APPEND extra_libs ${FFI_LIBRARIES})
  else()
    find_library(FFI_LIBRARY NAMES ffi)
    set(extra_libs ${extra_libs} ${FFI_LIBRARY})
    if(FFI_INCLUDE_DIR)
      include_directories(${FFI_INCLUDE_DIR})
    endif()
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
endif()

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # MaxOSX
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  # Emscripten
elseif(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
  # FreeBSD
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # Linux
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
  # Windows
endif()

# Core files
file(GLOB HEADER_FILES "*.hpp")
set(PWCORE_FILES
  convert.cpp
  error.cpp
  func_store.cpp
  basic_operator.cpp
  builtin_bit.cpp
  builtin_gui.cpp
  builtin_libc.cpp
  builtin_memory.cpp
  builtin_overflow.cpp
  builtin_posix.cpp
  builtin_va_arg.cpp
  builtin_warp.cpp
  connector.cpp
  dynamic_library.cpp
  endless_order_id.cpp
  finally.cpp
  format.cpp
  interrupt_memory_require.cpp
  lock.cpp
  logger.cpp
  logger_stdout.cpp
  message.cpp
  node_id.cpp
  packet.cpp
  process.cpp
  scheduler.cpp
  stackinfo.cpp
  std_error.cpp
  symbols.cpp
  thread.cpp
  type_store.cpp
  utils.cpp
  vmachine.cpp
  vmemory.cpp
  wrapped_operator.cpp
  )

if (WITH_LOG_FLUENTD)
  list(APPEND PWCORE_FILES logger_fluentd.cpp)
endif (WITH_LOG_FLUENTD)

if (WITH_LOG_SYSLOG)
  list(APPEND PWCORE_FILES logger_syslog.cpp)
endif (WITH_LOG_SYSLOG)
  
if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  add_library(pwcore STATIC
    ${HEADER_FILES}
    ${PWCORE_FILES}
    )
  add_dependencies(pwcore
    const_core
    const_core_constant
    )
endif()

if(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  add_executable(webfront
    ${HEADER_FILES}
    ${PWCORE_FILES}
    main_webfront.cpp
    )
  add_dependencies(webfront
    const_core
    const_core_constant
    )
  target_link_libraries(webfront)
endif()
