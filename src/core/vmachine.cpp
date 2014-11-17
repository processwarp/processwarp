
#include <cstring>
#include <dlfcn.h>
#include <ffi/ffi.h>
#include <memory>

#include "callinfo.hpp"
#include "error.hpp"
#include "func_store.hpp"
#include "util.hpp"
#include "vmachine.hpp"

using namespace usagi;

// コンストラクタ。
VMachine::VMachine() {
}

inline instruction_t get_opcode(instruction_t code) {
  return (code >> 24) & 0xff;
}

inline instruction_t get_codeA(instruction_t code) {
  return (code >> 12) & 0xfff;
}

inline instruction_t get_codeB(instruction_t code) {
  return (code      ) & 0xfff;
}

inline Value& get_operandA(unsigned int base, instruction_t code, Thread::Stack& stack) {
  assert((get_codeA(code) & 0x800) == 0);
  assert(base + get_codeA(code) < stack.size());
  return stack[base + get_codeA(code)];
}

inline Value& get_operandB(unsigned int base, instruction_t code, Thread::Stack& stack) {
  assert((get_codeB(code) & 0x800) == 0);
  assert(base + get_codeB(code) < stack.size());
  return stack[base + get_codeB(code)];
}

inline Value& get_operandA(unsigned int base, instruction_t code,
			   Thread::Stack& stack, std::vector<Value> k) {
  instruction_t a = get_codeA(code);
  if ((a & 0x800) != 0) {
    print_debug("a k %x %x\n", a, 0xfff - a);
    assert(0xfff - a < k.size());
    return k[0xfff - a]; // 定数の場合1の補数表現からの復元

  } else {
    print_debug("a stack %x\n", a);
    assert(base + a < stack.size());
    return stack[base + a];
  }
}

inline Value& get_operandB(unsigned int base, instruction_t code,
			   Thread::Stack& stack, std::vector<Value> k) {
  instruction_t b = get_codeB(code);
  if ((b & 0x800) != 0) {
    print_debug("b k %x %x\n", b, 0xfff - b);
    assert(0xfff - b < k.size());
    return k[0xfff - b]; // 定数の場合1の補数表現からの復元

  } else {
    print_debug("b stack %x\n", b);
    assert(base + b < stack.size());
    return stack[base + b];
  }
}

