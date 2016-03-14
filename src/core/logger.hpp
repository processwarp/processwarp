#pragma once

#include <string>

#include "definitions.hpp"
#include "message.hpp"

namespace processwarp {
namespace Logger {
/** Log level. */
enum class Level : int {
  ERROR,
  APP,
  WARN,
  INFO,
  DEBUG,
  VERBOSE
};

class Delegate {
 public:
  virtual ~Delegate();
  virtual void output(Level lv, const std::string& file, unsigned int line,
                      Message::Type mid, const std::string& mesage) = 0;
};

const std::string& get_level_string(Level lv);
void output(Level lv, const char* file, const std::size_t line,
            Message::Type mid, int dummy, ...);
void output_raw(Level lv, const char* file, const std::size_t line,
                Message::Type mid, const std::string& message);
void set_logger_delegate(Delegate* delegate_);
}  // namespace Logger

// Macros to access logger, ex: Logger.e(mid, params);
#define e(MID, ...) output(Logger::Level::ERROR, __FILE__, __LINE__, MID, 0, __VA_ARGS__);
#define a(MID, ...) output(Logger::Level::APP,   __FILE__, __LINE__, MID, 0, __VA_ARGS__);
#define w(MID, ...) output(Logger::Level::WARN,  __FILE__, __LINE__, MID, 0, __VA_ARGS__);
#define i(MID, ...) output(Logger::Level::INFO,  __FILE__, __LINE__, MID, 0, __VA_ARGS__);
#ifndef NDEBUG
#  define d(MID, ...) output(Logger::Level::DEBUG,   __FILE__, __LINE__, MID, 0, __VA_ARGS__);
#  define v(MID, ...) output(Logger::Level::VERBOSE, __FILE__, __LINE__, MID, 0, __VA_ARGS__);
#else
#  define d(MID, ...) /* Do nothing. */
#  define v(MID, ...) /* Do nothing. */
#endif
}  // namespace processwarp
