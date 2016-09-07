#pragma once

#include <sys/types.h>
#include <unistd.h>

#include <fluent.hpp>

#include <string>

#include "logger.hpp"

namespace processwarp {
namespace Logger {
class Fluentd : public Delegate {
 public:
  void initialize(const std::string& type_, const std::string& host,
                  unsigned int port, const std::string& tag_);
  void output(Level lv, const std::string& file, unsigned int line,
              Message::Type mid, const std::string& mesage);

 private:
  fluent::Logger logger;
  /** Source program type for log. */
  std::string type;
  std::string tag;
};
}  // namespace Logger
}  // namespace processwarp
