#pragma once

#include <sys/types.h>
#include <unistd.h>

#include <string>

#include "logger.hpp"

namespace processwarp {
namespace Logger {
class Syslog : public Delegate {
 public:
  void initialize(const std::string& type_);
  void output(Level lv, const std::string& file, unsigned int line,
              Message::Type mid, const std::string& mesage);

 private:
  /** Source program type for log. */
  std::string type;

  static void on_exit();
};
}  // namespace Logger
}  // namespace processwarp
