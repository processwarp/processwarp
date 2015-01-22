
#include <cstring>
#include <memory>

#include <ffi/ffi.h>
#include <dlfcn.h>
#include <unistd.h>

#include "error.hpp"
#include "func_store.hpp"
#include "instruction.hpp"
#include "stackinfo.hpp"
#include "type_based.hpp"
#include "util.hpp"
#include "vmachine.hpp"

using namespace usagi;

static TypeBased* TYPE_BASES[] = {
  nullptr, // 0
  nullptr, // 1 void
  new TypePointer(), // 2 pointer
  nullptr, // 3 function
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr, // 10
  new TypeExtended<int8_t>(), // 11 8bit整数型
  new TypeExtended<int16_t>(), // 12 16bit整数型
  new TypeExtended<int32_t>(), // 13 32bit整数型
  new TypeExtended<int64_t>(), // 14 64bit整数型
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr, // 20
  new TypeExtended<uint8_t>(), // 21 8bit整数型
  new TypeExtended<uint16_t>(), // 22 16bit整数型
  new TypeExtended<uint32_t>(), // 23 32bit整数型
  new TypeExtended<uint64_t>(), // 24 64bit整数型
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr,
  nullptr, // 30
  nullptr, // 31
  new TypeExtended<float>(), // 32 float
  new TypeExtended<double>(), // 33 double
  nullptr, // 34
  nullptr, // 35 quad
};

struct OperandRet {
  DataStore& data;
  vaddr_t addr;
  uint8_t* cache;
};

struct OperandParam {
  DataStore& stack;
  const std::vector<vaddr_t>& k;
  VMemory& vmemory;
};

inline FuncStore& get_function(instruction_t code, OperandParam& param) {
  int operand = Instruction::get_operand(code);
  // 関数は定数領域に置かれているはず
  assert((operand & HEAD_OPERAND) != 0);

  vaddr_t addr = param.k.at(FILL_OPERAND - operand);
  return param.vmemory.get_func(addr);
}

inline TypeStore& get_type(instruction_t code, OperandParam& param) {
  int operand = Instruction::get_operand(code);
  // 型は定数領域に置かれているはず
  assert((operand & HEAD_OPERAND) != 0);
  
  vaddr_t addr = param.k.at(FILL_OPERAND - operand);
  return param.vmemory.get_type(addr);
}

inline OperandRet get_operand(instruction_t code, OperandParam& param) {
  int operand = Instruction::get_operand(code);
  if ((operand & HEAD_OPERAND) != 0) {
    print_debug("operand k %x\n", FILL_OPERAND - operand);
    assert(FILL_OPERAND - operand < param.k.size());
    // 定数の場合1の補数表現からの復元
    vaddr_t addr = param.k.at(FILL_OPERAND - operand);
    DataStore& store = param.vmemory.get_data(addr);
    return {store, addr, store.head.get() + VMemory::get_addr_lower(addr)};

  } else {
    print_debug("operand stack %d %ld\n", operand, param.stack.size);
    assert(operand < param.stack.size);
    return {param.stack, param.stack.addr + operand, param.stack.head.get() + operand};
  }
}

// コンストラクタ。
VMachine::VMachine() :
  status(SETUP) {
}

