#pragma once

#include <map>
#include <memory>

#include "lib/picojson.h"

#include "definitions.hpp"
#include "vmachine.hpp"
#include "xmpp.hpp"

namespace usagi {
  /**
   * サーバクラス。
   */
  class Server {
  public:
    /**
     * サーバの繰り返しルーチン。
     * @return エラーメッセージ。
     */
    std::string loop();

    /**
     * サーバの機動ルーチン。
     * @param conf サーバ機動設定
     * @return エラーメッセージ
     */
    std::string start(const picojson::object& conf);

  private:
    /** サーバ名称 */
    std::string server_name;

    /** サーバが持つVM一覧 */
    typedef std::map<vpid_t, std::unique_ptr<VMachine>> VMS;
    VMS vms;

    /** XMPP接続 */
    Xmpp xmpp;

    /**
     * 新規VMを割り当てる。
     * @param conf VM機動設定
     * @return 新規VMのID
     */
    vpid_t assign_vm(const picojson::object& conf);

    /**
     * サーバで動くプロセス一覧を戻す。
     * @param command コマンド
     */
    void command_ps(const picojson::object& command);

    /**
     * 指定マシンへプロセスを転送する。
     * @param command コマンド
     */
    void command_warp_in(const picojson::object& command);

    /**
     * 自サーバへ転送されたプロセスをロードする。
     * @param command コマンド
     */
    void command_warp_out(const picojson::object& command);
  };
}
