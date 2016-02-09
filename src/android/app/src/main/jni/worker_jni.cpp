#include <worker_jni.h>

#include <map>
#include <memory>
#include <string>
#include <stack>
#include <vector>

#include "builtin_gui.hpp"
#include "jni_util.hpp"
#include "vmachine.hpp"
#include "vmemory.hpp"

namespace processwarp {
class WorkerJni : public VMachineDelegate, public VMemoryDelegate, public BuiltinGuiDelegate {
 public:
  /**
   * Push JNI instance, JNI methods must call this method to set JNI instance.
   * @param env JNI instance.
   */
  void push_env(JNIEnv* env) {
    env_stack.push(env);
  }

  /**
   * Pop JNI instance.
   */
  void pop_env() {
    env_stack.pop();
  }

  /**
   * Initialize worker - JNI wrapper.
   * Increment reference counter for Worker in JVM, and get reference to method to call java method.
   * Create new vm instance with passed parameters.
   * @param worker_ Worker instance in JVM.
   * @param my_nid_ Node-id for this node.
   * @param my_pid_ Process-id for new vm.
   * @param root_tid Root thread-id for new vm.
   * @param proc_addr Address of process information for new vm.
   * @parma master_nid Node-id of master node for new vm.
   * @param name Process name for new vm.
   */
  void initialize(jobject& worker_, const nid_t my_nid_, const vpid_t& my_pid_, vtid_t root_tid,
                  vaddr_t proc_addr, const nid_t master_nid, const std::string& name) {
    JniUtil::log_v("WorkerJni::initialize\n");
    JNIEnv* env = env_stack.top();
    worker = env->NewGlobalRef(worker_);

    jclass clazz = env->GetObjectClass(worker);
    send_command_id = env->GetMethodID(clazz, "workerSendCommand",
                                       "(Ljava/lang/String;Ljava/lang/String;"
                                       "Ljava/lang/String;ILjava/lang/String;)V");
    assert(send_command_id != nullptr);

    my_nid = my_nid_;
    my_pid = my_pid_;

    vm.reset(new VMachine(*this, *this, my_nid, libs, lib_filter));
    vm->initialize(my_pid, root_tid, proc_addr, master_nid, name);
    vm->initialize_gui(*this);
  }

  /**
   * Relay packet to capable module.
   * @param packet Command packet.
   */
  void relay_command(const CommandPacket& packet) {
    JniUtil::log_v("WorkerJni::relay_command\n");
    JNIEnv* env = env_stack.top();

    switch (packet.module) {
      case Module::MEMORY: {
        vm->vmemory.recv_command(packet);
      } break;

      case Module::VM: {
        vm->recv_command(packet);
      } break;

      default: {
        /// @todo error
        assert(false);
      }
    }
  }

  /**
   * Execute vm instruction some stepes.
   */
  void execute() {
    JniUtil::log_v("WorkerJni::execute\n");
    vm->execute();
  }

  /**
   * Delete reference to worker instance in JVM for quiting.
   */
  void quit() {
    JniUtil::log_v("WorkerJni::quit\n");
    JNIEnv* env = env_stack.top();

    env->DeleteGlobalRef(worker);
  }

 private:
  std::stack<JNIEnv*> env_stack;
  jobject worker;
  jmethodID send_command_id;

  /** Node-id for this node. */
  nid_t my_nid;
  /** vm's process-id. */
  vpid_t my_pid;

  /** Dynamic link libraries. */
  std::vector<void*> libs;
  /** Map of API name call from and call for that can access. */
  std::map<std::string, std::string> lib_filter;
  /** vm instance. */
  std::unique_ptr<VMachine> vm;


  /**
   * When vmachine require send command, relay it to RouterService.
   * RouterService process relay this command to target module in this node or another node through the server if need.
   * @param vm Caller instance.
   * @param packet Command packet.
   */
  void vmachine_send_command(VMachine& vm, const CommandPacket& packet) override {
    send_command(packet);
  }

  void vmachine_finish(VMachine& vm) override {
    /// @todo
    JniUtil::log_v("WorkerJni::vmachine_finish");
    assert(false);
  }

  void vmachine_finish_thread(VMachine& vm, const vtid_t& tid) override {
    /// @todo
    JniUtil::log_v("WorkerJni::vmachine_finish_thread");
    assert(false);
  }

  void vmachine_error(VMachine& vm, const std::string& message) override {
    /// @todo
    JniUtil::log_e("WorkerJni::vmachine_error\n%s", message.c_str());
    assert(false);
  }

  /**
   * When vmemory require send command, relay it to RouterService.
   * RouterService process relay this command to target module in this node or another node through the server if need.
   * @param memory Caller instance.
   * @param dst_nid Destination node-id.
   * @param module Target module.
   * @param command Command string.
   * @param param Parameter for command.
   */
  void vmemory_send_command(VMemory& memory, const nid_t& dst_nid, Module::Type module,
                            const std::string& command, picojson::object& param) override {
    assert(param.find("command") == param.end());

    param.insert(std::make_pair("command", picojson::value(command)));
    send_command({my_pid, dst_nid, SpecialNID::NONE, module, param});
  }

  /**
   * When vmemory tell update memory image by another node, relay this event to vm.
   * @param memory Caller instance.
   * @param addr Address updated.
   */
  void vmemory_recv_update(VMemory& memory, vaddr_t addr) override {
    assert(vm.get() != nullptr);

    vm->on_recv_update(addr);
  }

