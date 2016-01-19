
#include <android/log.h>
#include <router_jni.h>

#include <memory>

#include "convert.hpp"
#include "jni_util.hpp"
#include "scheduler.hpp"

namespace processwarp {
std::unique_ptr<processwarp::Scheduler> scheduler;

/*
 * Class:     org_processwarp_android_Router
 * Method:    schedulerInitialize
 * Signature: ()V
 */
extern "C" JNIEXPORT void JNICALL Java_org_processwarp_android_Router_schedulerInitialize
(JNIEnv* env, jobject caller) {
  __android_log_print(ANDROID_LOG_VERBOSE, "native", "scheduler::initialize\n");

  scheduler.reset(new processwarp::Scheduler());
}

/*
 * Class:     org_processwarp_android_Router
 * Method:    schedulerGetDstNid
 * Signature: (Ljava/lang/String;I)Ljava/lang/String;
 */
extern "C" JNIEXPORT jstring JNICALL Java_org_processwarp_android_Router_schedulerGetDstNid
(JNIEnv* env, jobject caller, jstring jpid, jint jmodule) {
  __android_log_print(ANDROID_LOG_VERBOSE, "native", "scheduler::getDstNid\n");

  nid_t dst_nid = scheduler->get_dst_nid(jstr2vpid(env, jpid), jmodule);

  return env->NewStringUTF(Convert::nid2str(dst_nid).c_str());
}

/*
 * Class:     org_processwarp_android_Router
 * Method:    schedulerRecvCommand
 * Signature: (Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
 */
extern "C" JNIEXPORT void JNICALL Java_org_processwarp_android_Router_schedulerRecvCommand(
    JNIEnv* env, jobject caller, jstring jpid, jstring jdst_nid, jstring jsrc_nid,
    int jmodule, jstring jcontent) {
  __android_log_print(ANDROID_LOG_VERBOSE, "native", "scheduler::recvCommand\n");
  /// @todo
}

/*
 * Class:     org_processwarp_android_Router
 * Method:    schedulerSetMyNid
 * Signature: (Ljava/lang/String;)V
 */
extern "C" JNIEXPORT void JNICALL Java_org_processwarp_android_Router_schedulerSetMyNid
(JNIEnv* env, jobject caller, jstring jnid) {
  __android_log_print(ANDROID_LOG_VERBOSE, "native", "scheduler::setMyNid\n");

  scheduler->set_my_nid(jstr2nid(env, jnid));
}

/*
 * Class:     org_processwarp_android_Router
 * Method:    schedulerActivate
 * Signature: ()V
 */
extern "C" JNIEXPORT void JNICALL Java_org_processwarp_android_Router_schedulerActivate
(JNIEnv* env, jobject caller) {
  __android_log_print(ANDROID_LOG_VERBOSE, "native", "scheduler::activate\n");

  scheduler->activate();
}
}  // namespace processwarp
