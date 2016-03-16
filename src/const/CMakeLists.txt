
add_custom_target(const_loader ALL
  COMMAND python ${PROJECT_SOURCE_DIR}/script/gen_message.py c LoaderMid ${PROJECT_SOURCE_DIR}/src/const/loader_mid ${PROJECT_SOURCE_DIR}/src/const/loader_log.tsv
  )
add_custom_target(const_core ALL
  COMMAND python ${PROJECT_SOURCE_DIR}/script/gen_message.py c CoreMid ${PROJECT_SOURCE_DIR}/src/const/core_mid ${PROJECT_SOURCE_DIR}/src/const/core_log.tsv
  )
add_custom_target(const_daemon ALL
  COMMAND python ${PROJECT_SOURCE_DIR}/script/gen_message.py c DaemonMid ${PROJECT_SOURCE_DIR}/src/const/daemon_mid ${PROJECT_SOURCE_DIR}/src/const/daemon_log.tsv
  )
