
#include "convert.hpp"
#include "util.hpp"
#include "vmachine.hpp"

using namespace processwarp;

/**
 * 数値をJSON-object形式に変換する。
 * JSONでは数値を倍精度浮動小数点数として保持するため倍精度整数などを
 * 格納しようとすると精度が劣化する。本メソッドでは数値を一旦文字列に
 * 変換してから格納する。
 * @param src 変換前数値
 * @return JSON-object
 */
template<class T> picojson::value num2json(T src) {
  std::ostringstream os;
  os << std::hex << std::setfill('0') << std::setw(sizeof(T) * 2) << src;
  return picojson::value(os.str());
}

template<> picojson::value num2json<uint8_t>(uint8_t src) {
  std::ostringstream os;
  os << std::hex << std::setfill('0') <<
    std::setw(sizeof(uint8_t) * 2) << static_cast<uint32_t>(src);
  return picojson::value(os.str());
}

/**
 * 文字列化数値のJSON-objectを数値に変換する。
 * 数値の精度はdstで指定した格納先の型に依存する。
 * @param v 変換前JSON-object
 * @param dst 数値格納先
 */
template<class T> T json2num(const picojson::value& src) {
  std::istringstream is(src.get<std::string>());
  T num;
  is >> std::hex >> num;
  return num;
}

template<> uint8_t json2num<uint8_t>(const picojson::value& src) {
  std::istringstream is(src.get<std::string>());
  uint32_t num;
  is >> std::hex >> num;
  return static_cast<uint8_t>(num);
}

// コンストラクタ。
Convert::Convert(VMachine& vm_) :
  vm(vm_),
  vmemory(vm_.vmemory) {
}

// スレッドをJSON形式に変換する。
picojson::value Convert::export_thread(const Thread& src, Related& related) {
  picojson::object dst;

  // StackInfo
  picojson::array dst_stackinfos;
  for (auto it = src.stackinfos.begin(); it != src.stackinfos.end(); it ++) {
    picojson::object dst_stackinfo;

    // 関数
    dst_stackinfo.insert(std::make_pair("func", vaddr2json((**it).func)));
    related.insert((**it).func);
    // return格納先
    dst_stackinfo.insert(std::make_pair("ret_addr", vaddr2json((**it).ret_addr)));
    related.insert(VMemory::get_addr_upper((**it).ret_addr));
    // 終了時にpcに設定する値
    dst_stackinfo.insert(std::make_pair("normal_pc", num2json((**it).normal_pc)));
    dst_stackinfo.insert(std::make_pair("unwind_pc", num2json((**it).unwind_pc)));
    // スタック領域
    dst_stackinfo.insert(std::make_pair("stack", vaddr2json((**it).stack)));
    related.insert((**it).stack);
    // allocaで確保された領域
    picojson::array alloca_addrs;
    for (auto it_aa = (**it).alloca_addrs.begin(); it_aa != (**it).alloca_addrs.end(); it_aa ++) {
      alloca_addrs.push_back(vaddr2json(*it_aa));
      related.insert(VMemory::get_addr_upper(*it_aa));
    }
    dst_stackinfo.insert(std::make_pair("alloca_addrs", picojson::value(alloca_addrs)));
    // 可変長引数を格納した領域アドレス
    dst_stackinfo.insert(std::make_pair("var_arg", vaddr2json((**it).var_arg)));
    related.insert(VMemory::get_addr_upper((**it).var_arg));
    // プログラムカウンタ、φ動作用カウンタ
    dst_stackinfo.insert(std::make_pair("pc", num2json((**it).pc)));
    dst_stackinfo.insert(std::make_pair("phi0", num2json((**it).phi0)));
    dst_stackinfo.insert(std::make_pair("phi1", num2json((**it).phi1)));
    // 操作対象の型
    dst_stackinfo.insert(std::make_pair("type", vaddr2json((**it).type)));
    related.insert(VMemory::get_addr_upper((**it).type));
    // アライメント
    dst_stackinfo.insert(std::make_pair("alignment", num2json((**it).alignment)));
    // 格納先アドレス
    dst_stackinfo.insert(std::make_pair("output", vaddr2json((**it).output)));
    related.insert(VMemory::get_addr_upper((**it).output));
    // 値レジスタ
    dst_stackinfo.insert(std::make_pair("value", vaddr2json((**it).value)));
    related.insert(VMemory::get_addr_upper((**it).value));
    // アドレスレジスタ
    dst_stackinfo.insert(std::make_pair("address", vaddr2json((**it).address)));
    related.insert(VMemory::get_addr_upper((**it).address));

    dst_stackinfos.push_back(picojson::value(dst_stackinfo));
  }
  dst.insert(std::make_pair("stackinfos", picojson::value(dst_stackinfos)));
  
  // funcs_at_befor_warp
  picojson::array dst_fabw;
  for (auto it : src.funcs_at_befor_warp) {
    dst_fabw.push_back(vaddr2json(it));
  }
  dst.insert(std::make_pair("funcs_at_befor_warp", picojson::value(dst_fabw)));

  // funcs_at_after_warp
  picojson::array dst_faaw;
  for (auto it : src.funcs_at_after_warp) {
    dst_faaw.push_back(vaddr2json(it));
  }
  dst.insert(std::make_pair("funcs_at_after_warp", picojson::value(dst_faaw)));

  // warp_parameter
  picojson::object dst_warp_parameter;
  for (auto it : src.warp_parameter) {
    dst_warp_parameter.insert(std::make_pair(Util::num2hex_str(it.first), num2json(it.second)));
  }
  dst.insert(std::make_pair("warp_parameter", picojson::value(dst_warp_parameter)));

  return picojson::value(dst);
}

