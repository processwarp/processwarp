
#include <syslog.h>

#include <cassert>
#include <cstdlib>
#include <string>

#include "logger_syslog.hpp"

namespace processwarp {
namespace Logger {
/**
 * Initialize for syslog.
 * @param type_ Source program type for log.
 */
void Syslog::initialize(const std::string& type_) {
  type = type_;
#ifdef NDEBUG
  openlog("processwarp", LOG_PID, LOG_USER);
#else
  openlog("processwarp.develop", LOG_PID, LOG_USER);
#endif
  std::atexit(Syslog::on_exit);
}

/**
 * Output log to syslog.
 * Convert log level for syslog, concat values and output.
 * @param lv Log level.
 * @param file File name that output log from.
 * @param line Line number at file.
 * @param mid Log message-id.
 * @param message Log output message string.
 */
void Syslog::output(Level lv, const std::string& file, unsigned int line,
                    Message::Type mid, const std::string& message) {
  int priority;
  switch (lv) {
    case Level::ERROR: priority = LOG_ERR;     break;
    case Level::WARN:  priority = LOG_WARNING; break;
    case Level::INFO:  priority = LOG_INFO;    break;
    case Level::DEBUG: priority = LOG_DEBUG;   break;
    default:
      assert(false);
      return;
  }

#ifdef NDEBUG
  syslog(priority, "lv=%s type=%s class=%s mid=%s message=%s",
         get_level_string(lv).c_str(), type.c_str(), file.c_str(), mid.c_str(), message.c_str());
#else
  syslog(priority, "lv=%s type=%s class=%s line=%d mid=%s message=%s",
         get_level_string(lv).c_str(), type.c_str(), file.c_str(), line,
         mid.c_str(), message.c_str());
#endif
}

/**
 * When exit program close syslog.
 */
void Syslog::on_exit() {
  closelog();
}
}  // namespace Logger
}  // namespace processwarp
