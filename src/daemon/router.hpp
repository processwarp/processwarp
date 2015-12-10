#pragma once

#include <picojson.h>
#include <uv.h>

#include <map>
#include <string>
#include <vector>

#include "daemon_define.hpp"
#include "definitions.hpp"

namespace processwarp {
class Router {
 public:
  static Router& get_instance();

  void initialize(uv_loop_t* loop_, const picojson::object& config_);
  bool check_account(const std::string& account_, const std::string& password_);
  void load_llvm(const std::string& filename, const std::vector<std::string>& args);
  void on_connect_node();
  void on_bind_node(const nid_t& nid);

 private:
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Configuration. */
  picojson::object config;
  /** This node's id. */
  nid_t my_nid;

  Router();
  Router(const Router&);
  Router& operator=(const Router&);
};
}  // namespace processwarp
