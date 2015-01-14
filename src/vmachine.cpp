
#include <cstring>
#include <memory>
#include <ffi/ffi.h>
#include <dlfcn.h>
#include <unistd.h>

#include "callinfo.hpp"
#include "error.hpp"
#include "func_store.hpp"
#include "instruction.hpp"
#include "util.hpp"
#include "vmachine.hpp"

using namespace usagi;

// コンストラクタ。
VMachine::VMachine() :
  status(SETUP) {
}

inline Value& get_operand_A(unsigned int base, instruction_t code, Thread::Stack& stack) {
  print_debug("operandA stack %llx\n", base + Instruction::get_code_A(code));
  assert((Instruction::get_code_A(code) & HEAD_OPERAND_AB) == 0);
  assert(base + Instruction::get_code_A(code) < stack.size());
  return stack.at(base + Instruction::get_code_A(code));
}

inline Value& get_operand_B(unsigned int base, instruction_t code, Thread::Stack& stack) {
  print_debug("operandB stack %llx\n", base + Instruction::get_code_B(code));
  assert((Instruction::get_code_B(code) & HEAD_OPERAND_AB) == 0);
  assert(base + Instruction::get_code_B(code) < stack.size());
  return stack.at(base + Instruction::get_code_B(code));
}

inline const Value& get_operand_A(unsigned int base, instruction_t code,
				  const Thread::Stack& stack, const std::vector<Value>& k) {
  instruction_t a = Instruction::get_code_A(code);
  if ((a & HEAD_OPERAND_AB) != 0) {
    print_debug("operandA k %llx\n", MAX_OPERAND_AB - a);
    assert(MAX_OPERAND_AB - a < k.size());
    return k.at(MAX_OPERAND_AB - a); // 定数の場合1の補数表現からの復元

  } else {
    print_debug("operandA stack %llx\n", a);
    assert(base + a < stack.size());
    return stack.at(base + a);
  }
}

inline const Value& get_operand_B(unsigned int base, instruction_t code,
				  const Thread::Stack& stack, const std::vector<Value>& k) {
  instruction_t b = Instruction::get_code_B(code);
  if ((b & HEAD_OPERAND_AB) != 0) {
    print_debug("operandB k %llx\n", MAX_OPERAND_AB - b);
    assert(MAX_OPERAND_AB - b < k.size());
    return k.at(MAX_OPERAND_AB - b); // 定数の場合1の補数表現からの復元

  } else {
    print_debug("operandB stack %llx\n", b);
    assert(base + b < stack.size());
    return stack.at(base + b);
  }
}

