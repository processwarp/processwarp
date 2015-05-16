
#ifndef EMSCRIPTEN
#include <dlfcn.h>
#endif

#include <time.h>

#include "convert.hpp"
#include "error.hpp"
#include "llvm_asm_loader.hpp"
#include "server.hpp"

using namespace processwarp;

// 新規VMを割り当てる。
vpid_t Server::assign_vm(const picojson::object& conf) {
  std::unique_ptr<VMachine> vm(new VMachine(libs));
  vm->setup();

  { // プログラムをロード
    LlvmAsmLoader loader(*vm);
    loader.load_file(conf.at("path").get<std::string>());
  }
  
  // 起動引数を取り出し
  picojson::array conf_args = conf.at("args").get<picojson::array>();
  std::vector<std::string> args;
  args.push_back(conf.at("path").get<std::string>());
  for (picojson::array::iterator it = conf_args.begin();
       it != conf_args.end(); it ++) {
    args.push_back(it->get<std::string>());
  }

  // TODO:環境変数を合成
  std::map<std::string, std::string> envs;

  // ロードしたプログラムと引数からVMをsetup
  vm->run(args, envs);
  
  // VM固有のIDを作成
  //vpid_t pid = Util::num2hex_str(time(nullptr)) + ";" + server_name;
  fixme("debug用にPIDを固定中");
  vpid_t pid = "00;localhost";

  // 機動成功したVMを一覧に登録
  vms.insert(std::make_pair(pid, std::move(vm)));

  return pid;
}

// サーバで動くプロセス一覧を戻す。
void Server::command_ps(const picojson::object& command) {
  picojson::object reply;

  for (Server::VMS::iterator it_vm = vms.begin(); it_vm != vms.end(); it_vm ++) {
    vpid_t pid = (it_vm->first);
    // VMachine& vm = *(it_vm->second);

    picojson::object vm_info;
    vm_info.insert(std::make_pair("pid", picojson::value(pid)));
    reply.insert(std::make_pair(pid, picojson::value(vm_info)));
  }

  // 応答を送信
  xmpp.send_reply(picojson::value(reply).serialize());
}

// 指定マシンへプロセスを転送する。
void Server::command_warp_in(const picojson::object& command) {
  // 対象と送信先を取得
  vpid_t pid     = command.at("pid").get<std::string>();
  std::string to = command.at("to" ).get<std::string>();

  // 対象VMからスレッドを取得
  VMachine& vm   = *(vms.at(pid).get());
  vm.setup_warpin(to);
}

