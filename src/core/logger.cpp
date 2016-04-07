
#include <cassert>
#include <cstdarg>
#include <string>
#include <vector>

#include "logger.hpp"
#include "util.hpp"

namespace processwarp {
namespace Logger {
/** Strings of log levels.  */
static const std::string LOG_NAMES[] = {
  "error",
  "warn",
  "info",
  "debug"
};
/** Saving delegater. */
static Delegate* delegate = nullptr;

/**
 * Simple destructor for vtable.
 */
Delegate::~Delegate() {
}

/**
 * Get string to show by log level.
 * @param lv Log level.
 */
const std::string& get_level_string(Level lv) {
  return LOG_NAMES[static_cast<int>(lv)];
}

/**
 * Output log with format similer to printf.
 * Log message was find by Message module.
 * @param lv Log level.
 * @param file File name that output log from.
 * @param line Line number at file.
 * @param mid Log message-id.
 * @param dummy Dummy parameter to va_args.
 * @param ... Parameters similter to printf.
 */
void output(Level lv, const char* file, const std::size_t line,
            Message::Type mid, int dummy, ...) {
  assert(delegate != nullptr);

  // Generate message.
  va_list args;
  va_start(args, dummy);
  std::string message = Message::vformat(mid, args);
  va_end(args);

  delegate->output(lv, Util::get_filename(file), line, mid, message);
}

/**
 * Output log direct, without Message module.
 * @param lv Log level.
 * @param file File name that output log from.
 * @param line Line number at file.
 * @param mid Log message-id.
 * @param message Log message.
 */
void output_raw(Level lv, const char* file, const std::size_t line,
                Message::Type mid, const std::string& message) {
  assert(delegate != nullptr);
  delegate->output(lv, Util::get_filename(file), line, mid, message);
}

/**
 * Output log direct, without Message module.
 * @param lv Log level.
 * @param file File name that output log from.
 * @param line Line number at file.
 * @param mid Log message-id.
 * @param message Log message.
 * @param dummy Dummy parameter to va_args.
 * @param ... Parameters similter to printf.
 */
void output_raw(Level lv, const char* file, const std::size_t line,
                Message::Type mid, const std::string& message, int dummy, ...) {
  assert(delegate != nullptr);

  // Generate message.
  std::vector<char> buffer;
  buffer.resize(message.size() * 1.2);
  int r = 0;
  va_list args;
  va_start(args, dummy);
  while ((r = vsnprintf(buffer.data(), buffer.size(), message.c_str(), args)) >= 0 &&
         static_cast<unsigned int>(r) >= buffer.size()) {
    buffer.resize(r + 1);
  }
  va_end(args);

  delegate->output(lv, Util::get_filename(file), line, mid, std::string(buffer.data()));
}

/**
 * Set log output module.
 * @param delegate_ Output module.
 */
void set_logger_delegate(Delegate* delegate_) {
  assert(delegate_ != nullptr);

  delegate = delegate_;
}
}  // namespace Logger
}  // namespace processwarp