// 変数の実体をJSON形式に変換する。
picojson::value Convert::export_store(vaddr_t src, Related& related) {
  if (VMemory::addr_is_func(src)) {
    return export_func(vmemory.get_func(src), related);

  } else if (VMemory::addr_is_type(src)) {
    return export_type(vmemory.get_type(src), related);

  } else {
    return export_data(vmemory.get_data(src), related);
  }
}

// JSONからスレッドを復元する。
void Convert::import_thread(const vtid_t& tid, const picojson::value& src) {
  const picojson::object& obj_src = src.get<picojson::object>();
  std::unique_ptr<Thread> thread(new Thread());

  // Stackinfo
  const picojson::array& stackinfos = obj_src.at("stackinfos").get<picojson::array>();
  for (auto it_si = stackinfos.begin(); it_si != stackinfos.end(); it_si ++) {
    const picojson::object& obj_si = it_si->get<picojson::object>();
    std::unique_ptr<StackInfo> stackinfo
      (new StackInfo(json2vaddr(obj_si.at("func")),
		     json2vaddr(obj_si.at("ret_addr")),
		     json2num<unsigned int>(obj_si.at("normal_pc")),
		     json2num<unsigned int>(obj_si.at("unwind_pc")),
		     json2vaddr(obj_si.at("stack"))));
    // allocaで確保された領域
    const picojson::array& alloca_addrs = obj_si.at("alloca_addrs").get<picojson::array>();
    stackinfo->alloca_addrs.resize(alloca_addrs.size());
    for (int i = 0, size = alloca_addrs.size(); i < size; i ++) {
      stackinfo->alloca_addrs.at(i) = json2vaddr(alloca_addrs.at(i));
    }
    // 可変長引数を格納した領域アドレス
    stackinfo->var_arg = json2vaddr(obj_si.at("var_arg"));
    // プログラムカウンタ、φ動作用カウンタ
    stackinfo->pc = json2num<unsigned int>(obj_si.at("pc"));
    stackinfo->phi0 = json2num<unsigned int>(obj_si.at("phi0"));
    stackinfo->phi1 = json2num<unsigned int>(obj_si.at("phi1"));
    // 操作対象の型
    stackinfo->type = json2vaddr(obj_si.at("type"));
    // アライメント
    stackinfo->alignment = json2num<vm_int_t>(obj_si.at("alignment"));
    // 格納先アドレス
    stackinfo->output = json2vaddr(obj_si.at("output"));
    // 値レジスタ
    stackinfo->value = json2vaddr(obj_si.at("value"));
    // アドレスレジスタ
    stackinfo->address = json2vaddr(obj_si.at("address"));
    
    thread->stackinfos.push_back(std::move(stackinfo));
  }

  // funcs_at_befor_warp
  const picojson::array& fabw = obj_src.at("funcs_at_befor_warp").get<picojson::array>();
  for (auto it : fabw) {
    thread->funcs_at_befor_warp.push_back(json2vaddr(it));
  }
  
  // funcs_at_after_warp
  const picojson::array& faaw = obj_src.at("funcs_at_after_warp").get<picojson::array>();
  for (auto it : faaw) {
    thread->funcs_at_after_warp.push_back(json2vaddr(it));
  }

  // warp_parameter
  const picojson::object& warp_parameter = obj_src.at("warp_parameter").get<picojson::object>();
  for (auto it : warp_parameter) {
    thread->warp_parameter.insert(std::make_pair(std::strtol(it.first.c_str(), nullptr, 16),
						 json2num<vm_uint_t>(it.second)));
  }

  vm.threads.insert(make_pair(tid, std::move(thread)));
}

