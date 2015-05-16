#pragma once

#include <cassert>
#include <map>
#include <memory>
#include <set>

#include "data_store.hpp"
#include "definitions.hpp"
#include "func_store.hpp"
#include "type_store.hpp"
#include "util.hpp"

namespace processwarp {
  /**
   * 仮想メモリ空間を管理するクラス。
   */
  class VMemory {
  public:
    /**
     * コンストラクタ。
     * 空きメモリの初期化などを行う。
     */
    VMemory();

    /**
     * アドレスが関数領域のものかどうか調べる。
     * @param addr 調査対象アドレス。
     * @return アドレスが関数領域の場合trueを戻す。
     */
    static bool addr_is_func(vaddr_t addr);

    /**
     * アドレスが型領域のものかどうか調べる。
     * @param addr 調査対象アドレス。
     * @return アドレスが型領域の場合trueを戻す。
     */
    static bool addr_is_type(vaddr_t addr);

    /**
     * メモリ空間に新しいデータ領域を確保する。
     * 同一アドレスにデータ領域が確保されていた場合、エラーとなる。
     * @param size データ領域のサイズ。
     * @param is_const 領域を定数として確保する場合trueを指定する。
     * @param addr 確保先仮想アドレス。VADDR_NONを指定すると空いているアドレスを割り当てる。
     * @return 確保したアドレスとデータ領域。
     */
    DataStore& alloc_data(uint64_t size, bool is_const, vaddr_t addr = VADDR_NON);

    /**
     * メモリ空間に新しい通常の関数領域を確保する。
     * 同一アドレスに領域が確保されていた場合、エラーとなる。
     * @param name 関数名称
     * @param ret_type 戻り値の型
     * @param arg_num 引数の数
     * @param is_var_arg 可変長引数かどうか
     * @param normal_prop 通常の関数のプロパティ
     * @param addr 確保先仮想アドレス。VADDR_NONを指定すると空いているアドレスを割り当てる。
     * @return 確保したアドレスと領域。
     */
    FuncStore& alloc_func(const Symbols::Symbol& name,
			  vaddr_t ret_type,
			  unsigned int arg_num,
			  bool is_var_arg,
			  const FuncStore::NormalProp& normal_prop,
			  vaddr_t addr = VADDR_NON);

    /**
     * メモリ空間に新しいVM組み込み関数領域を確保する。
     * 同一アドレスに領域が確保されていた場合、エラーとなる。
     * @param name 関数名称。
     * @param ret_type 戻り値の型。
     * @param arg_num 引数の数
     * @param is_var_arg 可変長引数かどうか
     * @param intrinsic VM組み込み関数へのポインタ。
     * @param param 組み込み関数へ渡す固定パラメタ。
     * @param addr 確保先仮想アドレス。VADDR_NONを指定すると空いているアドレスを割り当てる。
     * @return 確保したアドレスと領域。
     */
    FuncStore& alloc_func(const Symbols::Symbol& name,
			  vaddr_t ret_type,
			  unsigned int arg_num,
			  bool is_var_arg,
			  const intrinsic_func_t intrinsic, 
			  const IntrinsicFuncParam param,
			  vaddr_t addr = VADDR_NON);

    /**
     * メモリ空間に新しい外部関数領域を確保する。
     * 同一アドレスに領域が確保されていた場合、エラーとなる。
     * @param name 関数名称
     * @param ret_type 戻り値の型
     * @param arg_num 引数の数
     * @param is_var_arg 可変長引数かどうか
     * @param addr 確保先仮想アドレス。VADDR_NONを指定すると空いているアドレスを割り当てる。
     * @return 確保したアドレスと領域。
     */
    FuncStore& alloc_func(const Symbols::Symbol& name,
			  vaddr_t ret_type,
			  unsigned int arg_num,
			  bool is_var_arg,
			  vaddr_t addr = VADDR_NON);

    /**
     * メモリ空間に配列の型領域を確保する。
     * 同一アドレスに型領域が確保されていた場合、エラーとなる。
     * 同一のデータ構造に対しては、既存のアドレスを割り当てる。
     * @param size 構造のサイズ(Byte)
     * @param alignment アライメント(Byte)
     * @param element 配列の要素の型
     * @param num 配列の要素数
     * @param addr 確保先仮想アドレス。VADDR_NONを指定すると空いているアドレスを割り当てる。
     * @return 確保したアドレスと領域。
     */
    TypeStore& alloc_type_array(size_t size,
				unsigned int alignment,
				vaddr_t element,
				unsigned int num,
				vaddr_t addr = VADDR_NON);

