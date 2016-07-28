
#include "lock.hpp"

namespace processwarp {
namespace Lock {

#ifdef WITH_PTHREAD
Mutex::Mutex() {
  pthread_mutex_init(&mutex, nullptr);
}

Mutex::~Mutex() {
  pthread_mutex_destroy(&mutex);
}

Cond::Cond() {
  pthread_cond_init(&cond, nullptr);
}

Cond::~Cond() {
  pthread_cond_destroy(&cond);
}

void Cond::wait(Mutex& mutex) {
  pthread_cond_wait(&cond, &mutex.mutex);
}

void Cond::notify_all() {
  pthread_cond_broadcast(&cond);
}

Guard::Guard(Mutex& mutex_) :
    mutex(&mutex_.mutex) {
  pthread_mutex_lock(mutex);
}

Guard::~Guard() {
  pthread_mutex_unlock(mutex);
}
#endif

}  // namespace Lock
}  // namespace processwarp
