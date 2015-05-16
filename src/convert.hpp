#pragma once

#include <set>

#include "lib/picojson.h"

#include "definitions.hpp"

namespace processwarp {
  class Thread;
  class DataStore;
  class FuncStore;
  class TypeStore;
  class VMachine;
  class VMemory;

  class Convert {
  public:
    typedef std::set<vaddr_t> Related;

    /**
     * コンストラクタ。
     * 仮想メモリ空間を指定してインスタンスを作成。
     * @param vm 仮想メモリ空間
     */
    Convert(VMachine& vm_);

    /**
     * スレッドをJSON形式に変換する。
     * relatedに先に入っていたアドレスはそのまま保持、追加される
     * @param src 変換対象のスレッド
     * @param related スレッドが参照している変数アドレスの格納先
     * @return JSON
     */
    picojson::value export_thread(const Thread& src, Related& related);

    /**
     * 変数の実体をJSON形式に変換する。
     * relatedに先に入っていたアドレスはそのまま保持、追加される
     * @param src 変換対象の実体
     * @param related 変数が参照しているアドレスの格納先
     * @return JSON
     */
    picojson::value export_store(vaddr_t src, Related& related);

    /**
     * JSONからスレッドを復元する。
     * @param src 復元元JSON
     */
    void import_thread(const picojson::value& src);

    /**
     * JSONから変数を復元する。
     * @param src 復元元JSON
     */
    void import_store(vaddr_t addr, const picojson::value& src);

    /**
     * JSONから仮想アドレスを復元する。
     * @param src 復元元JSON
     * @return 仮想アドレス
     */
    vaddr_t json2vaddr(const picojson::value& src);

    /**
     * 仮想アドレスからJSON文字列に変換する。
     * @param 仮想アドレス
     * @return JSON
     */
    picojson::value vaddr2json(vaddr_t src);

  private:
    /// 対象仮想マシン
    VMachine& vm;
    /// 対象仮想メモリ
    VMemory& vmemory;

    // DataStoreをJSON形式に変換する。
    picojson::value export_data(const DataStore& src, Related& related);
    // FuncStoreをJSON形式に変換する。
    picojson::value export_func(const FuncStore& src, Related& related);
    // TypeStoreをJSON形式に変換する。
    picojson::value export_type(const TypeStore& src, Related& related);

    // JSONからDataStoreを復元する。
    void import_data(vaddr_t addr, const picojson::array& src);
    // JSONからFuncStoreを復元する。
    void import_func(vaddr_t addr, const picojson::object& src);
    // JSONからTypeStoreを復元する。
    void import_type(vaddr_t addr, const picojson::object& src);
  };
}
