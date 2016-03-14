
add_custom_target(const ALL
  COMMAND python ${PROJECT_SOURCE_DIR}/script/gen_message.py c LoaderMid ${PROJECT_SOURCE_DIR}/src/const/loader_mid ${PROJECT_SOURCE_DIR}/src/const/loader_log.tsv
  )
