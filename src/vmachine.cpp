
#include <cstring>
#include <inttypes.h>
#include <memory>

#if (defined(__APPLE__) && defined(__MACH__))
#include <ffi/ffi.h>
#elif !defined( EMSCRIPTEN)
#include <ffi.h>
#endif


#ifndef EMSCRIPTEN
#include <dlfcn.h>
#else
#include <emscripten/emscripten.h>
#endif

#include <unistd.h>

#include "error.hpp"
#include "func_store.hpp"
#include "instruction.hpp"
#include "builtin_bit.hpp"
#ifdef ENABLE_GLFW3
#include "builtin_glfw3.hpp"
#endif
#include "builtin_libc.hpp"
#include "builtin_memory.hpp"
#include "builtin_overflow.hpp"
#include "builtin_posix.hpp"
#include "builtin_va_arg.hpp"
#include "builtin_warp.hpp"
#include "stackinfo.hpp"
#include "type_based.hpp"
#include "util.hpp"
#include "vmachine.hpp"

using namespace processwarp;

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
  new TypeExtended<uint8_t>(), // 11 8bit整数型
  new TypeExtended<uint16_t>(), // 12 16bit整数型
  new TypeExtended<uint32_t>(), // 13 32bit整数型
  new TypeExtended<uint64_t>(), // 14 64bit整数型
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
  new TypeExtended<int8_t>(), // 21 8bit整数型
  new TypeExtended<int16_t>(), // 22 16bit整数型
  new TypeExtended<int32_t>(), // 23 32bit整数型
  new TypeExtended<int64_t>(), // 24 64bit整数型
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
  DataStore& k;
  VMemory& vmemory;
};

inline uint8_t* get_cache(vaddr_t addr, VMemory& vmemory) {
  DataStore& store = vmemory.get_data(addr);
  return store.head.get() + VMemory::get_addr_lower(addr);
}

inline FuncStore& get_function(instruction_t code, OperandParam& param) {
  int operand = Instruction::get_operand(code);
  if ((operand & HEAD_OPERAND) != 0) {
    assert((FILL_OPERAND - operand) < param.k.size);
    // 定数の場合1の補数表現からの復元
    vaddr_t addr =
      *reinterpret_cast<vaddr_t*>(param.k.head.get() + (FILL_OPERAND - operand));
    return param.vmemory.get_func(addr);
    
  } else {
    assert(operand < static_cast<signed>(param.stack.size));
    vaddr_t addr = *reinterpret_cast<vaddr_t*>(param.stack.head.get() + operand);
    return param.vmemory.get_func(addr);
  }
}

inline OperandRet get_operand(instruction_t code, OperandParam& param) {
  int operand = Instruction::get_operand(code);
  if ((operand & HEAD_OPERAND) != 0) {
    vaddr_t position = (FILL_OPERAND - operand);
    assert(position < param.k.size);
    // 定数の場合1の補数表現からの復元
    return {param.k, param.k.addr + position, param.k.head.get() + position};
    
  } else {
    assert(operand < static_cast<signed>(param.stack.size));
    return {param.stack, param.stack.addr + operand, param.stack.head.get() + operand};
  }
}

inline TypeStore& get_type(instruction_t code, OperandParam& param) {
  int operand = Instruction::get_operand(code);
  // 型は定数領域に置かれているはず
  assert((operand & HEAD_OPERAND) != 0);

  vaddr_t addr = *reinterpret_cast<vaddr_t*>(param.k.head.get() + (FILL_OPERAND - operand));
  return param.vmemory.get_type(addr);
}

// Constructor.
VMachine::VMachine(VMachineDelegate& _delegate,
		   std::vector<void*>& _libs,
		   const std::map<std::string, std::string>& _lib_filter) :
  delegate(_delegate),
  libs(_libs),
  lib_filter(_lib_filter),
  status(SETUP) {
}

// 仮想アドレスとネイティブポインタのペアを解消する。
void VMachine::destory_native_ptr(vaddr_t addr) {
  assert(addr != VADDR_NULL);
  assert(native_ptr.find(addr) != native_ptr.end());

  native_ptr.erase(addr);
  if (addr < last_free_native_ptr) last_free_native_ptr = addr;
}

