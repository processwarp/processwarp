
include_directories(third_party/picojson)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D PICOJSON_USE_LOCALE=0")
include_directories(third_party/safeint)

add_subdirectory(core)
add_subdirectory(daemon)
