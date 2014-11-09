#pragma once

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
    /** 大域変数、関数シンボル→アドレス型 */
    typedef std::map<const Symbols::Symbol*, Value> Globals;
    /** スレッド一覧型 */
    typedef std::vector<std::unique_ptr<Thread>> Threads;

    Globals globals; ///< 大域変数、関数シンボル→アドレス
    Symbols symbols; ///< シンボル
    Threads threads; ///< スレッド一覧
    VMemory vmemory; ///< 仮想メモリ空間

    /**
     * コンストラクタ。
     */
    VMachine();

    /**
     * VM命令を実行する。
     * @param max_clock コンテキストスイッチまで最長クロック数
     */
    void execute(int max_clock);

    /**
     * 関数を作成する。
     * @param is_var_arg 可変長引数かどうか
     * @param arg_num 引数の数
     * @param value_num 関数で利用する変数の数
     * @param code 命令配列
     * @param k 定数
     * @return 作成した値。
     */
    Value create_function(bool is_var_arg,
			  unsigned int arg_num,
			  unsigned int value_num,
			  const std::vector<uint32_t>& code,
			  const std::vector<Value*>&   k);

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
     * 大域変数のアドレスを設定する。
     * @param name 大域変数名
     * @param value 大域変数に登録する変数。
     */
    void set_global_value(const std::string& name, Value* value);

    /**
     * VMの初期設定をする。
     * エントリポイントに対するクロージャを作成し、実行可能な状態を作る。
     * @param args エントリポイントへ渡す引数。
     */
    void setup(std::vector<std::string> args);
    
  private:
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
    void resolve_value_cache(Value* target);
  };
}
