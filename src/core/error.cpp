
#include <string>

#include "error.hpp"

namespace processwarp {

// VM内例外のコンストラクタ。
Error::Error(const std::string& file, int line, Reason reason_, const std::string& mesg_) :
    reason(reason_),
    mesg(mesg_) {
  std::string::size_type sep = file.rfind('/');
  if (sep == std::string::npos) sep = file.rfind('\\');
  const char* file_cstr = file.c_str();
  if (sep != std::string::npos) {
    file_cstr += sep + 1;
  }

#ifndef EMSCRIPTEN
  fprintf(stderr, "\x1b[31mdebug\x1b[39m [%d@%s] Exception %d %s\n",
          line, file_cstr, static_cast<int>(reason_), mesg.c_str());

#else
  printf("debug [%d@%s] Exception %d %s\n",
         line, file_cstr, static_cast<int>(reason_), mesg.c_str());
#endif
}
}  // namespace processwarp
