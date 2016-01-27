#pragma once

#include <android/log.h>
#include <jni.h>
#include <picojson.h>
#include <string>

#include "convert.hpp"
#include "definitions.hpp"

namespace processwarp {
namespace JniUtil {
/**
 * Convert Java string type to C++ std::string.
 * @param env Java instance.
 * @param jstr Java String.
 * @return C++ std::string.
 */
inline std::string jstr2str(JNIEnv* env, const jstring jstr) {
  const char* ptr = env->GetStringUTFChars(jstr, nullptr);
  std::string str(ptr);
  env->ReleaseStringUTFChars(jstr, ptr);

  return str;
}

/**
 * Convert Java string type to process-id.
 * @param env Java instance.
 * @param jpid Process-id Java string typed.
 * @return Process-id.
 */
inline vpid_t jstr2vpid(JNIEnv* env, const jstring jpid) {
  return Convert::str2vpid(jstr2str(env, jpid));
}

/**
 * Convert Java string type to node-id.
 * @param env Java instance.
 * @param jnid Node-id Java string typed.
 * @return Node-id.
 */
inline nid_t jstr2nid(JNIEnv* env, const jstring jnid) {
  return Convert::str2nid(jstr2str(env, jnid));
}

/**
 * Android log output macros.
 * @param NAME Log output function name.
 * @param LV Log level for android monitor.
 */
#define M_ANDROID_LOG(NAME, LV)                                         \
  inline void NAME(const char* format, ...) {                           \
    va_list arg;                                                        \
    va_start(arg, format);                                              \
    __android_log_vprint(ANDROID_LOG_##LV, "processwarp", format, arg); \
    va_end(arg);                                                        \
  }
M_ANDROID_LOG(log_v, VERBOSE);
M_ANDROID_LOG(log_d, DEBUG);
M_ANDROID_LOG(log_i, INFO);
M_ANDROID_LOG(log_w, WARN);
M_ANDROID_LOG(log_e, ERROR);
#undef M_ANDROID_LOG
}  // namespace JniUtil
}  // namespace processwarp
