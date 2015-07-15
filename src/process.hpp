#pragma once

#include <map>
#include <set>
#include <stack>
#include <string>
#include <vector>

#include "error.hpp"
#include "func_store.hpp"
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
    /**
     * Destructor for virtual.
     */
    virtual ~ProcessDelegate() {};

    /**
     * Call when create thread.
     * @param proc Caller process.
     * @return A new thread-id.
     */
    virtual vtid_t assign_tid(Process& proc) = 0;

    /**
     */
    virtual VMemory::Accessor assign_accessor() = 0;
  };
  
  /**
   * 仮想マシンクラス。
   * 仮想マシンは１つのメモリ空間、複数のスレッド、コマンド実行から成り立つ。
   */
  class Process {
  public:
    /** 組み込み関数一覧 */
    typedef std::map<const std::string, std::pair<builtin_func_t, BuiltinFuncParam>>
      BuiltinFuncs;
    /** 大域変数、関数シンボル→アドレス型 */
    typedef std::map<const Symbols::Symbol*, vaddr_t> Globals;
    /** スレッド一覧型 */
    typedef std::map<vtid_t, std::unique_ptr<Thread>> Threads;
    /** 組み込みアドレス一覧 */
    typedef std::set<vaddr_t> BuiltinAddrs;
    /** 終了処理時に呼び出す関数一覧 */
    typedef std::stack<vaddr_t> CallsAtExit;
    
    /** Deleagetr. */
    ProcessDelegate& delegate;
    /** Accessotr to binded memory. */
    VMemory::Accessor proc_memory;
    /** My process-id. */
    const vpid_t pid;
    /** Root thread-id. */
    const vtid_t root_tid;
    /** Loaded external libraries for ffi. */
    std::vector<void*>& libs;
    /**
     * Map of API name call from and call for that can access.
     * Key:API nam call from application.
     * Value:API name call for OS.
     */
    std::map<std::string, std::string> lib_filter;
    BuiltinFuncs builtin_funcs; //< 組み込み関数一覧
    BuiltinAddrs builtin_addrs; //< 組み込みアドレス一覧(他にコピーしない)
    CallsAtExit calls_at_exit; //< 終了処理時に呼び出す関数一覧
    Globals globals;    ///< 大域変数、関数シンボル→アドレス
    Symbols symbols;    ///< シンボル
    Threads threads;    ///< スレッド一覧
    std::map<vaddr_t, void*> native_ptr; ///< 仮想アドレスとネイティブポインタのペア
    
    /**
     * Constructor.
     * @param delegate Delegater.
     * @param pid Assigned process-id.
     * @param root_tid Root thread-id.
     * @param libs List of external libraries.
     * @param lib_filter Map of API name call from and call for.
     */
    Process(ProcessDelegate& delegate,
	     const vpid_t& pid,
	     const vtid_t& root_tid,
	     std::vector<void*>& libs,
	     const std::map<std::string, std::string>& lib_filter);

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
     * Create a new thread.
     * @param func_addr Entry point for new thread.
     * @param arg_addr Argument for entry point.
     * @return Assigned thread-id for new thread.
     */
    vtid_t create_thread(vaddr_t func_addr, vaddr_t arg_addr);

    /**
     *
     */
    void detach_thread(vtid_t tid);

    /**
     * Prepare to exit a thread.
     * @param tid Target thread.
     * @param retval Thread's return value.
     */
    void exit_thread(vtid_t tid, vaddr_t retval);

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
     * @param tid target thread-id.
     * @param max_clock max instruction count for context switching.
     */
    void execute(vtid_t tid, int max_clock);

    /**
     * Change status to exit.
     */
    void exit();

    /**
     * ライブラリなど、外部の関数へのポインタを取得する。
     * @param name 関数の名称
     * @return 関数へのポインタ
     */
    external_func_t get_external_func(const Symbols::Symbol& name);

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
    static uint8_t  read_builtin_param_i8 (const std::vector<uint8_t>& src, int* seek);
    
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
     * 組み込み関数を登録する。
     * @param name 関数名(C)。
     * @param func 組み込み関数へのポインタ。
     * @param i64 組み込み関数へ渡す固定パラメタ。
     */
    void regist_builtin_func(const std::string& name,
			       builtin_func_t func, int i64);

    /**
     * 組み込み関数を登録する。
     * @param name 関数名(C)。
     * @param func 組み込み関数へのポインタ。
     * @param i64 組み込み関数へ渡す固定パラメタ。
     */
    void regist_builtin_func(const std::string& name,
			       builtin_func_t func, void* ptr);

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

    /**
     * Prepare to warp out.
     * @param tid thread-id to warp out.
     */
    void setup_warpout(const vtid_t& tid);

    /**
     * Prepare to warp in.
     * @param tid thread-id to warp in.
     * @param dst Destination device-id.
     */
    bool setup_warpin(const vtid_t& tid, const dev_id_t& dst);
  };
}
