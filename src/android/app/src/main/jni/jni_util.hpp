#pragma once

#include <picojson.h>

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
}  // namespace JniUtil
}  // namespace processwarp