// JSONから変数を復元する。
void Convert::import_store(vaddr_t addr, const picojson::value& src) {
  if (VMemory::addr_is_func(addr)) {
    import_func(addr, src.get<picojson::object>());

  } else if (VMemory::addr_is_type(addr)) {
    import_type(addr, src.get<picojson::object>());

  } else {
    import_data(addr, src.get<picojson::array>());
  }
}

// DataStoreをJSON形式に変換する。
picojson::value Convert::export_data(const DataStore& src, Related& related) {
  picojson::array dst;

  dst.resize(src.size);
  for (int i = 0, size = src.size; i < size; i ++) {
    dst.at(i) = num2json<uint8_t>(src.head[i]);
  }

  return picojson::value(dst);
}

// FuncStoreをJSON形式に変換する。
picojson::value Convert::export_func(const FuncStore& src, Related& related) {
  picojson::object dst;

  // アドレス
  dst.insert(std::make_pair("addr", vaddr2json(src.addr)));
  // 関数のタイプ
  dst.insert(std::make_pair("type", num2json<uint8_t>(src.type)));
  // 関数名称
  dst.insert(std::make_pair("name", picojson::value(src.name.str())));
  // 戻り値の型
  dst.insert(std::make_pair("ret_type", vaddr2json(src.ret_type)));
  related.insert(src.ret_type);
  // 引数の数
  dst.insert(std::make_pair("arg_num", num2json(src.arg_num)));
  // 可変長引数かどうか
  dst.insert(std::make_pair("is_var_arg", picojson::value(src.is_var_arg)));

  if (src.type == FuncType::FC_NORMAL) {
    // 関数で利用するスタックサイズ
    dst.insert(std::make_pair("stack_size", num2json(src.normal_prop.stack_size)));
    // 命令配列
    picojson::array code;
    code.resize(src.normal_prop.code.size());
    for (int i = 0, size = code.size(); i < size; i ++) {
      code.at(i) = num2json<instruction_t>(src.normal_prop.code.at(i));
    }
    dst.insert(std::make_pair("code", picojson::value(code)));
    // 定数領域
    dst.insert(std::make_pair("k", vaddr2json(src.normal_prop.k)));
    related.insert(src.normal_prop.k);
  }

  return picojson::value(dst);
}

// TypeStoreをJSON形式に変換する。
picojson::value Convert::export_type(const TypeStore& src, Related& related) {
  picojson::object dst;

  switch (src.kind) {
  case TypeKind::TK_BASIC: {
    // 基本型はすべてのVMで同じなのでexportしない
    assert(false);
  } break;

  case TypeKind::TK_STRUCT: {
    // 種類
    dst.insert(std::make_pair("kind", picojson::value("S")));
    // サイズ
    dst.insert(std::make_pair("size", num2json(src.size)));
    // アライメント
    dst.insert(std::make_pair("alignment", num2json(src.alignment)));
    // 構造体のメンバ
    picojson::array member;
    member.resize(src.member.size());
    for (int i = 0, size = src.member.size(); i < size; i ++) {
      member.at(i) = vaddr2json(src.member.at(i));
      related.insert(src.member.at(i));
    }
    dst.insert(std::make_pair("member", picojson::value(member)));
  } break;

  case TypeKind::TK_ARRAY:
  case TypeKind::TK_VECTOR: {
    // 種類
    if (src.kind == TypeKind::TK_ARRAY) {
      dst.insert(std::make_pair("kind", picojson::value("A")));
    } else {
      dst.insert(std::make_pair("kind", picojson::value("V")));
    }
    // サイズ
    dst.insert(std::make_pair("size", num2json(src.size)));
    // アライメント
    dst.insert(std::make_pair("alignment", num2json(src.alignment)));
    // 要素の型
    dst.insert(std::make_pair("element", vaddr2json(src.element)));
    // 要素数
    dst.insert(std::make_pair("num", num2json(src.num)));
  } break;

  default: {
    assert(false);
  } break;
  }

  return picojson::value(dst);
}

