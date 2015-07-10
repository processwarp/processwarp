#pragma once

#include <map>
#include <set>
#include <stack>
#include <string>
#include <vector>

#include "error.hpp"
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
    VMemory vmemory;    ///< 仮想メモリ空間
    std::map<vaddr_t, void*> native_ptr; ///< 仮想アドレスとネイティブポインタのペア
    vaddr_t last_free_native_ptr;
    
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
    void call_external(const FuncStore& func,
		       uint8_t* ret_addr,
		       std::vector<uint8_t>& args);

    /**
     * Setup to call function that type : void (*)(void).
     * @param thread thread in running.
     * @param func_addr addr of target function.
     */
    void call_setup_voidfunc(Thread& thread, vaddr_t func_addr);
    
    /**
     * 型のサイズと最大アライメントを計算する。
     * @param member 複合型のメンバ
     * @return <型のサイズ, 最大アライメント>
     */
    std::pair<size_t, unsigned int> calc_type_size(const std::vector<vaddr_t>& member);

    /**
     * 型のサイズと最大アライメントを計算する。
     * @param type 型
     * @return <型のサイズ, 最大アライメント>
     */
    std::pair<size_t, unsigned int> calc_type_size(vaddr_t type);

    /**
     * 終了処理を行う。
     */
    void close();

    /**
     * ネイティブポインタに仮想アドレス対応付ける。
     * get_raw_addr利用時に、引数に指定したアドレスが取得可能となる。
     * freeを利用して対応付けが解除される。
     * @param ptr ネイティブポインタ
     * @return 対応付けられた仮想アドレス。
     */
    vaddr_t create_native_ptr(void* ptr);

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
     * 配列型の型情報を作成する。
     * @param element 配列のメンバの型のアドレス
     * @param num 配列の要素数
     * @return 作成した値。
     */
    TypeStore& create_type_array(vaddr_t element, unsigned int num);

    /**
     * 基本型の型情報を作成する。
     * @param type 基本型。
     * @return 作成した値。
     */
    TypeStore& create_type_basic(BasicType type);

    /**
     * 構造体の型情報を作成する。
     * @param member 複合型のメンバ型のアドレス
     * @return 作成した値。
     */
    TypeStore& create_type_struct(const std::vector<vaddr_t>& member);

    /**
     * vectorの型情報を作成する。
     * @param element vectorのメンバの型のアドレス
     * @param num vectorの要素数
     * @return 作成した値。
     */
    TypeStore& create_type_vector(vaddr_t element, unsigned int num);

    /**
     * ネイティブ関数を指定アドレスに展開する。
     * 関数名を元に組み込み関数かライブラリ関数として分岐する。
     * @param name 関数名
     * @param ret_type 戻り値の型
     * @param arg_num 引数の数
     * @param is_var_arg 可変長引数かどうか
     * @param addr 展開先アドレス
     */
    void deploy_function(const std::string& name,
			 vaddr_t ret_type,
			 unsigned int arg_num,
			 bool is_var_arg,
			 vaddr_t addr);

    /**
     * 通常の関数(VMで解釈、実行する)を指定アドレスに展開する。
     * @param name 関数名
     * @param ret_type 戻り値の型
     * @param arg_num 引数の数
     * @param is_var_arg 可変長引数かどうか
     * @param prop 通常の関数のプロパティ
     * @param addr 展開先アドレス
     */
    void deploy_function_normal(const std::string& name,
				vaddr_t ret_type,
				unsigned int arg_num,
				bool is_var_arg,
				const FuncStore::NormalProp& prop,
				vaddr_t addr);

    /**
     * 仮想アドレスとネイティブポインタのペアを解消する。
     * @param addr 仮想アドレス
     */
    void destory_native_ptr(vaddr_t addr);

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
     * アドレスに格納された値にアクセスする。
     * @param アクセス先仮想アドレス。
     * @return アドレスに格納された値への参照。
     */
    template <typename T> T& get_by_addr(vaddr_t addr) {
      DataStore& store = vmemory.get_data(addr);
      // アクセス違反
      if (VMemory::get_addr_lower(addr) + sizeof(T) > store.size) {
	throw_error_message(Error::SEGMENT_FAULT, Util::vaddr2str(addr));
      }
      return *reinterpret_cast<T*>(store.head.get() + VMemory::get_addr_lower(addr));
    }

    /**
     * ライブラリなど、外部の関数へのポインタを取得する。
     * @param name 関数の名称
     * @return 関数へのポインタ
     */
    external_func_t get_external_func(const Symbols::Symbol& name);

    /**
     * 仮想アドレスに相当する実アドレスを取得する。
     * 取得した実アドレスは定数領域であっても書き換え可能。
     * 起動前のk領域の作成のため以外に利用すべきではない。
     * @param addr 仮想アドレス。
     * @return 実アドレス。
     */
    uint8_t* get_raw_addr(vaddr_t addr);

    /**
     * 型依存の演算インスタンスを取得する。
     * @param type 方に割り当てたアドレス。
     * @return 型依存の演算インスタンス。
     */
    TypeBased* get_type_based(vaddr_t type);

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
    void resolve_stackinfo_cache(Thread* thread, StackInfo* stackinfo);

    /**
     * 関数のアドレスを予約する。
     * @return 予約したアドレス。
     */
    vaddr_t reserve_func_addr();

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

    /**
     * 仮想アドレスに対応づくネイティブポインタを変更する。
     * @param addr 対象の仮想アドレス。
     * @param ptr ネイティブポインタ
     */
    void update_native_ptr(vaddr_t addr, void* ptr);

    /**
     * データ領域を確保する。
     * TODO 定数領域にVM内の計算などで書き換えが生じた場合、エラーとする
     * 定数領域であってもget_rawなどを利用して書き換えた場合はエラーとならないので注意。
     * @param size 確保するサイズ
     * @param is_constant 定数領域かどうか
     * @return 確保した領域の先頭の仮想アドレス
     */
    vaddr_t v_malloc(size_t size, bool is_constant);

    /**
     * データ領域へ実データをコピーする。
     * @param dst コピー先仮想アドレス。
     * @param src コピー元の実アドレス。
     * @param n コピーサイズ。
     */
    void v_memcpy(vaddr_t dst, void* src, size_t n);

    /**
     * データ領域を指定の数値で埋める。
     * 標準ライブラリのmemsetと同様の動作をする。
     * @param dst データ領域上の埋め先のアドレス。
     * @param c 埋めデータ(unsigned char分のデータのみ利用される)
     * @param len 埋めサイズ
     */
    void v_memset(vaddr_t dst, int c, size_t len);
  };
}
