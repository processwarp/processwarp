#pragma once

#include <map>
#include <memory>

#include "lib/picojson.h"

#include "definitions.hpp"
#include "vmachine.hpp"
#include "xmpp.hpp"

namespace processwarp {
  /**
   * サーバクラス。
   */
  class Server {
  public:
    /**
     * サーバ動作モード
     */
    enum RunMode {
      APPLICATION, ///< アプリケーション
      DAEMON,      ///< デーモン
    };

    /** サーバ動作モード */
    RunMode run_mode;

    /** サーバ名称 */
    std::string server_name;

    /** サーバが持つVM一覧 */
    typedef std::map<vpid_t, std::unique_ptr<VMachine>> VMS;
    VMS vms;

    /** サーバがロードしたライブラリ */
    std::vector<void*> libs;
    
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

    /**
     * サーバの終了ルーチン。
     */
    void end();

    /**
     * サーバの繰り返しルーチン。
     */
    void loop();

    /**
     * サーバの機動ルーチン。
     * @param conf サーバ機動設定
     */
    void start(const picojson::object& conf);

    /**
     * Dump and send process
     * @param vm target virtual machine
     * @param pid target process id
     */
    void warp_in(VMachine& vm, vpid_t pid);
  };
}