// VM命令を実行する。
void VMachine::execute(vtid_t tid, int max_clock) {
  Thread& thread = *(threads.at(tid));
 re_entry: {
    if (thread.stackinfos.size() == 1) {
      // calls_at_exitに関数が登録されている場合、順番に実行する
      if (!calls_at_exit.empty() && status != ERROR && status != FINISH) {
	vaddr_t func_addr = calls_at_exit.top();
	// 関数中でatexitを呼ばれる可能性があるので、先頭の関数を呼び出し前に除去する
	calls_at_exit.pop();
	// calls_at_exitの先頭の関数を呼び出し状態にセット
	call_setup_voidfunc(thread, func_addr);
	goto re_entry;

      } else {
	// エラーまたは正常終了に設定。
	if (status != ERROR) status = FINISH;
	return;
      }
    }
    if (status == BEFOR_WARP && thread.stackinfos.size() == thread.warp_stack_size) {
      if (thread.funcs_at_befor_warp.size() > thread.warp_call_count) {
	call_setup_voidfunc(thread, thread.funcs_at_befor_warp.at(thread.warp_call_count));
	thread.warp_call_count ++;
	goto re_entry;
	
      } else {
	status = WARP;
      }
    }
    if (status == AFTER_WARP && thread.stackinfos.size() == thread.warp_stack_size) {
      if (thread.funcs_at_befor_warp.size() > thread.warp_call_count) {
	call_setup_voidfunc(thread, thread.funcs_at_befor_warp.at(thread.warp_call_count));
	thread.warp_call_count ++;
	goto re_entry;
	
      } else {
	status = ACTIVE;
      }
    }

    StackInfo& stackinfo = *(thread.stackinfos.back().get());
    resolve_stackinfo_cache(&thread, &stackinfo);

    const FuncStore& func = *stackinfo.func_cache;
    const std::vector<instruction_t>& insts = func.normal_prop.code;
    DataStore& k = vmemory.get_data(func.normal_prop.k);
    OperandParam op_param = {*stackinfo.stack_cache, k, vmemory};

    for (; (status == ACTIVE || status == EXITING || status == WAIT_WARP ||
	    status == BEFOR_WARP || status == AFTER_WARP) &&
	   max_clock > 0; max_clock --) {
      instruction_t code = insts.at(stackinfo.pc);
      print_debug("pc:%d, k:%ld, insts:%ld, code:%08x %s\n",
		  stackinfo.pc, k.size / sizeof(vaddr_t),
		  insts.size(), code, Util::code2str(code).c_str());

      // call命令の判定(call命令の場合falseに変える)
      bool is_tailcall = true;

      switch (static_cast<uint8_t>(Instruction::get_opcode(code))) {

#define M_BINARY_OPERATOR(name, op)				\
	case Opcode::name: {					\
	  OperandRet operand = get_operand(code, op_param);	\
	  stackinfo.type_cache1->op(stackinfo.output_cache,	\
				    stackinfo.value_cache,	\
				    operand.cache);		\
	} break;

      case Opcode::NOP: {
	// 何もしない命令
      } break;
	
      case Opcode::CALL:
	is_tailcall = false;
	
      case Opcode::TAILCALL: {
	std::unique_ptr<StackInfo> new_stackinfo;
	FuncStore& new_func = get_function(code, op_param);

	assert(!is_tailcall); // TODO 動きを確認する。

	int normal_pc = Instruction::get_operand(insts.at(stackinfo.pc + 1));
	int unwind_pc = Instruction::get_operand(insts.at(stackinfo.pc + 2));
	// CALL命令の次の命令の場所を取得する
	int next_pc = 1;
	while(stackinfo.pc + next_pc < insts.size() &&
	      Instruction::get_opcode(insts.at(stackinfo.pc + next_pc)) == Opcode::EXTRA)
	  next_pc ++;
	
	// スタックのサイズの有無により作りを変える
	new_stackinfo.reset
	  (new StackInfo(new_func.addr,
			 // tailcallの場合、戻り値の格納先を現行のものから引き継ぐ
			 is_tailcall ? stackinfo.ret_addr : stackinfo.output,
			 (normal_pc != FILL_OPERAND ? normal_pc : stackinfo.pc + next_pc),
			 (unwind_pc != FILL_OPERAND ? unwind_pc : stackinfo.pc + next_pc),
			 (new_func.normal_prop.stack_size != 0 ?
			  vmemory.alloc_data(new_func.normal_prop.stack_size, false).addr :
			  VADDR_NON)));
	resolve_stackinfo_cache(&thread, new_stackinfo.get());

	// 引数を集める
	unsigned int args = 0;
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
	      args < new_func.arg_num) {
	    // 通常の引数はスタックの先頭にコピー
	    memcpy(new_stackinfo->stack_cache->head.get() + written_size, value.cache, type.size);
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
	print_debug("call %s\n", new_func.name.str().c_str());
	if (new_func.type == FuncType::FC_NORMAL) {
	  // 可変長引数でない場合、引数の数をチェック
	  if (args < new_func.arg_num ||
	      (!new_func.is_var_arg && args != new_func.arg_num))
	    throw_error(Error::TYPE_VIOLATION);

	  // 可変長引数分がある場合、別領域を作成
	  if (work.size() != 0) {
	    new_stackinfo->var_arg = v_malloc(work.size(), false);
	    new_stackinfo->alloca_addrs.push_back(new_stackinfo->var_arg);
	    v_memcpy(new_stackinfo->var_arg, work.data(), work.size());
	  } else {
	    new_stackinfo->var_arg = VADDR_NON;
	  }
	  
	  if (is_tailcall) {
	    // 末尾再帰の場合、既存のstackinfoを削除
	    // 次の命令はRETURNのはず
	    assert(Instruction::get_opcode(insts.at(stackinfo.pc + 2)) == Opcode::RETURN);
	    thread.stackinfos.pop_back();
	  } else {
	    stackinfo.pc ++;
	    // TODO assert(false);
	    // 末尾再帰でない場合、callinfosを追加
	  }
	  thread.stackinfos.push_back(std::unique_ptr<StackInfo>(new_stackinfo.release()));
	  goto re_entry;
	  
	} else if (new_func.type == FuncType::FC_BUILTIN) {
	  // VM組み込み関数の呼び出し
	  assert(new_func.builtin != nullptr);
	  if (new_func.builtin(*this, thread, new_func.builtin_param, stackinfo.output, work)) {
	    goto re_entry;
	  }

	} else { // func.type == FuncType::EXTERNAL
	  if (new_func.external == nullptr) {
	    new_func.external = get_external_func(new_func.name);
	  }

	  // 関数の呼び出し
	  call_external(new_func, stackinfo.output_cache, work);
	}
	
      } break;

      case Opcode::RETURN: {
	StackInfo& upperinfo = *(thread.stackinfos.at(thread.stackinfos.size() - 2).get());
	resolve_stackinfo_cache(&thread, &upperinfo);

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
	  stackinfo.type_cache1 = &thread.type_complex;
	  thread.type_complex.type_store = &store;
	}
	stackinfo.type_cache2 = &store;
	print_debug("set_type = %016" PRIx64 "\n", stackinfo.type);
      } break;

      case Opcode::SET_OUTPUT: {
	OperandRet operand = get_operand(code, op_param);
	stackinfo.output       = operand.addr;
	stackinfo.output_cache = operand.cache;
	print_debug("output = %016" PRIx64 "(%p)\n", stackinfo.output, stackinfo.output_cache);
      } break;

      case Opcode::SET_VALUE: {
	OperandRet operand = get_operand(code, op_param);
	stackinfo.value       = operand.addr;
	stackinfo.value_cache = operand.cache;
	print_debug("value = %016" PRIx64 "(%p)\n", stackinfo.value, stackinfo.value_cache);
      } break;

	M_BINARY_OPERATOR(ADD, op_add); // 加算
	M_BINARY_OPERATOR(SUB, op_sub); // 減算
	M_BINARY_OPERATOR(MUL, op_mul); // 乗算
	M_BINARY_OPERATOR(DIV, op_div); // 除算
	M_BINARY_OPERATOR(REM, op_rem); // 剰余
	M_BINARY_OPERATOR(SHL, op_shl); // 左シフト
	M_BINARY_OPERATOR(SHR, op_shr); // 右シフト
	M_BINARY_OPERATOR(AND, op_and); // and
	M_BINARY_OPERATOR(OR,  op_or);  // or
	M_BINARY_OPERATOR(XOR, op_xor); // xor

      case SET_OV_PTR: {
	OperandRet operand = get_operand(code, op_param);
	stackinfo.value        = *reinterpret_cast<vaddr_t*>(operand.cache);
	stackinfo.value_cache  = get_cache(stackinfo.value, vmemory);
	stackinfo.type_cache1->copy(stackinfo.output_cache, stackinfo.value_cache);
	stackinfo.output       = stackinfo.value;
	stackinfo.output_cache = stackinfo.value_cache;
	print_debug("output = %016" PRIx64 "\n", stackinfo.output);
	print_debug("value = %016" PRIx64 "\n", stackinfo.value);
      } break;

      case Opcode::SET: {
	OperandRet operand = get_operand(code, op_param);
	memcpy(stackinfo.output_cache, operand.cache, stackinfo.type_cache2->size);
      } break;

      case Opcode::SET_PTR: {
	OperandRet operand = get_operand(code, op_param);
	stackinfo.address = *reinterpret_cast<vaddr_t*>(operand.cache);
	stackinfo.address_cache = get_cache(stackinfo.address, vmemory);
	print_debug("address = %016" PRIx64 "(%p)\n", stackinfo.address, stackinfo.address_cache);
      } break;

      case Opcode::SET_ADR: {
	OperandRet operand = get_operand(code, op_param);
	stackinfo.address = operand.addr;
	stackinfo.address_cache = operand.cache;
	print_debug("address = %016" PRIx64 "(%p)\n", stackinfo.address, stackinfo.address_cache);
      } break;

      case Opcode::SET_ALIGN: {
	int operand = Instruction::get_operand_value(code);
	stackinfo.alignment = operand;
      } break;

      case Opcode::ADD_ADR: {
	int operand = Instruction::get_operand_value(code);
	stackinfo.address += operand;
	stackinfo.address_cache += operand;
	print_debug("+%d address = %016" PRIx64 "\n", operand, stackinfo.address);
      } break;

      case Opcode::MUL_ADR: {
	int operand = Instruction::get_operand_value(code);
	const vm_int_t diff = operand * stackinfo.type_cache1->get(stackinfo.value_cache);
	stackinfo.address += diff;
	stackinfo.address_cache += diff;
	print_debug("+%d * %" PRIu64 " address = %16" PRIx64 "\n",
		    operand, stackinfo.type_cache1->get(stackinfo.value_cache), stackinfo.address);
      } break;

      case Opcode::GET_ADR: {
	OperandRet operand = get_operand(code, op_param);
	*reinterpret_cast<vaddr_t*>(operand.cache) = stackinfo.address;
	print_debug("*%016" PRIx64 " = %016" PRIx64 "\n", operand.addr, stackinfo.address);
      } break;

      case Opcode::LOAD: {
	OperandRet operand = get_operand(code, op_param);
	stackinfo.type_cache1->copy(operand.cache, stackinfo.address_cache);
	print_debug("*%016" PRIx64 " = *%016" PRIx64 "(size = %ld)\n",
		    operand.addr, stackinfo.address, stackinfo.type_cache2->size);
      } break;

      case Opcode::STORE: {
	OperandRet operand = get_operand(code, op_param);
	print_debug("store %016" PRIx64 "\n", stackinfo.address);
	stackinfo.type_cache1->copy(stackinfo.address_cache, operand.cache);
      } break;

      case Opcode::CMPXCHG: {
	OperandRet operand = get_operand(code, op_param);
	int is_eq = 0;
	stackinfo.type_cache1->op_equal(reinterpret_cast<uint8_t*>(&is_eq),
					stackinfo.address_cache, stackinfo.value_cache);
	if (is_eq) {
	  // *a == vを満たす場合、値を書き換え＆書き換え成功フラグを設定
	  stackinfo.type_cache1->copy(stackinfo.output_cache, stackinfo.address_cache);
	  *(stackinfo.output_cache + stackinfo.type_cache2->size) = 1;
	  stackinfo.type_cache1->copy(stackinfo.address_cache, operand.cache);
	} else {
	  // *a != v出会った場合、書き換え成功フラグをリセット
	  stackinfo.type_cache1->copy(stackinfo.output_cache, stackinfo.address_cache);
	  *(stackinfo.output_cache + stackinfo.type_cache2->size) = 0;
	}
      } break;

      case Opcode::ALLOCA: {
	OperandRet operand = get_operand(code, op_param);
	// サイズを計算
	size_t size = *reinterpret_cast<uint32_t*>(operand.cache) * stackinfo.type_cache2->size;
	// 領域を確保
	DataStore& data = vmemory.alloc_data(size, false);
	// 確保領域のアドレスを設定
	*reinterpret_cast<vaddr_t*>(stackinfo.output_cache) = data.addr;
	// allocaで確保した領域はスタック終了時に開放できるように記録しておく
	stackinfo.alloca_addrs.push_back(data.addr);
	print_debug("alloca *%016" PRIx64 " = %016" PRIx64 "(%ld byte)\n",
		    stackinfo.output, data.addr, data.size);
      } break;

      case Opcode::TEST: {
	OperandRet operand = get_operand(code, op_param);
	instruction_t code2 = insts.at(stackinfo.pc + 1);
	// operandの指し先がtrueかどうか判定。
	if (*operand.cache) {
	  stackinfo.phi0 = stackinfo.phi1;
	  stackinfo.phi1 = stackinfo.pc = Instruction::get_operand(code2);
	  print_debug("pc = %d\n", stackinfo.pc);
	  continue;

	} else {
	  stackinfo.pc ++;
	}
      } break;

      case Opcode::TEST_EQ: {
	// vector未対応な点に注意
	OperandRet operand = get_operand(code, op_param);
	instruction_t code2 = insts.at(stackinfo.pc + 1);
	// 値を比較
	uint8_t res;
	stackinfo.type_cache1->op_equal(&res, stackinfo.value_cache, operand.cache);
	if (res) {
	  stackinfo.phi0 = stackinfo.phi1;
	  stackinfo.phi1 = stackinfo.pc = Instruction::get_operand(code2);
	  print_debug("pc = %d\n", stackinfo.pc);
	  continue;

	} else {
	  stackinfo.pc ++;
	}
      } break;

      case Opcode::JUMP: {
	stackinfo.phi0 = stackinfo.phi1;
	stackinfo.phi1 = stackinfo.pc = Instruction::get_operand(code);
	print_debug("pc = %d\n", stackinfo.pc);
	continue;
      } break;

      case Opcode::INDIRECT_JUMP: {
	OperandRet operand = get_operand(code, op_param);
	stackinfo.phi0 = stackinfo.phi1;
	stackinfo.phi1 = stackinfo.pc =
	  static_cast<unsigned int>(*reinterpret_cast<vaddr_t*>(operand.cache));
	print_debug("pc = %d\n", stackinfo.pc);
	continue;
      } break;

      case Opcode::PHI: {
	instruction_t code2 = insts.at(stackinfo.pc + 1);
	int count = 0;
	while ((Instruction::get_opcode(code) == Opcode::PHI ||
		Instruction::get_opcode(code) == Opcode::EXTRA)) {
	  // PHI命令はEXTRA含め、偶数個
	  if (Instruction::get_opcode(code2) != Opcode::EXTRA) {
	    throw_error(Error::INST_VIOLATION);
	  }

	  if (stackinfo.phi0 == Instruction::get_operand(code2)) {
	    OperandRet operand = get_operand(code, op_param);
	    stackinfo.type_cache1->copy(stackinfo.output_cache, operand.cache);
	  }
	  count += 2;
	  if (insts.size() <= stackinfo.pc + count + 1) break;
	  code  = insts.at(stackinfo.pc + count);
	  code2 = insts.at(stackinfo.pc + count + 1);
	}
	stackinfo.pc += count - 1;
		      
      } break;

      case Opcode::TYPE_CAST: {
	TypeStore& type = get_type(code, op_param);
	stackinfo.type_cache1->type_cast(stackinfo.output_cache,
					 type.addr,
					 stackinfo.value_cache);
      } break;

      case Opcode::BIT_CAST: {
	TypeStore& type = get_type(code, op_param);
	stackinfo.type_cache1->bit_cast(stackinfo.output_cache,
					type.size,
					stackinfo.value_cache);
      } break;

	M_BINARY_OPERATOR(EQUAL,         op_equal);         // o = v == A
	M_BINARY_OPERATOR(NOT_EQUAL,     op_not_equal);     // o = v != A
	M_BINARY_OPERATOR(GREATER,       op_greater);       // o = v > A
	M_BINARY_OPERATOR(GREATER_EQUAL, op_greater_equal); // o = v >= A
	M_BINARY_OPERATOR(NOT_NANS,      op_not_nans);      // o = !isnan(v) && !isnan(A)

      case Opcode::OR_NANS: {
	OperandRet operand = get_operand(code, op_param);
	if (stackinfo.type_cache1->is_or_nans(stackinfo.value_cache, operand.cache)) {
	  *stackinfo.output_cache = I8_TRUE;
	  stackinfo.pc += 1; // 次の命令をスキップ
	}
      } break;

      case Opcode::SELECT: {
	OperandRet operand1 = get_operand(code, op_param);
	OperandRet operand2 = get_operand(insts.at(stackinfo.pc + 1), op_param);
	if (*stackinfo.value_cache) {
	  stackinfo.type_cache1->copy(stackinfo.output_cache, operand1.cache);
	} else {
	  stackinfo.type_cache1->copy(stackinfo.output_cache, operand2.cache);
	}
	stackinfo.pc += 1; // EXTRA分pcを進める
      } break;

      case Opcode::SHUFFLE: {
	int m = Instruction::get_operand_value(code);
	OperandRet operand_mask = get_operand(insts.at(stackinfo.pc + 1), op_param);
	OperandRet operand_v2 = get_operand(insts.at(stackinfo.pc + 2), op_param);
	TypeStore& element_store = vmemory.get_type(stackinfo.type_cache2->element);
	TypeBased* element_based = get_type_based(stackinfo.type_cache2->element);
	uint32_t len = stackinfo.type_cache2->num;
	for (int i = 0; i < m; i ++) {
	  uint32_t mask = reinterpret_cast<uint32_t*>(operand_mask.cache)[i];
	  element_based->copy(stackinfo.output_cache + i * stackinfo.type_cache2->size,
			      (mask < len ?
			       stackinfo.value_cache + element_store.size * mask :
			       operand_v2.cache + element_store.size * (mask - len)));
	}
	stackinfo.pc += 2; // EXTRA分pcを進める
      } break;

      default: {
	// EXTRAARGを含む想定外の命令
	throw_error_message(Error::INST_VIOLATION, Util::num2hex_str(insts.at(stackinfo.pc)));
      } break;

#undef M_BIN_OPERATOR
      }
      
      stackinfo.pc ++;
    }
  }
}