// VM命令を実行する。
void VMachine::execute(int max_clock) {
  Thread&           thread  = *(threads.front().get());
  Thread::Stack&    stack   = thread.stack;
 re_entry: {
    // ciが0段の場合、終了
    if (thread.callinfos.size() == 0) return;
    
    CallInfo&         ci      = *(thread.callinfos.back().get());
    resolve_value_cache(&stack.at(ci.base - 1));
    const FuncStore&  func    = *reinterpret_cast<FuncStore*>(stack.at(ci.base - 1).cache);
    const std::vector<instruction_t>& insts   = func.normal_prop.code;
    const std::vector<Value>&         k       = func.normal_prop.k;

    for (; max_clock > 0; max_clock --) {
      instruction_t code = insts.at(ci.pc);
      print_debug("pc:%d, code:%016llx, stack:%ld, k:%ld, insts:%ld\n",
		  ci.pc, code, stack.size(), k.size(), insts.size());
      usleep(100000);///< TODO
      switch (static_cast<uint8_t>(Instruction::get_opcode(code))) {
      case Opcode::CALL: {
	std::unique_ptr<CallInfo> new_ci(new CallInfo());
	const bool is_tailcall = (Instruction::get_code_B(code) == 1);
	const instruction_t ret_code = insts.at(ci.pc + 1); // 戻り値に関する情報
	if (is_tailcall) {
	  // 末尾再帰のため、ciを再利用
	  new_ci->pos_ret = ci.pos_ret;
	  new_ci->base    = ci.base;
	  new_ci->pc      = 0;
	  new_ci->phi     = 0;
	  // 関数をbase-1に設置
	  stack.at(new_ci->base - 1) = get_operand_A(ci.base, code, stack, k);

	} else {
	  // 末尾再帰でないので新しいciを作成
	  new_ci->pos_ret = ci.base + Instruction::get_code_B(ret_code);
	  /// TODO 現在利用しているスタックの最大+2にする
	  new_ci->base    = ci.base + func.normal_prop.val_num + 2;
	  new_ci->pc      = 0;
	  new_ci->phi     = 0;
	  // 関数をbase-1に設置
	  stack.at(new_ci->base - 1) = get_operand_A(ci.base, code, stack, k);
	}

	resolve_value_cache(&stack.at(new_ci->base - 1));
	FuncStore& func = *static_cast<FuncStore*>(stack.at(new_ci->base - 1).cache);

	// 引数を集める
	/// @TODO コピー効率を上げる
	std::vector<Value> args;
	std::vector<Value> arg_types;
	while (code = insts.at(ci.pc + args.size() + 2),
	       Instruction::get_opcode(code) == Opcode::EXTRAARG2) {
	  arg_types.push_back(get_operand_A(ci.base, code, stack, k));
	  args     .push_back(get_operand_B(ci.base, code, stack, k));

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
	ci.pc += args.size() + 1;

	if (func.type == FuncType::FC_NORMAL) {
	  // 可変長引数でない場合、引数の数をチェック
	  if (args.size() < func.normal_prop.arg_num ||
	      (!func.normal_prop.is_var_arg && args.size() != func.normal_prop.arg_num))
	    throw_error(Error::TYPE_VIOLATION);

	  // 引数をスタックの所定の位置に設定
	  if (stack.size() < new_ci->base + func.normal_prop.val_num + STACK_BUFFER_SIZE)
	    stack.resize(new_ci->base + func.normal_prop.val_num + STACK_BUFFER_SIZE);
	  for (int i = 0; i < func.normal_prop.arg_num; i ++)
	    stack.at(new_ci->base + i) = args.at(i);

	  // 可変長引数分がある場合、callinfoに退避
	  new_ci->var_arg.resize(args.size() - func.normal_prop.arg_num);
	  for (int i = 0, num = args.size() - func.normal_prop.arg_num; i < num; i ++)
	    new_ci->var_arg.at(i) = args.at(func.normal_prop.arg_num + i);

	  if (is_tailcall) {
	    // 末尾再帰の場合、既存のciを上書き
	    // 次の命令はRETURNのはず
	    assert(Instruction::get_opcode(insts.at(ci.pc)) == Opcode::RETURN);
	    ci = *new_ci;
	  } else {
	    ci.pc ++;
	    // 末尾再帰でない場合、callinfosを追加
	    thread.callinfos.push_back(std::unique_ptr<CallInfo>(new_ci.release()));
	  }
	  goto re_entry;

	} else if (func.type == FuncType::FC_INTRINSIC) {
	  // VM組み込み関数の呼び出し
	  assert(func.intrinsic != nullptr);
	  stack.at(new_ci->pos_ret) = func.intrinsic(*this, thread, args);
	  // 末尾再帰の場合、既存のciは削除
	  if (is_tailcall) {
	    ci.pc ++;
	    // 次の命令はRETURNのはず
	    assert(Instruction::get_opcode(insts.at(ci.pc)) == Opcode::RETURN);
	    thread.callinfos.pop_back();
	    goto re_entry;
	  }

	} else { // func.type == FuncType::EXTERNAL
	  // 関数のロードを行っていない場合、ロードする
	  if (func.external == nullptr) {
	    func.external = get_external_func(func.name);
	  }

	  // 関数の呼び出し
	  stack.at(new_ci->pos_ret) = call_external(func.external,
						    get_operand_A(ci.base, ret_code, stack, k),
						    arg_types, args);

	  // 末尾再帰の場合、既存のciは削除
	  if (is_tailcall) {
	    ci.pc ++;
	    // 次の命令はRETURNのはず
	    assert(Instruction::get_opcode(insts.at(ci.pc)) == Opcode::RETURN);
	    thread.callinfos.pop_back();
	    goto re_entry;
	  }
	}
	
      } break;

      case Opcode::RETURN: {
	if (Instruction::get_code_A(code) == 0) {
	  // 戻り値がないので何もしない

	} else {
	  // 戻り値を設定する
	  stack.at(ci.pos_ret) = get_operand_B(ci.base, code, stack, k);
	}
	// callinfoを除去してpcを変更せずにre_entryに移動
	thread.callinfos.pop_back();
	goto re_entry;
      } break;

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

      case Opcode::ADD: {
	Value& dst = get_operand_A(ci.base, code, stack);
	const Value& type = get_operand_B(ci.base, code, stack, k);
	code = insts.at(ci.pc + 1);
	const Value& val_a = get_operand_A(ci.base, code, stack, k);
	const Value& val_b = get_operand_B(ci.base, code, stack, k);
	resolve_value_cache(&val_a);
	resolve_value_cache(&val_b);

	switch(type.get_address()) {
	case BasicType::TY_I8: {
	  dst = create_value_by_primitive(*static_cast<uint8_t*>(val_a.cache) +
					  *static_cast<uint8_t*>(val_b.cache));
	} break;
	case BasicType::TY_I16: {
	  dst = create_value_by_primitive(*static_cast<uint16_t*>(val_a.cache) +
					  *static_cast<uint16_t*>(val_b.cache));
	} break;
	case BasicType::TY_I32: {
	  dst = create_value_by_primitive(*static_cast<uint32_t*>(val_a.cache) +
					  *static_cast<uint32_t*>(val_b.cache));
	} break;
	case BasicType::TY_I64: {
	  dst = create_value_by_primitive(*static_cast<uint64_t*>(val_a.cache) +
					  *static_cast<uint64_t*>(val_b.cache));
	} break;
	case BasicType::TY_F32: {
	  dst = create_value_by_primitive(*static_cast<float*>(val_a.cache) +
					  *static_cast<float*>(val_b.cache));
	} break;
	case BasicType::TY_F64: {
	  dst = create_value_by_primitive(*static_cast<double*>(val_a.cache) +
					  *static_cast<double*>(val_b.cache));
	} break;
	default: {
	} break;
	}
	ci.pc ++;
      } break;

      case Opcode::UREM: {
	Value& dst = get_operand_A(ci.base, code, stack);
	const Value& type = get_operand_B(ci.base, code, stack, k);
	code = insts.at(ci.pc + 1);
	const Value& val_a = get_operand_A(ci.base, code, stack, k);
	const Value& val_b = get_operand_B(ci.base, code, stack, k);
	resolve_value_cache(&val_a);
	resolve_value_cache(&val_b);

	switch(type.get_address()) {
	case BasicType::TY_I8: {
	  dst = create_value_by_primitive(*static_cast<uint8_t*>(val_a.cache) %
					  *static_cast<uint8_t*>(val_b.cache));
	} break;
	case BasicType::TY_I16: {
	  dst = create_value_by_primitive(*static_cast<uint16_t*>(val_a.cache) %
					  *static_cast<uint16_t*>(val_b.cache));
	} break;
	case BasicType::TY_I32: {
	  dst = create_value_by_primitive(*static_cast<uint32_t*>(val_a.cache) %
					  *static_cast<uint32_t*>(val_b.cache));
	} break;
	case BasicType::TY_I64: {
	  dst = create_value_by_primitive(*static_cast<uint64_t*>(val_a.cache) %
					  *static_cast<uint64_t*>(val_b.cache));
	} break;
	default: {
	} break;
	}
	ci.pc ++;
      } break;

      case Opcode::SREM: {
	Value& dst = get_operand_A(ci.base, code, stack);
	const Value& type = get_operand_B(ci.base, code, stack, k);
	code = insts.at(ci.pc + 1);
	const Value& val_a = get_operand_A(ci.base, code, stack, k);
	const Value& val_b = get_operand_B(ci.base, code, stack, k);
	resolve_value_cache(&val_a);
	resolve_value_cache(&val_b);

	switch(type.get_address()) {
	case BasicType::TY_I8: {
	  dst = create_value_by_primitive(*static_cast<int8_t*>(val_a.cache) %
					  *static_cast<int8_t*>(val_b.cache));
	} break;
	case BasicType::TY_I16: {
	  dst = create_value_by_primitive(*static_cast<int16_t*>(val_a.cache) %
					  *static_cast<int16_t*>(val_b.cache));
	} break;
	case BasicType::TY_I32: {
	  dst = create_value_by_primitive(*static_cast<int32_t*>(val_a.cache) %
					  *static_cast<int32_t*>(val_b.cache));
	} break;
	case BasicType::TY_I64: {
	  dst = create_value_by_primitive(*static_cast<int64_t*>(val_a.cache) %
					  *static_cast<int64_t*>(val_b.cache));
	} break;
	default: {
	} break;
	}
	ci.pc ++;
      } break;

      case Opcode::LOAD: {
	Value& dst = get_operand_A(ci.base, code, stack);
	const Value& src = get_operand_B(ci.base, code, stack, k);
	resolve_value_cache(&src);
	// srcに格納されている値をアドレスとして設定する。
	dst.type = Value::Type::POINTER_DATA;
	dst.set_address(*reinterpret_cast<vaddr_t*>(src.cache));
      } break;

      case Opcode::STORE: {
	const Value& src = get_operand_A(ci.base, code, stack);
	Value& dst = get_operand_B(ci.base, code, stack);
	resolve_value_cache(&src);
	assert(false);
      } break;

      case Opcode::GET_EP: {
	Value& dst = get_operand_A(ci.base, code, stack);
	const Value& src = get_operand_B(ci.base, code, stack, k);
	assert(!src.is_immediate());	// srcはポインタのはず
	code = insts.at(ci.pc + 1);
	vaddr_t type_addr = get_operand_A(ci.base, code, stack, k).get_address();
	unsigned int idx_size = Instruction::get_code_B(code);

	longest_int_t diff = 0;
	longest_int_t idx;
	int next;

	for (next = 1;
	     Instruction::get_opcode(code = insts.at(ci.pc + next + 1)) == Opcode::EXTRAARG2;
	     next ++) {
	  if (next == 1) {
	    idx = get_value_as_int(get_operand_A(ci.base, code, stack, k), idx_size);
	    TypeStore* type = &vmemory.get_type(type_addr);
	    diff += type->size * idx;

	  } else {
	    idx = get_value_as_int(get_operand_A(ci.base, code, stack, k), idx_size);
	    TypeStore* type = &vmemory.get_type(type_addr);
	    if (type->is_array) {
	      // 配列要素数より多い要素にアクセスした場合エラー
	      if (idx >= type->num) throw_error(Error::SEGMENT_FAULT);
	      type = &vmemory.get_type(type_addr = type->element);
	      diff += type->size * idx;
	      
	    } else {
	      // 構造要素数より多い要素にアクセスした場合エラー
	      if (idx >= type->member.size()) throw_error(Error::SEGMENT_FAULT);
	      for (int m_idx = 0; m_idx < idx; m_idx ++) {
		TypeStore* m_type = &vmemory.get_type(type_addr = type->member.at(m_idx));
		diff += m_type->size;
	      }
	    }
	  }
	  // OperandBがMAX_OPERAND_ABの場合、パディングなので処理をスキップ
	  if (Instruction::get_code_B(code) == MAX_OPERAND_AB) continue; 
	  idx = get_value_as_int(get_operand_B(ci.base, code, stack, k), idx_size);
	  TypeStore* type = &vmemory.get_type(type_addr);
	  if (type->is_array) {
	    // 配列要素数より多い要素にアクセスした場合エラー
	    if (idx >= type->num) throw_error(Error::SEGMENT_FAULT);
	    type = &vmemory.get_type(type_addr = type->element);
	    diff += type->size * idx;

	  } else {
	    // 構造要素数より多い要素にアクセスした場合エラー
	    if (idx >= type->member.size()) throw_error(Error::SEGMENT_FAULT);
	    for (int m_idx = 0; m_idx < idx; m_idx ++) {
	      TypeStore* m_type = &vmemory.get_type(type_addr = type->member.at(m_idx));
	      diff += m_type->size;
	    }
	  }
	}
	dst = src;
	dst.inner_value.address.lower += diff;
	dst.cache = nullptr;

	ci.pc += next;
      } break;

      case Opcode::SEXT: {
	Value& dst = get_operand_A(ci.base, code, stack);
	const Value& dst_type = get_operand_B(ci.base, code, stack, k);
	code = insts.at(ci.pc + 1);
	const Value& src = get_operand_A(ci.base, code, stack, k);
	const Value& src_type = get_operand_B(ci.base, code, stack, k);
	resolve_value_cache(&dst);
	resolve_value_cache(&dst_type);
	resolve_value_cache(&src);
	resolve_value_cache(&src_type);

	size_t src_size = reinterpret_cast<TypeStore*>(src_type.cache)->size;
	size_t dst_size = reinterpret_cast<TypeStore*>(dst_type.cache)->size;
	longest_int_t work = get_value_as_int(src, src_size);
	memcpy(dst.cache, &work, dst_size);

	ci.pc ++;
      } break;

      default:
	// EXTRAARGを含む想定外の命令
	throw_error_message(Error::INST_VIOLATION, Util::num2hex_str(insts.at(ci.pc)));
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
  print_debug("call_external\n");
  for (int i = 0; i < args.size(); i ++) {
    print_debug("param%d\n", i + 1);
    Value& v = args[i];
    if (v.is_immediate()) {
      print_debug("\tvalue:%016llx(%ld)\n",
		  v.inner_value.immediate.value.i64,
		  v.inner_value.immediate.size);
    } else {
      print_debug("\taddr:%016llx\n", v.get_address());
    }
  }

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
    fixme(Util::vaddr2str(ret_type.get_address()));
    assert(false); // TODO 他の型の対応
  } break;
  }

  // 引数の型変換 & ポインタ格納
  std::vector<ffi_type*> ffi_arg_types(args.size());
  std::vector<void*> ffi_args(args.size());

  for (int i = 0, size = args.size(); i < size; i ++) {
    resolve_value_cache(&args.at(i));

    switch(arg_types.at(i).get_address()) {
    case BasicType::TY_POINTER: {
      ffi_arg_types.at(i) = &ffi_type_pointer;
      ffi_args.at(i)      = &args.at(i).cache;
      print_debug("%p, %s\n", args.at(i).cache, args.at(i).cache);
    } break;

    case BasicType::TY_I8: {
      ffi_arg_types.at(i) = &ffi_type_uint8;
      ffi_args.at(i)      = args.at(i).cache;
    } break;

    case BasicType::TY_I16: {
      ffi_arg_types.at(i) = &ffi_type_uint16;
      ffi_args.at(i)      = args.at(i).cache;
    } break;

    case BasicType::TY_I32: {
      ffi_arg_types.at(i) = &ffi_type_uint32;
      ffi_args.at(i)      = args.at(i).cache;
    } break;

    case BasicType::TY_I64: {
      ffi_arg_types.at(i) = &ffi_type_uint64;
      ffi_args.at(i)      = args.at(i).cache;
    } break;

    default: {
      fixme(Util::vaddr2str(arg_types.at(i).get_address()));
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

// VMの終了処理を行う。
void VMachine::close() {
  // ロードした外部のライブラリを閉じる
  /*
  for (auto it = ext_libs.begin(); it != ext_libs.end(); it ++) {
    dlclose(*it);
  }
  //*/
}

// 値をコピーする。
void VMachine::copy_value(Value& dst, const Value& src, const Value& type) {
  assert(src.type == Value::NORMAL_DATA);

  // コピー先とコピー元が同じ場合何もしない。
  if (&dst == &src) return;

  // コピー
  dst = src;

  // void、ポインタ、即値以外の場合、新しいデータ領域に中身をコピーする。
  if (type.get_address() != BasicType::TY_VOID &&
      type.get_address() != BasicType::TY_POINTER &&
      !src.is_immediate()) {
    resolve_value_cache(&type);
    VMemory::AllocDataRet store =
      vmemory.copy_data(src.get_address(),
			static_cast<TypeStore*>(type.cache)->size);
    dst.inner_value.address.upper = store.addr;
    dst.inner_value.address.lower = 0;
    dst.cache                     = store.data.head.get();
  }
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
  print_debug("\tcode:(%ld)\n", prop.code.size());
  for (auto it = prop.code.begin(); it != prop.code.end(); it++) {
    print_debug("\t\t%016llx\n", *it);
  }
  print_debug("\taddress\t:%016llx\n", store.addr);
  print_debug("\tfunc\t:%p\n", &store.func);
  print_debug("\tk:(%ld)\n", prop.k.size());
  for (auto it = prop.k.begin(); it != prop.k.end(); it++) {
    if (it->is_immediate()) {
      print_debug("\t\tv:%016llx(%ld)\n",
		  it->inner_value.immediate.value.i64,
		  it->inner_value.immediate.size);
    } else {
      print_debug("\t\ta:%016llx\n", it->get_address());
    }
  }

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

// NULLポインタを作成する。
Value VMachine::create_null() {
  Value val;
  val.type = Value::POINTER_DATA;
  val.inner_value.address.upper = VADDR_NULL;
  val.inner_value.address.lower = 0;
  val.cache = nullptr;

  print_debug("create_pointer\n");

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
  print_debug("\taddr\t:%016llx\n", val.inner_value.address.upper);

  return val;
}

// 配列型情報を作成する。
Value VMachine::create_type(vaddr_t element, unsigned int num) {
  // サイズ、アライメントを計算
  std::vector<vaddr_t> member;
  member.push_back(element);
  std::pair<size_t, unsigned int> info = calc_type_size(member);

  // 領域を確保
  VMemory::AllocTypeRet store = vmemory.alloc_type(info.first * num, info.second, element, num);
  TypeStore& type = store.type;

  // 型のアドレスを持つValueを作成
  Value val;
  val.type = Value::TYPE;
  val.inner_value.address.upper = store.addr;
  val.inner_value.address.lower = 0;
  val.cache = &type;

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
    val.cache = store.data.head.get();
  }

  // データ領域にデータをコピー
  if (data != nullptr) {
    std::memcpy(val.cache, data, size);
  }

  print_debug("create_array\n");
  print_debug("\tper_size\t:%d\n", per_size);
  print_debug("\tlength\t:%d\n", length);
  if (!val.is_immediate()) {
    print_debug("\taddress\t:%s\n", Util::vaddr2str(val.inner_value.address.upper).c_str());
  }
  print_debug("\tcache:\t%p\n", val.cache);
  if (data == nullptr) {
    print_debug("\tdata:nullptr\n");
  } else {
    print_debug("\tdata:\n");
    for (int i = 0; i < length; i ++) {
      print_debug("\t\t%02x(%c)\n",
		  static_cast<const char*>(data)[i],
		  (' ' <= static_cast<const char*>(data)[i] &&
		   static_cast<const char*>(data)[i] <= '~' ?
		   static_cast<const char*>(data)[i] : ' '));
    }
  }

  return val;
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
void VMachine::deploy_function_intrinsic(const std::string& name, vaddr_t addr) {
  auto ifunc = intrinsic_funcs.find(name);

  // VM組み込み関数に指定の名前の関数がない。
  if (ifunc == intrinsic_funcs.end()) {
    throw_error_message(Error::EXT_LIBRARY, name);
  }

  // 関数領域を確保
  vmemory.alloc_func(symbols.get(name), ifunc->second, addr);
}

// 通常の関数(VMで解釈、実行する)を指定アドレスに展開する。
void VMachine::deploy_function_normal(const std::string& name,
				      const FuncStore::NormalProp& prop,
				      vaddr_t addr) {
  // 関数領域を確保
  vmemory.alloc_func(symbols.get(name), prop, addr);
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
  init_thread->top = 2; // 戻り値所、関数、ベース〜と格納するので2
  CallInfo* init_callinfo;
  init_thread->callinfos.push_back(std::unique_ptr<CallInfo>(init_callinfo = new CallInfo()));

  // 関数の呼び出し情報を設定
  init_callinfo->pos_ret = 0;
  init_callinfo->base    = 2; // 戻り値所、関数、ベース〜と格納するので2
  init_callinfo->pc      = 0;

  // main関数の取得
  auto it_main_func = globals.find(&symbols.get("main"));
  if (it_main_func == globals.end())
    throw_error_message(Error::SYM_NOT_FOUND, "main");
  FuncStore& main_func = vmemory.get_func(it_main_func->second.inner_value.address.upper);
  
  // 関数情報を元にstackを拡張
  init_thread->stack.resize(init_thread->top + main_func.normal_prop.val_num + STACK_BUFFER_SIZE);
  init_thread->stack.at(1) = it_main_func->second;
  
  // プログラムのコマンドライン引数を設定
  if (main_func.normal_prop.arg_num == 2) {
    // ポインタのポインタ
    std::unique_ptr<vaddr_t[]> param2(new vaddr_t[args.size()]);
    // 引数1要素毎に作った値のアドレスを格納する
    for (unsigned int i = 0, arg_size = args.size(); i < arg_size; i ++) {
      Value value = create_value_by_array(sizeof(char),
					  args.at(i).length() + 1,
					  args.at(i).c_str());
      place_virtual_value(&value);
      param2[i] = value.get_address();
    }
    
    init_thread->stack.at(2) = create_value_by_primitive(static_cast<vm_int_t>(args.size()));
    init_thread->stack.at(3) = create_value_by_array(sizeof(vaddr_t), args.size(), param2.get());
    init_thread->top += 2;

  } else if (main_func.normal_prop.arg_num != 0) {
    // int main()でもint main(int, char**)でもないようだ
    throw_error(Error::SPEC_VIOLATION);
  }
  // int main()の場合は引数を設定しない

  status = ACTIVE;
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
  // BasicTypeのメンバをsize0, alignment0のTY_VOIDにしておくことで、getelementptrの
  // 計算で余計に計算しても問題が起きない
  std::vector<vaddr_t> basic_type_dummy;
  basic_type_dummy.push_back(BasicType::TY_VOID);

#define M_ALLOC_BASIC_TYPE(s, a, t)					\
  vmemory.alloc_type((s), (a), basic_type_dummy, (t));			\
  intrinsic_addrs.insert(t)

  // 基本型を登録
  M_ALLOC_BASIC_TYPE(0,  0,  BasicType::TY_VOID);
  M_ALLOC_BASIC_TYPE(8,  8,  BasicType::TY_POINTER);
  M_ALLOC_BASIC_TYPE(8,  8,  BasicType::TY_FUNCTION);
  M_ALLOC_BASIC_TYPE(1,  1,  BasicType::TY_I8);
  M_ALLOC_BASIC_TYPE(2,  2,  BasicType::TY_I16);
  M_ALLOC_BASIC_TYPE(4,  4,  BasicType::TY_I32);
  M_ALLOC_BASIC_TYPE(8,  8,  BasicType::TY_I64);
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

// 変数の中身をintとして取得する。
longest_int_t VMachine::get_value_as_int(const Value& src, unsigned int size) {
  /// TODO ビッグエンディアンでも動くか？
  longest_int_t int_value;
  resolve_value_cache(&src);
  // srcが負の場合先頭部分を1うめ
  if (*(reinterpret_cast<int8_t*>(src.cache) + size - 1) >= 0) {
    int_value = 0;
  } else {
    int_value = LONGEST_UINT_FILL << (size * 8);
  }
  // 数値部分をコピー
  memcpy(&int_value, src.cache, size);

  print_debug("get_value_as_int src:%016llx, size:%d, head:%d, out:%016llx\n",
	      *reinterpret_cast<uint64_t*>(src.cache), size, 
	      *(reinterpret_cast<int8_t*>(src.cache) + size - 1),
	      int_value);

  return int_value;
}

// 変数が即値であった場合に、仮想メモリに値を配置し直す。
void VMachine::place_virtual_value(Value* target) {
  // 即値でないのでスキップ
  if (!target->is_immediate()) return;

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
void VMachine::resolve_value_cache(const Value* target) {
  if (target->cache == nullptr) {
    // 領域の型にあわせてキャッシュの詰め方が変わる
    if (VMemory::addr_is_func(target->inner_value.address.upper)) {
      // 関数の場合、FuncStoreへのポインタ
      assert(target->inner_value.address.lower == 0);
      target->cache = &vmemory.get_func(target->inner_value.address.upper);

    } else if (VMemory::addr_is_type(target->inner_value.address.upper)) {
      // 型の場合、TypeStoreへのポインタ
      assert(target->inner_value.address.lower == 0);
      target->cache = &vmemory.get_type(target->inner_value.address.upper);

    } else {
      // データの場合、DataStoreの内部データへのポインタ(+lower分)
      target->cache =
	vmemory.get_data(target->inner_value.address.upper).head.get() +
	target->inner_value.address.lower;
    }
  }
}