// VM命令を実行する。
void VMachine::execute(int max_clock) {
  Thread&           thread  = *threads[0].get();
  Thread::Stack&    stack   = thread.stack;
 re_entry: {
    // ciが0段の場合、終了
    if (thread.callinfos.size() == 0) return;
    
    CallInfo&         ci      = *(thread.callinfos.back().get());
    const FuncStore&  func    = vmemory.get_func(stack[ci.func].get_address());
    const std::vector<instruction_t>& insts   = func.normal_prop.code;
    const std::vector<Value>&         k       = func.normal_prop.k;

    for (; max_clock > 0; max_clock --) {
      instruction_t code = insts[ci.pc];
      print_debug("%d:%x\n", ci.pc, code);
      switch (static_cast<uint8_t>(get_opcode(code))) {
      case Opcode::CALL: {
	std::unique_ptr<CallInfo> new_ci(new CallInfo());
	const bool is_tailcall = (get_codeB(code) == 1);
	const instruction_t ret_code = insts[ci.pc + 1]; // 戻り値に関する情報
	if (is_tailcall) {
	  // 末尾再帰のため、ciを再利用
	  new_ci->func    = ci.pos_ret;
	  new_ci->pos_ret = ci.pos_ret;
	  new_ci->base    = ci.base;
	  new_ci->pc      = 0;
	  // 戻り値設定先に関数をおいておく(スタックをずらす必要がなく、return時に上書きされる)
	  stack[new_ci->func] = get_operandA(ci.base, code, stack, k);

	} else {
	  // 末尾再帰でないので新しいciを作成
	  new_ci->func    = ci.base + get_codeA(code);
	  assert(false);
	  new_ci->pos_ret = 0;  /// TODO EX2-0B
	  new_ci->base    = 0;  /// TODO 現在利用しているスタックの最大+1にする
	  new_ci->pc      = 0;
	}

	resolve_value_cache(&stack[new_ci->func]);
	FuncStore& func = *static_cast<FuncStore*>(stack[new_ci->func].cache);

	// 引数を集める
	std::vector<Value> args;
	std::vector<Value> arg_types;
	while (code = insts[ci.pc + args.size() + 2], get_opcode(code) == Opcode::EXTRAARG2) {
	  arg_types.push_back(get_operandA(ci.base, code, stack, k));
	  args     .push_back(get_operandB(ci.base, code, stack, k));

	  Value& arg_type = arg_types.back();
	  Value& arg      = args.back();

	  // void、ポインタ、即値以外の場合、新しいデータ領域に中身をコピーする。
	  if (arg_type.get_address() != BasicType::TY_VOID &&
	      arg_type.get_address() != BasicType::TY_POINTER &&
	      !arg.is_immediate()) {
	    resolve_value_cache(&arg_type);
	    VMemory::AllocDataRet store =
	      vmemory.copy_data(arg.get_address(),
				static_cast<TypeStore*>(arg_type.cache)->size);
	    arg.inner_value.address.upper = store.addr;
	    arg.inner_value.address.lower = 0;
	    arg.cache                     = store.data.head.get();
	  }
	}

	// pcの書き換え
	ci.pc += args.size() + 2;

	if (func.type == FuncType::FC_NORMAL) {
	  // 可変長引数でない場合、引数の数をチェック
	  if (args.size() < func.normal_prop.arg_num ||
	      (!func.normal_prop.is_var_arg && args.size() != func.normal_prop.arg_num))
	    throw_error(Error::TYPE_VIOLATION);

	  // 引数をスタックの所定の位置に設定
	  if (stack.size() < new_ci->base + func.normal_prop.val_num)
	    stack.resize(new_ci->base + func.normal_prop.val_num);
	  for (int i = 0; i < func.normal_prop.arg_num; i ++)
	    stack[new_ci->base + i] = args[i];

	  // 可変長引数分がある場合、callinfoに退避
	  new_ci->var_arg.resize(args.size() - func.normal_prop.arg_num);
	  for (int i = 0, num = args.size() - func.normal_prop.arg_num; i < num; i ++)
	    new_ci->var_arg[i] = args[func.normal_prop.arg_num + i];

	  if (is_tailcall) {
	    // 末尾再帰の場合、既存のciを上書き
	    // 次の命令はRETURNのはず
	    assert(get_opcode(insts[ci.pc]) == Opcode::RETURN);
	    ci = *new_ci;
	  } else {
	    // 末尾再帰でない場合、callinfosを追加
	    thread.callinfos.push_back(std::unique_ptr<CallInfo>(new_ci.release()));
	  }
	  goto re_entry;

	} else if (func.type == FuncType::FC_INTRINSIC) {
	  // VM組み込み関数の呼び出し
	  assert(func.intrinsic != nullptr);
	  stack[new_ci->pos_ret] = func.intrinsic(*this, thread, args);
	  // 末尾再帰の場合、既存のciは削除
	  if (is_tailcall) {
	    // 次の命令はRETURNのはず
	    assert(get_opcode(insts[ci.pc]) == Opcode::RETURN);
	    thread.callinfos.pop_back();
	    goto re_entry;
	  }

	} else { // func.type == FuncType::EXTERNAL
	  // 関数のロードを行っていない場合、ロードする
	  if (func.external == nullptr) {
	    func.external = get_external_func(func.name);
	  }

	  // 関数の呼び出し
	  stack[new_ci->pos_ret] = call_external(func.external,
						 get_operandA(ci.base, ret_code, stack, k),
						 arg_types, args);

	  // 末尾再帰の場合、既存のciは削除
	  if (is_tailcall) {
	    // 次の命令はRETURNのはず
	    assert(get_opcode(insts[ci.pc]) == Opcode::RETURN);
	    thread.callinfos.pop_back();
	    goto re_entry;
	  }
	}
	
      } break;

      case Opcode::RETURN: {
	fixme("RETURN");
	return;
      } break;
	
      default:
	// EXTRAARGを含む想定外の命令
	throw_error_message(Error::INST_VIOLATION, Util::num2hex_str(insts[ci.pc]));
      }
      
      ci.pc ++;
    }
  }
}

