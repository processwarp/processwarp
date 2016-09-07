
#include <cassert>
#include <cstdarg>
#include <memory>
#include <string>
#include <vector>

#include "core_mid.hpp"
#include "lock.hpp"
#include "logger.hpp"
#ifdef WITH_LOG_FLUENTD
#  include "logger_fluentd.hpp"
#endif
#include "logger_stdout.hpp"
#ifdef WITH_LOG_SYSLOG
#  include "logger_syslog.hpp"
#endif
#include "util.hpp"

namespace processwarp {
namespace Logger {
/** Strings of log levels.  */
static const char* LOG_NAMES[] = {
  "error",
  "warn",
  "info",
  "debug"
};
/** Saving delegater. */
static Delegate* delegate = nullptr;
/** Logger instance. */
static std::unique_ptr<Logger::Delegate> logger;
/** Mutex for logger. */
static Lock::Mutex mutex;

/**
 * Simple destructor for vtable.
 */
Delegate::~Delegate() {
}

/**
 * Get string to show by log level.
 * @param lv Log level.
 */
const char* get_level_string(Level lv) {
  return LOG_NAMES[static_cast<int>(lv)];
}

/**
 * Initialize logger.
 * @return True if initialize was succeed.
 */
bool initialize(const picojson::object& config, const std::string& type) {
  bool ret = true;
  std::string logger_type;
  {
    Lock::Guard guard(mutex);

    if (config.find("logger") != config.end()) {
      logger_type = config.at("logger").get<std::string>();
    } else {
      logger_type = "stdout";
    }

#ifdef WITH_LOG_FLUENTD
    if (logger_type == "fluentd") {
      Logger::Fluentd* logger_fluentd = new Logger::Fluentd();
      logger.reset(logger_fluentd);
      logger_fluentd->initialize("native",
                                 config.at("fluentd_host").get<std::string>(),
                                 floorl(config.at("fluentd_port").get<double>()),
                                 config.at("fluentd_tag").get<std::string>());
    }
#endif

#ifdef WITH_LOG_SYSLOG
    if (logger_type == "syslog") {
      Logger::Syslog* logger_syslog = new Logger::Syslog();
      logger.reset(logger_syslog);
      logger_syslog->initialize("native");
    }
#endif

    if (!logger) {
      logger.reset(new Logger::Stdout());
      if (logger_type != "stdout") {
        ret = false;
      }
    }

    delegate = logger.get();
  }

  err(CoreMid::L1012, logger_type.c_str());

  return ret;
}

/**
 * Initialize logger with log output module.
 * @param delegate_ Output module.
 */
bool initialize(Delegate* delegate_) {
  Lock::Guard guard(mutex);

  delegate = delegate_;
}

/**
 * Initialize logger without configure (stdout).
 */
bool initialize_boot() {
  assert(!logger);
  Lock::Guard guard(mutex);

  logger.reset(new Logger::Stdout());
  delegate = logger.get();

  return true;
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
  Lock::Guard guard(mutex);

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
  Lock::Guard guard(mutex);

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
  Lock::Guard guard(mutex);

  // Generate message.
  std::vector<char> buffer;
  buffer.resize(message.size() * 1.2);
  int r = 0;
  va_list args;
  va_list args_copy;
  va_start(args, dummy);
  va_copy(args_copy, args);
  while ((r = vsnprintf(buffer.data(), buffer.size(), message.c_str(), args_copy)) >= 0 &&
         static_cast<unsigned int>(r) >= buffer.size()) {
    buffer.resize(r + 1);
    va_end(args_copy);
    va_copy(args_copy, args);
  }
  va_end(args);
  va_end(args_copy);

  delegate->output(lv, Util::get_filename(file), line, mid, std::string(buffer.data()));
}
}  // namespace Logger
}  // namespace processwarp
