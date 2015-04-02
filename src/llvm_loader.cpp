#include <iostream>
#include <fstream>
#include <sstream>

#include "lib/picojson.h"

#include "convert.hpp"
#include "definitions.hpp"
#include "error.hpp"
#include "llvm_asm_loader.hpp"
#include "vmachine.hpp"

using namespace usagi;

static const std::string pool_path("/tmp/");

int main(int argc, char* argv[]) {
  // 標準入力を読み込み
  std::string line;
  while(std::getline(std::cin, line, '\0')) {
    picojson::object param;

    // 標準入力をJSONに変換
    picojson::value v;
    std::istringstream is(line);
    std::string err = picojson::parse(v, is);
    if (!err.empty()) {
      std::cerr << err << std::endl;
      exit(EXIT_FAILURE);
    }
    param = v.get<picojson::object>();
    
    // PIDパラメタを取得
    std::string pid       = param.at("pid").get<std::string>();
    std::string device_id = param.at("device_id").get<std::string>();
    
    try {
      // VMを用意
      std::vector<void*> libs; // 変換プログラムではライブラリのロードを行わないので空
      VMachine vm(libs);
      vm.setup();
    
      // プログラムをロード
      LlvmAsmLoader loader(vm);
      loader.load_file(pool_path + pid + ".ll");
      // 仮環境変数
      std::map<std::string, std::string> envs;
      // 仮引数
      std::vector<std::string> args;
      // 起動状態へ
      vm.run(args, envs);
      
      // プログラムをダンプ&ファイルに書き込み
      Convert convert(vm);
      Convert::Related related;
      picojson::object body;
      picojson::object dump;
      body.insert(std::make_pair("to", picojson::value(device_id)));
      body.insert(std::make_pair("thread", convert.export_thread(*(vm.threads.back()), related)));
      std::set<vaddr_t> all = vm.vmemory.get_alladdr();
      for (auto it = all.begin(); it != all.end(); it ++) {
	// NULLはexportしない
	if (*it == VADDR_NULL || *it == VADDR_NON) continue;
	// VM組み込みのアドレスはexportしない
	if (vm.intrinsic_addrs.find(*it) != vm.intrinsic_addrs.end()) continue;
	
	dump.insert(std::make_pair(Util::vaddr2str(*it), convert.export_store(*it, related)));
      }
      body.insert(std::make_pair("dump", picojson::value(dump)));

      std::ofstream ofs(pool_path + pid + ".out");
      ofs << picojson::value(dump).serialize();
    
      // 結果を標準出力に書き込み
      picojson::object result;
      result.insert(std::make_pair("result",    picojson::value(0.0)));
      result.insert(std::make_pair("pid",       picojson::value(pid)));
      result.insert(std::make_pair("device_id", picojson::value(device_id)));
      std::cout << picojson::value(result).serialize() << '\0';
    
    } catch(Error ex) {
      // エラー内容を標準出力に書き込み
      picojson::object result;
      result.insert(std::make_pair("result",    picojson::value(-1.0)));
      result.insert(std::make_pair("pid",       picojson::value(pid)));
      result.insert(std::make_pair("device_id", picojson::value(device_id)));
      result.insert(std::make_pair("reason",    picojson::value(std::to_string(ex.reason))));
      result.insert(std::make_pair("message",   picojson::value(ex.mesg)));
      std::cout << picojson::value(result).serialize() << '\0';
    }
  }

  return 0;
}