void Server::warp_in(VMachine& vm, vpid_t pid) {
  picojson::object reply;
  picojson::object dump;

  // LThread& thread = vm.vmemory.get<LThread>(vm.current_thread);

  // VMに関連づいたon_warp_inのメソッドを呼び出す
  //for(vaddr_t cl_addr : vm.on_warp_in) vm.exec_closure(cl_addr);
  
  // 応答JSONを作成
  Convert convert(vm);
  reply.insert(std::make_pair("cmd", picojson::value(std::string("warp_out"))));
  reply.insert(std::make_pair("pid", picojson::value(pid)));
  
  // on_warp_in/on_warp_outをexportする
  //picojson::array on_warp_in;
  //picojson::array on_warp_out;
  //for(auto it : vm.on_warp_in) on_warp_in.push_back(picojson::value(it));
  //for(auto it : vm.on_warp_out) on_warp_out.push_back(picojson::value(it));
  //reply.insert(std::make_pair("on_warp_in",  picojson::value(on_warp_in)));
  //reply.insert(std::make_pair("on_warp_out", picojson::value(on_warp_out)));
  
  Convert::Related related;
  reply.insert(std::make_pair("thread", convert.export_thread(*(vm.threads.back()), related)));
  
  // relatedの中身をすべてexportする
  /*
    while(true) {
    bool dump_flg = false;
    for (Convert::Related::iterator it = related.begin(); it != related.end(); it ++) {
    // NULLはexportしない
    if (*it == VADDR_NULL || *it == VADDR_NON) continue;
    // VM組み込みのアドレスはexportしない
    if (vm.intrinsic_addrs.find(*it) != vm.intrinsic_addrs.end()) continue;

    // 未ダンプなので、ダンプを出力
    if (dump.find(Util::vaddr2str(*it)) == dump.end()) {
    dump_flg = true;
    dump.insert(std::make_pair(Util::vaddr2str(*it), convert.export_store(*it, related)));
	
    break; // relatedが変更された可能性があるのでやり直し
    }
    }

    // すべてスキャンしてdumpしたものがなければ終了
    if (!dump_flg) break;
    }
    /*/
  fixme("必要な領域を請求する機能が無いので、メモリ上のデータを全て吐き出している");
  std::set<vaddr_t> all = vm.vmemory.get_alladdr();
  for (auto it = all.begin(); it != all.end(); it ++) {
    // NULLはexportしない
    if (*it == VADDR_NULL || *it == VADDR_NON) continue;
    // VM組み込みのアドレスはexportしない
    if (vm.intrinsic_addrs.find(*it) != vm.intrinsic_addrs.end()) continue;

    dump.insert(std::make_pair(Util::vaddr2str(*it), convert.export_store(*it, related)));
  }
  //*/
  reply.insert(std::make_pair("dump", picojson::value(dump)));

  // 応答を送信
  xmpp.send_message(vm.warp_to, picojson::value(reply).serialize());
  
  // スレッドを停止
  vm.status = VMachine::PASSIVE;
}

// 自サーバへ転送されたプロセスをロードする。
void Server::command_warp_out(const picojson::object& command) {
  // picojson::object reply;
  fixme("warp out!!");

  std::string pid = command.at("pid").get<std::string>();

  // VM、変換器を作成
  std::unique_ptr<VMachine> vm(new VMachine(libs));
  vm->setup();
  Convert convert(*vm);

  // 転送されたインスタンスを展開
  picojson::object dump = command.at("dump").get<picojson::object>();
  for (auto it = dump.begin(); it != dump.end(); it ++) {
    convert.import_store(Util::str2vaddr(it->first), it->second);
  }

  // スレッドをと展開
  convert.import_thread(command.at("thread"));
  
  // on_warp_in/on_warp_outをimportする
  //for(auto it : command.at("on_warp_in").get<picojson::array>())
  //vm->on_warp_in.push_back(vmemory.get_addr_by_string(it.get<std::string>(), true));
  //for(auto it : command.at("on_warp_out").get<picojson::array>())
  //vm->on_warp_out.push_back(vmemory.get_addr_by_string(it.get<std::string>(), true));
  
  vm->setup_warpout();

  // アクティブにしたVMを一覧に登録
  vm->status = VMachine::ACTIVE;
  vms.insert(std::make_pair(pid, std::move(vm)));
  
  // VMに関連づいたon_warp_outのメソッドを呼び出す
  //for(vaddr_t cl_addr : vm->on_warp_out) vm->exec_closure(cl_addr);
}

// サーバの繰り返しルーチン。
void Server::end() {
#ifndef EMSCRIPTEN
  // 動的ライブラリのclose
  for(auto lib : libs) {
    dlclose(lib);
  }
#endif
}

