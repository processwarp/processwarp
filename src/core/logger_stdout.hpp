#pragma once

#include <sys/types.h>
#include <unistd.h>

#include <string>

#include "logger.hpp"

namespace processwarp {
namespace Logger {
class Stdout : public Delegate {
 public:
  void output(Level lv, const std::string& file, unsigned int line,
              Message::Type mid, const std::string& mesage) override;
};
}  // namespace Logger
}  // namespace processwarp
