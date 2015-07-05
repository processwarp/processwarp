
#include "thread.hpp"

using namespace processwarp;

// Constructor with thread-id.
Thread::Thread(vtid_t tid_) :
  tid(tid_),
  status(NORMAL),
  warp_stack_size(0),
  warp_call_count(0),
  join_waiting(JOIN_NONE) {
  }
