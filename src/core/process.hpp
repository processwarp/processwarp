#pragma once

#include <ctime>
#include <map>
#include <memory>
#include <set>
#include <stack>
#include <string>
#include <utility>
#include <vector>

#include "dynamic_library.hpp"
#include "error.hpp"
#include "func_store.hpp"
#include "lock.hpp"
#include "symbols.hpp"
#include "thread.hpp"
#include "vmemory.hpp"

namespace processwarp {
class Process;

/**
 * Delegate for Process
 */
class ProcessDelegate {
 public:
  virtual ~ProcessDelegate();

  virtual std::unique_ptr<VMemory::Accessor> process_assign_accessor(const vpid_t& pid) = 0;
  virtual void process_change_thread_set(Process& process) = 0;
  virtual void process_on_invoke_thread(Process& process, vtid_t tid) = 0;
};

/**
 * 仮想マシンクラス。
 * 仮想マシンは１つのメモリ空間、複数のスレッド、コマンド実行から成り立つ。
 */
class Process {
 public:
  /** 大域変数、関数シンボル→アドレス型 */
  typedef std::map<const Symbols::Symbol*, vaddr_t> Globals;
  /** 組み込みアドレス一覧 */
  typedef std::set<vaddr_t> BuiltinAddrs;
  /** 終了処理時に呼び出す関数一覧 */
  typedef std::stack<vaddr_t> CallsAtExit;

  /** Deleagetr. */
  ProcessDelegate& delegate;
  /** Accessotr to binded memory. */
  std::unique_ptr<VMemory::Accessor> proc_memory;
  /** Address of process information. */
  const vaddr_t addr;
  /** My process-id. */
  const vpid_t pid;
  /** Root thread-id. */
  const vtid_t root_tid;

  /** Loaded external libraries for ffi. */
  const std::vector<DynamicLibrary::lib_handler_t>& libs;
  /** Map of API name call from and call for that can access. */
  const std::map<std::string, std::string>& lib_filter;
  /** Map of API name and built-in function pointer and parameter. */
  const std::map<std::string, std::pair<builtin_func_t, BuiltinFuncParam>>& builtin_funcs;

  BuiltinAddrs builtin_addrs;   //< 組み込みアドレス一覧(他にコピーしない)
  CallsAtExit calls_at_exit;    //< 終了処理時に呼び出す関数一覧
  Globals globals;    ///< 大域変数、関数シンボル→アドレス
  Symbols symbols;    ///< シンボル

  std::map<vtid_t, std::unique_ptr<Thread>> threads;
  std::set<vtid_t> active_threads;
  Lock::Mutex mutex_threads;

  std::map<vtid_t, NodeID> require_warp_threads;
  Lock::Mutex mutex_require_warp_threads;

  std::map<vaddr_t, void*> native_ptr;  ///< 仮想アドレスとネイティブポインタのペア
  /** Process name. */
  std::string name;

  /** Thread-ids waiting to get memory data and create instance on warp phase. (not dump) */
  std::set<vtid_t> waiting_warp_setup;

  /** Thread-ids and timestamp waiting to dealt with on warp phase. (not dump) */
  std::map<vtid_t, std::time_t> waiting_warp_result;
  Lock::Mutex mutex_waiting_warp_result;
  Lock::Cond cond_waiting_warp_result;

  /**
   * Allocate process on memory from delegate.
   * if master_nid is "" then allocate memory as master otherwise copy.
   * @param delegate
   * @param pid
   * @param root_tid
   * @param libs
   * @param lib_filter
   * @param builtin_funcs
   */
  static std::unique_ptr<Process>
  alloc(ProcessDelegate& delegate,
        const vpid_t& pid,
        vtid_t root_tid,
        const std::vector<DynamicLibrary::lib_handler_t>& libs,
        const std::map<std::string, std::string>& lib_filter,
        const std::map<std::string, std::pair<builtin_func_t, BuiltinFuncParam>>& builtin_funcs);

