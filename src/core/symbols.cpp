
#include "symbols.hpp"

using namespace usagi;

// シンボル文字列を取得する。
const std::string& Symbols::Symbol::str() const {
  return *this;
}

// 文字列を指定してシンボルを作成。
Symbols::Symbol::Symbol(const std::string& str) :
  std::string(str) {
}

// 文字列に対応するシンボル文字列を取得する。
const Symbols::Symbol& Symbols::get(const std::string& src) {
  // srcで既存のシンボル文字列の集合を捜査する。
  auto exist = store.find(src);
  if (exist != store.end()) {
    // 既存のシンボルに合致した場合、参照に変換して戻す。
    return *(exist->second);
    
  } else {
    // 対応するシンボルがない場合、新しく作成する。
    Symbol* copy = new Symbol(src);
    store.insert(std::make_pair(src, std::unique_ptr<Symbol>(copy)));
    return *copy;
  }
}
