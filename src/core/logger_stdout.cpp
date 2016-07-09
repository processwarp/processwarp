
#include <syslog.h>

#include <cassert>
#include <cstdlib>
#include <string>

#include "logger_stdout.hpp"

namespace processwarp {
namespace Logger {

/**
 * Output log to stdout.
 * @param lv Log level.
 * @param file File name that output log from.
 * @param line Line number at file.
 * @param mid Log message-id.
 * @param message Log output message string.
 */
void Stdout::output(Level lv, const std::string& file, unsigned int line,
                    Message::Type mid, const std::string& message) {
#ifdef NDEBUG
  printf("lv=%s class=%s mid=%s message=%s\n",
         get_level_string(lv), file.c_str(),
         mid.c_str(), message.c_str());
#else
  printf("lv=%s class=%s line=%d mid=%s message=%s\n",
         get_level_string(lv), file.c_str(), line,
         mid.c_str(), message.c_str());
#endif
}
}  // namespace Logger
}  // namespace processwarp
