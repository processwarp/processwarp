#pragma once

#ifdef WITH_PTHREAD
#  include <pthread.h>
#else
#  include <atomic>
#  include <condition_variable>
#  include <mutex>
#  include <thread>
#endif

namespace processwarp {
namespace Lock {

#ifdef WITH_PTHREAD
class Mutex {
 public:
  pthread_mutex_t mutex;

  Mutex();
  virtual ~Mutex();
};

class Cond {
 public:
  pthread_cond_t cond;

  Cond();
  virtual ~Cond();

  void wait(Mutex& mutex);
  void notify_all();
};

class Guard {
 public:
  pthread_mutex_t* mutex;

  explicit Guard(Mutex& mutex_);
  virtual ~Guard();
};

#else
typedef std::mutex Mutex;
typedef std::condition_variable_any Cond;
typedef std::lock_guard<std::mutex> Guard;
#endif


}  // namespace Lock
}  // namespace processwarp
