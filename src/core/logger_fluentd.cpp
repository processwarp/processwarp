
#include <unistd.h>

#include <cassert>
#include <cstdlib>
#include <string>

#include "logger_fluentd.hpp"

namespace processwarp {
namespace Logger {
/**
 * Initialize for libfluent.
 * @param type_ Source program type for log.
 */
void Fluentd::initialize(const std::string& type_, const std::string& host,
                         unsigned int port, const std::string& tag_) {
  type = type_;
  tag = tag_;
  logger.new_forward(host, port);
}

/**
 * Output log to fluentd.
 * @param lv Log level.
 * @param file File name that output log from.
 * @param line Line number at file.
 * @param mid Log message-id.
 * @param message Log output message string.
 */
void Fluentd::output(Level lv, const std::string& file, unsigned int line,
                    Message::Type mid, const std::string& message) {
  fluent::Message *msg = logger.retain_message(tag);

  msg->set("lv", get_level_string(lv));
  msg->set("type", type);
  msg->set("class", file);
#ifndef NDEBUG
  msg->set("line", line);
  msg->set("pid", getpid());
#endif
  msg->set("mid", mid);
  msg->set("message", message);

  logger.emit(msg);
}
}  // namespace Logger
}  // namespace processwarp
