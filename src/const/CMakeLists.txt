
add_custom_command(
  OUTPUT ${PROJECT_SOURCE_DIR}/src/const/loader_mid.hpp
  COMMAND python
  ARGS ${PROJECT_SOURCE_DIR}/script/gen_message.py c LoaderMid ${PROJECT_SOURCE_DIR}/src/const/loader_mid ${PROJECT_SOURCE_DIR}/src/const/loader_log.tsv
  DEPENDS ${PROJECT_SOURCE_DIR}/script/gen_message.py ${PROJECT_SOURCE_DIR}/src/const/loader_log.tsv
  )
add_custom_target(const_loader
  SOURCES ${PROJECT_SOURCE_DIR}/src/const/loader_mid.hpp)

add_custom_command(
  OUTPUT ${PROJECT_SOURCE_DIR}/src/const/core_mid.hpp
  COMMAND python
  ARGS ${PROJECT_SOURCE_DIR}/script/gen_message.py c CoreMid ${PROJECT_SOURCE_DIR}/src/const/core_mid ${PROJECT_SOURCE_DIR}/src/const/core_log.tsv
  DEPENDS ${PROJECT_SOURCE_DIR}/script/gen_message.py ${PROJECT_SOURCE_DIR}/src/const/core_log.tsv
  )
add_custom_target(const_core
  SOURCES ${PROJECT_SOURCE_DIR}/src/const/core_mid.hpp)

add_custom_command(
  OUTPUT ${PROJECT_SOURCE_DIR}/src/const/daemon_mid.hpp
  COMMAND python
  ARGS ${PROJECT_SOURCE_DIR}/script/gen_message.py c DaemonMid ${PROJECT_SOURCE_DIR}/src/const/daemon_mid ${PROJECT_SOURCE_DIR}/src/const/daemon_log.tsv
  DEPENDS ${PROJECT_SOURCE_DIR}/script/gen_message.py ${PROJECT_SOURCE_DIR}/src/const/daemon_log.tsv
  )
add_custom_target(const_daemon
  SOURCES ${PROJECT_SOURCE_DIR}/src/const/daemon_mid.hpp)
