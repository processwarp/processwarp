
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "lib/picojson.h"

#include "error.hpp"
#include "llvm_asm_loader.hpp"
#include "server.hpp"
#include "vmachine.hpp"

using namespace usagi;

/**
 * エントリーポイント。
 */
/*
int main(const int argc, const char* argv[]) {
  if(argc != 2) return (EXIT_FAILURE);
  
  try {
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

  } catch(const Error& e) {
    print_debug("Exception code:%d  message:%s\n", e.reason, e.mesg.c_str());
    return(EXIT_FAILURE);
  }
}
/*/
int main(int argc, char* argv[]) {
  // コマンド解析
  if (argc == 2) {
    picojson::object conf;

    { // 設定ファイルを開く
      std::ifstream conf_file(argv[1]);
      if (!conf_file.is_open()) {
	std::cerr << "can't open configure-file." << std::endl;
	goto on_error;
      }
      
      // 設定ファイルをJSONとして解析
      picojson::value v;
      std::string err = picojson::parse(v, conf_file);
      conf_file.close(); // もう閉じてOK.
      if (!err.empty()) {
	std::cerr << err << std::endl;
	goto on_error;
      }
      conf = v.get<picojson::object>();
    }

    Server server;
    std::string err = server.start(conf);
    if (err != "") {
      std::cerr << err << std::endl;
      goto on_error;
    }
    
    while((err = server.loop()) == "") {
      // エラーが発生しなければループを継続
    }
    std::cerr << err << std::endl;
    goto on_error;

  } else {
    std::cerr << "you must select configure-file." << std::endl;
    goto on_error;
  }
  
  // 正常終了
  return 0;

  // 異常終了
 on_error:
  std::cerr << "usage: usagi configure-file" << std::endl;
  return 1;
}
//*/