// VM命令を実行する。
void VMachine::execute(int max_clock) {
  Thread& thread = *(threads.front().get());
 re_entry: {
    // ciが1段の場合、終了
    if (thread.stackinfos.size() == 1) return;
    
    StackInfo& stackinfo = *(thread.stackinfos.back().get());
    const FuncStore& func = stackinfo.func_cache;
    const std::vector<instruction_t>& insts = func.normal_prop.code;
    const std::vector<vaddr_t>&       k     = func.normal_prop.k;
    OperandParam op_param = {stackinfo.stack_cache, k, vmemory};

    for (; max_clock > 0; max_clock --) {
      instruction_t code = insts.at(stackinfo.pc);
      print_debug("pc:%d, code:%08x, k:%ld, insts:%ld\n",
		  stackinfo.pc, code, k.size(), insts.size());
      //usleep(100000);///< TODO

      // call命令の判定(call命令の場合falseに変える)
      bool is_tailcall = true;

      switch (static_cast<uint8_t>(Instruction::get_opcode(code))) {
      case Opcode::NOP: {
	// 何もしない命令
      } break;
	
      case Opcode::CALL:
	is_tailcall = false;
	
      case Opcode::TAILCALL: {
	std::unique_ptr<StackInfo> new_stackinfo;
	FuncStore& new_func = get_function(code, op_param);

	assert(!is_tailcall); // TODO 動きを確認する。
	new_stackinfo.reset
	  (new StackInfo(new_func,
			 // tailcallの場合、戻り値の格納先を現行のものから引き継ぐ
			 is_tailcall ? stackinfo.ret_addr : stackinfo.output,
			 Instruction::get_operand(insts.at(stackinfo.pc + 1)),
			 Instruction::get_operand(insts.at(stackinfo.pc + 2)),
			 vmemory.alloc_data(new_func.normal_prop.stack_size, false)));
	
	// 引数を集める
	int args = 0;
	int written_size = 0;
	instruction_t type_inst;
	instruction_t value_inst;
	std::vector<uint8_t> work; // 可変長引数、ネイティブメソッド用引数を一時的に格納する領域
	while (stackinfo.pc + 4 + args * 2 < insts.size() &&
	       Instruction::get_opcode(type_inst  = insts.at(stackinfo.pc + 3 + args * 2))
	       == Opcode::EXTRA &&
	       Instruction::get_opcode(value_inst = insts.at(stackinfo.pc + 4 + args * 2))
	       == Opcode::EXTRA) {

	  const TypeStore& type  = get_type(type_inst, op_param);
	  OperandRet value = get_operand(value_inst, op_param);

	  if (new_func.type == FuncType::FC_NORMAL &&
	      args < new_func.normal_prop.arg_num) {
	      // 通常の引数はスタックの先頭にコピー
	      memcpy(new_stackinfo->stack_cache.head.get() + written_size, value.cache, type.size);
	      written_size += type.size;

	  } else {
	    // 可変長引数、ネイティブメソッド用引数は一時領域に格納
	    std::size_t dest = work.size();
	    work.resize(dest + sizeof(vaddr_t) + type.size);
	    memcpy(work.data() + dest,                   &type.addr,  sizeof(vaddr_t));
	    memcpy(work.data() + dest + sizeof(vaddr_t), value.cache, type.size);
	  }
	  
	  args += 1;
	}

	// pcの書き換え
	stackinfo.pc += args * 2 + 2;

	if (new_func.type == FuncType::FC_NORMAL) {
	  // 可変長引数でない場合、引数の数をチェック
	  if (args < new_func.normal_prop.arg_num ||
	      (!new_func.normal_prop.is_var_arg && args != new_func.normal_prop.arg_num))
	    throw_error(Error::TYPE_VIOLATION);

	  // 可変長引数分がある場合、別領域を作成
	  DataStore& store = create_value_by_array(work.size(), 1, work.data());
	  new_stackinfo->alloca_addrs.push_back(store.addr);
	  new_stackinfo->var_arg = store.addr;

	  if (is_tailcall) {
	    // 末尾再帰の場合、既存のstackinfoを削除
	    // 次の命令はRETURNのはず
	    assert(Instruction::get_opcode(insts.at(stackinfo.pc + 2)) == Opcode::RETURN);
	    thread.stackinfos.pop_back();
	  } else {
	    stackinfo.pc ++;
	    assert(false);
	    // 末尾再帰でない場合、callinfosを追加
	  }
	  thread.stackinfos.push_back(std::unique_ptr<StackInfo>(new_stackinfo.release()));
	  goto re_entry;

	} else if (func.type == FuncType::FC_INTRINSIC) {
	  // VM組み込み関数の呼び出し
	  assert(false);
	  assert(func.intrinsic != nullptr);
	  func.intrinsic(*this, thread, stackinfo.output_cache, work);

	} else { // func.type == FuncType::EXTERNAL
	  // 関数のロードを行っていない場合、ロードする
	  if (new_func.external == nullptr) {
	    new_func.external = get_external_func(new_func.name);
	  }

	  // 関数の呼び出し
	  call_external(new_func.external, new_func.ret_type, stackinfo.output_cache, work);
	}
	
      } break;

      case Opcode::RETURN: {
	StackInfo& upperinfo = *(thread.stackinfos.at(thread.stackinfos.size() - 2).get());

	if (Instruction::get_operand(code) == FILL_OPERAND) {
	  // 戻り値がないので何もしない

	} else {
	  // 戻り値を設定する
	  OperandRet operand = get_operand(code, op_param);
	  
	  stackinfo.type_cache1->copy(upperinfo.output_cache, operand.cache);
	}
	// スタック領域を開放
	vmemory.free(stackinfo.stack);

	// alloca領域を開放
	for (vaddr_t addr : stackinfo.alloca_addrs) {
	  vmemory.free(addr);
	}
	
	// 1段上のスタックのpcを設定(normal_pc)
	upperinfo.pc = stackinfo.normal_pc;

	// stackinfoを1つ除去してre_entryに移動
	thread.stackinfos.pop_back();
	goto re_entry;
      } break;

      case Opcode::SET_TYPE: {
	TypeStore& store = get_type(code, op_param);
	stackinfo.type = store.addr;
	if (store.addr < sizeof(TYPE_BASES) / sizeof(TYPE_BASES[0])) {
	  stackinfo.type_cache1 = TYPE_BASES[store.addr];
	  if (stackinfo.type_cache1 == nullptr) {
	    assert(false); // TODO 未対応の型
	  }

	} else {
	  assert(false); // 拡張型
	}
	stackinfo.type_cache2 = &store;
      } break;

      case Opcode::SET_OUTPUT: {
	OperandRet operand = get_operand(code, op_param);
	stackinfo.output       = operand.addr;
	stackinfo.output_cache = operand.cache;
      } break;

      case Opcode::SET_VALUE: {
	OperandRet operand = get_operand(code, op_param);
	stackinfo.value       = operand.addr;
	stackinfo.value_cache = operand.cache;
      } break;

      case Opcode::ADD: {
	OperandRet operand = get_operand(code, op_param);
	stackinfo.type_cache1->add(stackinfo.output_cache,
				   stackinfo.value_cache,
				   operand.cache);
      } break;

      case Opcode::SET_ADR: {
	OperandRet operand = get_operand(code, op_param);
	stackinfo.address = operand.addr;
	stackinfo.address_cache = operand.cache;
      } break;

      case Opcode::SET_PTR: {
	OperandRet operand = get_operand(code, op_param);
	/*
	vaddr_t addr = *reinterpret_cast<vaddr_t*>(operand.cache);
	DataStore& data = vmemory.get_data(addr);
	stackinfo.address = addr;
	stackinfo.address_cache = data.head.get() + VMemory::get_addr_lower(addr);
	*/
	stackinfo.address = operand.addr;
	stackinfo.address_cache = operand.cache;
      } break;

      case Opcode::SET_ALIGN: {
	int operand = Instruction::get_operand_value(code);
	stackinfo.alignment = operand;
      } break;

      case Opcode::ADD_ADR: {
	int operand = Instruction::get_operand_value(code);
	stackinfo.address += operand;
	stackinfo.address_cache += operand;
      } break;

      case Opcode::MUL_ADR: {
	int operand = Instruction::get_operand_value(code);
	const vm_int_t diff = operand * stackinfo.type_cache1->get(stackinfo.value_cache);
	stackinfo.address += diff;
	stackinfo.address_cache += diff;
      } break;

      case Opcode::GET_ADR: {
	OperandRet operand = get_operand(code, op_param);
	*reinterpret_cast<vaddr_t*>(operand.cache) = stackinfo.address;
      } break;

      case Opcode::LOAD: {
	OperandRet operand = get_operand(code, op_param);
	memcpy(operand.cache, stackinfo.address_cache, stackinfo.type_cache2->size);
      } break;

      case Opcode::STORE: {
	OperandRet operand = get_operand(code, op_param);
	memcpy(stackinfo.address_cache, operand.cache, stackinfo.type_cache2->size);
      } break;

	/*
      case Opcode::JUMP: {
	// 無条件ジャンプを行う
	ci.phi = ci.pc = Instruction::get_code_A(code);
	continue;
      } break;

      case Opcode::PHI: {
	Value& dst = get_operand_A(ci.base, code, stack);
	const Value& type = get_operand_B(ci.base, code, stack, k);
	while (code = insts.at(ci.pc + 1), Instruction::get_opcode(code) == Opcode::EXTRAARG2) {
	  if (Instruction::get_code_B(code) == ci.phi) {
	    const Value& src = get_operand_A(ci.base, code, stack, k);
	    copy_value(dst, src, type);
	  }
	  ci.pc ++;
	}
		      
      } break;
	*/

      case Opcode::TYPE_CAST: {
	TypeStore& type = get_type(code, op_param);
	stackinfo.type_cache1->type_cast(stackinfo.output_cache,
					 type.addr,
					 stackinfo.value_cache);
      } break;

      default: {
	// EXTRAARGを含む想定外の命令
	throw_error_message(Error::INST_VIOLATION, Util::num2hex_str(insts.at(stackinfo.pc)));
      } break;
      }
      
      stackinfo.pc ++;
    }
  }
}

