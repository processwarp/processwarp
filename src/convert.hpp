#pragma once

#include <set>

#include "lib/picojson.h"

#include "definitions.hpp"
#include "util.hpp"

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
     * Import thread from JSON.
     * @param tid thread-id
     * @param src JSON
     */
    void import_thread(const vtid_t& tid, const picojson::value& src);

    /**
     * JSONから変数を復元する。
     * @param src 復元元JSON
     */
    void import_store(vaddr_t addr, const picojson::value& src);

    /**
     * Convert process-id from JSON.
     * @param json JSON.
     * @return process-id.
     */
    static vpid_t json2vpid(const picojson::value& json) {
      return json.get<vpid_t>();
    }

    /**
     * Convert thread-id from JSON.
     * @param json JSON.
     * @return thread-id.
     */
    static vtid_t json2vtid(const picojson::value& json) {
      return str2vtid(json.get<std::string>());
    }

    /**
     * JSONから仮想アドレスを復元する。
     * @param src 復元元JSON
     * @return 仮想アドレス
     */
    vaddr_t json2vaddr(const picojson::value& src);

    /**
     * Convert process-id to JSON.
     * @param pid process-id.
     * @return process-id as JSON.
     */
    static picojson::value vpid2json(const vpid_t& pid) {
      return picojson::value(pid);
    }

    /**
     * Convert thread-id to JSON.
     * @param tid thread-id.
     * @return thread-id as JSON.
     */
    static picojson::value vtid2json(const vtid_t& tid) {
      return picojson::value(vtid2str(tid));
    }

    /**
     * 仮想アドレスからJSON文字列に変換する。
     * @param 仮想アドレス
     * @return JSON
     */
    picojson::value vaddr2json(vaddr_t src);

    /**
     * Convert process-id to string.
     * @param pid process-id.
     * @return process-id as string.
     */
    static const std::string& vpid2str(const vpid_t& pid) {
      return pid;
    }
    
    /**
     * Convert thread-id to string.
     * @param tid thread-id.
     * @return thread-id as string.
     */
    static std::string vtid2str(const vtid_t& tid) {
      return Util::num2hex_str<vtid_t>(tid);
    }

    /**
     * Convert thread-id from string.
     * @param str string.
     * @param thread-id.
     */
    static vtid_t str2vtid(const std::string& str) {
      return Util::hex_str2num<vtid_t>(str);
    }

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
