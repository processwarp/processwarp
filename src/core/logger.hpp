#pragma once

#include <string>

#include "message.hpp"
#include "type.hpp"

namespace processwarp {
namespace Logger {
/** Log level. */
enum class Level : int {
  ERROR,
  WARN,
  INFO,
  DEBUG
};

class Delegate {
 public:
  virtual ~Delegate();
  virtual void output(Level lv, const std::string& file, unsigned int line,
                      Message::Type mid, const std::string& mesage) = 0;
};

const char* get_level_string(Level lv);
void output(Level lv, const char* file, const std::size_t line,
            Message::Type mid, int dummy, ...);
void output_raw(Level lv, const char* file, const std::size_t line,
                Message::Type mid, const std::string& message);
void output_raw(Level lv, const char* file, const std::size_t line,
                Message::Type mid, const std::string& message, int dummy, ...);
void set_logger_delegate(Delegate* delegate_);
// For dummy to avoid error that "expected unqualified-id".
inline void do_nothing() {}
}  // namespace Logger
}  // namespace processwarp

#ifdef __ANDROID__
#  ifndef PRIu64
#    define PRIu64 "llu"
#  endif
#  ifndef PRIx64
#    define PRIx64 "llx"
#  endif
#endif

// Macros to access logger, ex: Logger.e(mid, params);
#define err(MID, ...)                                                   \
  output(processwarp::Logger::Level::ERROR, __FILE__, __LINE__, MID, 0, ##__VA_ARGS__)
#define warn(MID, ...)                                                  \
  output(processwarp::Logger::Level::WARN,  __FILE__, __LINE__, MID, 0, ##__VA_ARGS__)
#define info(MID, ...)                                                  \
  output(processwarp::Logger::Level::INFO,  __FILE__, __LINE__, MID, 0, ##__VA_ARGS__)
#ifdef NDEBUG
#  define dbg(MID, ...) processwarp::do_nothing()
#  define dbg_raw(MID, MSG, ...) processwarp::do_nothing()
#else
#  define dbg(MID, ...)                                                 \
  output(processwarp::Logger::Level::DEBUG,   __FILE__, __LINE__, MID, 0, ##__VA_ARGS__)
#  define dbg_raw(MID, MSG, ...)                                        \
  output_raw(processwarp::Logger::Level::DEBUG, __FILE__, __LINE__, MID, MSG, 0, ##__VA_ARGS__)
#endif

#if defined(NDEBUG) || !defined(DEBUG_VM)
#  define dbg_vm(MID, MSG, ...) processwarp::do_nothing()
#else
#  define dbg_vm(MID, MSG, ...)                                         \
  output_raw(processwarp::Logger::Level::DEBUG, __FILE__, __LINE__, MID, MSG, 0, ##__VA_ARGS__)
#endif

#if defined(NDEBUG) || !defined(DEBUG_MEM)
#  define dbg_mem(MID, MSG, ...) processwarp::do_nothing()
#else
#  define dbg_mem(MID, MSG, ...)                                        \
  output_raw(processwarp::Logger::Level::DEBUG, __FILE__, __LINE__, MID, MSG, 0, ##__VA_ARGS__)
#endif
