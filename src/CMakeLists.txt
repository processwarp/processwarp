find_package(PkgConfig)

if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  # LLVM (http://llvm.org/docs/CMake.html)
  find_package(LLVM CONFIG)
  if(LLVM_FOUND)
    message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
    message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
  
    include_directories(${LLVM_INCLUDE_DIRS})
    llvm_map_components_to_libnames(llvm_libs support core irreader)
    list(APPEND extra_libs ${llvm_libs})
    add_definitions(${LLVM_DEFINITIONS})
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D ENABLE_LLVM")
  endif()

  # GLFW
  # pkg_search_module(GLFW glfw3)
  if(GLFW_FOUND)
    include_directories(${GLFW_INCLUDE_DIRS})
    string(REPLACE ";" " " GLFW_CFLAGS_STR "${GLFW_CFLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GLFW_CFLAGS_STR}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D ENABLE_GLFW3")
    list(APPEND extra_libs ${GLFW_LIBRARIES})
  endif()

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
  endif()

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
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wno-unused-parameter")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0")

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # MaxOSX
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  # Emscripten
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-warn-absolute-paths")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --bind -s EXPORT_ALL=1")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s DISABLE_EXCEPTION_CATCHING=0")

elseif(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
  # FreeBSD
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
  list(APPEND extra_libs pthread)

elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # Linux
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
  list(APPEND extra_libs pthread)
  list(APPEND extra_libs dl)
endif()

if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  set(CORE_FILES
    error.cpp
    func_store.cpp
    basic_operator.cpp
    builtin_bit.cpp
    builtin_libc.cpp
    builtin_memory.cpp
    builtin_overflow.cpp
    builtin_posix.cpp
    builtin_va_arg.cpp
    builtin_warp.cpp
    main_core.cpp
    process.cpp
    socketio.cpp
    stackinfo.cpp
    std_error.cpp
    symbols.cpp
    thread.cpp
    type_store.cpp
    util.cpp
    vmachine.cpp
    vmemory.cpp
    wrapped_operator.cpp
    )
if(GLFW_FOUND)
  list(APPEND CORE_FILES builtin_glfw3.cpp)
endif()

  add_executable(core ${CORE_FILES})
  target_link_libraries(core ${extra_libs})
endif()

if(LLVM_FOUND AND NOT ${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  set(LOADER_FILES
    error.cpp
    func_store.cpp
    basic_operator.cpp
    builtin_bit.cpp
    builtin_libc.cpp
    builtin_memory.cpp
    builtin_overflow.cpp
    builtin_posix.cpp
    builtin_va_arg.cpp
    builtin_warp.cpp
    llvm_asm_loader.cpp
    main_loader.cpp
    process.cpp
    stackinfo.cpp
    std_error.cpp
    symbols.cpp
    thread.cpp
    type_store.cpp
    util.cpp
    vmemory.cpp
    wrapped_operator.cpp
    )
  if(GLFW_FOUND)
    list(APPEND LOADER_FILES builtin_glfw3.cpp)
  endif()
  add_executable(loader ${LOADER_FILES})
  target_link_libraries(loader ${extra_libs})
endif()

if(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
  set(WEBFRONT_FILES
    error.cpp
    func_store.cpp
    basic_operator.cpp
    builtin_bit.cpp
    builtin_glfw3.cpp
    builtin_libc.cpp
    builtin_memory.cpp
    builtin_overflow.cpp
    builtin_posix.cpp
    builtin_va_arg.cpp
    builtin_warp.cpp
    main_webfront.cpp
    process.cpp
    stackinfo.cpp
    std_error.cpp
    symbols.cpp
    thread.cpp
    type_store.cpp
    util.cpp
    vmachine.cpp
    vmemory.cpp
    wrapped_operator.cpp
    )

  add_executable(webfront ${WEBFRONT_FILES})
  target_link_libraries(webfront)
endif()
