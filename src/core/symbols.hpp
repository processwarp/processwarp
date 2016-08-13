#pragma once

#include <string>
#include <map>
#include <memory>

#include "lock.hpp"

namespace processwarp {
/**
 * 同一の文字列に対して、同一のインスタンス：シンボルを生成するクラス。
 * 例えば、異なるアドレスに配置された複数の"a"から、同一の"a"へのアドレスを戻す。
 * 異なるSymbolのインスタンスs1, s2では異なる"a"へのアドレスを戻す。
 * <code>
 * Symbols s1, s2;
 * std::string a1 = "a";
 * std::string a2 = "a";
 * if (&s1.get(a1) == &s1.get(a2)) {...} // true
 * if (&s1.get(a1) == &s2.get(a1)) {...} // trueとは限らない
 * if (&s1.get(a1) == &a1 || &s1.get(a2) == &a2) {...} // trueとは限らない
 * </code>
 */
class Symbols {
 public:
  class Symbol : private std::string {
   public:
    const std::string& str() const;

   private:
    friend Symbols;

    Symbol();
    explicit Symbol(const Symbol&);
    explicit Symbol(const std::string& str_);
  };

  const Symbol& get(const std::string& src);

 private:
  /** シンボル文字列の集合。 */
  std::map<std::string, std::unique_ptr<Symbol>> store;
  Lock::Mutex mutex;
};
}  // namespace processwarp