// 外部の関数を呼び出す。
Value VMachine::call_external(external_func_t func,
			      const Value& ret_type,
			      const std::vector<Value>& arg_types,
			      std::vector<Value> args) {
  // 戻り値
  Value ret;

  // 戻り値の型変換
  ffi_type* ffi_ret_type = nullptr;
  switch(ret_type.get_address()) {
  case BasicType::TY_I32: {
    ffi_ret_type = &ffi_type_uint32;
    ret = create_value_by_primitive(static_cast<uint32_t>(0));
  } break;

  default: {
    fixme(Util::addr2str(ret_type.get_address()));
    assert(false); // TODO 他の型の対応
  } break;
  }

  // 引数の型変換 & ポインタ格納
  std::vector<ffi_type*> ffi_arg_types(args.size());
  std::vector<void*> ffi_args(args.size());

  for (int i = 0, size = args.size(); i < size; i ++) {
    switch(arg_types[i].get_address()) {
    case BasicType::TY_POINTER: {
      ffi_arg_types[i] = &ffi_type_pointer;
      ffi_args[i]      = &args[i].cache;
    } break;

    default: {
      fixme(Util::addr2str(arg_types[i].get_address()));
      assert(false); // TODO 他の型の対応
    } break;
    }
  }

  // libffiの準備
  ffi_cif cif;
  ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, args.size(),
				   ffi_ret_type, ffi_arg_types.data());

  if (status != FFI_OK) {
    throw_error_message(Error::EXT_CALL, Util::num2hex_str(status));
  }

  // メソッド呼び出し
  ffi_call(&cif, func, ret.cache, ffi_args.data());

  return ret;
}

// 型のサイズを計算する。
std::pair<size_t, unsigned int> VMachine::calc_type_size(const std::vector<vaddr_t>& member) {
  size_t size = 0;
  unsigned int max_alignment = 0;
  unsigned int odd;

  for (int i = 0, size = member.size(); i < size; i ++) {
    TypeStore& type = vmemory.get_type(member[i]);
    // メンバ中で一番大きなアライメントを保持
    if (max_alignment > type.alignment) max_alignment = type.alignment;
    // パディングを計算する
    if ((odd = size % type.alignment) != 0) size = size - odd + type.alignment;
    // サイズ分を追加
    size += type.size;
  }
  // 一番大きなアライメントで最後に調整
  if ((odd = size % max_alignment) != 0) size = size - odd + max_alignment;

  return std::make_pair(size, max_alignment);
}

// VMの終了処理を行う。
void VMachine::close() {
  // ロードした外部のライブラリを閉じる
  /*
  for (auto it = ext_libs.begin(); it != ext_libs.end(); it ++) {
    dlclose(*it);
  }
  //*/
}

// 関数を作成する。
Value VMachine::create_function(const std::string& name,
				const FuncStore::NormalProp& prop) {
  // 関数領域を確保
  VMemory::AllocFuncRet store = vmemory.alloc_func(symbols.get(name), prop);
  
  // 関数のアドレスを持つValueを作成。
  Value val;
  val.type = Value::FUNCTION;
  val.inner_value.address.upper = store.addr;
  val.inner_value.address.lower = 0;
  val.cache = &store.func;

  print_debug("create_function\n");
  print_debug("\tis_var_arg\t:%d\n", prop.is_var_arg);
  print_debug("\targ_num\t:%d\n", prop.arg_num);
  print_debug("\tcode:\n");
  for (auto it = prop.code.begin(); it != prop.code.end(); it++)
    print_debug("\t\t%08x\n", *it);
  print_debug("\taddress:%08llx\n", store.addr);
  print_debug("\tfunc:%p\n", &store.func);
  print_debug("\tk:\n");
  //for (auto it = k.begin(); it != k.end(); it++)
  //print_debug("\t\t:%s\n", (*it)->c_str());

  return val;
}

// VM組み込み関数/ライブラリなど外部の関数を作成する。
Value VMachine::create_function(const std::string& name) {
  auto ifunc = intrinsic_funcs.find(name);

  // 関数領域を確保
  VMemory::AllocFuncRet store = (ifunc == intrinsic_funcs.end() ?
				 vmemory.alloc_func(symbols.get(name)) :
				 vmemory.alloc_func(symbols.get(name), ifunc->second));

  // 関数のアドレスを持つValueを作成。
  Value val;
  val.type = Value::FUNCTION;
  val.inner_value.address.upper = store.addr;
  val.inner_value.address.lower = 0;
  val.cache = &store.func;
  
  return val;
}

// ポインタ変数を作成する。
Value VMachine::create_pointer(Value* src, int delta) {
  // 関数ポインタに対する演算はエラー
  if ((src->type == Value::FUNCTION || src->type == Value::TYPE) && delta != 0)
    throw_error(Error::MOD_FUNCTION);

  // 即値はポインタが作れないので仮想メモリに移動
  place_virtual_value(src);
  // 変数のキャッシュを解決しておく
  resolve_value_cache(src);

  // セグメンテーションフォルト判定
  if ((delta < 0 && static_cast<int>(src->inner_value.address.lower) + delta < 0) ||
      (delta > 0 && static_cast<int>(src->inner_value.address.lower) + delta >=
       static_cast<int>(vmemory.get_data(src->inner_value.address.upper).size)))
    throw_error(Error::SEGMENT_FAULT);

  // ポインタを作成。
  Value val;
  val.type = Value::POINTER_DATA;
  val.inner_value.address.upper = src->inner_value.address.upper;
  val.inner_value.address.lower = src->inner_value.address.lower + delta;
  val.cache = static_cast<uint8_t*>(src->cache) + delta;

  print_debug("create_pointer\n");
  print_debug("\tupper\t:%llx\n", val.inner_value.address.upper);
  print_debug("\tlower\t:%llx\n", val.inner_value.address.lower);
  print_debug("\tcache\t:%p\n", val.cache);
  
  return val;
}