  static std::unique_ptr<Process>
  alloc(ProcessDelegate& delegate,
        const vpid_t& pid,
        vtid_t root_tid,
        const std::vector<DynamicLibrary::lib_handler_t>& libs,
        const std::map<std::string, std::string>& lib_filter,
        const std::map<std::string, std::pair<builtin_func_t, BuiltinFuncParam>>& builtin_funcs,
        vaddr_t proc_addr,
        const NodeID& master_nid);

  /**
   * Read out process information from memory.
   * @param delegate
   * @param memory
   * @param addr
   * @param libs
   * @param lib_filter
   * @param builtin_funcs
   */
  static std::unique_ptr<Process>
  read(ProcessDelegate& delegate,
       std::unique_ptr<VMemory::Accessor> memory,
       vaddr_t addr,
       const std::vector<DynamicLibrary::lib_handler_t>& libs,
       const std::map<std::string, std::string>& lib_filter,
       const std::map<std::string, std::pair<builtin_func_t, BuiltinFuncParam>>& builtin_funcs);

  /**
   * 外部の関数を呼び出す。
   * @param func 外部の関数情報
   * @param ret_addr 戻り値の格納場所(実際のアドレス)
   * @param args 引数(型とデータを交互にかくのうしたもの)
   */
  void call_external(Thread& thread,
                     const FuncStore& func,
                     vaddr_t ret_addr,
                     std::vector<uint8_t>& args);

  /**
   * Setup to call function that type : void (*)(void).
   * @param thread thread in running.
   * @param func_addr addr of target function.
   */
  void call_setup_voidfunc(Thread& thread, vaddr_t func_addr);

  /**
   * 終了処理を行う。
   */
  void close();

  /**
   * Get activated thread instance have had process.
   * @param 
   */
  Thread& get_thread(vtid_t addr);

  /**
   * Warp out thread.
   * Activate exist thread assigned in address.
   * @param tid
   */
  void warp_out_thread(vtid_t tid);

  /**
   * Create a new thread and activate.
   * @param thread Current thread.
   * @param func_addr Entry point for new thread.
   * @param arg_addr Argument for entry point.
   * @return Assigned thread-id for new thread.
   */
  vtid_t create_thread(Thread& thread, vaddr_t func_addr, vaddr_t arg_addr);

  /**
   *
   */
  void detach_thread(vtid_t tid);

  /**
   * Prepare to exit a thread.
   * @param thread Target thread.
   * @param retval Thread's return value.
   */
  void exit_thread(Thread& thread, vaddr_t retval);

  /**
   * Free a instance of thread, leave stack-top for join thread if need.
   * @param thread Target thread.
   * @return True if thread instance was disabled yet (Dont access).
   */
  bool destroy_thread(Thread& thread);

  /**
   * Join a thread.
   * @param current Current thread (join from).
   * @param target Join target thread.
   * @param retval Saved addr.
   * @return True if joined. False if waiting.
   */
  bool join_thread(vtid_t current, vtid_t target, vaddr_t retval);

  /**
   * Execute instructions.
   * @param thread Target thread.
   * @param max_clock max instruction count for context switching.
   */
  void execute(Thread& thread, int max_clock);

  /**
   * Change status in order to exit force.
   * This method have effect when root-thread is exist on this node.
   */
  void terminate();

  /**
   * ライブラリなど、外部の関数へのポインタを取得する。
   * @param name 関数の名称
   * @return 関数へのポインタ
   */
  DynamicLibrary::external_func_t get_external_func(const Symbols::Symbol& name);

  /**
   * 組み込み関数用に引数を取り出す(ポインタ)。
   * 読み出そうとした引数が格納された型と異なったり、オーバーフローした場合エラーとなる。
   * @param src 呼び出しパラメタ格納先。
   * @param seek seek位置。
   * @return 読みだした値。
   */
  static vaddr_t read_builtin_param_ptr(const std::vector<uint8_t>& src, int* seek);

  /**
   * 組み込み関数用に引数を取り出す(int8_t)。
   * 読み出そうとした引数が格納された型と異なったり、オーバーフローした場合エラーとなる。
   * @param src 呼び出しパラメタ格納先。
   * @param seek seek位置。
   * @return 読みだした値。
   */
  static uint8_t  read_builtin_param_i8(const std::vector<uint8_t>& src, int* seek);