// 外部の関数を呼び出す。
void VMachine::call_external(external_func_t func,
			     vaddr_t ret_type,
			     uint8_t* ret_addr,
			     std::vector<uint8_t>& args) {
  print_debug("call_external\n");

  // 戻り値の型変換
  ffi_type* ffi_ret_type = nullptr;
  switch(ret_type) {
  case BasicType::TY_UI8:  ffi_ret_type = &ffi_type_uint8;  break;
  case BasicType::TY_UI16: ffi_ret_type = &ffi_type_uint16; break;
  case BasicType::TY_UI32: ffi_ret_type = &ffi_type_uint32; break;
  case BasicType::TY_UI64: ffi_ret_type = &ffi_type_uint64; break;
  case BasicType::TY_SI8:  ffi_ret_type = &ffi_type_sint8;  break;
  case BasicType::TY_SI16: ffi_ret_type = &ffi_type_sint16; break;
  case BasicType::TY_SI32: ffi_ret_type = &ffi_type_sint32; break;
  case BasicType::TY_SI64: ffi_ret_type = &ffi_type_sint64; break;

  default: {
    fixme(Util::vaddr2str(ret_type));
    assert(false); // TODO 他の型の対応
  } break;
  }

  // 引数の型変換 & ポインタ格納
  std::vector<ffi_type*> ffi_arg_types;
  std::vector<void*> ffi_args;

  int seek = 0;
  while(seek < args.size()) {
    TypeStore& type = vmemory.get_type(*reinterpret_cast<vaddr_t*>(args.data() + seek));

    switch(type.addr) {
    case BasicType::TY_POINTER: {
      ffi_arg_types.push_back(&ffi_type_pointer);
      vaddr_t addr = *reinterpret_cast<vaddr_t*>(args.data() + seek + sizeof(vaddr_t));
      DataStore& pointed = vmemory.get_data(addr);
      *reinterpret_cast<void**>(args.data() + seek + sizeof(vaddr_t)) =
	pointed.head.get() + VMemory::get_addr_lower(addr);
      ffi_args.push_back(args.data() + seek + sizeof(vaddr_t));
    } break;

    case BasicType::TY_UI8: {
      ffi_arg_types.push_back(&ffi_type_uint8);
      ffi_args.push_back(args.data() + seek + sizeof(vaddr_t));
    } break;

    case BasicType::TY_UI16: {
      ffi_arg_types.push_back(&ffi_type_uint16);
      ffi_args.push_back(args.data() + seek + sizeof(vaddr_t));
    } break;

    case BasicType::TY_UI32: {
      ffi_arg_types.push_back(&ffi_type_uint32);
      ffi_args.push_back(args.data() + seek + sizeof(vaddr_t));
    } break;

    case BasicType::TY_UI64: {
      ffi_arg_types.push_back(&ffi_type_uint64);
      ffi_args.push_back(args.data() + seek + sizeof(vaddr_t));
    } break;

    default: {
      fixme(Util::vaddr2str(type.addr));
      assert(false); // TODO 他の型の対応
    } break;
    }
    
    seek += sizeof(vaddr_t) + type.size;
  }

  // libffiの準備
  ffi_cif cif;
  ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, ffi_args.size(),
				   ffi_ret_type, ffi_arg_types.data());

  if (status != FFI_OK) {
    throw_error_message(Error::EXT_CALL, Util::num2hex_str(status));
  }

  // メソッド呼び出し
  ffi_call(&cif, func, ret_addr, ffi_args.data());
}