// 基本型情報を作成する。
Value VMachine::create_type(BasicType type) {
  // 型のアドレスを持つValueを作成
  Value val;
  val.type = Value::TYPE;
  val.inner_value.address.upper = type;
  val.inner_value.address.lower = 0;
  val.cache = &vmemory.get_type(type);
  print_debug("create_type\n");
  print_debug("\taddr\t:%llx\n", val.inner_value.address.upper);

  return val;
}

// 複合型情報を作成する。
Value VMachine::create_type(const std::vector<vaddr_t>& member) {
  // 領域を確保
  std::pair<size_t, unsigned int> info = calc_type_size(member);
  VMemory::AllocTypeRet store = vmemory.alloc_type(info.first, info.second, member);
  TypeStore& type = store.type;

  // 型のアドレスを持つValueを作成
  Value val;
  val.type = Value::TYPE;
  val.inner_value.address.upper = store.addr;
  val.inner_value.address.lower = 0;
  val.cache = &type;

  return val;
}

// データの配列で初期化した値を作成する。
Value VMachine::create_value_by_array(int per_size, int length, const void* data) {
  Value val;
  val.type = Value::NORMAL_DATA;

  int size = per_size * length;
  if (size == 1 || size == 2 || size == 4 || size == 8) {
    // 即値を作る
    std::memcpy(&val.inner_value.immediate.value, data, size);
    val.inner_value.immediate.size = size;
    val.cache = &val.inner_value.immediate.value;

  } else {
    // データ領域を作る
    VMemory::AllocDataRet store = vmemory.alloc_data(size, false);/// @TODO 定数フラグ
    
    // 仮想アドレスをコピー
    val.inner_value.address.upper = store.addr;
    val.inner_value.address.lower = 0;
    // データ領域にデータをコピー
    std::memcpy(store.data.head.get(), data, size);
    val.cache = store.data.head.get();
  }

  print_debug("create_array\n");
  print_debug("\tper_size\t:%d\n", per_size);
  print_debug("\tlength\t:%d\n", length);
  if (!val.is_immediate()) {
    print_debug("\taddress\t:%s\n", Util::addr2str(val.inner_value.address.upper).c_str());
  }
  print_debug("\tcache:\t%p\n", val.cache);
  print_debug("\tdata:\n");
  for (int i = 0; i < length; i ++)
    print_debug("\t\t%02x(%c)\n",
		static_cast<const char*>(data)[i],
		(' ' <= static_cast<const char*>(data)[i] &&
		 static_cast<const char*>(data)[i] <= '~' ?
		 static_cast<const char*>(data)[i] : ' '));

  return val;
}

// ライブラリなど、外部の関数へのポインタを取得する。
external_func_t VMachine::get_external_func(const Symbols::Symbol& name) {
  external_func_t func = reinterpret_cast<external_func_t>(dlsym(RTLD_NEXT, name.str().c_str()));

  // エラーを確認
  char* error;
  if ((error = dlerror()) != nullptr) {
    throw_error_message(Error::EXT_LIBRARY, error);
  }

  return func;
}

