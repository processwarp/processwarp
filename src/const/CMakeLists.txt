
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
add_custom_target(const_processwarp
  SOURCES ${PROJECT_SOURCE_DIR}/src/const/daemon_mid.hpp)

add_custom_command(
  OUTPUT ${PROJECT_SOURCE_DIR}/src/core/constant.hpp
  COMMAND python
  ARGS ${PROJECT_SOURCE_DIR}/script/gen_constant.py --cpp-dst ${PROJECT_SOURCE_DIR}/src/core/constant.hpp ${PROJECT_SOURCE_DIR}/src/const/definition.json ${PROJECT_SOURCE_DIR}/src/const/nid.json ${PROJECT_SOURCE_DIR}/src/const/pid.json ${PROJECT_SOURCE_DIR}/src/const/module.json
  DEPENDS ${PROJECT_SOURCE_DIR}/script/gen_constant.py ${PROJECT_SOURCE_DIR}/src/const/definition.json ${PROJECT_SOURCE_DIR}/src/const/nid.json ${PROJECT_SOURCE_DIR}/src/const/pid.json ${PROJECT_SOURCE_DIR}/src/const/module.json
  )
add_custom_target(const_core_constant
  SOURCES ${PROJECT_SOURCE_DIR}/src/core/constant.hpp)

add_custom_command(
  OUTPUT ${PROJECT_SOURCE_DIR}/src/electron/constant.js
  COMMAND python
  ARGS ${PROJECT_SOURCE_DIR}/script/gen_constant.py --nodejs-dst ${PROJECT_SOURCE_DIR}/src/electron/constant.js ${PROJECT_SOURCE_DIR}/src/const/definition.json ${PROJECT_SOURCE_DIR}/src/const/nid.json ${PROJECT_SOURCE_DIR}/src/const/pid.json ${PROJECT_SOURCE_DIR}/src/const/module.json
  DEPENDS ${PROJECT_SOURCE_DIR}/script/gen_constant.py ${PROJECT_SOURCE_DIR}/src/const/definition.json ${PROJECT_SOURCE_DIR}/src/const/nid.json ${PROJECT_SOURCE_DIR}/src/const/pid.json ${PROJECT_SOURCE_DIR}/src/const/module.json
  )

add_custom_target(const_electron
  SOURCES ${PROJECT_SOURCE_DIR}/src/electron/constant.js
  )
