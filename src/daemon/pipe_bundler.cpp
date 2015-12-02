
#include <cassert>

#include "pipe_bundler.hpp"

namespace processwarp {

/**
 * Constructor for singleton pattern.
 * This class is singleton.
 * This method is private.
 */
PipeBundler::PipeBundler() {
}

/**
 * PipeBundler instance getter as singleton pattern.
 * @return The singleton instance of PipeBundler class.
 */
PipeBundler& PipeBundler::get_instance() {
  static PipeBundler instance;
  return instance;
}

/**
 * Set uv-loop for PipeBundler.
 */
void PipeBundler::initialize(uv_loop_t* loop_) {
  loop = loop_;
}

/**
 * Insert pipe to set of enabled pipe.
 * @param pipe Pipe that is enabled.n
 */
void PipeBundler::insert(Pipe* pipe) {
  assert(pipes.count(pipe) == 0);

  pipes.insert(pipe);
}

/**
 * Remove pipe from set of enabled pipe and insert it to set of close-waiting pipe.
 * Check and delete close-waiting pipes when idle.
 * @param pipe Pipe will close.
 */
void PipeBundler::erase(Pipe* pipe) {
  assert(pipes.count(pipe) == 1);
  assert(close_wait.count(pipe) == 0);

  pipes.erase(pipe);
  close_wait.insert(pipe);

  /// @todo Check and delete close-waiting pipes.
  assert(false);
}
}  // namespace processwarp
