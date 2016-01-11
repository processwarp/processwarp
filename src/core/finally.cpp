
#include <cassert>

#include "finally.hpp"

namespace processwarp {

// constructor.
Finally::Finally() :
    next_key(1) {
}

// Kick finalize functions in destructor.
Finally::~Finally() {
  do {
    next_key--;
    auto func = funcs.find(next_key);
    if (func != funcs.end()) {
#ifdef NDEBUG
      try {
        func->second();
      } catch (...) {
      }
#else   // ifdef NDEBUG
      func->second();
#endif  // ifdef NDEBUG
    }
  } while (next_key != 0);
}

// Add a finalize function.
int Finally::add(std::function<void()> func) {
  funcs.insert(std::make_pair(next_key, func));
  return next_key++;
}

// Remove all finalize functions at this finallizer.
void Finally::clear() {
  funcs.clear();
}

// Remove finalize function.
void Finally::remove(int key) {
  if (key != 0) {
    funcs.erase(key);
  }
}
}  // namespace processwarp