// サーバの繰り返しルーチン。
void Server::loop() {
  // VMの処理を進める
  for (Server::VMS::iterator it_vm = vms.begin(); it_vm != vms.end(); it_vm ++) {
    VMachine& vm = *(it_vm->second);
    if (vm.status == VMachine::ACTIVE ||
	vm.status == VMachine::WAIT_WARP ||
	vm.status == VMachine::BEFOR_WARP ||
	vm.status == VMachine::AFTER_WARP) {
      vm.execute(10);
      
    } else if (vm.status == VMachine::WARP) {
      warp_in(vm, it_vm->first);
    }
  }

  // コマンドを受信する
  std::string& command_str = xmpp.get_command();
  if (command_str != "") {
    picojson::value c;
    // 文字列->JSON
    std::istringstream s(command_str);
    std::string err = picojson::parse(c, s);

    // エラー
    if (!err.empty()) {
      throw_error_message(Error::PROTOCOL,
			  std::string("command :").append(err));

    } else if (!c.is<picojson::object>()) {
      throw_error_message(Error::PROTOCOL,
			  std::string("unknown command type."));
    }

    picojson::object cmd_json = c.get<picojson::object>();

    std::string cmd = cmd_json.at("cmd").get<std::string>();
    if (cmd == "ps") {
      command_ps(cmd_json);
	
    } else if (cmd == "warp_in") {
      command_warp_in(cmd_json);

    } else if (cmd == "warp_out") {
      command_warp_out(cmd_json);

    } else {
      print_debug("unknown command : %s", cmd.c_str());
    }
  }
  
  // 終了したVMを除去する
  for(auto it_vm = vms.begin(); it_vm != vms.end();) {
    VMachine& vm = *(it_vm->second);
    if (vm.status == VMachine::FINISH || vm.status == VMachine::ERROR) {
      it_vm = vms.erase(it_vm);
    } else {
      it_vm ++;
    }
  }
}

// サーバのメインルーチンを実行
void Server::start(const picojson::object& conf) {
  // ファイルを開いたかどうか
  bool is_filed = false;

#ifndef EMSCRIPTEN
  // 動的ライブラリのロード
  if (conf.find("libs") != conf.end()) {
    const picojson::array& lib_paths = conf.at("libs").get<picojson::array>();
    for (auto lib : lib_paths) {
      void* dl_handle = dlopen(lib.get<std::string>().c_str(), RTLD_LAZY);
      if (!dl_handle) {
	throw_error_message(Error::EXT_LIBRARY, dlerror());
      }
      libs.push_back(dl_handle);
    }
  }
#endif

  // ネットワークモードに応じた分岐
  std::string network = conf.at("network").get<std::string>();
  if (network == "xmpp") {
    const picojson::object& conf_network = conf.at("xmpp").get<picojson::object>();
    xmpp.connect(conf_network.at("server"  ).get<std::string>(),
		 conf_network.at("jid"     ).get<std::string>(),
		 conf_network.at("password").get<std::string>());
    // サーバ名称 = JID
    server_name = conf_network.at("jid").get<std::string>();

  } else {
    throw_error_message(Error::CONFIGURE, std::string("unknown network mode."));;
  }

  if (conf.find("files") != conf.end()) {
    const picojson::array& files = conf.at("files").get<picojson::array>();
    
    // filesディレクティブ(配列)からfileを取り出してロードする。
    for (auto it = files.begin(); it != files.end(); it ++) {
      picojson::object file = it->get<picojson::object>();

      assign_vm(file);
      is_filed = true;
    }
  }

  if (conf.find("mode") != conf.end()) {
    // 動作モードが明示的に指定されている場合、それを読み込む。
    std::string mode = conf.at("mode").get<std::string>();
    if (mode == "application") {
      run_mode = RunMode::APPLICATION;

    } else if (mode == "daemon") {
      run_mode = RunMode::DAEMON;

    } else {
      throw_error_message(Error::CONFIGURE, std::string("unknown run mode."));
    }
    
  } else {
    // 動作モードが指定されなかった場合、ファイルが指定されればアプリケーション、
    // ファイルが指定されていなければデーモンとして動作
    if (is_filed) {
      run_mode = RunMode::APPLICATION;
    } else {
      run_mode = RunMode::DAEMON;
    }
  }
  // 実行モードに応じた分岐
  std::string mode = conf.at("mode").get<std::string>();
}
