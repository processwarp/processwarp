
#include <cassert>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "router.hpp"
#include "server_connector.hpp"
#include "util.hpp"

namespace processwarp {

/**
 * Constructor for singleton pattern.
 * This class is singleton.
 * This method is private.
 */
Router::Router() {
}

/**
 * Router instance getter as singleton pattern.
 * @return The singleton instance of Router class.
 */
Router& Router::get_instance() {
  static Router instance;
  return instance;
}

/**
 * Initiazlie Router with libuv loop and configuration.
 * Store both of parameters.
 * @param loop_ Loop for Router.
 * @param config_ Configuration.
 */
void Router::initialize(uv_loop_t* loop_, const picojson::object& config_) {
  loop   = loop_;
  config = config_;
}

/**
 * Check account is eaual to the same to connecting it.
 * @param account_ Target account name.
 * @param password_ Target password.
 * @return True if account and password is eaual to the same to connecting it.
 */
bool Router::check_account(const std::string& account_, const std::string& password_) {
  ServerConnector& server = ServerConnector::get_instance();
  if (server.get_status() != ServerStatus::CONNECT) {
    /// @todo error
    assert(false);
  }

  std::string hash_password = password_;
  for (int i = 0; i < 10; i ++) {
    hash_password = Util::calc_sha256(hash_password);
  }
  hash_password = "[10sha256]" + hash_password;

  if (account_ == config.at("account").get<std::string>() &&
      hash_password == config.at("password").get<std::string>()) {
    return true;
  } else {
    return false;
  }
}

/**
 * Open the LLVM-IR file and send load-llvm command to server.
 * @param filename Filename of LLVM-IR.
 * @param args Arguments to pass application's entry point.
 */
void Router::load_llvm(const std::string& filename, const std::vector<std::string>& args) {
  ServerConnector& server = ServerConnector::get_instance();

  if (server.get_status() != ServerStatus::CONNECT) {
    /// @todo error
    assert(false);
  }

  std::ifstream ifs(filename);
  std::stringstream file;
  std::string line;

  if (!ifs.is_open()) {
    /// @todo errro
    assert(false);
  }
  while (std::getline(ifs, line, '\n')) {
    file << line << '\n';
  }
  ifs.close();

  server.send_load_llvm(Util::file_basename(filename, "\\.[^\\.]"), file.str(), args, my_nid);
}

/**
 * When connect is success, send bind_node packet with my-nid and node-name.
 */
void Router::on_connect_node() {
  ServerConnector& server = ServerConnector::get_instance();

  server.send_bind_node(my_nid, config.at("node-name").get<std::string>());
}

/**
 * When bind is success, store assigned nid as my-nid.
 * @param nid Assigned nid for this node.
 */
void Router::on_bind_node(const nid_t& nid) {
  my_nid = nid;
}
}  // namespace processwarp
