
#include <iomanip>
#include <iostream>

#include "util.hpp"

using namespace usagi;

// 未実装機能を表すメソッド。
void Util::_fixme(long line, const char* file, std::string mesg) {
    std::cerr.setf(std::ios::dec);
    std::cerr << "\x1b[31mfixme\x1b[39m [l" << line << "@" << file << "] " << mesg << std::endl;
}

// アドレスを16進数表現で文字列に変換。
std::string Util::addr2str(vaddr_t addr) {
  std::ostringstream os;
  os << "0x" << std::hex << std::setw(16) << std::uppercase << addr;
  return os.str();
}
