#pragma once

#include <string>
#include <sstream>
#include <iomanip>
#include <iostream>

#include "definitions.hpp"

namespace usagi {
  class Util {
  public:
    /**
     * 数字を10進数表現で文字列に変換。
     * @param v 変換元数値
     * @return 変換後文字列
     */
    template<class T> static std::string num2dec_str(T v) {
      return std::to_string(v);
    }

    /**
     * 数字を16進数表現で文字列に変換。
     * @param v 変換元数値
     * @return 変換後文字列
     */
    template<class T> static std::string num2hex_str(T v) {
      std::ostringstream os;
      os << std::hex << std::setfill('0') << std::setw(sizeof(T) * 2) << v;
      return os.str();
    }

    /**
     * 文字列をアドレスに変換。
     * @param str 変換元文字列
     * @return 変換後アドレス
     */
    static vaddr_t str2vaddr(const std::string& str);

    /**
     * アドレスを16進数表現で文字列に変換。
     * @param addr 変換元アドレス
     * @return 変換後文字列
     */
    static std::string vaddr2str(vaddr_t addr);

    /**
     * 未実装機能を表すメソッド。
     * 画面にメッセージを出力する。
     * @param mesg 画面に出力するメッセージ
     */
#ifdef NDEBUG
#define fixme(mesg) //
#else
#define fixme(mesg) Util::_fixme(__LINE__, __FILE__, mesg);
#endif
    static void _fixme(long line, const char* file, std::string mesg);

    /**
     * デバッグ情報出力用関数
     */
#ifdef NDEBUG
#define print_debug(...) //
#else
#define print_debug(...) {						\
    fprintf(stderr, "\x1b[36mdebug\x1b[39m [%d@" __FILE__ "] ", __LINE__); \
    fprintf(stderr, "" __VA_ARGS__);					\
    }
#endif

#ifdef NDEBUG
#define at_death(...) //
#else
#define at_death(...)							\
    class AtDeath {							\
    public:								\
    virtual ~AtDeath() {						\
      fprintf(stderr, "\x1b[36mdebug at death\x1b[39m " __VA_ARGS__);	\
    }									\
    };									\
    AtDeath atdeath
#endif

  };
}
