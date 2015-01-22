
#include "data_store.hpp"

using namespace usagi;

// コンストラクタ
DataStore::DataStore(vaddr_t addr_, size_t size_) :
  addr(addr_),
  size(size_),
  head(new uint8_t[size_]) {
}
