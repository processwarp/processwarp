
#include <iostream>

#include "util.hpp"

using namespace usagi;

// 未実装機能を表すメソッド。
void Util::_fixme(long line, const char* file, std::string mesg) {
    std::cerr.setf(std::ios::dec);
    std::cerr << "\x1b[31mfixme\x1b[39m [l" << line << "@" << file << "] " << mesg << std::endl;
}

