
#include "finally.hpp"

using namespace processwarp;

// Constructor.
Finally::Finally() :
  next_key(0) {
}

// Kick finalize functions in destructor.
Finally::~Finally() {
  do {
    next_key --;
    auto func = funcs.find(next_key);
    if (func != funcs.end()) {
      func->second();
    }
  } while(next_key != 0);
}

// Add a finalize function.
int Finally::add(std::function<void()> func) {
  funcs.insert(std::make_pair(next_key, func));
  return next_key ++;
}

// Remove finalize function.
void Finally::remove(int key) {
  funcs.erase(key);
}