// 型のサイズと最大アライメントを計算する。
std::pair<size_t, unsigned int> VMachine::calc_type_size(const std::vector<vaddr_t>& member) {
  size_t size = 0;
  unsigned int max_alignment = 0;
  unsigned int odd;

  for (int i = 0, member_size = member.size(); i < member_size; i ++) {
    TypeStore& type = vmemory.get_type(member.at(i));
    // メンバ中で一番大きなアライメントを保持
    if (type.alignment > max_alignment) max_alignment = type.alignment;
    // パディングを計算する
    if ((odd = size % type.alignment) != 0) size = size - odd + type.alignment;
    // サイズ分を追加
    size += type.size;
  }
  // 一番大きなアライメントで最後に調整
  if ((odd = size % max_alignment) != 0) size = size - odd + max_alignment;

  return std::make_pair(size, max_alignment);
}

// 型のサイズと最大アライメントを計算する。
std::pair<size_t, unsigned int> VMachine::calc_type_size(vaddr_t type) {
  TypeStore& t = vmemory.get_type(type);
  
  return std::make_pair(t.size, t.alignment);
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
FuncStore& VMachine::create_function(const std::string& name,
				     vaddr_t ret_type,
				     const FuncStore::NormalProp& prop) {
  // 関数領域を確保
  FuncStore& store = vmemory.alloc_func(symbols.get(name), ret_type, prop);
  
  print_debug("create_function\n");
  print_debug("\tis_var_arg\t:%d\n", prop.is_var_arg);
  print_debug("\targ_num\t:%d\n", prop.arg_num);
  print_debug("\tstack_size\t:%d\n", prop.stack_size);
  print_debug("\tcode:(%ld)\n", prop.code.size());
  for (auto it = prop.code.begin(); it != prop.code.end(); it++) {
    print_debug("\t\t%08x\n", *it);
  }
  print_debug("\taddress\t:%016llx\n", store.addr);
  print_debug("\tfunc\t:%p\n", &store);
  print_debug("\tk:(%ld)\n", prop.k.size());
  for (auto it = prop.k.begin(); it != prop.k.end(); it++) {
    print_debug("\t\t%016llx\n", *it);
  }
  print_debug("\tret_type\t%016llx\n", store.ret_type);

  return store;
}

// VM組み込み関数/ライブラリなど外部の関数を作成する。
FuncStore& VMachine::create_function(const std::string& name,
				     vaddr_t ret_type) {
  auto ifunc = intrinsic_funcs.find(name);

  // 関数領域を確保
  FuncStore& store = (ifunc == intrinsic_funcs.end() ?
		      vmemory.alloc_func(symbols.get(name), ret_type) :
		      vmemory.alloc_func(symbols.get(name), ret_type, ifunc->second));

  return store;
}

// NULLポインタを作成する。
DataStore& VMachine::create_null() {
  return create_pointer(VADDR_NULL, 0);
}

// ポインタ変数を作成する。
DataStore& VMachine::create_pointer(vaddr_t src, int delta) {
  // 関数ポインタに対する演算はエラー
  if ((VMemory::addr_is_func(src) || VMemory::addr_is_type(src)) && delta != 0)
    throw_error(Error::MOD_FUNCTION);

  /// セグメンテーションフォルト判定
  vaddr_t lower = vmemory.get_addr_lower(src);
  DataStore& data = vmemory.get_data(src);
  if ((delta < 0 && static_cast<signed>(lower) + delta < 0) ||
      (delta > 0 && static_cast<signed>(lower) + delta >=
       static_cast<int>(data.size)))
    throw_error(Error::SEGMENT_FAULT);

  print_debug("create_pointer\n");
  print_debug("\tsrc\t:%llx\n", src);
  print_debug("\tdelta\t:%d\n", delta);
  print_debug("\taddr\t:%p\n", data.head.get());

  // ポインタを作成。
  return create_value_by_primitive(src + delta);
}

// 基本型情報を作成する。
TypeStore& VMachine::create_type(BasicType type) {
  // 型のアドレスを持つValueを作成
  print_debug("create_type(basic)\n");
  print_debug("\taddr\t:%016llx\n", type);
  
  return vmemory.get_type(type);
}

// 配列型情報を作成する。
TypeStore& VMachine::create_type(vaddr_t element, unsigned int num) {
  // サイズ、アライメントを計算
  std::vector<vaddr_t> member;
  member.push_back(element);
  std::pair<size_t, unsigned int> info = calc_type_size(member);
  
  // 領域を確保
  return vmemory.alloc_type(info.first * num, info.second, element, num);
}

// 複合型情報を作成する。
TypeStore& VMachine::create_type(const std::vector<vaddr_t>& member) {
  // 領域を確保
  std::pair<size_t, unsigned int> info = calc_type_size(member);
  return vmemory.alloc_type(info.first, info.second, member);
}

// データの配列で初期化した値を作成する。
DataStore& VMachine::create_value_by_array(int per_size, int length, const void* data) {
  int size = per_size * length;
  // データ領域を作る
  DataStore& store = vmemory.alloc_data(size, false);/// @TODO 定数フラグ
  
  // データ領域にデータをコピー
  if (data != nullptr) {
    std::memcpy(store.head.get(), data, size);
  }

  print_debug("create_array\n");
  print_debug("\taddr\t:%016llx\n", store.addr);
  print_debug("\taddr\t:%p\n", store.head.get());
  print_debug("\tper_size\t:%d\n", per_size);
  print_debug("\tlength\t:%d\n", length);
  if (data == nullptr) {
    print_debug("\tdata:nullptr\n");
  } else {
    print_debug("\tdata:\n");
    for (int i = 0; i < size; i ++) {
      print_debug("\t\t%02x(%c)\n",
		  static_cast<const char*>(data)[i],
		  (' ' <= static_cast<const char*>(data)[i] &&
		   static_cast<const char*>(data)[i] <= '~' ?
		   static_cast<const char*>(data)[i] : ' '));
    }
  }

  return store;
}

// ライブラリ関数を指定アドレスに展開する。
void VMachine::deploy_function_external(const std::string& name, vaddr_t addr) {
  auto ifunc = intrinsic_funcs.find(name);

  // VM組み込み関数と同じ名前は使えない
  if (ifunc != intrinsic_funcs.end()) {
    throw_error_message(Error::EXT_LIBRARY, name);
  }

  // 関数領域を確保
  vmemory.alloc_func(symbols.get(name), addr);
}

// VM組み込み関数を指定アドレスに展開する。
void VMachine::deploy_function_intrinsic(const std::string& name, vaddr_t ret_type, vaddr_t addr) {
  auto ifunc = intrinsic_funcs.find(name);

  // VM組み込み関数に指定の名前の関数がない。
  if (ifunc == intrinsic_funcs.end()) {
    throw_error_message(Error::EXT_LIBRARY, name);
  }

  // 関数領域を確保
  vmemory.alloc_func(symbols.get(name), ret_type, ifunc->second, addr);
}

// 通常の関数(VMで解釈、実行する)を指定アドレスに展開する。
void VMachine::deploy_function_normal(const std::string& name,
				      vaddr_t ret_type,
				      const FuncStore::NormalProp& prop,
				      vaddr_t addr) {
  // 関数領域を確保
  vmemory.alloc_func(symbols.get(name), ret_type, prop, addr);
}

// ライブラリなど、外部の関数へのポインタを取得する。
external_func_t VMachine::get_external_func(const Symbols::Symbol& name) {
  print_debug("get external func:%s\n", name.str().c_str());
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

  // main関数の取得
  auto it_main_func = globals.find(&symbols.get("main"));
  if (it_main_func == globals.end())
    throw_error_message(Error::SYM_NOT_FOUND, "main");
  FuncStore& main_func = vmemory.get_func(it_main_func->second);

  // main関数用のスタックを確保する
  DataStore& main_stack = vmemory.alloc_data(main_func.normal_prop.stack_size, 1);
  
  vaddr_t init_stack_addr;
  // プログラムのコマンドライン引数を設定
  if (main_func.normal_prop.arg_num == 2) {
    // main関数の戻り値と引数を格納するのに必要な領域サイズを計算
    const size_t ret_size = calc_type_size(main_func.ret_type).first;
    size_t init_stack_size = ret_size + sizeof(vaddr_t) * args.size();
    for (unsigned int i = 0, arg_size = args.size(); i < arg_size; i ++) {
      init_stack_size += args.at(i).length() + 1;
    }
    // 領域を確保
    DataStore& init_stack = vmemory.alloc_data(init_stack_size, 1);
    init_stack_addr = init_stack.addr;
    // mainのreturnを受け取るためのスタックを1段確保する
    StackInfo* init_stackinfo = new StackInfo(*static_cast<FuncStore*>(nullptr),
					      VADDR_NON, 0, 0, init_stack);
    init_thread->stackinfos.push_back(std::unique_ptr<StackInfo>(init_stackinfo));
    
    // init_stack_dataにmain関数の戻り値、argvとして渡すポインタの配列、引数文字列、、を格納する
    vaddr_t sum = ret_size + sizeof(vaddr_t) * args.size();
    for (unsigned int i = 0, arg_size = args.size(); i < arg_size; i ++) {
      memcpy(init_stack.head.get() + ret_size + sizeof(vaddr_t) * i,
	     &sum, sizeof(vaddr_t));
      memcpy(init_stack.head.get() + sum,
	     args.at(i).c_str(), args.at(i).length() + 1);
      sum += args.at(i).length() + 1;
    }
    // main関数のスタックの先頭にargc, argvを格納する
    vm_int_t argc = args.size();
    vaddr_t  argv = init_stack.addr + ret_size;
    memcpy(main_stack.head.get(), &argc, sizeof(argc));
    memcpy(main_stack.head.get() + sizeof(argc), &argv, sizeof(argv));
    
  } else if (main_func.normal_prop.arg_num != 0) {
    // int main()でもint main(int, char**)でもないようだ
    throw_error(Error::SPEC_VIOLATION);

  } else {
    // int main()の場合は引数を設定しない
    // main関数の戻り値格納先を確保する
    DataStore& init_stack = vmemory.alloc_data(calc_type_size(main_func.ret_type).first, 1);
    init_stack_addr = init_stack.addr;
    // mainのreturnを受け取るためのスタックを1段確保する
    StackInfo* init_stackinfo = new StackInfo(*static_cast<FuncStore*>(nullptr),
					      VADDR_NON, 0, 0, init_stack);
    init_stackinfo->output = init_stack.addr;
    init_stackinfo->output_cache = init_stack.head.get();
    init_thread->stackinfos.push_back(std::unique_ptr<StackInfo>(init_stackinfo));
  }

  StackInfo* main_stackinfo = new StackInfo(main_func,
					    init_stack_addr,
					    0, 0, main_stack);
  init_thread->stackinfos.push_back(std::unique_ptr<StackInfo>(main_stackinfo));

  status = ACTIVE;
}

// 大域変数のアドレスを設定する。
void VMachine::set_global_value(const std::string& name, vaddr_t addr) {
  /// @todo 同一の名前が再利用されないことの確認
  globals.insert(std::make_pair(&symbols.get(name), addr));
}

// VMの初期設定をする。
void VMachine::setup() {
  // BasicTypeのメンバをsize0, alignment0のTY_VOIDにしておくことで、getelementptrの
  // 計算で余計に計算しても問題が起きない
  std::vector<vaddr_t> basic_type_dummy;
  basic_type_dummy.push_back(BasicType::TY_VOID);

#define M_ALLOC_BASIC_TYPE(s, a, t)		       \
  vmemory.alloc_type((s), (a), basic_type_dummy, (t)); \
  intrinsic_addrs.insert(t)

  // 基本型を登録
  M_ALLOC_BASIC_TYPE(0,  0,  BasicType::TY_VOID);
  M_ALLOC_BASIC_TYPE(8,  8,  BasicType::TY_POINTER);
  M_ALLOC_BASIC_TYPE(8,  8,  BasicType::TY_FUNCTION);
  M_ALLOC_BASIC_TYPE(1,  1,  BasicType::TY_UI8);
  M_ALLOC_BASIC_TYPE(2,  2,  BasicType::TY_UI16);
  M_ALLOC_BASIC_TYPE(4,  4,  BasicType::TY_UI32);
  M_ALLOC_BASIC_TYPE(8,  8,  BasicType::TY_UI64);
  M_ALLOC_BASIC_TYPE(1,  1,  BasicType::TY_SI8);
  M_ALLOC_BASIC_TYPE(2,  2,  BasicType::TY_SI16);
  M_ALLOC_BASIC_TYPE(4,  4,  BasicType::TY_SI32);
  M_ALLOC_BASIC_TYPE(8,  8,  BasicType::TY_SI64);
  M_ALLOC_BASIC_TYPE(4,  4,  BasicType::TY_F32);
  M_ALLOC_BASIC_TYPE(8,  8,  BasicType::TY_F64);
  M_ALLOC_BASIC_TYPE(16, 16, BasicType::TY_F128);

#undef M_ALLOC_BASIC_TYPE

  // Cの標準ライブラリをロード
  /*
  void* dl_handle = dlopen(, RTLD_LAZY);
  if (!dl_handle) {
    throw_error_message(Error::EXT_LIBRARY, dlerror());
  }
  //*/
}

// ワープ後のVMの設定をする。
void VMachine::setup_continuous() {
}
