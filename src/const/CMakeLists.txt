
add_custom_command(
  OUTPUT ${PROCESSWARP_SOURCE_DIR}/src/const/loader_mid.hpp
  COMMAND python
  ARGS ${PROCESSWARP_SOURCE_DIR}/script/gen_message.py c LoaderMid ${PROCESSWARP_SOURCE_DIR}/src/const/loader_mid ${PROCESSWARP_SOURCE_DIR}/src/const/loader_log.tsv
  DEPENDS ${PROCESSWARP_SOURCE_DIR}/script/gen_message.py ${PROCESSWARP_SOURCE_DIR}/src/const/loader_log.tsv
  )
add_custom_target(const_loader
  SOURCES ${PROCESSWARP_SOURCE_DIR}/src/const/loader_mid.hpp)

add_custom_command(
  OUTPUT ${PROCESSWARP_SOURCE_DIR}/src/const/core_mid.hpp
  COMMAND python
  ARGS ${PROCESSWARP_SOURCE_DIR}/script/gen_message.py c CoreMid ${PROCESSWARP_SOURCE_DIR}/src/const/core_mid ${PROCESSWARP_SOURCE_DIR}/src/const/core_log.tsv
  DEPENDS ${PROCESSWARP_SOURCE_DIR}/script/gen_message.py ${PROCESSWARP_SOURCE_DIR}/src/const/core_log.tsv
  )
add_custom_target(const_core
  SOURCES ${PROCESSWARP_SOURCE_DIR}/src/const/core_mid.hpp)

add_custom_command(
  OUTPUT ${PROCESSWARP_SOURCE_DIR}/src/const/daemon_mid.hpp
  COMMAND python
  ARGS ${PROCESSWARP_SOURCE_DIR}/script/gen_message.py c DaemonMid ${PROCESSWARP_SOURCE_DIR}/src/const/daemon_mid ${PROCESSWARP_SOURCE_DIR}/src/const/daemon_log.tsv ${PROCESSWARP_SOURCE_DIR}/src/const/core_log.tsv
  DEPENDS ${PROCESSWARP_SOURCE_DIR}/script/gen_message.py ${PROCESSWARP_SOURCE_DIR}/src/const/daemon_log.tsv ${PROCESSWARP_SOURCE_DIR}/src/const/core_log.tsv
  )
add_custom_target(const_processwarp
  SOURCES ${PROCESSWARP_SOURCE_DIR}/src/const/daemon_mid.hpp)

add_custom_command(
  OUTPUT ${PROCESSWARP_SOURCE_DIR}/src/core/constant.hpp
  COMMAND python
  ARGS ${PROCESSWARP_SOURCE_DIR}/script/gen_constant.py --cpp-dst ${PROCESSWARP_SOURCE_DIR}/src/core/constant.hpp ${PROCESSWARP_SOURCE_DIR}/src/const/definition.json ${PROCESSWARP_SOURCE_DIR}/src/const/module.json ${PROCESSWARP_SOURCE_DIR}/src/const/nid.json ${PROCESSWARP_SOURCE_DIR}/src/const/packet_mode.json ${PROCESSWARP_SOURCE_DIR}/src/const/packet_error.json ${PROCESSWARP_SOURCE_DIR}/src/const/pid.json
  DEPENDS ${PROCESSWARP_SOURCE_DIR}/script/gen_constant.py ${PROCESSWARP_SOURCE_DIR}/src/const/definition.json ${PROCESSWARP_SOURCE_DIR}/src/const/module.json ${PROCESSWARP_SOURCE_DIR}/src/const/nid.json ${PROCESSWARP_SOURCE_DIR}/src/const/packet_mode.json ${PROCESSWARP_SOURCE_DIR}/src/const/packet_error.json ${PROCESSWARP_SOURCE_DIR}/src/const/pid.json
  )
add_custom_target(const_core_constant
  SOURCES ${PROCESSWARP_SOURCE_DIR}/src/core/constant.hpp)

add_custom_command(
  OUTPUT ${PROCESSWARP_SOURCE_DIR}/src/electron/constant.js
  COMMAND python
  ARGS ${PROCESSWARP_SOURCE_DIR}/script/gen_constant.py --nodejs-dst ${PROCESSWARP_SOURCE_DIR}/src/electron/constant.js ${PROCESSWARP_SOURCE_DIR}/src/const/definition.json ${PROCESSWARP_SOURCE_DIR}/src/const/nid.json ${PROCESSWARP_SOURCE_DIR}/src/const/packet_mode.json ${PROCESSWARP_SOURCE_DIR}/src/const/packet_error.json ${PROCESSWARP_SOURCE_DIR}/src/const/pid.json ${PROCESSWARP_SOURCE_DIR}/src/const/module.json
  DEPENDS ${PROCESSWARP_SOURCE_DIR}/script/gen_constant.py ${PROCESSWARP_SOURCE_DIR}/src/const/definition.json ${PROCESSWARP_SOURCE_DIR}/src/const/nid.json ${PROCESSWARP_SOURCE_DIR}/src/const/packet_mode.json ${PROCESSWARP_SOURCE_DIR}/src/const/packet_error.json ${PROCESSWARP_SOURCE_DIR}/src/const/pid.json ${PROCESSWARP_SOURCE_DIR}/src/const/module.json
  )

add_custom_target(const_electron
  SOURCES ${PROCESSWARP_SOURCE_DIR}/src/electron/constant.js
  )