// JSONからDataStoreを復元する。
void Convert::import_data(vaddr_t addr, const picojson::array& src) {
  DataStore& store = vmemory.alloc_data(src.size(), false, addr);
  for (int i = 0, size = src.size(); i < size; i ++) {
    store.head[i] = json2num<uint8_t>(src.at(i));
  }
}

// JSONからFuncStoreを復元する。
void Convert::import_func(vaddr_t addr, const picojson::object& src) {
  // 関数のタイプ
  uint8_t type = json2num<uint8_t>(src.at("type"));
  // 関数名称
  std::string name = src.at("name").get<std::string>();
  // 戻り値の型
  vaddr_t ret_type = json2vaddr(src.at("ret_type"));
  // 引数の数
  unsigned int arg_num = json2num<unsigned int>(src.at("arg_num"));
  // 可変長引数かどうか
  bool is_var_arg = src.at("is_var_arg").get<bool>();

  switch(type) {
  case FuncType::FC_NORMAL: {
    FuncStore::NormalProp prop;
    // 関数で利用するスタックサイズ
    prop.stack_size = json2num<unsigned int>(src.at("stack_size"));
    // 命令配列
    picojson::array code = src.at("code").get<picojson::array>();
    prop.code.resize(code.size());
    for (int i = 0, size = code.size(); i < size; i ++) {
      prop.code.at(i) = json2num<instruction_t>(code.at(i));
    }
    // 定数領域
    prop.k = json2vaddr(src.at("k"));

    vm.deploy_function_normal(name, ret_type, arg_num, is_var_arg, prop, addr);
  } break;

  case FuncType::FC_BUILTIN: {
    vm.deploy_function(name, ret_type, arg_num, is_var_arg, addr);
  } break;

  case FuncType::FC_EXTERNAL: {
    vm.deploy_function(name, ret_type, arg_num, is_var_arg, addr);
  } break;

  default: {
    print_debug("%d\n", type);
    assert(false); /// TODO パケットの正当性チェック
  } break;
  }
}

// JSONからTypeStoreを復元する。
void Convert::import_type(vaddr_t addr, const picojson::object& src) {
  std::string kind = src.at("kind").get<std::string>();
  if (kind == "S") {
    // 構造体
    picojson::array member = src.at("member").get<picojson::array>();
    std::vector<vaddr_t> work;
    work.resize(member.size());
    for (int i = 0, size = member.size(); i < size; i ++) {
      work.at(i) = json2vaddr(member.at(i));
    }

    vmemory.alloc_type_struct(json2num<size_t>(src.at("size")),
			      json2num<unsigned int>(src.at("alignment")),
			      work, addr);

  } else if (kind == "A") {
    // 配列
    vmemory.alloc_type_array(json2num<size_t>(src.at("size")),
			     json2num<unsigned int>(src.at("alignment")),
			     json2vaddr(src.at("element")),
			     json2num<unsigned int>(src.at("num")),
			     addr);

  } else if (kind == "V") {
    // vector
    vmemory.alloc_type_vector(json2num<size_t>(src.at("size")),
			      json2num<unsigned int>(src.at("alignment")),
			      json2vaddr(src.at("element")),
			      json2num<unsigned int>(src.at("num")),
			      addr);

  } else {
    assert(false);
  }
}

// JSONから仮想アドレスを復元する。
vaddr_t Convert::json2vaddr(const picojson::value& src) {
  return Util::str2vaddr(src.get<std::string>());
}

// 仮想アドレスからJSON文字列に変換する。
picojson::value Convert::vaddr2json(vaddr_t src) {
  return picojson::value(Util::vaddr2str(src));
}
