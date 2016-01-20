#include <router_jni.h>

#include <cassert>
#include <memory>
#include <string>

#include "convert.hpp"
#include "jni_util.hpp"
#include "scheduler.hpp"

namespace processwarp {
class DelegateJni : public SchedulerDelegate {
 public:
  JNIEnv* env;

  /**
   * Initialize Scheduler delegate - JNI wrapper.
   * Incliment reference counter for Router in JVM, and get reference to method to call java method.
   * @param env_ JNI instance.
   * @param router_ Router instance in JVM.
   */
  void initialize(JNIEnv* env_, jobject& router_) {
    JniUtil::log_v("delegate::initialize\n");
    env = env_;
    router = env->NewGlobalRef(router_);

    jclass clazz = env->GetObjectClass(router);
    create_vm_id = env->GetMethodID(clazz, "schedulerCreateVm",
                                    "(Ljava/lang/String;JJLjava/lang/String;)V");
    create_gui_id = env->GetMethodID(clazz, "schedulerCreateGui",
                                     "(Ljava/lang/String;)V");
    send_command_id = env->GetMethodID(clazz, "schedulerSendCommand",
                                       "(Ljava/lang/String;Ljava/lang/String;"
                                       "Ljava/lang/String;ILjava/lang/String;)V");
    assert(create_vm_id != nullptr);
    assert(create_gui_id != nullptr);
    assert(send_command_id != nullptr);
  }

 private:
  jobject router;
  jmethodID create_vm_id;
  jmethodID create_gui_id;
  jmethodID send_command_id;

  /**
   * When scheduler require create vm, call java method to do it.
   * @param scheduler Caller instance.
   * @param pid Process-id for new vm.
   * @param root_tid Root thread-id for new vm.
   * @param proc_addr Address of process information for new vm.
   * @param master_nid Node-id of master node for new vm.
   */
  void scheduler_create_vm(Scheduler& scheduler, const vpid_t& pid, vtid_t root_tid,
                           vaddr_t proc_addr, const nid_t& master_nid) override {
    JniUtil::log_v("delegate::scheduler_create_vm\n");
    jstring jpid = env->NewStringUTF(Convert::vpid2str(pid).c_str());
    jstring jnid = env->NewStringUTF(Convert::nid2str(master_nid).c_str());

    env->CallVoidMethod(router, create_vm_id,
                        jpid,
                        *reinterpret_cast<jlong*>(&root_tid),
                        *reinterpret_cast<jlong*>(&proc_addr),
                        jnid);

    env->DeleteLocalRef(jpid);
    env->DeleteLocalRef(jnid);
  }

  /**
   * When scheduler require create GUI, call java methid to do it.
   * @param scheduler Caller instance.
   * @param pid Process-id for new GUI.
   */
  void scheduler_create_gui(Scheduler& scheduler, const vpid_t& pid) override {
    JniUtil::log_v("delegate::scheduler_create_gui\n");
    jstring jpid = env->NewStringUTF(Convert::vpid2str(pid).c_str());

    env->CallVoidMethod(router, create_gui_id, jpid);
    env->DeleteLocalRef(jpid);
  }

  /**
   * When scheduler require send a command, call java methid to do it.
   * @param scheduler Caller instance.
   * @param packet Command packet.
   */
  void scheduler_send_command(Scheduler& scheduler, const CommandPacket& packet) override {
    JniUtil::log_v("delegate::schedule_send_command\n");
    jstring jpid = env->NewStringUTF(Convert::vpid2str(packet.pid).c_str());
    jstring jdst_nid = env->NewStringUTF(Convert::nid2str(packet.dst_nid).c_str());
    jstring jsrc_nid = env->NewStringUTF(Convert::nid2str(packet.src_nid).c_str());
    jstring jcontent = env->NewStringUTF(picojson::value(packet.content).serialize().c_str());

    env->CallVoidMethod(router, send_command_id,
                        jpid,
                        jdst_nid,
                        jsrc_nid,
                        *reinterpret_cast<const jint*>(&packet.module),
                        jcontent);

    env->DeleteLocalRef(jpid);
    env->DeleteLocalRef(jdst_nid);
    env->DeleteLocalRef(jsrc_nid);
    env->DeleteLocalRef(jcontent);
  }
};

std::unique_ptr<processwarp::Scheduler> scheduler;
DelegateJni delegate_jni;

/*
 * Class:     org_processwarp_android_Router
 * Method:    schedulerInitialize
 * Signature: ()V
 */
extern "C" JNIEXPORT void JNICALL Java_org_processwarp_android_Router_schedulerInitialize
(JNIEnv* env, jobject caller, jobject router) {
  JniUtil::log_v("scheduler::initialize\n");

  delegate_jni.initialize(env, router);
  scheduler.reset(new processwarp::Scheduler());
  scheduler->initialize(delegate_jni);
}

/*
 * Class:     org_processwarp_android_Router
 * Method:    schedulerGetDstNid
 * Signature: (Ljava/lang/String;I)Ljava/lang/String;
 */
extern "C" JNIEXPORT jstring JNICALL Java_org_processwarp_android_Router_schedulerGetDstNid
(JNIEnv* env, jobject caller, jstring jpid, jint jmodule) {
  JniUtil::log_v("scheduler::getDstNid\n");
  assert(delegate_jni.env == env);

  nid_t dst_nid = scheduler->get_dst_nid(JniUtil::jstr2vpid(env, jpid), jmodule);

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
  JniUtil::log_v("scheduler::recvCommand\n");
  assert(delegate_jni.env == env);

  picojson::value v;
  std::istringstream is(JniUtil::jstr2str(env, jcontent));
  std::string err = picojson::parse(v, is);
  if (!err.empty()) {
    /// @todo error
    assert(false);
  }

  CommandPacket packet = {
    JniUtil::jstr2vpid(env, jpid),
    JniUtil::jstr2nid(env, jdst_nid),
    JniUtil::jstr2nid(env, jsrc_nid),
    jmodule,
    v.get<picojson::object>()
  };

  scheduler->recv_command(packet);
}

/*
 * Class:     org_processwarp_android_Router
 * Method:    schedulerSetMyNid
 * Signature: (Ljava/lang/String;)V
 */
extern "C" JNIEXPORT void JNICALL Java_org_processwarp_android_Router_schedulerSetMyNid
(JNIEnv* env, jobject caller, jstring jnid) {
  JniUtil::log_v("scheduler::setMyNid\n");
  assert(delegate_jni.env == env);

  scheduler->set_my_nid(JniUtil::jstr2nid(env, jnid));
}

/*
 * Class:     org_processwarp_android_Router
 * Method:    schedulerActivate
 * Signature: ()V
 */
extern "C" JNIEXPORT void JNICALL Java_org_processwarp_android_Router_schedulerActivate
(JNIEnv* env, jobject caller) {
  JniUtil::log_v("scheduler::activate\n");
  assert(delegate_jni.env == env);

  scheduler->activate();
}
}  // namespace processwarp