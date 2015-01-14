
#include "util.hpp"

using namespace usagi;

// 未実装機能を表すメソッド。
void Util::_fixme(long line, const char* file, std::string mesg) {
    std::cerr.setf(std::ios::dec);
    std::cerr << "\x1b[31mfixme\x1b[39m [l" << line << "@" << file << "] " << mesg << std::endl;
}

// 文字列をアドレスに変換。
vaddr_t Util::str2vaddr(const std::string& str) {
  std::istringstream is(str);
  vaddr_t addr;
  is >> std::hex >> addr;
  return addr;
}

// アドレスを16進数表現で文字列に変換。
std::string Util::vaddr2str(vaddr_t addr) {
  std::ostringstream os;
  os << std::hex << std::setfill('0') << std::setw(16) << std::uppercase << addr;
  return os.str();
}
