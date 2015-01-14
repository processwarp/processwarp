#pragma once

#include <set>
#include <string>
#include <vector>

#include "symbols.hpp"
#include "thread.hpp"
#include "value.hpp"
#include "vmemory.hpp"

namespace usagi {
  /**
   * 仮想マシンクラス。
   * 仮想マシンは１つのメモリ空間、複数のスレッド、コマンド実行から成り立つ。
   */
  class VMachine {
  public:
    /** VM組み込み関数一覧 */
    typedef std::map<const std::string, intrinsic_func_t> IntrinsicFuncs;
    /** 大域変数、関数シンボル→アドレス型 */
    typedef std::map<const Symbols::Symbol*, Value> Globals;
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
    //at_death("VMachine\n");
    //std::vector<void*> ext_libs; ///< ロードした外部のライブラリ
    
    /**
     * コンストラクタ。
     */
    VMachine();

    /**
     * 外部の関数を呼び出す。
     * @param func 外部の関数へのポインタ
     * @param ret_type 戻り値の型
     * @param arg_types 引数の型
     * @param args 引数
     * @return 戻り値
     */
    Value call_external(external_func_t func,
			const Value& ret_type,
			const std::vector<Value>& arg_types,
			std::vector<Value> args);

    /**
     * 型のサイズと最大アライメントを計算する。
     * @param member 複合型のメンバ
     * @return <型のサイズ, 最大アライメント>
     */
    std::pair<size_t, unsigned int> calc_type_size(const std::vector<vaddr_t>& member);

    /**
     * VMの終了処理を行う。
     */
    void close();

    /**
     * 値をコピーする。
     * @param コピー先の値の格納先
     * @param コピー元の値の格納先
     * @param コピーするデータの型
     */
    void copy_value(Value& dst, const Value& src, const Value& type);

    /**
     * 通常の関数(VMで解釈、実行する)を作成する。
     * @param name 関数名
     * @param prop 通常の関数のプロパティ
     * @return 作成した値。
     */
    Value create_function(const std::string& name,
			  const FuncStore::NormalProp& prop);

    /**
     * VM組み込み関数/ライブラリなど外部の関数を作成する。
     * @param name 関数名
     * @return 作成した値。
     */
    Value create_function(const std::string& name);

    /**
     * NULLポインタを作成する。
     * @return 作成した値。
     */
    Value create_null();

    /**
     * ポインタ変数を作成する。
     * @param src ポインタの基底となる値(ポインタ含む)。
     * @param delta 基底の値のアドレスからの差(1Byte単位)。
     * @return 作成した値。
     */
    Value create_pointer(Value* src, int delta);

    /**
     * 基本型情報を作成する。
     * @param type 基本型
     * @return 作成した値。
     */
    Value create_type(BasicType type);

    /**
     * 配列型情報を作成する。
     * @param element 配列のメンバの型のアドレス
     * @param num 配列の要素数
     * @return 作成した値。
     */
    Value create_type(vaddr_t element, unsigned int num);

    /**
     * 複合型情報を作成する。
     * @param member 複合型のメンバ型のアドレス
     * @return 作成した値。
     */
    Value create_type(const std::vector<vaddr_t>& member);

    /**
     * プリミティブ変数で処理化した値を作成する。
     * @param T プリミティブ型
     * @param src プリミティブ変数
     * @return 作成した値。
     */
    template<typename T> Value create_value_by_primitive(T src) {
      return create_value_by_array(sizeof(src), 1, &src);
    }

    /**
     * データの配列で初期化した値を作成する。
     * @param per_size 1要素のサイズ
     * @param length   要素数
     * @param data 配列の生データを持つ領域のアドレス
     * @return 作成した値。
     */
    Value create_value_by_array(int  per_size,
				int  length,
				const void* data);

    /**
     * ライブラリ関数を指定アドレスに展開する。
     * @param name 関数名
     * @param addr 展開先アドレス
     */
    void deploy_function_external(const std::string& name, vaddr_t addr);
    
    /**
     * VM組み込み関数を指定アドレスに展開する。
     * @param name 関数名
     * @param addr 展開先アドレス
     */
    void deploy_function_intrinsic(const std::string& name, vaddr_t addr);

    /**
     * 通常の関数(VMで解釈、実行する)を指定アドレスに展開する。
     * @param name 関数名
     * @param prop 通常の関数のプロパティ
     * @param addr 展開先アドレス
     */
    void deploy_function_normal(const std::string& name,
				const FuncStore::NormalProp& prop,
				vaddr_t addr);

    /**
     * VM命令を実行する。
     * @param max_clock コンテキストスイッチまで最長クロック数
     */
    void execute(int max_clock);

    /**
     * ライブラリなど、外部の関数へのポインタを取得する。
     * @param name 関数の名称
     * @return 関数へのポインタ
     */
    external_func_t get_external_func(const Symbols::Symbol& name);

    /**
     * アプリケーションの初期設定をする。
     * エントリポイントに対するクロージャを作成し、実行可能な状態を作る。
     * @param args エントリポイントへ渡す引数。
     */
    void run(std::vector<std::string> args);
    
    /**
     * 大域変数のアドレスを設定する。
     * @param name 大域変数名
     * @param value 大域変数に登録する変数。
     */
    void set_global_value(const std::string& name, Value* value);

    /**
     * VMの初期設定をする。
     */
    void setup();

    /**
     * ワープ後のVMの設定をする。
     */
    void setup_continuous();

  private:
    /**
     * 変数の中身をintとして取得する。
     * 変数の中身はsize-byteの値とし、符号あり整数としてlongest_int_tに
     * 拡張した値を戻す。
     * @param src VMの変数
     * @param size 変数のサイズ(sizeof(longest_int_t)以下であること)
     * @return 拡張済みの値
     */
    longest_int_t get_value_as_int(const Value& src, unsigned int size);

    /**
     * 変数が即値であった場合に、仮想メモリに値を配置し直す。
     * 値が仮想メモリに配置済みの場合は何もしない。
     * @param target 対象の変数
     */
    void place_virtual_value(Value* target);

    /**
     * 変数のキャッシュを解決します。
     * 変数が即値またはキャッシュ設定済みの場合なにもしない。
     * @param target 対象の変数
     */
    void resolve_value_cache(const Value* target);
  };
}
