#pragma once

#include <set>
#include <string>
#include <vector>

#include "error.hpp"
#include "symbols.hpp"
#include "thread.hpp"
#include "vmemory.hpp"

namespace usagi {
  /**
   * 仮想マシンクラス。
   * 仮想マシンは１つのメモリ空間、複数のスレッド、コマンド実行から成り立つ。
   */
  class VMachine {
  public:
    /** VM組み込み関数一覧 */
    typedef std::map<const std::string, std::pair<intrinsic_func_t, IntrinsicFuncParam>>
      IntrinsicFuncs;
    /** 大域変数、関数シンボル→アドレス型 */
    typedef std::map<const Symbols::Symbol*, vaddr_t> Globals;
    /** スレッド一覧型 */
    typedef std::vector<std::unique_ptr<Thread>> Threads;
    /** VM組み込みアドレス一覧 */
    typedef std::set<vaddr_t> IntrinsicAddrs;
    /** VM実行状態一覧 */
    enum Status {
      SETUP,   ///< 起動中
      ACTIVE,  ///< 実行中(実行中スレッドあり)
      PASSIVE, ///< 実行中(実行中スレッドなし)
      FINISH,  ///< 終了
    };

    IntrinsicFuncs intrinsic_funcs; //< VM組み込み関数一覧
    IntrinsicAddrs intrinsic_addrs; //< VM組み込みアドレス一覧(他VMにコピーしない)
    Globals globals;    ///< 大域変数、関数シンボル→アドレス
    Status  status;     ///< VM実行状態
    Symbols symbols;    ///< シンボル
    Threads threads;    ///< スレッド一覧
    VMemory vmemory;    ///< 仮想メモリ空間
    //std::vector<void*> ext_libs; ///< ロードした外部のライブラリ
    
    /**
     * コンストラクタ。
     */
    VMachine();

    /**
     * 外部の関数を呼び出す。
     * @param func 外部の関数へのポインタ
     * @param ret_type 戻り値の型
     * @param ret_addr 戻り値の格納場所(実際のアドレス)
     * @param args 引数(型とデータを交互にかくのうしたもの)
     */
    void call_external(external_func_t func,
		       vaddr_t ret_type,
		       uint8_t* ret_addr,
		       std::vector<uint8_t>& args);
    
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
     * VMの終了処理を行う。
     */
    void close();

    /**
     * 基本型情報を作成する。
     * @param type 基本型。
     * @return 作成した値。
     */
    TypeStore& create_type(BasicType type);

    /**
     * 配列型情報を作成する。
     * @param element 配列のメンバの型のアドレス
     * @param num 配列の要素数
     * @return 作成した値。
     */
    TypeStore& create_type(vaddr_t element, unsigned int num);

    /**
     * 複合型情報を作成する。
     * @param member 複合型のメンバ型のアドレス
     * @return 作成した値。
     */
    TypeStore& create_type(const std::vector<vaddr_t>& member);

    /**
     * ネイティブ関数を指定アドレスに展開する。
     * 関数名を元にVM組み込み関数かライブラリ関数として分岐する。
     * @param name 関数名
     * @param ret_type 戻り値の型
     * @param addr 展開先アドレス
     */
    void deploy_function(const std::string& name,
			 vaddr_t ret_type,
			 vaddr_t addr);

    /**
     * 通常の関数(VMで解釈、実行する)を指定アドレスに展開する。
     * @param name 関数名
     * @param ret_type 戻り値の型
     * @param prop 通常の関数のプロパティ
     * @param addr 展開先アドレス
     */
    void deploy_function_normal(const std::string& name,
				vaddr_t ret_type,
				const FuncStore::NormalProp& prop,
				vaddr_t addr);

    /**
     * VM命令を実行する。
     * @param max_clock コンテキストスイッチまで最長クロック数
     */
    void execute(int max_clock);

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
     * 組み込み関数用に引数を取り出す(ポインタ)。
     * 読み出そうとした引数が格納された型と異なったり、オーバーフローした場合エラーとなる。
     * @param src 呼び出しパラメタ格納先。
     * @param seek seek位置。
     * @return 読みだした値。
     */
    static vaddr_t read_intrinsic_param_ptr(const std::vector<uint8_t>& src, int* seek);

    /**
     * 組み込み関数用に引数を取り出す(int8_t)。
     * 読み出そうとした引数が格納された型と異なったり、オーバーフローした場合エラーとなる。
     * @param src 呼び出しパラメタ格納先。
     * @param seek seek位置。
     * @return 読みだした値。
     */
    static int8_t  read_intrinsic_param_i8 (const std::vector<uint8_t>& src, int* seek);
    
    /**
     * 組み込み関数用に引数を取り出す(int16_t)。
     * 読み出そうとした引数が格納された型と異なったり、オーバーフローした場合エラーとなる。
     * @param src 呼び出しパラメタ格納先。
     * @param seek seek位置。
     * @return 読みだした値。
     */
    static int16_t read_intrinsic_param_i16(const std::vector<uint8_t>& src, int* seek);

    /**
     * 組み込み関数用に引数を取り出す(int32_t)。
     * 読み出そうとした引数が格納された型と異なったり、オーバーフローした場合エラーとなる。
     * @param src 呼び出しパラメタ格納先。
     * @param seek seek位置。
     * @return 読みだした値。
     */
    static int32_t read_intrinsic_param_i32(const std::vector<uint8_t>& src, int* seek);

    /**
     * 組み込み関数用に引数を取り出す(int64_t)。
     * 読み出そうとした引数が格納された型と異なったり、オーバーフローした場合エラーとなる。
     * @param src 呼び出しパラメタ格納先。
     * @param seek seek位置。
     * @return 読みだした値。
     */
    static int64_t read_intrinsic_param_i64(const std::vector<uint8_t>& src, int* seek);

    /**
     * 組み込み関数をVMに登録する。
     * @param name 関数名(C)。
     * @param func 組み込み関数へのポインタ。
     * @param i64 組み込み関数へ渡す固定パラメタ。
     */
    void regist_intrinsic_func(const std::string& name,
			       intrinsic_func_t func, int i64);

    /**
     * 組み込み関数をVMに登録する。
     * @param name 関数名(C)。
     * @param func 組み込み関数へのポインタ。
     * @param i64 組み込み関数へ渡す固定パラメタ。
     */
    void regist_intrinsic_func(const std::string& name,
			       intrinsic_func_t func, void* ptr);

    /**
     * StackInfoのキャッシュを解決し、実行前の状態にする。
     * @param target キャッシュ解決対象のStackInfo
     */
    void resolve_stackinfo_cache(StackInfo* target);

    /**
     * 関数のアドレスを予約する。
     * @return 予約したアドレス。
     */
    vaddr_t reserve_func_addr();

    /**
     * アプリケーションの初期設定をする。
     * エントリポイントに対するクロージャを作成し、実行可能な状態を作る。
     * @param args エントリポイントへ渡す引数。
     */
    void run(std::vector<std::string> args);

    /**
     * 大域変数のアドレスを設定する。
     * @param name 大域変数名
     * @param addr 大域変数に登録するアドレス。
     */
    void set_global_value(const std::string& name, vaddr_t addr);

    /**
     * VMの初期設定をする。
     */
    void setup();

    /**
     * ワープ後のVMの設定をする。
     */
    void setup_continuous();

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
