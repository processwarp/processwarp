
#include "convert.hpp"
#include "util.hpp"
#include "vmachine.hpp"

using namespace usagi;

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

  // スタックトップ
  dst.insert(std::make_pair("top", num2json(src.top)));

  // CallInfo
  picojson::array dst_callinfos;
  for (auto it = src.callinfos.begin(); it != src.callinfos.end(); it ++) {
    picojson::object dst_callinfo;
    dst_callinfo.insert(std::make_pair("pos_ret", num2json((**it).pos_ret)));
    dst_callinfo.insert(std::make_pair("base", num2json((**it).base)));
    dst_callinfo.insert(std::make_pair("pc", num2json((**it).pc)));
    dst_callinfo.insert(std::make_pair("phi", num2json((**it).phi)));

    picojson::array var_arg;
    for (auto it_va = (**it).var_arg.begin(); it_va != (**it).var_arg.end(); it_va ++) {
      var_arg.push_back(export_value(*it_va, related));
    }
    dst_callinfo.insert(std::make_pair("var_arg", picojson::value(var_arg)));

    dst_callinfos.push_back(picojson::value(dst_callinfo));
  }
  dst.insert(std::make_pair("callinfos", picojson::value(dst_callinfos)));

  // スタック
  picojson::array dst_stack;
  for (auto it = src.stack.begin(); it != src.stack.end(); it ++) {
    dst_stack.push_back(export_value(*it, related));
  }
  dst.insert(std::make_pair("stack", picojson::value(dst_stack)));

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
void Convert::import_thread(const picojson::value& src) {
  const picojson::object& obj_src = src.get<picojson::object>();
  std::unique_ptr<Thread> thread(new Thread());
  
  // スタックトップ
  thread->top = json2num<unsigned int>(obj_src.at("top"));
  
  // CallInfo
  const picojson::array& callinfos = obj_src.at("callinfos").get<picojson::array>();
  for (auto it_ci = callinfos.begin(); it_ci != callinfos.end(); it_ci ++) {
    const picojson::object& obj_ci = it_ci->get<picojson::object>();
    std::unique_ptr<CallInfo> callinfo(new CallInfo());

    callinfo->pos_ret = json2num<unsigned int>(obj_ci.at("pos_ret"));
    callinfo->base    = json2num<unsigned int>(obj_ci.at("base"));
    callinfo->pc      = json2num<unsigned int>(obj_ci.at("pc"));
    callinfo->phi     = json2num<unsigned int>(obj_ci.at("phi"));

    // 可変長配列
    const picojson::array& var_arg = obj_ci.at("var_arg").get<picojson::array>();
    callinfo->var_arg.resize(var_arg.size());
    for (int i = 0, size = var_arg.size(); i < size; i ++) {
      callinfo->var_arg[i] = import_value(var_arg.at(i).get<picojson::object>());
    }
    
    thread->callinfos.push_back(std::move(callinfo));
  }

  // スタック
  const picojson::array& stack = obj_src.at("stack").get<picojson::array>();
  thread->stack.resize(stack.size());
  for (int i = 0, size = stack.size(); i < size; i ++) {
    thread->stack[i] = import_value(stack.at(i).get<picojson::object>());
  }

  vm.threads.push_back(std::move(thread));
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
    dst[i] = num2json<uint8_t>(src.head[i]);
  }

  return picojson::value(dst);
}

// FuncStoreをJSON形式に変換する。
picojson::value Convert::export_func(const FuncStore& src, Related& related) {
  picojson::object dst;

  // 関数のタイプ
  dst.insert(std::make_pair("type", num2json<uint8_t>(src.type)));
  // 関数名称
  dst.insert(std::make_pair("name", picojson::value(src.name.str())));

  if (src.type == FuncType::FC_NORMAL) {
    dst.insert(std::make_pair("is_var_arg", picojson::value(src.normal_prop.is_var_arg)));
    dst.insert(std::make_pair("arg_num", num2json(src.normal_prop.arg_num)));
    dst.insert(std::make_pair("val_num", num2json(src.normal_prop.val_num)));
    
    // 命令配列
    picojson::array code;
    code.resize(src.normal_prop.code.size());
    for (int i = 0, size = code.size(); i < size; i ++) {
      code[i] = num2json<instruction_t>(src.normal_prop.code[i]);
    }
    dst.insert(std::make_pair("code", picojson::value(code)));

    // 定数配列
    picojson::array k;
    k.resize(src.normal_prop.k.size());
    for (int i = 0, size = k.size(); i < size; i ++) {
      k[i] = export_value(src.normal_prop.k[i], related);
    }
    dst.insert(std::make_pair("k", picojson::value(k)));
  }
  
  return picojson::value(dst);
}

// TypeStoreをJSON形式に変換する。
picojson::value Convert::export_type(const TypeStore& src, Related& related) {
  picojson::object dst;

  // 構造のサイズ
  dst.insert(std::make_pair("size", num2json(src.size)));
  // アライメント
  dst.insert(std::make_pair("alignment", num2json(src.alignment)));
  
  if (src.is_array) {
    // 配列の情報を出力
    dst.insert(std::make_pair("element", vaddr2json(src.element)));
    dst.insert(std::make_pair("num",     num2json(src.num)));
    
  } else {
    // 構造のメンバの配列を出力
    picojson::array member;
    member.resize(src.member.size());
    for (int i = 0, size = src.member.size(); i < size; i ++) {
      member[i] = vaddr2json(src.member[i]);
      related.insert(src.member[i]);
    }
    dst.insert(std::make_pair("member", picojson::value(member)));
  }

  return picojson::value(dst);
}