  /**
   * 組み込み関数用に引数を取り出す(int16_t)。
   * 読み出そうとした引数が格納された型と異なったり、オーバーフローした場合エラーとなる。
   * @param src 呼び出しパラメタ格納先。
   * @param seek seek位置。
   * @return 読みだした値。
   */
  static uint16_t read_builtin_param_i16(const std::vector<uint8_t>& src, int* seek);

  /**
   * 組み込み関数用に引数を取り出す(int32_t)。
   * 読み出そうとした引数が格納された型と異なったり、オーバーフローした場合エラーとなる。
   * @param src 呼び出しパラメタ格納先。
   * @param seek seek位置。
   * @return 読みだした値。
   */
  static uint32_t read_builtin_param_i32(const std::vector<uint8_t>& src, int* seek);

  /**
   * 組み込み関数用に引数を取り出す(int64_t)。
   * 読み出そうとした引数が格納された型と異なったり、オーバーフローした場合エラーとなる。
   * @param src 呼び出しパラメタ格納先。
   * @param seek seek位置。
   * @return 読みだした値。
   */
  static uint64_t read_builtin_param_i64(const std::vector<uint8_t>& src, int* seek);

  /**
   * Get argument as vm_uint_t for built-in methods.
   * This method is just wrapping read_builtin_param_i32.
   */
  static inline vm_uint_t read_builtin_param_i(const std::vector<uint8_t>& src, int* seek) {
    return read_builtin_param_i32(src, seek);
  }

  /**
   * Get argument as size_t for built-in methods.
   * This method is just wrapping read_builtin_param_i64.
   */
  static inline uint64_t read_builtin_param_size(const std::vector<uint8_t>& src, int* seek) {
    return read_builtin_param_i64(src, seek);
  }

  bool require_warp(vtid_t tid, const NodeID& dst_nid);

  /**
   * StackInfoのキャッシュを解決し、実行前の状態にする。
   * @param thread stackinfoが所属するThread
   * @param stackinfo キャッシュ解決対象のStackInfo
   */
  void resolve_stackinfo_cache(Thread& thread, StackInfo* stackinfo);

  /**
   * アプリケーションの初期設定をする。
   * エントリポイントに対するクロージャを作成し、実行可能な状態を作る。
   * @param args エントリポイントへ渡すコマンドライン引数。
   * @param envs エントリポイントへ渡す環境変数。
   */
  void run(const std::vector<std::string>& args,
           const std::map<std::string, std::string>& envs);

  /**
   * 大域変数のアドレスを設定する。
   * @param name 大域変数名
   * @param addr 大域変数に登録するアドレス。
   */
  void set_global_value(const std::string& name, vaddr_t addr);

  /**
   * 初期設定をする。
   */
  void setup();

 private:
  struct CreateThreadInfo {
    vaddr_t func_addr;
    vaddr_t arg_addr;
    vtid_t tid;
    std::unique_ptr<Thread> thread;
    vaddr_t root_stack;
    vaddr_t root_stackaddr;
    vaddr_t func_stackaddr;

    CreateThreadInfo(vaddr_t func_addr_, vaddr_t arg_addr_);
  };

  std::unique_ptr<CreateThreadInfo> create_thread_info;

  /**
   * Constructor.
   * @param delegate Delegater.
   * @param pid Assigned process-id.
   * @param root_tid Root thread-id.
   * @param libs List of external libraries.
   * @param lib_filter Map of API name call from and call for.
   */
  Process(ProcessDelegate& delegate,
          std::unique_ptr<VMemory::Accessor> proc_memory,
          const vaddr_t addr,
          const vpid_t& pid,
          const vtid_t& root_tid,
          const std::vector<DynamicLibrary::lib_handler_t>& libs,
          const std::map<std::string, std::string>& lib_filter,
          const std::map<std::string, std::pair<builtin_func_t, BuiltinFuncParam>>& builtin_funcs);
};
}  // namespace processwarp
