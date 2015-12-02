#pragma once

#include <uv.h>

#include <set>

#include "pipe.hpp"

namespace processwarp {
class PipeBundler {
 public:
  static PipeBundler& get_instance();

  void initialize(uv_loop_t* loop_);
  void insert(Pipe* pipe);
  void erase(Pipe* pipe);

 private:
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** */
  std::set<Pipe*> pipes;
  /** */
  std::set<Pipe*> close_wait;

  PipeBundler();
  PipeBundler(const PipeBundler&);
  PipeBundler& operator=(const PipeBundler&);
};
}  // namespace processwarp
