find_package(PkgConfig)

# ffi
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

# fluentd
if (WITH_LOG_FLUENTD)
  list(APPEND extra_libs "fluent")
  link_directories(${PROJECT_SOURCE_DIR}/local/lib)
endif (WITH_LOG_FLUENTD)

# LLVM (http://llvm.org/docs/CMake.html)
find_package(LLVM CONFIG REQUIRED)
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  list(APPEND llvm_libs "-L/usr/lib/llvm-3.6/lib/ -lLLVMIRReader -lLLVMBitReader -lLLVMAsmParser -lLLVMCore -lLLVMSupport -lcurses")
else()
  llvm_map_components_to_libnames(llvm_libs support core irreader)
endif()
list(APPEND extra_libs ${llvm_libs})
add_definitions(${LLVM_DEFINITIONS})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D ENABLE_LLVM")

# OpenSSL
find_package(OpenSSL REQUIRED)
include_directories(${OPENSSL_INCLUDE_DIR})
list(APPEND extra_libs ${OPENSSL_LIBRARIES})

# RE2
if(WITH_RE2)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWITH_RE2=1")
  include_directories(${PROJECT_SOURCE_DIR}/lib/re2)
  link_directories(${PROJECT_SOURCE_DIR}/tmp/re2/src/RE2-build)
  list(APPEND extra_libs re2)
endif()

# C++ options
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Wno-unused-parameter")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0")

list(APPEND extra_libs "pthread")
list(APPEND extra_libs "dl")

set(LOADER_FILES
  llvm_asm_loader.cpp
  llvm_util.cpp
  loader.cpp
  )

add_executable(loader
  ${LOADER_FILES}
  )
add_dependencies(loader
  const_loader
  const_core_constant
  )
target_link_libraries(loader
  pwcore
  ${extra_libs}
  )
install(TARGETS loader DESTINATION ${PROJECT_SOURCE_DIR}/bin)
