
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
  vmachine.setup();

  { // VMにLLVMファイルを読み込む
    LlvmAsmLoader loader(vmachine);
    loader.load_file(argv[1]);
  }

  std::vector<std::string> args;
  vmachine.run(args);
  vmachine.execute(100);

  vmachine.close();

  print_debug("bye!\n");
  return(EXIT_SUCCESS);
}
