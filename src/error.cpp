
#include "error.hpp"

using namespace usagi;

// VM内例外のコンストラクタ。
Error::Error(const std::string& file, int line, Reason reason_, const std::string& mesg_) :
  reason(reason_),
  mesg(mesg_) {

#ifndef EMSCRIPTEN
  fprintf(stderr, "\x1b[31mdebug\x1b[39m [%d@%s] Exception %d %s\n",
	  line, file.c_str(), static_cast<int>(reason_), mesg.c_str());

#else
  printf("debug [%d@%s] Exception %d %s\n",
	 line, file.c_str(), static_cast<int>(reason_), mesg.c_str());
#endif
  }
