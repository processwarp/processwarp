
#include "data_store.hpp"

using namespace usagi;

// コンストラクタ
DataStore::DataStore(size_t size_) :
  size(size_),
  head(new uint8_t[size_]) {
}
