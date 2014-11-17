#pragma once

#include <cassert>
#include <map>
#include <memory>

#include "data_store.hpp"
#include "definitions.hpp"
#include "func_store.hpp"
#include "type_store.hpp"

namespace usagi {
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
     * データ領域確保の戻り値型。
     */
    struct AllocDataRet {
      vaddr_t addr;
      DataStore& data;
    };

    /**
     * 関数領域確保の戻り値型。
     */
    struct AllocFuncRet {
      vaddr_t addr;
      FuncStore& func;
    };

    /**
     * 型領域確保の戻り値型。
     */
    struct AllocTypeRet {
      vaddr_t addr;
      TypeStore& type;
    };

    struct 
    /**
     * メモリ空間に新しいデータ領域を確保する。
     * 同一アドレスにデータ領域が確保されていた場合、エラーとなる。
     * @param size データ領域のサイズ。
     * @param is_const 領域を定数として確保する場合trueを指定する。
     * @param addr 確保先仮想アドレス。VADDR_NONを指定すると空いているアドレスを割り当てる。
     * @return 確保したアドレスとデータ領域。
     */
    AllocDataRet alloc_data(size_t size, bool is_const, vaddr_t addr = VADDR_NON);

    /**
     * メモリ空間に新しい通常の関数領域を確保する。
     * 同一アドレスに領域が確保されていた場合、エラーとなる。
     * @param name 関数名称
     * @param normal_prop 通常の関数のプロパティ
     * @param addr 確保先仮想アドレス。VADDR_NONを指定すると空いているアドレスを割り当てる。
     * @return 確保したアドレスと領域。
     */
    AllocFuncRet alloc_func(const Symbols::Symbol& name,
			    const FuncStore::NormalProp& normal_prop,
			    vaddr_t addr = VADDR_NON);

    /**
     * メモリ空間に新しいVM組み込み関数領域を確保する。
     * 同一アドレスに領域が確保されていた場合、エラーとなる。
     * @param name 関数名称
     * @param intrinsic VM組み込み関数へのポインタ
     * @param addr 確保先仮想アドレス。VADDR_NONを指定すると空いているアドレスを割り当てる。
     * @return 確保したアドレスと領域。
     */
    AllocFuncRet alloc_func(const Symbols::Symbol& name,
			    const intrinsic_func_t intrinsic, 
			    vaddr_t addr = VADDR_NON);

    /**
     * メモリ空間に新しい外部関数領域を確保する。
     * 同一アドレスに領域が確保されていた場合、エラーとなる。
     * @param name 関数名称
     * @param addr 確保先仮想アドレス。VADDR_NONを指定すると空いているアドレスを割り当てる。
     * @return 確保したアドレスと領域。
     */
    AllocFuncRet alloc_func(const Symbols::Symbol& name,
			    vaddr_t addr = VADDR_NON);

    /**
     * メモリ空間に型領域を確保する。
     * 同一アドレスに型領域が確保されていた場合、エラーとなる。
     * 同一のデータ構造に対しては、既存のアドレスを割り当てる。
     * @param size 構造のサイズ(Byte)
     * @param alignment アライメント(Byte)
     * @param member 構造のメンバの配列
     * @param addr 確保先仮想アドレス。VADDR_NONを指定すると空いているアドレスを割り当てる。
     * @return 確保したアドレスと領域。
     */
    AllocTypeRet alloc_type(size_t size,
			    unsigned int alignment,
			    const std::vector<vaddr_t>& member,
			    vaddr_t addr = VADDR_NON);

    /**
     * 既存のメモリ空間をコピーして新しいデータ領域を確保する。
     * @param addr コピー元アドレス。
     * @param size コピーサイズ。
     * @return 確保したアドレスとデータ領域。
     */
    AllocDataRet copy_data(vaddr_t addr, unsigned int size);

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

  private:
    /** メモリ空間のもつ数値一覧(仮想アドレス→データ領域) */
    std::map<vaddr_t, DataStore> data_store_map;
    /** メモリ空間のもつ数値一覧(仮想アドレス→関数領域) */
    std::map<vaddr_t, FuncStore> func_store_map;
    /** メモリ空間の持つ型一覧(仮想アドレス→型領域) */
    std::map<vaddr_t, TypeStore> type_store_map;

    /** 空きアドレス */
    vaddr_t last_free[0xf];
  };
}
