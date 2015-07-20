#pragma once

#include <set>

#include "lib/picojson.h"

#include "definitions.hpp"
#include "util.hpp"

namespace processwarp {
  class Thread;
  class FuncStore;
  class TypeStore;
  class Process;
  class VMemory;

  class Convert {
  public:
    typedef std::set<vaddr_t> Related;

    /**
     * コンストラクタ。
     * 仮想メモリ空間を指定してインスタンスを作成。
     * @param proc 仮想メモリ空間
     */
    Convert(Process& proc);

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
     * Convert JSON to bool.
     * @param json Source JSON.
     * @return A converted integer.
     */
    static bool json2bool(const picojson::value& json) {
      return json.get<std::string>() == "T";
    }
    
    /**
     * Convert JSON to integer.
     * @param json Source JSON.
     * @return A converted integer.
     */
    template<class T> static T json2int(const picojson::value& json) {
      return Util::hex_str2num<T>(json.get<std::string>());
    }

    /**
     * Convert a thread-id from JSON.
     * @param json Source JSON.
     * @return A thread-id.
     */
    static vtid_t json2vtid(const picojson::value& json) {
      return json2int<vtid_t>(json);
    }

    /**
     * Convert a virtual address from JSON.
     * @param json Source JSON.
     * @return A virtual address.
     */
    static vaddr_t json2vaddr(const picojson::value& json) {
      return json2int<vaddr_t>(json);
    }

    /**
     * Convert a instruction code from JSON.
     * @param json Source JSON.
     * @return A instruction code.
     */
    static instruction_t json2code(const picojson::value& json) {
      return json2int<instruction_t>(json);
    }

    /**
     * Convert process-id to JSON.
     * @param pid Source process-id.
     * @return Process-id as JSON.
     */
    static picojson::value vpid2json(const vpid_t& pid) {
      return picojson::value(pid);
    }

    static picojson::value bool2json(bool b) {
      return picojson::value(b ? "T" : "F");
    }
    
    /**
     * Convert integer to JSON.
     * @param num Source integer.
     * @return Integer as JSON.
     */
    template<class T> static picojson::value int2json(T num) {
      return picojson::value(Util::num2hex_str<T>(num));
    }

    /**
     * Convert thread-id to JSON.
     * @param tid Source thread-id.
     * @return Thread-id as JSON.
     */
    static picojson::value vtid2json(const vtid_t& tid) {
      return int2json<vtid_t>(tid);
    }

    /**
     * Convert virtual address to JSON.
     * @param addr Source virtual address.
     * @return Virtual address as JSON.
     */
    static picojson::value vaddr2json(vaddr_t addr) {
      return int2json<vaddr_t>(addr);
    }

    /**
     * Convert instruction code to JSON.
     * @param code Source instruction code.
     * @return Instruction code as JSON.
     */
    static picojson::value code2json(instruction_t code) {
      return int2json<instruction_t>(code);
    }

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
    /// 対象プロセス
    Process& proc;
    /// 対象仮想メモリ
    VMemory& vmemory;

    // JSONからDataStoreを復元する。
    void import_data(vaddr_t addr, const picojson::array& src);
    // JSONからFuncStoreを復元する。
    void import_func(vaddr_t addr, const picojson::object& src);
    // JSONからTypeStoreを復元する。
    void import_type(vaddr_t addr, const picojson::object& src);
  };
}
