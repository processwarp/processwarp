
#include <cstring>
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

// VM命令を実行する。
void VMachine::execute(int max_clock) {
  Thread& thread = *threads[0].get();
  Thread::Stack& stack = thread.stack;
  const CallInfo& ci   = *thread.call_infos[thread.call_infos.size() - 1].get();
  const FuncStore& func = vmemory.get_func(stack[ci.func].get_address());

  fixme("VMachine::execute");
}

// 関数を作成する。
Value VMachine::create_function(bool is_var_arg,
				unsigned int arg_num,
				unsigned int val_num,
				const std::vector<instruction_t>& code,
				const std::vector<Value*>& k) {
  // 関数領域を確保
  VMemory::AllocFuncRet store = vmemory.alloc_func();
  FuncStore& func = store.func;

  // 確保した領域に関数のプロパティを設定
  func.is_var_arg = is_var_arg;
  func.arg_num    = arg_num;
  func.val_num    = val_num;
  func.code.reset(new instruction_t[code.size()]);
  for (unsigned int i = 0; i < code.size(); i ++)
    func.code[i] = code[i];
  func.k.reset(new Value[k.size()]);
  for (unsigned int i = 0; i < k.size(); i ++)
    func.k[i] = *k[i];

  // 関数のアドレスを持つValueを作成。
  Value val;
  val.is_pointer  = false;
  val.is_function = true;
  val.inner_value.address.upper = store.addr;
  val.cache = &func;

  print_debug("create_function\n");
  print_debug("\tis_var_arg\t:%d\n", is_var_arg);
  print_debug("\targ_num\t:%d\n", arg_num);
  print_debug("\tcode:\n");
  for (auto it = code.begin(); it != code.end(); it++)
    print_debug("\t\t%08x\n", *it);
  print_debug("\tk:\n");
  //for (auto it = k.begin(); it != k.end(); it++)
  //print_debug("\t\t:%s\n", (*it)->c_str());

  return val;
}

// ポインタ変数を作成する。
Value VMachine::create_pointer(Value* src, int delta) {
  // 関数ポインタに対する演算はエラー
  if (src->is_function && delta != 0)
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
  val.is_pointer  = true;
  val.is_function = src->is_function;
  val.inner_value.address.upper = src->inner_value.address.upper;
  val.inner_value.address.lower = src->inner_value.address.lower + delta;
  val.cache = static_cast<uint8_t*>(src->cache) + delta;

  print_debug("create_pointer\n");
  //print_debug("\tval_addr\t:%s\n", val_addr->c_str());

  return val;
}

// データの配列で初期化した値を作成する。
Value VMachine::create_value_by_array(int per_size, int length, const void* data) {
  Value val;
  val.is_pointer  = false;
  val.is_function = false;

  int size = per_size * length;
  if (size == 1 || size == 2 || size == 4 || size == 8) {
    // 即値を作る
    std::memcpy(&val.inner_value.immediate.value, data, size);
    val.inner_value.immediate.size = size;

  } else {
    // データ領域を作る
    VMemory::AllocDataRet store = vmemory.alloc_data(size, false);/// @TODO 定数フラグ
    
    // 仮想アドレスをコピー
    val.inner_value.address.upper = store.addr;
    // データ領域にデータをコピー
    std::memcpy(store.data.head.get(), data, size);
  }

  print_debug("create_array\n");
  print_debug("\tper_size\t:%d\n", per_size);
  print_debug("\tlength\t:%d\n", length);
  print_debug("\tdata:\n");
  for (int i = 0; i < length; i ++)
    print_debug("\t\t%02x(%c)\n",
		static_cast<const char*>(data)[i],
		(' ' <= static_cast<const char*>(data)[i] &&
		 static_cast<const char*>(data)[i] <= '~' ?
		 static_cast<const char*>(data)[i] : ' '));

  return val;
}

// 大域変数のアドレスを設定する。
void VMachine::set_global_value(const std::string& name, Value* value) {
  /// @todo 同一の名前が再利用されないことの確認
  // 大域変数は仮想メモリに配置
  place_virtual_value(value);
  globals.insert(std::make_pair(&symbols.get(name), *value));
}

// VMの初期設定をする。
void VMachine::setup(std::vector<std::string> args) {
  // main関数の取得
  auto it_main_func = globals.find(&symbols.get("main"));
  if (it_main_func == globals.end())
    throw_error_message(Error::SYM_NOT_FOUND, "main");
  FuncStore& main_func = vmemory.get_func(it_main_func->second.inner_value.address.upper);
  
  // 最初のスレッドを作成
  Thread* init_thread;
  threads.push_back(std::unique_ptr<Thread>(init_thread = new Thread()));
  
  // スレッドを初期化
  init_thread->top = 1;
  CallInfo* init_call_info;
  init_thread->call_infos.push_back(std::unique_ptr<CallInfo>(init_call_info = new CallInfo()));
  init_thread->stack.resize(init_thread->top + main_func.val_num);
  
  // プログラムのコマンドライン引数を設定
  if (main_func.arg_num == 2) {
    // ポインタのポインタ
    std::unique_ptr<vaddr_t[]> param2(new vaddr_t[args.size()]);
    // 引数1要素毎に作った値のアドレスを格納する
    for (unsigned int i = 0, arg_size = args.size(); i < arg_size; i ++) {
      param2[i] = create_value_by_array(sizeof(char),
					args[i].length() + 1,
					args[i].c_str()).get_address();
    }
    
    init_thread->stack[1] = create_value_by_primitive(static_cast<vm_int_t>(args.size()));
    init_thread->stack[2] = create_value_by_array(sizeof(vaddr_t), args.size(), param2.get());
    init_thread->top += 2;

  } else if (main_func.arg_num != 0) {
    // int main()でもint main(int, char**)でもないようだ
    throw_error(Error::SPEC_VIOLATION);
  }
  // int main()の場合は引数を設定しない
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
