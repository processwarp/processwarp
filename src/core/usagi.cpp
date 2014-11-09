
#include <cstdlib>
#include <string>
#include <vector>

#include "llvm_asm_loader.hpp"
#include "vmachine.hpp"

using namespace usagi;

/**
 * エントリーポイント。
 */
int main(const int argc, const char* argv[]) {
  if(argc != 2) return (EXIT_FAILURE);
  
  VMachine vmachine;

  { // VMにLLVMファイルを読み込む
    LlvmAsmLoader loader(vmachine);
    loader.load_file(argv[1]);
  }

  std::vector<std::string> args;
  vmachine.setup(args);
  vmachine.execute(0);
  
  return(EXIT_SUCCESS);
}
