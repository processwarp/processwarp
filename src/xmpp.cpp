
#include <assert.h>
#include <sstream>
#include <gloox/message.h>

#include "util.hpp"
#include "xmpp.hpp"

using namespace processwarp;

static int STATUS_START      = 0;
static int STATUS_CONNECT    = 1;
static int STATUS_DISCONNECT = 2;

// XMPPへの接続を行う。
void Xmpp::connect(const std::string& server, const std::string& jid, const std::string& password) {
  status = STATUS_START;
  print_debug("xmpp server : %s\nxmpp jid : %s\n", server.c_str(), jid.c_str());
  // 準備
  client.reset(new gloox::Client(gloox::JID(jid), password));
  client->registerConnectionListener(this);
  client->registerMessageHandler(this);
  client->setServer(server);

  // 接続開始
  client->connect(false);

  // onConnect/onDisconnectが呼ばれるまで待つ
  while (status == STATUS_START) {
    client->recv();
  }

  // onConnect以外が呼ばれた場合、エラーとみなす
  if (status != STATUS_CONNECT) {
  }
}

// コマンドの受信を行う。
std::string& Xmpp::get_command() {
  // コマンドのリセット
  command = "";

  // ブロックせずに受信を試す
  client->recv(0);
  
  // コマンドが来ている場合、ソレを戻す
  return command;
}

// コマンドのリプライを送信する。
void Xmpp::send_reply(const std::string& message) {
  send_message(last_from, message);
}

// ターゲットにメッセージを送信する。
void Xmpp::send_message(const std::string& target, const std::string& message) {
  printf("send : (%s) %s\n", target.c_str(), message.c_str());

  if (sessions.find(target) == sessions.end()) {
    // 送信先先へのセッションを作る
    std::unique_ptr<gloox::MessageSession> session
      (new gloox::MessageSession(client.get(), target));
    session->registerMessageHandler(this);
    session->send(message);
    sessions.insert(std::make_pair(target, std::move(session)));
    
  } else {
    sessions.at(target)->send(message);
  }
}

//
void Xmpp::onConnect() {
  status = STATUS_CONNECT;
  print_debug("xmpp connect.\n");
}

//
void Xmpp::onDisconnect(gloox::ConnectionError reason) {
  status = STATUS_DISCONNECT;
  print_debug("xmpp disconnect:%d\n", reason);
}

//
bool Xmpp::onTLSConnect(const gloox::CertInfo& info) {
  print_debug("xmpp TLS connect.\n");
  return true;
}

//
void Xmpp::handleMessage(const gloox::Message& msg, gloox::MessageSession* session) {
  assert(command == "");
  command = msg.body();
  last_from = msg.from().full();

  print_debug("xmpp message:%s\n", (command.c_str()));
}