// VMの初期設定をする。
void VMachine::run(std::vector<std::string> args) {
  // 最初のスレッドを作成
  Thread* init_thread;
  threads.push_back(std::unique_ptr<Thread>(init_thread = new Thread()));
  
  // スレッドを初期化
  init_thread->top = 1;
  CallInfo* init_callinfo;
  init_thread->callinfos.push_back(std::unique_ptr<CallInfo>(init_callinfo = new CallInfo()));

  // 関数の呼び出し情報を設定
  init_callinfo->func    = 0;
  init_callinfo->pos_ret = 0;
  init_callinfo->base    = 1;
  init_callinfo->pc      = 0;

  // main関数の取得
  auto it_main_func = globals.find(&symbols.get("main"));
  if (it_main_func == globals.end())
    throw_error_message(Error::SYM_NOT_FOUND, "main");
  FuncStore& main_func = vmemory.get_func(it_main_func->second.inner_value.address.upper);
  
  // 関数情報を元にstackを拡張
  init_thread->stack.resize(init_thread->top + main_func.normal_prop.val_num);
  init_thread->stack[0] = it_main_func->second;
  
  // プログラムのコマンドライン引数を設定
  if (main_func.normal_prop.arg_num == 2) {
    // ポインタのポインタ
    std::unique_ptr<vaddr_t[]> param2(new vaddr_t[args.size()]);
    // 引数1要素毎に作った値のアドレスを格納する
    for (unsigned int i = 0, arg_size = args.size(); i < arg_size; i ++) {
      Value value = create_value_by_array(sizeof(char),
					  args[i].length() + 1,
					  args[i].c_str());
      place_virtual_value(&value);
      param2[i] = value.get_address();
    }
    
    init_thread->stack[1] = create_value_by_primitive(static_cast<vm_int_t>(args.size()));
    init_thread->stack[2] = create_value_by_array(sizeof(vaddr_t), args.size(), param2.get());
    init_thread->top += 2;

  } else if (main_func.normal_prop.arg_num != 0) {
    // int main()でもint main(int, char**)でもないようだ
    throw_error(Error::SPEC_VIOLATION);
  }
  // int main()の場合は引数を設定しない
}

// 大域変数のアドレスを設定する。
void VMachine::set_global_value(const std::string& name, Value* value) {
  /// @todo 同一の名前が再利用されないことの確認
  // 大域変数は仮想メモリに配置
  place_virtual_value(value);
  globals.insert(std::make_pair(&symbols.get(name), *value));
}

// VMの初期設定をする。
void VMachine::setup() {
  // 基本型を登録
  vmemory.alloc_type(0,  0,  *static_cast<std::vector<vaddr_t>*>(nullptr), BasicType::TY_VOID);
  vmemory.alloc_type(8,  8,  *static_cast<std::vector<vaddr_t>*>(nullptr), BasicType::TY_POINTER);
  vmemory.alloc_type(8,  8,  *static_cast<std::vector<vaddr_t>*>(nullptr), BasicType::TY_FUNCTION);
  vmemory.alloc_type(1,  1,  *static_cast<std::vector<vaddr_t>*>(nullptr), BasicType::TY_I8);
  vmemory.alloc_type(2,  2,  *static_cast<std::vector<vaddr_t>*>(nullptr), BasicType::TY_I16);
  vmemory.alloc_type(4,  4,  *static_cast<std::vector<vaddr_t>*>(nullptr), BasicType::TY_I32);
  vmemory.alloc_type(8,  8,  *static_cast<std::vector<vaddr_t>*>(nullptr), BasicType::TY_I64);
  vmemory.alloc_type(4,  4,  *static_cast<std::vector<vaddr_t>*>(nullptr), BasicType::TY_F32);
  vmemory.alloc_type(8,  8,  *static_cast<std::vector<vaddr_t>*>(nullptr), BasicType::TY_F64);
  vmemory.alloc_type(16, 16, *static_cast<std::vector<vaddr_t>*>(nullptr), BasicType::TY_F128);

  // Cの標準ライブラリをロード
  /*
  void* dl_handle = dlopen(, RTLD_LAZY);
  if (!dl_handle) {
    throw_error_message(Error::EXT_LIBRARY, dlerror());
  }
  //*/
}

// 変数が即値であった場合に、仮想メモリに値を配置し直す。
void VMachine::place_virtual_value(Value* target) {
  // 即値でないのでスキップ
  if (target->cache != &(target->inner_value.immediate.value)) return;

  // 即値のサイズと同じデータ領域を確保
  /// @TODO:定数かどうかの判定
  VMemory::AllocDataRet alloc_data =
    vmemory.alloc_data(target->inner_value.immediate.size, false);
  
  // 変数の即値を仮想メモリにコピー
  memcpy(alloc_data.data.head.get(),
	 &target->inner_value.immediate.value,
	 target->inner_value.immediate.size);

  // 変数の指す内容を仮想メモリに変更
  target->inner_value.address.upper = alloc_data.addr;
  target->inner_value.address.lower = 0;
  target->cache = alloc_data.data.head.get();
}

// 変数のキャッシュを解決します。
void VMachine::resolve_value_cache(Value* target) {
  if (target->cache == nullptr) {
    target->cache =
      vmemory.get_data(target->inner_value.address.upper).head.get() +
      target->inner_value.address.lower;
  }
}
