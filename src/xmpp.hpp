#pragma once

#include <memory>
#include <gloox/client.h>
#include <gloox/connectionlistener.h>
#include <gloox/messagehandler.h>
#include <gloox/messagesession.h>
#include <string>

namespace processwarp {
  class Xmpp : public gloox::ConnectionListener, gloox::MessageHandler {
  public:
    /**
     * XMPPへの接続を行う。
     * @param server XMPPサーバのホスト名。
     * @param jid XMPP参加時のJID。
     * @param password パスワード。
     */
    void connect(const std::string& server, const std::string& jid, const std::string& password);
    
    /**
     * コマンドの受信を行う。
     * @return 受信文字列、文字列がない場合、長さ０の文字列が入っている。
     */
    std::string& get_command();

    /**
     * コマンドのリプライを送信する。
     * 送信先は最後にコマンドを送ってきたセッションとなる。
     * @param 送信メッセージ
     */
    void send_reply(const std::string& message);

    /**
     * ターゲットにメッセージを送信する。
     * @param 送信先
     * @param 送信メッセージ
     */
    void send_message(const std::string& target, const std::string& message);
    
  private:
    // gloox
    std::unique_ptr<gloox::Client> client;
    // セッション一覧(JID->session)
    std::map<std::string, std::unique_ptr<gloox::MessageSession>> sessions;
    
    // 接続ステータス
    int status;
    
    // 最後に受信したコマンド
    std::string command;
    // 最後のコマンドの送信元
    std::string last_from;
    
    //
    virtual void onConnect() override;
    
    //
    virtual void onDisconnect(gloox::ConnectionError reason) override;
    
    //
    virtual bool onTLSConnect(const gloox::CertInfo& info) override;
    
    //
    virtual void handleMessage(const gloox::Message& msg, gloox::MessageSession* session = 0);
  };
}