  /**
   * When built-in GUI module require send command, relay it to RouterService.
   * RouterService process relay this command to target module in this node or another node through the server if need.
   * @param proc Caller instance.
   * @param dst_nid Destination node-id.
   * @param module Target module.
   * @param command Command string.
   * @param param Parameter for command.
   */
  void builtin_gui_send_command(Process& proc, const nid_t& dst_nid, Module::Type module,
                                const std::string& command, picojson::object& param) override {
    assert(param.find("command") == param.end());

    param.insert(std::make_pair("command", picojson::value(command)));
    send_command({my_pid, dst_nid, SpecialNID::NONE, module, param});
  }

  /**
   * Call Java's Worker::workerSendCommand by JNI to send command packet.
   * @param packet Command packet.
   */
  void send_command(const CommandPacket& packet) {
    JNIEnv* env = env_stack.top();

    jstring jpid = env->NewStringUTF(Convert::vpid2str(packet.pid).c_str());
    jstring jdst_nid = env->NewStringUTF(Convert::nid2str(packet.dst_nid).c_str());
    jstring jsrc_nid = env->NewStringUTF(Convert::nid2str(my_nid).c_str());
    jstring jcontent = env->NewStringUTF(picojson::value(packet.content).serialize().c_str());

    env->CallVoidMethod(worker, send_command_id,
                        jpid,
                        jdst_nid,
                        jsrc_nid,
                        static_cast<jint>(packet.module),
                        jcontent);

    env->DeleteLocalRef(jpid);
    env->DeleteLocalRef(jdst_nid);
    env->DeleteLocalRef(jsrc_nid);
    env->DeleteLocalRef(jcontent);
  }
};

/**
 * Map of process-id and JNI worker wrapper instance.
 */
std::map<vpid_t, WorkerJni> workers;

/*
 * Class:     org_processwarp_android_Worker
 * Method:    workerInitialize
 * Signature: (Lorg/processwarp/android/Worker;Ljava/lang/String;Ljava/lang/String;JJLjava/lang/String;)V
 */
extern "C" JNIEXPORT void JNICALL Java_org_processwarp_android_Worker_workerInitialize(
    JNIEnv* env, jobject caller, jobject worker, jstring jmy_nid,
    jstring jmy_pid, jlong jroot_tid, jlong jproc_addr, jstring jmaster_nid, jstring jname) {
  JniUtil::log_v("workerInitialize\n");

  vpid_t pid = JniUtil::jstr2vpid(env, jmy_pid);

  WorkerJni& worker_jni = workers[pid];
  worker_jni.push_env(env);
  try {
    worker_jni.initialize(worker,
                          JniUtil::jstr2nid(env, jmy_nid),
                          pid,
                          *reinterpret_cast<vtid_t*>(&jroot_tid),
                          *reinterpret_cast<vaddr_t*>(&jproc_addr),
                          JniUtil::jstr2nid(env, jmaster_nid),
                          JniUtil::jstr2str(env, jname));
  } catch (...) {
    JniUtil::log_e("exception on workerInitialize");
  }
  worker_jni.pop_env();
}

/*
 * Class:     org_processwarp_android_Worker
 * Method:    workerRelayCommand
 * Signature: (Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
 */
extern "C" JNIEXPORT void JNICALL Java_org_processwarp_android_Worker_workerRelayCommand(
    JNIEnv* env, jobject caller, jstring jpid, jstring jdst_nid, jstring jsrc_nid,
    jint jmodule, jstring jcontent) {
  JniUtil::log_v("workerRelayCommand\n");

  picojson::value v;
  std::istringstream is(JniUtil::jstr2str(env, jcontent));
  std::string err = picojson::parse(v, is);
  if (!err.empty()) {
    /// @todo error
    assert(false);
  }

  vpid_t pid = JniUtil::jstr2vpid(env, jpid);
  CommandPacket packet = {
    pid,
    JniUtil::jstr2nid(env, jdst_nid),
    JniUtil::jstr2nid(env, jsrc_nid),
    jmodule,
    v.get<picojson::object>()
  };

  WorkerJni& worker_jni = workers.at(pid);
  worker_jni.push_env(env);
  try {
    worker_jni.relay_command(packet);
  } catch (...) {
    JniUtil::log_e("exception on workerRelayCommand");
  }
  worker_jni.pop_env();
}

/*
 * Class:     org_processwarp_android_Worker
 * Method:    workerExecute
 * Signature: (Ljava/lang/String;)V
 */
extern "C" JNIEXPORT void JNICALL Java_org_processwarp_android_Worker_workerExecute(
    JNIEnv* env, jobject caller, jstring jpid) {
  JniUtil::log_v("workerExecute");

  vpid_t pid = JniUtil::jstr2vpid(env, jpid);
  WorkerJni& worker_jni = workers.at(pid);

  worker_jni.push_env(env);
  try {
    worker_jni.execute();
  } catch (...) {
    JniUtil::log_e("exception on workerExecute");
  }
  worker_jni.pop_env();
}

/*
 * Class:     org_processwarp_android_Worker
 * Method:    workerQuit
 * Signature: (Ljava/lang/String;)V
 */
extern "C" JNIEXPORT void JNICALL Java_org_processwarp_android_Worker_workerQuit(
    JNIEnv* env, jobject caller, jstring jpid) {
  JniUtil::log_v("workerQuit\n");

  vpid_t pid = JniUtil::jstr2vpid(env, jpid);

  WorkerJni& worker_jni = workers.at(pid);
  worker_jni.push_env(env);
  try {
    worker_jni.quit();
  } catch (...) {
    JniUtil::log_e("exception on workerQuit");
  }
  worker_jni.pop_env();
  workers.erase(pid);
}
}  // namespace processwarp