// 外部の関数を呼び出す。
void VMachine::call_external(const FuncStore& func,
			     uint8_t* ret_addr,
			     std::vector<uint8_t>& args) {
#ifndef EMSCRIPTEN
  // 戻り値の型変換
  ffi_type* ffi_ret_type = nullptr;
  switch(func.ret_type) {
  case BasicType::TY_VOID: ffi_ret_type = &ffi_type_void;   break;
    //case BasicType::TY_POINTER: ffi_ret_type = &ffi_type_pointer; break;
  case BasicType::TY_UI8:  ffi_ret_type = &ffi_type_uint8;  break;
  case BasicType::TY_UI16: ffi_ret_type = &ffi_type_uint16; break;
  case BasicType::TY_UI32: ffi_ret_type = &ffi_type_uint32; break;
  case BasicType::TY_UI64: ffi_ret_type = &ffi_type_uint64; break;
  case BasicType::TY_SI8:  ffi_ret_type = &ffi_type_sint8;  break;
  case BasicType::TY_SI16: ffi_ret_type = &ffi_type_sint16; break;
  case BasicType::TY_SI32: ffi_ret_type = &ffi_type_sint32; break;
  case BasicType::TY_SI64: ffi_ret_type = &ffi_type_sint64; break;
  case BasicType::TY_F32:  ffi_ret_type = &ffi_type_float;  break;
  case BasicType::TY_F64:  ffi_ret_type = &ffi_type_double; break;

  default: {
    fixme(Util::vaddr2str(func.ret_type));
    assert(false); // TODO 他の型の対応
  } break;
  }

  // 引数の型変換 & ポインタ格納
  std::vector<ffi_type*> ffi_arg_types;
  std::vector<void*> ffi_args;

  unsigned int seek = 0;
  while(seek < args.size()) {
    TypeStore& type = vmemory.get_type(*reinterpret_cast<vaddr_t*>(args.data() + seek));

    switch(type.addr) {
    case BasicType::TY_POINTER: {
      ffi_arg_types.push_back(&ffi_type_pointer);
      vaddr_t addr = *reinterpret_cast<vaddr_t*>(args.data() + seek + sizeof(vaddr_t));
      auto native = native_ptr.find(addr);
      if (native != native_ptr.end()) {
	*reinterpret_cast<void**>(args.data() + seek + sizeof(vaddr_t)) = native->second;
	
      } else {
	DataStore& pointed = vmemory.get_data(addr);
	*reinterpret_cast<void**>(args.data() + seek + sizeof(vaddr_t)) =
	  pointed.head.get() + VMemory::get_addr_lower(addr);
      }
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
      
    case BasicType::TY_SI8: {
      ffi_arg_types.push_back(&ffi_type_sint8);
      ffi_args.push_back(args.data() + seek + sizeof(vaddr_t));
    } break;

    case BasicType::TY_SI16: {
      ffi_arg_types.push_back(&ffi_type_sint16);
      ffi_args.push_back(args.data() + seek + sizeof(vaddr_t));
    } break;

    case BasicType::TY_SI32: {
      ffi_arg_types.push_back(&ffi_type_sint32);
      ffi_args.push_back(args.data() + seek + sizeof(vaddr_t));
    } break;

    case BasicType::TY_SI64: {
      ffi_arg_types.push_back(&ffi_type_sint64);
      ffi_args.push_back(args.data() + seek + sizeof(vaddr_t));
    } break;

    case BasicType::TY_F32: {
      ffi_arg_types.push_back(&ffi_type_float);
      ffi_args.push_back(args.data() + seek + sizeof(vaddr_t));
    } break;

    case BasicType::TY_F64: {
      ffi_arg_types.push_back(&ffi_type_double);
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
  
  // 戻り値格納用の領域を作成
  size_t ret_size = vmemory.get_type(func.ret_type).size;
  // sizeof(void*)の倍数領域を確保する。
  std::vector<void*> ret_buf(ret_size / sizeof(void*) +
			     (ret_size % sizeof(void*) == 0 ? 0 : 1));
  // メソッド呼び出し
  ffi_call(&cif, func.external, ret_buf.data(), ffi_args.data());
  // 戻り値格納用領域から戻り値を取り出し。
  memcpy(ret_addr, ret_buf.data(), ret_size);
  
#else // !defined(EMSCRIPTEN)
  // 戻り値格納用の領域を作成
  size_t ret_size = vmemory.get_type(func.ret_type).size;
  // sizeof(void*)の倍数領域を確保する。
  std::vector<void*> ret_buf(ret_size / sizeof(void*) +
			     (ret_size % sizeof(void*) == 0 ? 0 : 1));
  
  // EMSCRIPTENのJavaScriptを合成する。
  std::stringstream asm_code;
  std::stringstream asm_param;
  std::vector<uint32_t> vararg_buf;
  if (func.ret_type != BasicType::TY_VOID) {
    asm_code << "setValue(" << static_cast<void*>(ret_buf.data()) << ","
	     << "ccall('" << func.name.str() << "', 'number', [";
    
  } else {
    asm_code << "ccall('" << func.name.str() << "', 'v', [";
  }
  
  unsigned int seek  = 0;
  unsigned int count = 0;
  while(seek < args.size() && count < func.arg_num) {
    
    if (seek != 0) {
      asm_code  << ",";
      asm_param << ",";
    }
    asm_code << "'number'";
    
    TypeStore& type = vmemory.get_type(*reinterpret_cast<vaddr_t*>(args.data() + seek));
    switch(type.addr) {
    case BasicType::TY_POINTER: {
      vaddr_t addr = *reinterpret_cast<vaddr_t*>(args.data() + seek + sizeof(vaddr_t));
      auto native = native_ptr.find(addr);
      if (native != native_ptr.end()) {
	asm_param << static_cast<void*>(native->second);
	
      } else {
	DataStore& pointed = vmemory.get_data(addr);
	asm_param << static_cast<void*>(pointed.head.get() + VMemory::get_addr_lower(addr));
      }
    } break;

    case BasicType::TY_UI8:
    case BasicType::TY_SI8: {
      asm_param << "getValue(" << static_cast<void*>(args.data() + seek + sizeof(vaddr_t)) << ",'i8')";
    } break;

    case BasicType::TY_UI16:
    case BasicType::TY_SI16: {
      asm_param << "getValue(" << static_cast<void*>(args.data() + seek + sizeof(vaddr_t)) << ",'i16')";
    } break;

    case BasicType::TY_UI32:
    case BasicType::TY_SI32: {
      asm_param << "getValue(" << static_cast<void*>(args.data() + seek + sizeof(vaddr_t)) << ",'i32')";
    } break;

    case BasicType::TY_UI64:
    case BasicType::TY_SI64: {
      asm_param << "getValue(" << static_cast<void*>(args.data() + seek + sizeof(vaddr_t)) << ",'i64')";
    } break;

    case BasicType::TY_F32: {
      asm_param << "getValue(" << static_cast<void*>(args.data() + seek + sizeof(vaddr_t)) << ",'float')";
    } break;

    case BasicType::TY_F64: {
      asm_param << "getValue(" << static_cast<void*>(args.data() + seek + sizeof(vaddr_t)) << ",'double')";
    } break;
    };

    seek  += sizeof(vaddr_t) + type.size;
    count += 1;
  }
  if (!func.is_var_arg) {
    if (seek != args.size()) {
      assert(false);
    }
    
  } else {
    while(seek < args.size()) {
      TypeStore& type = vmemory.get_type(*reinterpret_cast<vaddr_t*>(args.data() + seek));
      switch(type.addr) {
      case BasicType::TY_POINTER: {
	vaddr_t addr = *reinterpret_cast<vaddr_t*>(args.data() + seek + sizeof(vaddr_t));
	auto native = native_ptr.find(addr);
	void* raw_ptr;
	if (native != native_ptr.end()) {
	  raw_ptr = static_cast<void*>(native->second);
	
	} else {
	  DataStore& pointed = vmemory.get_data(addr);
	  raw_ptr = static_cast<void*>(pointed.head.get() + VMemory::get_addr_lower(addr));
	}
	vararg_buf.resize(vararg_buf.size() + 1);
	memcpy(&vararg_buf.back(), &raw_ptr, sizeof(void*));
      } break;

      case BasicType::TY_UI8:
      case BasicType::TY_SI8: {
	int32_t raw_val = static_cast<int32_t>(*reinterpret_cast<int8_t*>(args.data() + seek + sizeof(vaddr_t)));
	vararg_buf.resize(vararg_buf.size() + 1);
	memcpy(&vararg_buf.back(), &raw_val, sizeof(raw_val));
      } break;
	
      case BasicType::TY_UI16:
      case BasicType::TY_SI16: {
	int32_t raw_val = static_cast<int32_t>(*reinterpret_cast<int16_t*>(args.data() + seek + sizeof(vaddr_t)));
	vararg_buf.resize(vararg_buf.size() + 1);
	memcpy(&vararg_buf.back(), &raw_val, sizeof(raw_val));
      } break;
	
      case BasicType::TY_UI32:
      case BasicType::TY_SI32: {
	int32_t raw_val = *reinterpret_cast<int32_t*>(args.data() + seek + sizeof(vaddr_t));
	vararg_buf.resize(vararg_buf.size() + 1);
	memcpy(&vararg_buf.back(), &raw_val, sizeof(raw_val));
      } break;

      case BasicType::TY_UI64:
      case BasicType::TY_SI64: {
	uint64_t raw_val = *reinterpret_cast<uint64_t*>(args.data() + seek + sizeof(vaddr_t));
	vararg_buf.resize(vararg_buf.size() + 2);
	memcpy(&vararg_buf.back(), &raw_val, sizeof(raw_val));
      } break;

      case BasicType::TY_F32: {
	double raw_val = static_cast<double>(*reinterpret_cast<float*>(args.data() + seek + sizeof(vaddr_t)));
	vararg_buf.resize(vararg_buf.size() + 2);
	memcpy(&vararg_buf.back(), &raw_val, sizeof(raw_val));
      } break;

      case BasicType::TY_F64: {
	double raw_val = *reinterpret_cast<double*>(args.data() + seek + sizeof(vaddr_t));
	vararg_buf.resize(vararg_buf.size() + 2);
	memcpy(&vararg_buf.back(), &raw_val, sizeof(raw_val));
      } break;
      };
      seek  += sizeof(vaddr_t) + type.size;
    }
    
    asm_code  << ",'number'";
    asm_param << "," << static_cast<void*>(vararg_buf.data());
  }
  asm_code << "],[" << asm_param.str() << "])";
  
  // 戻り値の型を合成する。
  switch(func.ret_type) {
  case BasicType::TY_VOID: asm_code << ";";   break;
    //case BasicType::TY_POINTER: ffi_ret_type = &ffi_type_pointer; break;
  case BasicType::TY_UI8:  asm_code << ", 'i8');";  break;
  case BasicType::TY_UI16: asm_code << ", 'i16');"; break;
  case BasicType::TY_UI32: asm_code << ", 'i32');"; break;
  case BasicType::TY_UI64: asm_code << ", 'i64');"; break;
  case BasicType::TY_SI8:  asm_code << ", 'i8');";  break;
  case BasicType::TY_SI16: asm_code << ", 'i16');"; break;
  case BasicType::TY_SI32: asm_code << ", 'i32');"; break;
  case BasicType::TY_SI64: asm_code << ", 'i64');"; break;
  case BasicType::TY_F32:  asm_code << ", 'float');";  break;
  case BasicType::TY_F64:  asm_code << ", 'double');"; break;
    
  default: {
    fixme(Util::vaddr2str(func.ret_type));
    assert(false); // TODO 他の型の対応
  } break;
  }

  print_debug("asm:%s\n", asm_code.str().c_str());
  // JavaScript経由でEMSCRIPTENの関数を利用する
  emscripten_run_script(asm_code.str().c_str());

  if (func.ret_type != BasicType::TY_VOID) {
    // 戻り値格納用領域から戻り値を取り出し。
    memcpy(ret_addr, ret_buf.data(), ret_size);
  }
  
#endif
}



// Setup to call function that type : void (*)(void).
void VMachine::call_setup_voidfunc(Thread& thread, vaddr_t func_addr) {
  FuncStore& func = vmemory.get_func(func_addr);
  std::unique_ptr<StackInfo> stackinfo
    (new StackInfo(func.addr,
		   VADDR_NON, // 戻り値なし
		   0, 0, // 正常、異常終了時のpc設定もなし
		   (func.normal_prop.stack_size != 0 ?
		    vmemory.alloc_data(func.normal_prop.stack_size, false).addr :
		    VADDR_NON)));  
  // 関数の型に合わせて呼び出す。
  if (func.type == FuncType::FC_NORMAL) {
    thread.stackinfos.push_back(std::unique_ptr<StackInfo>(stackinfo.release()));
    
  } else if (func.type == FuncType::FC_BUILTIN) {
    // VM組み込み関数の呼び出し
    assert(func.builtin != nullptr);
    std::vector<uint8_t> work;
    func.builtin(*this, thread, func.builtin_param, VADDR_NON, work);
    
  } else {
    if (func.external == nullptr) {
      func.external = get_external_func(func.name);
    }
    
    // 関数の呼び出し
    std::vector<uint8_t> work;
    call_external(func, nullptr, work);
  }
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
}

// ネイティブポインタに仮想アドレス対応付ける。
vaddr_t VMachine::create_native_ptr(void* ptr) {
  while(native_ptr.find(last_free_native_ptr) != native_ptr.end()) {
    last_free_native_ptr ++;
  }
  native_ptr.insert(std::make_pair(last_free_native_ptr, ptr));
  
  print_debug("create native pair:%s %p\n",
	      Util::numptr2str(&last_free_native_ptr, sizeof(vaddr_t)).c_str(), ptr);
  return (last_free_native_ptr ++);
}

// 配列型の型情報を作成する。
TypeStore& VMachine::create_type_array(vaddr_t element, unsigned int num) {
  // サイズ、アライメントを計算
  std::vector<vaddr_t> member(num, element);
  std::pair<size_t, unsigned int> info = calc_type_size(member);
  
  // 領域を確保
  return vmemory.alloc_type_array(info.first, info.second, element, num);
}

// 基本型の型情報を作成する。
TypeStore& VMachine::create_type_basic(BasicType type) {
  // 基本型はVMにより登録してあるものだけなので、ソレを戻す。
  return vmemory.get_type(type);
}

// 構造体の型情報を作成する。
TypeStore& VMachine::create_type_struct(const std::vector<vaddr_t>& member) {
  // 領域を確保
  std::pair<size_t, unsigned int> info = calc_type_size(member);
  return vmemory.alloc_type_struct(info.first, info.second, member);
}

// vectorの型情報を作成する。
TypeStore& VMachine::create_type_vector(vaddr_t element, unsigned int num) {
  std::vector<vaddr_t> member(num, element);
  std::pair<size_t, unsigned int> info = calc_type_size(member);
  // 領域を確保
  return vmemory.alloc_type_vector(info.first, info.second, element, num);
}

// ネイティブ関数を指定アドレスに展開する。
void VMachine::deploy_function(const std::string& name,
			       vaddr_t ret_type,
			       unsigned int arg_num,
			       bool is_var_arg,
			       vaddr_t addr) {
  auto ifunc = builtin_funcs.find(name);
  if (ifunc == builtin_funcs.end()) {
    // 組み込み関数に名前がなかった場合、ライブラリ関数として展開。
    vmemory.alloc_func(symbols.get(name), ret_type, arg_num, is_var_arg, addr);

  } else {
    // 組み込み関数に名前があった場合組み込み関数として展開。
    vmemory.alloc_func(symbols.get(name), ret_type,
		       arg_num, is_var_arg, ifunc->second.first, ifunc->second.second, addr);
  }
}

// 通常の関数(VMで解釈、実行する)を指定アドレスに展開する。
void VMachine::deploy_function_normal(const std::string& name,
				      vaddr_t ret_type,
				      unsigned int arg_num,
				      bool is_var_arg,
				      const FuncStore::NormalProp& prop,
				      vaddr_t addr) {
  // 関数領域を確保
  vmemory.alloc_func(symbols.get(name), ret_type, arg_num, is_var_arg, prop, addr);
}

// Change status to exit.
void VMachine::exit() {
  print_debug("Exit process");

  if (status == SETUP || status == PASSIVE) {
    status = FINISH;
    
  } else if (status == ACTIVE || status == WAIT_WARP ||
	     status == BEFOR_WARP || status == WARP ||
	     status == AFTER_WARP) {
    status = ACTIVE;
    fixme("exit thread");
    threads.at(1).get()->stackinfos.resize(1);
    
  } else if (status ==  EXITING) {
    // Do noting.
    
  } else {
    assert(false);
  }
}

// ライブラリなど、外部の関数へのポインタを取得する。
external_func_t VMachine::get_external_func(const Symbols::Symbol& name) {
  print_debug("get external func:%s\n", name.str().c_str());
  if (lib_filter.find(name.str()) == lib_filter.end()) {
    throw_error_message(Error::SYM_NOT_FOUND, name.str());
  }
#ifndef EMSCRIPTEN
  const char* sym_char = lib_filter.at(name.str()).c_str();
  // Search function that have the same name by dlsym.
  void* sym = dlsym(RTLD_DEFAULT, sym_char);
  if (sym == nullptr) {
    for (auto it : libs) {
      sym = dlsym(it, sym_char);
      if (sym != nullptr) {
	break;
      }
    }
  }
  if (sym == nullptr) {
    throw_error_message(Error::EXT_LIBRARY, dlerror());
  }

  external_func_t func = reinterpret_cast<external_func_t>(sym);

  return func;

#else
  // dlsym isn't used on EMSCRIPTEN.
  return nullptr;
#endif
}

// 仮想アドレスに相当する実アドレスを取得する。
uint8_t* VMachine::get_raw_addr(vaddr_t addr) {
  auto native = native_ptr.find(addr);
  if (native != native_ptr.end()) {
    return reinterpret_cast<uint8_t*>(native->second);
    
  } else {
    DataStore& store = vmemory.get_data(addr);
    // アクセス違反を確認する
    if (VMemory::get_addr_lower(addr) > store.size) {
      throw_error_message(Error::SEGMENT_FAULT, Util::vaddr2str(addr));
    }
    return reinterpret_cast<uint8_t*>(store.head.get() + VMemory::get_addr_lower(addr));
  }
}

// 型依存の演算インスタンスを取得する。
TypeBased* VMachine::get_type_based(vaddr_t type) {
  // 複合型に対する演算命令
  static TypeComplex type_complex;
  if (type < sizeof(TYPE_BASES) / sizeof(TYPE_BASES[0])) {
    // 存在する基本型の場合、TYPE_BASESからインスタンスを取得
    assert(TYPE_BASES[type] != nullptr);
    return TYPE_BASES[type];
    
  } else {
    // 複合型の場合、type_complexを使う。
    type_complex.type_store = &vmemory.get_type(type);
    return &type_complex;
  }
}

/**
 * 組み込み関数用に引数を取り出すメソッドを作成するマクロ。
 * @param name メソッド名
 * @param type C++での実際の型
 * @param basic_type VM内の型
 */
#define M_READ_BUILTIN_PARAM(name, type, basic_type)			\
  type VMachine::name(const std::vector<uint8_t>& src, int* seek) {	\
    /* 境界チェック */							\
    if (*seek + sizeof(vaddr_t) + sizeof(type) > src.size())		\
      throw_error(Error::SEGMENT_FAULT);				\
    /* 型チェック */							\
    if (*reinterpret_cast<const vaddr_t*>(src.data() + *seek) != BasicType::basic_type) \
      throw_error(Error::TYPE_VIOLATION);				\
    /* seekをずらす & 読み取り */					\
    int tmp_seek = *seek + sizeof(vaddr_t);				\
    *seek += sizeof(vaddr_t) + sizeof(type);				\
    return *reinterpret_cast<const vaddr_t*>(src.data() + tmp_seek);	\
  }

M_READ_BUILTIN_PARAM(read_builtin_param_ptr, vaddr_t, TY_POINTER);
M_READ_BUILTIN_PARAM(read_builtin_param_i8,  uint8_t,  TY_UI8);
M_READ_BUILTIN_PARAM(read_builtin_param_i16, uint16_t, TY_UI16);
M_READ_BUILTIN_PARAM(read_builtin_param_i32, uint32_t, TY_UI32);
M_READ_BUILTIN_PARAM(read_builtin_param_i64, uint64_t, TY_UI64);

#undef M_READ_BUILTIN_PARAM

// 組み込み関数をVMに登録する。
void VMachine::regist_builtin_func(const std::string& name,
				     builtin_func_t func, int i64) {
  BuiltinFuncParam param;
  param.i64 = i64;
  builtin_funcs.insert
    (std::make_pair(name, std::make_pair(func, param)));
}

// 組み込み関数をVMに登録する。
void VMachine::regist_builtin_func(const std::string& name,
				     builtin_func_t func, void* ptr) {
  BuiltinFuncParam param;
  param.ptr = ptr;
  builtin_funcs.insert
    (std::make_pair(name, std::make_pair(func, param)));
}

// StackInfoのキャッシュを解決し、実行前の状態にする。
void VMachine::resolve_stackinfo_cache(Thread* thread, StackInfo* stackinfo) {
  // 関数
  if (stackinfo->func != VADDR_NON) {
    stackinfo->func_cache = &vmemory.get_func(stackinfo->func);
  } else {
    stackinfo->func_cache = nullptr;
  }
  // スタック領域
  if (stackinfo->stack != VADDR_NON) {
    stackinfo->stack_cache = &vmemory.get_data(stackinfo->stack);
  } else {
    stackinfo->stack_cache = nullptr;
  }
  // 操作対象の型
  if (stackinfo->type != VADDR_NON) {
    stackinfo->type_cache2 = &vmemory.get_type(stackinfo->type);
    if (stackinfo->type < sizeof(TYPE_BASES) / sizeof(TYPE_BASES[0])) {
      stackinfo->type_cache1 = TYPE_BASES[stackinfo->type];
      if (stackinfo->type_cache1 == nullptr) {
	assert(false); // TODO 未対応の型
      }
    } else {
      stackinfo->type_cache1 = &(thread->type_complex);
      thread->type_complex.type_store = stackinfo->type_cache2;
    }
  } else {
    stackinfo->type_cache1 = nullptr;
    stackinfo->type_cache2 = nullptr;
  }
  // 格納先アドレス
  if (stackinfo->output != VADDR_NON) {
    stackinfo->output_cache = get_cache(stackinfo->output, vmemory);
  } else {
    stackinfo->output_cache = nullptr;
  }
  // 値レジスタ
  if (stackinfo->value != VADDR_NON) {
    stackinfo->value_cache = get_cache(stackinfo->value, vmemory);
  } else {
    stackinfo->value_cache = nullptr;
  }
  // アドレスレジスタ
  if (stackinfo->address != VADDR_NON) {
    stackinfo->address_cache = get_cache(stackinfo->address, vmemory);
  } else {
    stackinfo->address_cache = nullptr;
  }
}

// 関数のアドレスを予約する。
vaddr_t VMachine::reserve_func_addr() {
  return vmemory.reserve_func_addr();
}

// VMの初期設定をする。
void VMachine::run(const std::vector<std::string>& args,
		   const std::map<std::string, std::string>& envs) {
  // 最初のスレッドを作成
  Thread* init_thread;
  threads.insert(std::make_pair(delegate.assign_tid(*this),
				std::unique_ptr<Thread>(init_thread = new Thread())));
  
  // スレッドを初期化

  // main関数の取得
  auto it_main_func = globals.find(&symbols.get("main"));
  if (it_main_func == globals.end())
    throw_error_message(Error::SYM_NOT_FOUND, "main");
  FuncStore& main_func = vmemory.get_func(it_main_func->second);

  // main関数用のスタックを確保する
  DataStore* main_stack = nullptr;
  if (main_func.normal_prop.stack_size != 0) {
    main_stack = &vmemory.alloc_data(main_func.normal_prop.stack_size, false);
  }

  // main関数の内容に応じて、init_stackを作成する
  DataStore* init_stack;
  if (main_func.arg_num == 2 || main_func.arg_num == 3) {
    // main関数の戻り値と引数を格納するのに必要な領域サイズを計算
    const size_t ret_size = calc_type_size(main_func.ret_type).first;
    size_t init_stack_size = ret_size + sizeof(vaddr_t) * args.size();
    for (unsigned int i = 0, arg_size = args.size(); i < arg_size; i ++) {
      init_stack_size += args.at(i).length() + 1;
    }
    // 第3引数まである場合はenvpに必要な領域サイズも計算
    if (main_func.arg_num == 3) {
      init_stack_size += sizeof(vaddr_t) * (envs.size() + 1);
      for (auto pair : envs) {
	// +2 は'='と'\0'用
	init_stack_size += pair.first.length() + pair.second.length() + 2;
      }
    }
    // 領域を確保
    init_stack = &vmemory.alloc_data(init_stack_size, false);

    // main関数のスタックの先頭にargc, argvを格納する
    vm_int_t argc = args.size();
    vaddr_t  argv = init_stack->addr + ret_size;
    memcpy(main_stack->head.get(), &argc, sizeof(argc));
    memcpy(main_stack->head.get() + 4, &argv, sizeof(argv));

    // init_stack_dataにmain関数の戻り値、argvとして渡すポインタの配列、引数文字列、、を格納する
    vaddr_t sum = ret_size + sizeof(vaddr_t) * args.size();
    for (unsigned int i = 0, arg_size = args.size(); i < arg_size; i ++) {
      vaddr_t addr = init_stack->addr + sum;
      memcpy(init_stack->head.get() + ret_size + sizeof(vaddr_t) * i,
	     &addr, sizeof(vaddr_t));
      memcpy(init_stack->head.get() + sum,
	     args.at(i).c_str(), args.at(i).length() + 1);
      sum += args.at(i).length() + 1;
    }

    // 第3引数まである場合はenvpとして渡すポインタの配列、環境変数文字列をを格納する
    if (main_func.arg_num == 3) {
      // main関数のスタックにenvpを格納する。
      unsigned int arg_size = sum;
      vaddr_t envp = init_stack->addr + sum;
      memcpy(main_stack->head.get() + 4 + sizeof(vaddr_t), &envp, sizeof(envp));
      sum += sizeof(vaddr_t) * (envs.size() + 1);
      int i = 0;
      for (auto pair : envs) {
	vaddr_t addr = init_stack->addr + sum;
	memcpy(init_stack->head.get() + arg_size + sizeof(vaddr_t) * i, &addr, sizeof(vaddr_t));
	sum += sprintf(reinterpret_cast<char*>(init_stack->head.get() + sum),
		       "%s=%s", pair.first.c_str(), pair.second.c_str()) + 1;
	i ++;
      }
      memcpy(init_stack->head.get() + arg_size + sizeof(vaddr_t) * i, &VADDR_NULL, sizeof(vaddr_t));
    }

  } else if (main_func.arg_num != 0) {
    // int main()でもint main(int, char**)でもないようだ
    throw_error(Error::SPEC_VIOLATION);

  } else {
    // int main()の場合は引数を設定しない
    // main関数の戻り値格納先を確保する
    init_stack = &vmemory.alloc_data(calc_type_size(main_func.ret_type).first, false);
  }

  // mainのreturnを受け取るためのスタックを1段確保する
  StackInfo* init_stackinfo = new StackInfo(VADDR_NON, VADDR_NON, 0, 0, init_stack->addr);
  init_stackinfo->output = init_stack->addr;
  init_stackinfo->output_cache = init_stack->head.get();
  init_thread->stackinfos.push_back(std::unique_ptr<StackInfo>(init_stackinfo));
  
  StackInfo* main_stackinfo;
  if (main_stack != nullptr) {
    main_stackinfo = new StackInfo(main_func.addr, init_stack->addr, 0, 0, main_stack->addr);
  } else {
    main_stackinfo = new StackInfo(main_func.addr, init_stack->addr, 0, 0, VADDR_NON);
  }

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

#define M_ALLOC_BASIC_TYPE(s, a, t)		\
  vmemory.alloc_type_basic((s), (a), (t));	\
  builtin_addrs.insert(t)

  // 基本型を登録
  M_ALLOC_BASIC_TYPE(0,  0,  BasicType::TY_VOID);
  M_ALLOC_BASIC_TYPE(8,  8,  BasicType::TY_POINTER);
  M_ALLOC_BASIC_TYPE(8,  8,  BasicType::TY_FUNCTION);
  M_ALLOC_BASIC_TYPE(1,  1,  BasicType::TY_UI8);
  M_ALLOC_BASIC_TYPE(2,  2,  BasicType::TY_UI16);
  M_ALLOC_BASIC_TYPE(4,  4,  BasicType::TY_UI32);
  M_ALLOC_BASIC_TYPE(8,  8,  BasicType::TY_UI64);
  M_ALLOC_BASIC_TYPE(16, 16, BasicType::TY_UI128);
  M_ALLOC_BASIC_TYPE(32, 32, BasicType::TY_UI256);
  M_ALLOC_BASIC_TYPE(64, 64, BasicType::TY_UI512);
  M_ALLOC_BASIC_TYPE(1,  1,  BasicType::TY_SI8);
  M_ALLOC_BASIC_TYPE(2,  2,  BasicType::TY_SI16);
  M_ALLOC_BASIC_TYPE(4,  4,  BasicType::TY_SI32);
  M_ALLOC_BASIC_TYPE(8,  8,  BasicType::TY_SI64);
  M_ALLOC_BASIC_TYPE(16, 16, BasicType::TY_SI128);
  M_ALLOC_BASIC_TYPE(32, 32, BasicType::TY_SI256);
  M_ALLOC_BASIC_TYPE(64, 64, BasicType::TY_SI512);
  M_ALLOC_BASIC_TYPE(4,  4,  BasicType::TY_F32);
  M_ALLOC_BASIC_TYPE(8,  8,  BasicType::TY_F64);
  M_ALLOC_BASIC_TYPE(16, 16, BasicType::TY_F128);

#undef M_ALLOC_BASIC_TYPE

  // ネイティブポインタペアリング用アドレスを予約
  vmemory.reserve_data_addr(AddrType::AD_PTR);
  native_ptr.insert(std::make_pair(VADDR_NULL, nullptr));
  last_free_native_ptr = AddrType::AD_PTR + 1;

  // VMの組み込み関数をロード
  BuiltinBit::regist(*this);
#ifdef ENABLE_GLFW3
  BuiltinGlfw3::regist(*this);
#endif
  BuiltinLibc::regist(*this);
  BuiltinMemory::regist(*this);
  BuiltinOverflow::regist(*this);
  BuiltinPosix::regist(*this);
  BuiltinVaArg::regist(*this);
  BuiltinWarp::regist(*this);

  print_debug("finish setup.\n");
}

// Prepare to warp out.
void VMachine::setup_warpout(const vtid_t& tid) {
  Thread& thread = *threads.at(tid);

  thread.warp_stack_size = thread.stackinfos.size();
  thread.warp_call_count = 0;

  status = AFTER_WARP;
}

// Prepare to warp in.
bool VMachine::setup_warpin(const vtid_t& tid, const dev_id_t& dst) {
  // Status must be normal when warp
  if (status != ACTIVE) {
    return false;
  }

  Thread& thread = *threads.at(tid);

  //thread.warp_to = dst;
  
  if (thread.warp_parameter[PW_KEY_WARP_TIMING] == PW_VAL_ON_ANYTIME) {
    thread.warp_stack_size = thread.stackinfos.size();
    thread.warp_call_count = 0;
    status = BEFOR_WARP;

  } else { // On polling
    status = WAIT_WARP;
  }

  return true;
}

// 仮想アドレスに対応づくネイティブポインタを変更する。
void VMachine::update_native_ptr(vaddr_t addr, void* ptr) {
  assert(addr != VADDR_NULL && ptr != nullptr);
  assert(native_ptr.find(addr) != native_ptr.end());
  native_ptr[addr] = ptr;
}

// データ領域を確保する。
vaddr_t VMachine::v_malloc(size_t size, bool is_const) {
  return vmemory.alloc_data(size, is_const).addr;
}

// データ領域へ実データをコピーする。
void VMachine::v_memcpy(vaddr_t dst, void* src, size_t n) {
  DataStore& store = vmemory.get_data(dst);
  // アクセス違反をチェック
  if (VMemory::get_addr_lower(dst) + n > store.size) {
    throw_error_message(Error::SEGMENT_FAULT, Util::vaddr2str(dst));
  }
  memcpy(store.head.get(), src, n);
}

// データ領域を指定の数値で埋める。
void VMachine::v_memset(vaddr_t dst, int c, size_t len) {
  DataStore& store = vmemory.get_data(dst);
  // アクセス違反をチェック
  if (VMemory::get_addr_lower(dst) + len > store.size) {
    throw_error_message(Error::SEGMENT_FAULT, Util::vaddr2str(dst));
  }
  memset(store.head.get(), c, len);
}
