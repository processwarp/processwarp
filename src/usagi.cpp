
#include <cstdlib>
#include <fstream>
#include <getopt.h>
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
int main(int argc, char* argv[]) {
  int opt, option_index;
  picojson::object conf;

  option long_options[] = {
    {"config", required_argument, nullptr, 'c'},
    {"llvm",   required_argument, nullptr, 'l'},
    {0, 0, 0, 0} // terminate
  };

  while((opt = getopt_long(argc, argv, "ac:l:", long_options, &option_index)) != -1) {
    switch(opt) {
    case 'c': { // 設定ファイルを読み込む
      std::ifstream conf_file(optarg);
      if (!conf_file.is_open()) {
	std::cerr << "Can't open configure-file." << std::endl;
	return EXIT_FAILURE;
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
    } break;

    case 'l': {
      // 'files'ディレクティブがない場合作る
      if (conf.find("file") == conf.end()) {
	conf.insert(std::make_pair("files", picojson::value(picojson::array())));
      }
      // 'files'の中にファイルに対応したディレクティブを作る
      picojson::object file;
      file.insert(std::make_pair("type", picojson::value(std::string("llvm"))));
      file.insert(std::make_pair("path", picojson::value(std::string(optarg))));
      file.insert(std::make_pair("args", picojson::value(picojson::array())));
      
      picojson::array& files = conf.at("files").get<picojson::array>();
      files.push_back(picojson::value(file));
    } break;

    case ':':
    case '?': {
      printf("Unknown or required argument option -%c\n", opt);
      goto on_error;
    } break;
    }
  }

  // '--'以降のオプションを一番最後のfileディレクティブのargsに格納する。
  for (int i = optind; i < argc; i ++) {
    // 一番最後のfileディレクティブを取得、ディレクティブがない場合エラー
    if (conf.find("files") == conf.end()) goto on_error;
    picojson::array& files = conf.at("files").get<picojson::array>();
    if (files.size() == 0) goto on_error;
    picojson::object& file = files.back().get<picojson::object>();
    // argsディレクティブを取得、ティレクティブがない場合作成
    if (file.find("args") == file.end()) {
      file.insert(std::make_pair("args", picojson::value(picojson::array())));
    }
    picojson::array& args = file.at("args").get<picojson::array>();
    args.push_back(picojson::value(argv[i]));
  }

  { // サーバ起動
    Server server;
    server.start(conf);

    // デーモンか、実行中のアプリケーションがある間、ループし続ける
    while(server.run_mode == Server::DAEMON ||
	  server.vms.size() != 0) {
      server.loop();
    }

    // 正常終了
    return EXIT_SUCCESS;
  }

 on_error:
  printf("Usage : COMMAND -c path [-l path [-- ...]]\n");
  return EXIT_FAILURE;
}