    /**
     * メモリ空間に基本型の型領域を確保する。
     * 同一アドレスに型領域が確保されていた場合、エラーとなる。
     * 同一のデータ構造に対しては、既存のアドレスを割り当てる。
     * @param size 構造のサイズ(Byte)
     * @param alignment アライメント(Byte)
     * @param addr 確保先仮想アドレス。
     * @return 確保したアドレスと領域。
     */
    TypeStore& alloc_type_basic(size_t size,
				unsigned int alignment,
				vaddr_t addr);

    /**
     * メモリ空間に構造体の型領域を確保する。
     * 同一アドレスに型領域が確保されていた場合、エラーとなる。
     * 同一のデータ構造に対しては、既存のアドレスを割り当てる。
     * @param size 構造のサイズ(Byte)
     * @param alignment アライメント(Byte)
     * @param member 構造のメンバの配列
     * @param addr 確保先仮想アドレス。VADDR_NONを指定すると空いているアドレスを割り当てる。
     * @return 確保したアドレスと領域。
     */
    TypeStore& alloc_type_struct(size_t size,
				 unsigned int alignment,
				 const std::vector<vaddr_t>& member,
				 vaddr_t addr = VADDR_NON);

    /**
     * メモリ空間にvectorの型領域を確保する。
     * 同一アドレスに型領域が確保されていた場合、エラーとなる。
     * 同一のデータ構造に対しては、既存のアドレスを割り当てる。
     * @param size 構造のサイズ(Byte)
     * @param alignment アライメント(Byte)
     * @param element 配列の要素の型
     * @param num 配列の要素数
     * @param addr 確保先仮想アドレス。VADDR_NONを指定すると空いているアドレスを割り当てる。
     * @return 確保したアドレスと領域。
     */
    TypeStore& alloc_type_vector(uint64_t size,
				 unsigned int alignment,
				 vaddr_t element,
				 unsigned int num,
				 vaddr_t addr = VADDR_NON);

    /**
     * 指定されたデータ領域を開放する。
     * 指定アドレスがNULLの場合、なにもしない。
     * @param addr データ領域のアドレス。
     */
    void free(vaddr_t addr);

    /**
     * アドレスのupper部分を取り出す。
     * @param addr アドレス
     * @return アドレスのupper部分
     */
    static vaddr_t get_addr_upper(vaddr_t addr);

    /**
     * アドレスのlower部分を取り出す。
     * @param addr アドレス
     * @return アドレスのlower部分
     */
    static vaddr_t get_addr_lower(vaddr_t addr);

    /**
     * 現在管理しているアドレスすべての集合を作成する。
     * @return アドレスの集合
     */
    std::set<vaddr_t> get_alladdr();
    
    /**
     * アドレスに対応する領域を取得する。
     * @param addr 仮想アドレス。
     * @return アドレスに対応する領域。
     */
    DataStore& get_data(vaddr_t addr);

    /**
     * アドレスに対応する関数領域を取得する。
     * @param addr 仮想アドレス。
     * @return アドレスに対応する関数領域。
     */
    FuncStore& get_func(vaddr_t addr);

    /**
     * アドレスに対応する型領域を取得する。
     * @param addr 仮想アドレス。
     * @return アドレスに対応する型領域。
     */
    TypeStore& get_type(vaddr_t addr);

    /**
     * データアドレスを予約する。
     * 割り当ての仕組み上、addrで指定したアドレスタイプに従い
     * 0〜256TByteの範囲でアドレスの予約がされる。
     * addrはlower部分が0のアドレスである(領域の先頭)である必要がある。
     * @param addr 予約するアドレス。
     */
    void reserve_data_addr(vaddr_t addr);

    /**
     * 関数のアドレスを予約する。
     * @return 予約したアドレス。
     */
    vaddr_t reserve_func_addr();

  private:
    /** メモリ空間のもつデータ領域一覧(仮想アドレス→データ領域) */
    std::map<vaddr_t, DataStore> data_store_map;
    /** データ領域として予約されたアドレス一覧 */
    std::set<vaddr_t> data_reserved;
    /** メモリ空間のもつ関数領域一覧(仮想アドレス→関数領域) */
    std::map<vaddr_t, FuncStore> func_store_map;
    /** 関数領域として予約されたアドレス一覧 */
    std::set<vaddr_t> func_reserved;
    /** メモリ空間の持つ型領域一覧(仮想アドレス→型領域) */
    std::map<vaddr_t, TypeStore> type_store_map;
    /** 型領域として予約されたアドレス一覧 */
    std::set<vaddr_t> type_reserved;
    
    /** 空きアドレス */
    vaddr_t last_free[0x10];
  };
}