// ValueをJSON形式に変換する。
picojson::value Convert::export_value(const Value& src, Related& related) {
  picojson::object dst;

  // 分類
  dst.insert(std::make_pair("type", num2json<uint8_t>(src.type)));
  if (src.is_immediate()) {
    // 即値の場合、size分のuint8_tとして出力
    picojson::array immediate;
    assert(src.inner_value.immediate.size == 0 ||
	   src.inner_value.immediate.size == 1 ||
	   src.inner_value.immediate.size == 2 ||
	   src.inner_value.immediate.size == 4 ||
	   src.inner_value.immediate.size == 8);
    immediate.resize(src.inner_value.immediate.size);
    for (int i = 0, size = immediate.size(); i < size; i ++) {
      immediate[i] = num2json(*(reinterpret_cast<const uint8_t*>
				(&src.inner_value.immediate.value) + i));
    }
    dst.insert(std::make_pair("immediate", picojson::value(immediate)));

  } else {
    // アドレスの場合、素直に出力
    dst.insert(std::make_pair("addr", vaddr2json(src.get_address())));
    related.insert(src.inner_value.address.upper);
  }

  return picojson::value(dst);
}

// JSONからDataStoreを復元する。
void Convert::import_data(vaddr_t addr, const picojson::array& src) {
  VMemory::AllocDataRet ret = vmemory.alloc_data(src.size(), false, addr);
  for (int i = 0, size = src.size(); i < size; i ++) {
    ret.data.head[i] = json2num<uint8_t>(src[i]);
  }
}

// JSONからFuncStoreを復元する。
void Convert::import_func(vaddr_t addr, const picojson::object& src) {
  // 関数のタイプ
  uint8_t type = json2num<uint8_t>(src.at("type"));
  // 関数名称
  std::string name = src.at("name").get<std::string>();

  switch(type) {
  case FuncType::FC_NORMAL: {
    FuncStore::NormalProp prop;

    prop.is_var_arg = src.at("is_var_arg").get<bool>();
    prop.arg_num    = json2num<unsigned int>(src.at("arg_num"));
    prop.val_num    = json2num<unsigned int>(src.at("val_num"));

    picojson::array code = src.at("code").get<picojson::array>();
    prop.code.resize(code.size());
    for (int i = 0, size = code.size(); i < size; i ++) {
      prop.code[i] = json2num<instruction_t>(code[i]);
    }

    const picojson::array k = src.at("k").get<picojson::array>();
    prop.k.resize(k.size());
    for (int i = 0, size = k.size(); i < size; i ++) {
      prop.k[i] = import_value(k[i].get<picojson::object>());
    }

    vm.deploy_function_normal(name, prop, addr);
  } break;

  case FuncType::FC_INTRINSIC: {
    vm.deploy_function_intrinsic(name, addr);
  } break;

  case FuncType::FC_EXTERNAL: {
    vm.deploy_function_external(name, addr);
  } break;

  default: {
    print_debug("%d\n", type);
    assert(false); /// TODO パケットの正当性チェック
  } break;
  }
}

// JSONからTypeStoreを復元する。
void Convert::import_type(vaddr_t addr, const picojson::object& src) {
  if (src.find("element") != src.end()) {
    // 配列情報のインポート
    vmemory.alloc_type(json2num<size_t>(src.at("size")),
		       json2num<unsigned int>(src.at("alignment")),
		       json2vaddr(src.at("element")),
		       json2num<unsigned int>(src.at("num")),
		       addr);

  } else {
    // 構造情報のインポート
    picojson::array member = src.at("member").get<picojson::array>();
    std::vector<vaddr_t> work;
    work.resize(member.size());
    for (int i = 0, size = member.size(); i < size; i ++) {
      work[i] = json2vaddr(member[i]);
    }

    vmemory.alloc_type(json2num<size_t>(src.at("size")),
		       json2num<unsigned int>(src.at("alignment")),
		       work, addr);
  }
}

// JSONからValueを復元する。
Value Convert::import_value(const picojson::object& src) {
  Value value;
  
  value.type = static_cast<Value::Type>(json2num<uint8_t>(src.at("type")));

  if (src.find("immediate") == src.end()) {
    // 即値でない場合、アドレスを格納してキャッシュはクリアしておく
    vaddr_t addr = json2vaddr(src.at("addr"));
    value.inner_value.address.upper = VMemory::get_addr_upper(addr);
    value.inner_value.address.lower = VMemory::get_addr_lower(addr);
    value.cache = nullptr;

  } else {
    // 即値の場合、中身をコピーして、キャッシュをvalueの先頭にしておく
    picojson::array immediate = src.at("immediate").get<picojson::array>();
    value.inner_value.immediate.size = immediate.size();
    for (int i = 0, size = immediate.size(); i < size; i ++) {
      *(reinterpret_cast<uint8_t*>(&value.inner_value.immediate.value) + i) =
	json2num<uint8_t>(immediate[i]);
    }
    value.cache = &value.inner_value.immediate.value;
  }

  return value;
}

// JSONから仮想アドレスを復元する。
vaddr_t Convert::json2vaddr(const picojson::value& src) {
  return Util::str2vaddr(src.get<std::string>());
}

// 仮想アドレスからJSON文字列に変換する。
picojson::value Convert::vaddr2json(vaddr_t src) {
  return picojson::value(Util::vaddr2str(src));
}
