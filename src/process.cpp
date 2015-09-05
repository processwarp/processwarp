
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

#include "convert.hpp"
#include "error.hpp"
#include "finally.hpp"
#include "func_store.hpp"
#include "instruction.hpp"
#include "process.hpp"
#include "stackinfo.hpp"
#include "type_store.hpp"
#include "util.hpp"
#include "std_error.hpp"
#include "wrapped_operator.hpp"

using namespace processwarp;

struct OperandParam {
  vaddr_t stack;
  vaddr_t k;
  Process& proc;
  VMemory::Accessor& memory;
};

inline std::unique_ptr<FuncStore> get_function(instruction_t code, OperandParam& param) {
  int operand = Instruction::get_operand(code);
  if ((operand & HEAD_OPERAND) != 0) {
    // 定数の場合1の補数表現からの復元
    vaddr_t addr = param.memory.get<vaddr_t>(param.k + (FILL_OPERAND - operand));
    return std::move(FuncStore::read(param.proc, param.memory, addr));
    
  } else {
    vaddr_t addr = param.memory.get<vaddr_t>(param.stack + operand);
    return std::move(FuncStore::read(param.proc, param.memory, addr));
  }
}

inline vaddr_t get_operand(instruction_t code, OperandParam& param) {
  int operand = Instruction::get_operand(code);
  if ((operand & HEAD_OPERAND) != 0) {
    // 定数の場合1の補数表現からの復元
    return param.k + (FILL_OPERAND - operand);
    
  } else {
    return param.stack + operand;
  }
}

inline std::unique_ptr<TypeStore> get_type(instruction_t code, OperandParam& param) {
  int operand = Instruction::get_operand(code);
  vaddr_t addr = param.memory.get<vaddr_t>(param.k + (FILL_OPERAND - operand));
  return std::move(TypeStore::read(param.memory, addr));
}

// Constructor.
Process::Process(ProcessDelegate& delegate_,
		 std::unique_ptr<VMemory::Accessor> proc_memory_,
		 const vaddr_t addr_,
		 const vpid_t& pid_,
		 const vtid_t& root_tid_,
		 const std::vector<void*>& libs_,
		 const std::map<std::string, std::string>& lib_filter_,
		 const std::map<std::string, std::pair<builtin_func_t, BuiltinFuncParam>>& builtin_funcs_) :
  delegate(delegate_),
  proc_memory(std::move(proc_memory_)),
  addr(addr_),
  pid(pid_),
  root_tid(root_tid_),
  libs(libs_),
  lib_filter(lib_filter_),
  builtin_funcs(builtin_funcs_) {
}

// Allocate process on memory from delegate.
std::unique_ptr<Process> Process::alloc(ProcessDelegate& delegate,
					const vpid_t& pid,
					vtid_t root_tid,
					const std::vector<void*>& libs,
					const std::map<std::string, std::string>& lib_filter,
					const std::map<std::string, std::pair<builtin_func_t, BuiltinFuncParam>>& builtin_funcs) {
  picojson::object js_proc;
  std::unique_ptr<VMemory::Accessor> memory(delegate.assign_accessor(pid));
  
  js_proc.insert(std::make_pair("pid", Convert::vpid2json(pid)));
  js_proc.insert(std::make_pair("root_tid", Convert::vtid2json(root_tid)));

  std::string str_proc = picojson::value(js_proc).serialize();
  vaddr_t addr = memory->set_meta_area(str_proc, VADDR_NULL);

  return Process::read(delegate, std::move(memory), addr, libs, lib_filter, builtin_funcs);
}

// Allocate process on memory from delegate.
std::unique_ptr<Process> Process::alloc(ProcessDelegate& delegate,
					const vpid_t& pid,
					vtid_t root_tid,
					const std::vector<void*>& libs,
					const std::map<std::string, std::string>& lib_filter,
					const std::map<std::string, std::pair<builtin_func_t, BuiltinFuncParam>>& builtin_funcs,
					vaddr_t proc_addr,
					const dev_id_t& master_dev_id) {
  picojson::object js_proc;
  std::unique_ptr<VMemory::Accessor> memory(delegate.assign_accessor(pid));
  
  js_proc.insert(std::make_pair("pid", Convert::vpid2json(pid)));
  js_proc.insert(std::make_pair("root_tid", Convert::vtid2json(root_tid)));

  std::string str_proc = picojson::value(js_proc).serialize();
  vaddr_t addr = memory->set_meta_area(str_proc, proc_addr, master_dev_id);

  return Process::read(delegate, std::move(memory), addr, libs, lib_filter, builtin_funcs);
}

// Read out process information from memory.
std::unique_ptr<Process> Process::read(ProcessDelegate& delegate,
				       std::unique_ptr<VMemory::Accessor> memory,
				       vaddr_t addr,
				       const std::vector<void*>& libs,
				       const std::map<std::string, std::string>& lib_filter,
				       const std::map<std::string, std::pair<builtin_func_t, BuiltinFuncParam>>& builtin_funcs) {
  picojson::value js_tmp;
  std::istringstream is(memory->get_meta_area(addr));
  std::string err = picojson::parse(js_tmp, is);
  if (!err.empty()) {
    /// TODO:error
    assert(false);
  }
  picojson::object& js_proc = js_tmp.get<picojson::object>();
  
  vpid_t pid = Convert::json2vpid(js_proc.at("pid"));
  vtid_t root_tid = Convert::json2vtid(js_proc.at("root_tid"));
  
  return std::unique_ptr<Process>
    (new Process(delegate, std::move(memory), addr,
		 pid, root_tid, libs, lib_filter, builtin_funcs));
}

// VM命令を実行する。
void Process::execute(Thread& thread, int max_clock) {
  VMemory::Accessor& memory = *thread.memory;
#ifndef NDEBUG
  memory.is_read_sequence = true;
#endif

 re_entry: {
    if (thread.stack.size() == 1) {
      if (thread.tid == root_tid) {
	// calls_at_exitに関数が登録されている場合、順番に実行する
	if (!calls_at_exit.empty() &&
	    thread.status != Thread::ERROR && thread.status != Thread::FINISH) {
	  vaddr_t func_addr = calls_at_exit.top();
	  // 関数中でatexitを呼ばれる可能性があるので、先頭の関数を呼び出し前に除去する
	  calls_at_exit.pop();
	  // calls_at_exitの先頭の関数を呼び出し状態にセット
	  call_setup_voidfunc(thread, func_addr);
	  goto re_entry;

	} else {
	  // エラーまたは正常終了に設定。
	  if (thread.status != Thread::ERROR) thread.status = Thread::FINISH;
	  return;
	}

      } else { // Non root thread.
	if (thread.status != Thread::ERROR) {
	  if (thread.join_waiting == JOIN_WAIT_DETACHED) {
	    thread.status = Thread::FINISH;

	  } else {
	    thread.status = Thread::JOIN_WAIT;
	  }
	}
	return;
      }
    }

    if (thread.status == Thread::BEFOR_WARP &&
	thread.stack.size() == thread.warp_stack_size) {
      if (thread.funcs_at_befor_warp.size() > thread.warp_call_count) {
	call_setup_voidfunc(thread, thread.funcs_at_befor_warp.at(thread.warp_call_count));
	thread.warp_call_count ++;
	goto re_entry;
	
      } else {
	thread.status = Thread::WARP;
      }
    }
    if (thread.status == Thread::AFTER_WARP &&
	thread.stack.size() == thread.warp_stack_size) {
      if (thread.funcs_at_befor_warp.size() > thread.warp_call_count) {
	call_setup_voidfunc(thread, thread.funcs_at_befor_warp.at(thread.warp_call_count));
	thread.warp_call_count ++;
	goto re_entry;
	
      } else {
	thread.status = Thread::NORMAL;
      }
    }

    StackInfo& stackinfo = thread.get_stackinfo(-1);
    VMemory::Accessor::MasterKey stackinfo_master_key = memory.keep_master(stackinfo.addr);
    VMemory::Accessor::MasterKey stack_master_key = memory.keep_master(stackinfo.stack);
    resolve_stackinfo_cache(thread, &stackinfo);

    const FuncStore& func = *stackinfo.func_store;
    const std::vector<instruction_t>& insts = func.normal_prop.code;
    OperandParam op_param = {stackinfo.stack, func.normal_prop.k, *this, memory};

    for (; (thread.status == Thread::NORMAL ||
	    thread.status == Thread::WAIT_WARP ||
	    thread.status == Thread::BEFOR_WARP ||
	    thread.status == Thread::AFTER_WARP) &&
	   max_clock > 0; max_clock --) {
#ifndef NDEBUG
      memory.is_read_sequence = true;
#endif
      
      instruction_t code = insts.at(stackinfo.pc);
      print_debug("pc:%d, insts:%" PRIu64 ", code:%08x %s\n",
		  stackinfo.pc, static_cast<longest_uint_t>(insts.size()),
		  code, Util::code2str(code).c_str());

      // call命令の判定(call命令の場合falseに変える)
      bool is_tailcall = true;

      switch (static_cast<uint8_t>(Instruction::get_opcode(code))) {

#define M_BINARY_OPERATOR(name, op)					\
	case Opcode::name: {						\
	  stackinfo.type_operator->op(stackinfo.output,			\
				      stackinfo.value,			\
				      get_operand(code, op_param));	\
	} break;

      case Opcode::NOP: {
	// 何もしない命令
      } break;
	
      case Opcode::CALL:
	is_tailcall = false;
	
      case Opcode::TAILCALL: {
	std::unique_ptr<FuncStore> new_func(std::move(get_function(code, op_param)));

	assert(!is_tailcall); // TODO 動きを確認する。

	int normal_pc = Instruction::get_operand(insts.at(stackinfo.pc + 1));
	int unwind_pc = Instruction::get_operand(insts.at(stackinfo.pc + 2));
	// CALL命令の次の命令の場所を取得する
	int next_pc = 1;
	while(stackinfo.pc + next_pc < insts.size() &&
	      Instruction::get_opcode(insts.at(stackinfo.pc + next_pc)) == Opcode::EXTRA)
	  next_pc ++;
	
	Finally finally_call;
	// スタックのサイズの有無により作りを変える
	vaddr_t new_stackaddr =
	  StackInfo::alloc(memory,
			   new_func->addr,
			   // tailcallの場合、戻り値の格納先を現行のものから引き継ぐ
			   is_tailcall ? stackinfo.ret_addr : stackinfo.output,
			   (normal_pc != FILL_OPERAND ? normal_pc : stackinfo.pc + next_pc),
			   (unwind_pc != FILL_OPERAND ? unwind_pc : stackinfo.pc + next_pc),
			   (new_func->normal_prop.stack_size != 0 ?
			    memory.alloc(new_func->normal_prop.stack_size) :
			    VADDR_NON));
	finally_call.add([&] {
	    memory.free(new_stackaddr);
	  });
	std::unique_ptr<StackInfo> new_stackinfo(StackInfo::read(memory, new_stackaddr));
	resolve_stackinfo_cache(thread, new_stackinfo.get());

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

	  std::unique_ptr<TypeStore> type(std::move(get_type(type_inst, op_param)));
	  vaddr_t value = get_operand(value_inst, op_param);

	  if (new_func->type == FuncType::FC_NORMAL && args < new_func->arg_num) {
	    // 通常の引数はスタックの先頭にコピー
	    memory.set_copy(new_stackinfo->stack + written_size, value, type->size);
	    written_size += type->size;

	  } else {
	    // 可変長引数、ネイティブメソッド用引数は一時領域に格納
	    std::size_t dest = work.size();
	    work.resize(dest + sizeof(vaddr_t) + type->size);
	    memcpy(work.data() + dest,                   &(type->addr),         sizeof(vaddr_t));
	    memcpy(work.data() + dest + sizeof(vaddr_t), memory.get_raw(value), type->size);
	  }
	  
	  args += 1;
	}

	print_debug("call %s\n", new_func->name.str().c_str());
	if (new_func->type == FuncType::FC_NORMAL) {
	  // 可変長引数でない場合、引数の数をチェック
	  if (args < new_func->arg_num ||
	      (!new_func->is_var_arg && args != new_func->arg_num))
	    throw_error(Error::TYPE_VIOLATION);

	  // 可変長引数分がある場合、別領域を作成
	  if (work.size() != 0) {
	    new_stackinfo->var_arg = memory.alloc(work.size());
	    finally_call.add([&]{
		memory.free(new_stackinfo->var_arg);
	      });
	    new_stackinfo->alloca_addrs.push_back(new_stackinfo->var_arg);
	    memory.set_copy(new_stackinfo->var_arg, work.data(), work.size());
	  } else {
	    new_stackinfo->var_arg = VADDR_NON;
	  }
	  
	  if (is_tailcall) {
	    // 末尾再帰の場合、既存のstackinfoを削除
	    // 次の命令はRETURNのはず
	    assert(Instruction::get_opcode(insts.at(stackinfo.pc + stackinfo.pc * 2 + 4))
		   == Opcode::RETURN);
	    thread.pop_stack();
	  } else {
	    // TODO assert(false);
	    // 末尾再帰でない場合、callinfosを追加
	  }
	  new_stackinfo->write(memory);
	  thread.push_stack(new_stackaddr, std::move(new_stackinfo));
	  finally_call.clear();
	  if (is_tailcall) {
	    stackinfo.pc += args * 2 + 2;
	  } else {
	    stackinfo.pc += args * 2 + 3;
	  }
	  goto re_entry;
	  
	} else if (new_func->type == FuncType::FC_BUILTIN) {
	  // VM組み込み関数の呼び出し
	  assert(new_func->builtin != nullptr);
	  BuiltinPost bp = new_func->builtin(*this, thread, new_func->builtin_param,
					     stackinfo.output, work);
	  switch(bp) {
	  case BP_NORMAL: stackinfo.pc += args * 2 + 2; break;
	  case BP_RE_ENTRY: stackinfo.pc += args * 2 + 2; goto re_entry;
	  case BP_RETRY_LATER: return;
	  default: assert(false);
	  }

	} else { // func.type == FuncType::EXTERNAL
	  if (new_func->external == nullptr) {
	    new_func->external = get_external_func(new_func->name);
	  }

	  // 関数の呼び出し
	  call_external(thread, *new_func, stackinfo.output, work);
	  stackinfo.pc += args * 2 + 2;
	}
      } break;

      case Opcode::RETURN: {
	StackInfo& upperinfo = thread.get_stackinfo(-2);
	resolve_stackinfo_cache(thread, &upperinfo);

	if (Instruction::get_operand(code) == FILL_OPERAND) {
	  // 戻り値がないので何もしない

	} else {
	  // 戻り値を設定する
	  vaddr_t operand = get_operand(code, op_param);
	  
	  stackinfo.type_operator->copy(upperinfo.output, operand);
	}
	// 1段上のスタックのpcを設定(normal_pc)
	upperinfo.pc = stackinfo.normal_pc;

	// stackinfoを1つ除去してre_entryに移動
	stack_master_key.reset();
	stackinfo_master_key.reset();
	thread.pop_stack();
	goto re_entry;
      } break;

      case Opcode::SET_TYPE: {
	std::unique_ptr<TypeStore> store(std::move(get_type(code, op_param)));
	stackinfo.type_operator = thread.get_operator(store->addr);
	/// TODO:未対応の型
	assert(stackinfo.type_operator != nullptr);
	stackinfo.type = store->addr;
	stackinfo.type_store.swap(store);
	print_debug("set_type = %016" PRIx64 "\n", stackinfo.type);
      } break;

      case Opcode::SET_OUTPUT: {
	stackinfo.output = get_operand(code, op_param);
	print_debug("output = %016" PRIx64 "\n", stackinfo.output);
      } break;

      case Opcode::SET_VALUE: {
	stackinfo.value = get_operand(code, op_param);
	print_debug("value = %016" PRIx64 "\n", stackinfo.value);
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
	stackinfo.value        = memory.get<vaddr_t>(get_operand(code, op_param));
	stackinfo.type_operator->copy(stackinfo.output, stackinfo.value);
	stackinfo.output       = stackinfo.value;
	print_debug("output = %016" PRIx64 "\n", stackinfo.output);
	print_debug("value = %016" PRIx64 "\n", stackinfo.value);
      } break;

      case Opcode::SET: {
	memory.set_copy(stackinfo.output,
			get_operand(code, op_param),
			stackinfo.type_store->size);
      } break;

      case Opcode::SET_PTR: {
	stackinfo.address = memory.get<vaddr_t>(get_operand(code, op_param));
	print_debug("address = %016" PRIx64 "\n", stackinfo.address);
      } break;

      case Opcode::SET_ADR: {
	stackinfo.address = get_operand(code, op_param);
	print_debug("address = %016" PRIx64 "\n", stackinfo.address);
      } break;

      case Opcode::SET_ALIGN: {
	int operand = Instruction::get_operand_value(code);
	stackinfo.alignment = operand;
      } break;

      case Opcode::ADD_ADR: {
	int operand = Instruction::get_operand_value(code);
	stackinfo.address += operand;
	print_debug("+%d address = %016" PRIx64 "\n", operand, stackinfo.address);
      } break;

      case Opcode::MUL_ADR: {
	int operand = Instruction::get_operand_value(code);
	const vm_int_t diff = operand * stackinfo.type_operator->get(stackinfo.value);
	stackinfo.address += diff;
	print_debug("+%d * %" PRIu64 " address = %16" PRIx64 "\n",
		    operand, stackinfo.type_operator->get(stackinfo.value), stackinfo.address);
      } break;

      case Opcode::GET_ADR: {
	memory.set<vaddr_t>(get_operand(code, op_param), stackinfo.address);
	print_debug("*%016" PRIx64 " = %016" PRIx64 "\n",
		    get_operand(code, op_param), stackinfo.address);
      } break;

      case Opcode::LOAD: {
	stackinfo.type_operator->copy(get_operand(code, op_param), stackinfo.address);
	print_debug("*%016" PRIx64 " = *%016" PRIx64 "(size = %" PRIu64 ")\n",
		    get_operand(code, op_param), stackinfo.address,
		    static_cast<longest_uint_t>(stackinfo.type_store->size));
      } break;

      case Opcode::STORE: {
	stackinfo.type_operator->copy(stackinfo.address, get_operand(code, op_param));
	print_debug("store %016" PRIx64 "\n", stackinfo.address);
      } break;

      case Opcode::CMPXCHG: {
	/// TODO:cmpxchg needs lock
	//memory.lock_master(stackinfo.output);
	//memory.lock_master(stackinfo.address);
	
	bool is_eq = stackinfo.type_operator->is_equal(stackinfo.address, stackinfo.value);

	if (is_eq) {
	  // *a == vを満たす場合、値を書き換え＆書き換え成功フラグを設定
	  stackinfo.type_operator->copy(stackinfo.output, stackinfo.address);
	  memory.set<uint8_t>(stackinfo.output + stackinfo.type_store->size, 1);
	  stackinfo.type_operator->copy(stackinfo.address, get_operand(code, op_param));

	} else {
	  // *a != vの場合、書き換え成功フラグをリセット
	  stackinfo.type_operator->copy(stackinfo.output, stackinfo.address);
	  memory.set<uint8_t>(stackinfo.output + stackinfo.type_store->size, 0);
	}
      } break;

      case Opcode::ALLOCA: {
	// サイズを計算
	size_t size = memory.get<uint32_t>(get_operand(code, op_param)) *
	  stackinfo.type_store->size;
	// 領域を確保
	vaddr_t addr = memory.alloc(size);
	// 確保領域のアドレスを設定
	memory.set<vaddr_t>(stackinfo.output, addr);
	// allocaで確保した領域はスタック終了時に開放できるように記録しておく
	stackinfo.alloca_addrs.push_back(addr);
	print_debug("alloca *%016" PRIx64 " = %016" PRIx64 "(%" PRIu64 " byte)\n",
		    stackinfo.output, addr, static_cast<longest_uint_t>(size));
      } break;

      case Opcode::TEST: {
	instruction_t code2 = insts.at(stackinfo.pc + 1);
	// operandの指し先がtrueかどうか判定。
	if (memory.get<uint8_t>(get_operand(code, op_param))) {
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
	instruction_t code2 = insts.at(stackinfo.pc + 1);
	// 値を比較
	uint8_t res = stackinfo.type_operator->is_equal(stackinfo.value,
							get_operand(code, op_param));
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
	stackinfo.phi0 = stackinfo.phi1;
	stackinfo.phi1 = stackinfo.pc =
	  static_cast<unsigned int>(memory.get<vaddr_t>(get_operand(code, op_param)));
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
	    stackinfo.type_operator->copy(stackinfo.output, get_operand(code, op_param));
	  }
	  count += 2;
	  if (insts.size() <= stackinfo.pc + count + 1) break;
	  code  = insts.at(stackinfo.pc + count);
	  code2 = insts.at(stackinfo.pc + count + 1);
	}
	stackinfo.pc += count - 1;
		      
      } break;

      case Opcode::TYPE_CAST: {
	std::unique_ptr<TypeStore> type(std::move(get_type(code, op_param)));
	stackinfo.type_operator->type_cast(stackinfo.output,
					   type->addr,
					   stackinfo.value);
      } break;

      case Opcode::BIT_CAST: {
	std::unique_ptr<TypeStore> type(std::move(get_type(code, op_param)));
	stackinfo.type_operator->bit_cast(stackinfo.output,
					  type->size,
					  stackinfo.value);
      } break;

	M_BINARY_OPERATOR(EQUAL,         op_equal);         // o = v == A
	M_BINARY_OPERATOR(NOT_EQUAL,     op_not_equal);     // o = v != A
	M_BINARY_OPERATOR(GREATER,       op_greater);       // o = v > A
	M_BINARY_OPERATOR(GREATER_EQUAL, op_greater_equal); // o = v >= A
	M_BINARY_OPERATOR(NOT_NANS,      op_not_nans);      // o = !isnan(v) && !isnan(A)

      case Opcode::OR_NANS: {
	if (stackinfo.type_operator->is_or_nans(stackinfo.value, get_operand(code, op_param))) {
	  memory.set<uint8_t>(stackinfo.output, I8_TRUE);
	  stackinfo.pc += 1; // 次の命令をスキップ
	}
      } break;

      case Opcode::SELECT: {
	if (memory.get<uint8_t>(stackinfo.value)) {
	  stackinfo.type_operator->copy(stackinfo.output, get_operand(code, op_param));
	} else {
	  stackinfo.type_operator->copy(stackinfo.output,
				     get_operand(insts.at(stackinfo.pc + 1), op_param));
	}
	stackinfo.pc += 1; // EXTRA分pcを進める
      } break;

      case Opcode::SHUFFLE: {
	int m = Instruction::get_operand_value(code);
	vaddr_t operand_mask = get_operand(insts.at(stackinfo.pc + 1), op_param);
	vaddr_t operand_v2 = get_operand(insts.at(stackinfo.pc + 2), op_param);
	std::unique_ptr<TypeStore> element_store =
	  TypeStore::read(memory, stackinfo.type_store->element);
	WrappedOperator* element_based = thread.get_operator(stackinfo.type_store->element);
	uint32_t len = stackinfo.type_store->num;
	for (int i = 0; i < m; i ++) {
	  uint32_t mask = memory.get<uint32_t>(operand_mask + sizeof(uint32_t) * i);
	  element_based->copy(stackinfo.output + i * stackinfo.type_store->size,
			      (mask < len ?
			       stackinfo.value + element_store->size * mask :
			       operand_v2 + element_store->size * (mask - len)));
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
void Process::call_external(Thread& thread,
			    const FuncStore& func,
			    vaddr_t ret_addr,
			    std::vector<uint8_t>& args) {
#ifndef EMSCRIPTEN
  VMemory::Accessor& memory = *thread.memory;
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
    std::unique_ptr<TypeStore> type =
      TypeStore::read(memory, *reinterpret_cast<vaddr_t*>(args.data() + seek));

    switch(type->addr) {
    case BasicType::TY_POINTER: {
      ffi_arg_types.push_back(&ffi_type_pointer);
      vaddr_t addr = *reinterpret_cast<vaddr_t*>(args.data() + seek + sizeof(vaddr_t));
      auto native = native_ptr.find(addr);
      if (native != native_ptr.end()) {
	*reinterpret_cast<void**>(args.data() + seek + sizeof(vaddr_t)) = native->second;
	
      } else {
	*reinterpret_cast<void**>(args.data() + seek + sizeof(vaddr_t)) =
	  memory.get_raw_writable(addr);
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
      /// TODO:error
      assert(false);
    } break;
    }
    
    seek += sizeof(vaddr_t) + type->size;
  }

  // libffiの準備
  ffi_cif cif;
  ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, ffi_args.size(),
				   ffi_ret_type, ffi_arg_types.data());

  if (status != FFI_OK) {
    throw_error_message(Error::EXT_CALL, Util::num2hex_str(status));
  }
  
  // 戻り値格納用の領域を作成
  size_t ret_size = TypeStore::read(memory, func.ret_type)->size;
  // sizeof(void*)の倍数領域を確保する。
  std::vector<void*> ret_buf(ret_size / sizeof(void*) +
			     (ret_size % sizeof(void*) == 0 ? 0 : 1));
  // メソッド呼び出し
  ffi_call(&cif, func.external, ret_buf.data(), ffi_args.data());
  // 戻り値格納用領域から戻り値を取り出し。
  if (ret_addr != VADDR_NULL) {
    memory.set_copy(ret_addr, reinterpret_cast<uint8_t*>(ret_buf.data()), ret_size);
  }
  
#else // !defined(EMSCRIPTEN)
  VMemory::Accessor& memory = *thread.memory;
  // 戻り値格納用の領域を作成
  size_t ret_size = TypeStore::read(memory, func.ret_type)->size;
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
    
    std::unique_ptr<TypeStore> type(TypeStore::read(memory, *reinterpret_cast<vaddr_t*>(args.data() + seek)));
    switch(type->addr) {
    case BasicType::TY_POINTER: {
      vaddr_t addr = *reinterpret_cast<vaddr_t*>(args.data() + seek + sizeof(vaddr_t));
      auto native = native_ptr.find(addr);
      if (native != native_ptr.end()) {
	asm_param << static_cast<void*>(native->second);
	
      } else {
	asm_param << static_cast<void*>(memory.get_raw_writable(addr));
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

    seek  += sizeof(vaddr_t) + type->size;
    count += 1;
  }
  if (!func.is_var_arg) {
    if (seek != args.size()) {
      assert(false);
    }
    
  } else {
    while(seek < args.size()) {
      std::unique_ptr<TypeStore> type(TypeStore::read(memory, *reinterpret_cast<vaddr_t*>(args.data() + seek)));
      switch(type->addr) {
      case BasicType::TY_POINTER: {
	vaddr_t addr = *reinterpret_cast<vaddr_t*>(args.data() + seek + sizeof(vaddr_t));
	auto native = native_ptr.find(addr);
	void* raw_ptr;
	if (native != native_ptr.end()) {
	  raw_ptr = static_cast<void*>(native->second);
	
	} else {
	  raw_ptr = static_cast<void*>(memory.get_raw_writable(addr));
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
	vararg_buf.resize(vararg_buf.size() + 2 + (vararg_buf.size() % 2));
	memcpy(&vararg_buf.at(vararg_buf.size() - 2), &raw_val, sizeof(raw_val));
      } break;

      case BasicType::TY_F32: {
	double raw_val = static_cast<double>(*reinterpret_cast<float*>(args.data() + seek + sizeof(vaddr_t)));
	vararg_buf.resize(vararg_buf.size() + 2 + (vararg_buf.size() % 2));
	memcpy(&vararg_buf.at(vararg_buf.size() - 2), &raw_val, sizeof(raw_val));
      } break;

      case BasicType::TY_F64: {
	double raw_val = *reinterpret_cast<double*>(args.data() + seek + sizeof(vaddr_t));
	vararg_buf.resize(vararg_buf.size() + 2 + (vararg_buf.size() % 2));
	memcpy(&vararg_buf.at(vararg_buf.size() - 2), &raw_val, sizeof(raw_val));
      } break;
      };
      seek  += sizeof(vaddr_t) + type->size;
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
    memory.set_copy(ret_addr, reinterpret_cast<const uint8_t*>(ret_buf.data()), ret_size);
  }
  
#endif
}



// Setup to call function that type : void (*)(void).
void Process::call_setup_voidfunc(Thread& thread, vaddr_t func_addr) {
  std::unique_ptr<FuncStore> func(FuncStore::read(*this, *thread.memory, func_addr));

  // 関数の型に合わせて呼び出す。
  if (func->type == FuncType::FC_NORMAL) {
    vaddr_t stackaddr =
      StackInfo::alloc(*thread.memory,
		       func->addr,
		       VADDR_NON, // 戻り値なし
		       0, 0, // 正常、異常終了時のpc設定もなし
		       (func->normal_prop.stack_size != 0 ?
			thread.memory->alloc(func->normal_prop.stack_size) :
			VADDR_NON));
    std::unique_ptr<StackInfo> stackinfo(StackInfo::read(*thread.memory, stackaddr));
    thread.push_stack(stackaddr, std::move(stackinfo));
    
  } else if (func->type == FuncType::FC_BUILTIN) {
    // VM組み込み関数の呼び出し
    assert(func->builtin != nullptr);
    std::vector<uint8_t> work;
    func->builtin(*this, thread, func->builtin_param, VADDR_NON, work);
    
  } else {
    if (func->external == nullptr) {
      func->external = get_external_func(func->name);
    }
    
    // 関数の呼び出し
    std::vector<uint8_t> work;
    call_external(thread, *func, VADDR_NULL, work);
  }
}

// VMの終了処理を行う。
void Process::close() {
}

// Get activated thread instance have had process.
Thread& Process::get_thread(vtid_t tid) {
  auto it = threads.find(tid);
  if (it == threads.end() || it->second.get() == nullptr) {
    return *threads.insert
      (std::make_pair(tid, Thread::read(tid, delegate.assign_accessor(pid)))).
      first->second.get();
    
  } else {
    Thread& thread = *it->second.get();
    thread.read();
    return thread;
  }
}

// Warp out thread.
void Process::warp_out_thread(vtid_t tid) {
  active_threads.insert(tid);
  waiting_warp_setup.insert(tid);
  delegate.on_change_thread_set(*this);
}

// Create a new thread.
vtid_t Process::create_thread(vaddr_t func_addr, vaddr_t arg_addr) {
  std::unique_ptr<FuncStore> func(std::move(FuncStore::read(*this, *proc_memory, func_addr)));

  // check function type
  if (func->type != FC_NORMAL) {
    throw_error_message(Error::SPEC_VIOLATION, func->name.str());
  }

  Thread& thread =
    *threads.insert(Thread::alloc(delegate.assign_accessor(pid))).first->second.get();

  vaddr_t root_stack = thread.memory->alloc(sizeof(vaddr_t));
  vaddr_t root_stackaddr =
    StackInfo::alloc(*thread.memory, VADDR_NON, VADDR_NON, 0, 0, root_stack);
  std::unique_ptr<StackInfo> root_stackinfo(std::move(StackInfo::read(*thread.memory,
								      root_stackaddr)));
  root_stackinfo->output = root_stack;
  root_stackinfo->write(*thread.memory);
  thread.push_stack(root_stackaddr, std::move(root_stackinfo));

  vaddr_t func_stackaddr;
  if (func->normal_prop.stack_size != 0) {
    vaddr_t func_stack = proc_memory->alloc(func->normal_prop.stack_size);
    func_stackaddr =
      StackInfo::alloc(*thread.memory, func->addr, root_stack, 0, 0, func_stack);

  } else {
    func_stackaddr =
      StackInfo::alloc(*thread.memory, func->addr, root_stack, 0, 0, VADDR_NON);
  }
  thread.push_stack(func_stackaddr);
  thread.write();

  active_threads.insert(thread.tid);
  delegate.on_change_thread_set(*this);

  return thread.tid;
}

// Prepare to exit a thread.
void Process::exit_thread(Thread& thread, vaddr_t retval) {
  StackInfo& root_stackinfo = thread.get_stackinfo(1);
  // Copy return value.
  thread.memory->set_copy(root_stackinfo.ret_addr,
			  reinterpret_cast<const uint8_t*>(&retval),
			  sizeof(retval));
  // Free stacks.
  while(thread.stack.size() > 1) {
    thread.pop_stack();
  }
}

// Free a instance of thread, leave stack-top for join thread if need.
bool Process::destroy_thread(Thread& thread) {
#ifndef NDEBUG
  thread.memory->is_read_sequence = true;
#endif
  if (thread.join_waiting == JOIN_WAIT_DETACHED) {
    while (thread.stack.size() > 0) {
      thread.pop_stack();
    }
    proc_memory->free(thread.tid);
    active_threads.erase(thread.tid);
    threads.erase(thread.tid);
    return true;

  } else {
    while (thread.stack.size() > 1) {
      thread.pop_stack();
    }
    thread.status = Thread::JOIN_WAIT;
    return false;
  }
}

// Join a thread.
bool Process::join_thread(vtid_t current, vtid_t target, vaddr_t retval) {
  Thread& target_thread  = get_thread(target);
  if (target_thread.join_waiting != current) {
    if (target_thread.join_waiting != JOIN_WAIT_NONE) {
      throw_std_error(StdError::PW_INVAL);
      
    } else if (target == current) {
      throw_std_error(StdError::PW_DEADLK);
    }
    
    target_thread.join_waiting = current;
  }

  if (target_thread.status == Thread::JOIN_WAIT) {
    // copy retval
    proc_memory->set<vaddr_t>(retval, proc_memory->get<vaddr_t>
			     (target_thread.get_stackinfo(0).stack));

    target_thread.join_waiting = JOIN_WAIT_DETACHED;
    target_thread.status = Thread::FINISH;
    target_thread.write();
    return true;

  } else {
    // waiting
    return false;
  }
}

// Change status to exit.
void Process::exit() {
  print_debug("Exit process");
  
  for (auto& it_thread : active_threads) {
    Thread& thread = get_thread(it_thread);

    if (thread.status == Thread::NORMAL ||
	thread.status == Thread::WAIT_WARP ||
	thread.status == Thread::BEFOR_WARP ||
	thread.status == Thread::WARP ||
	thread.status == Thread::AFTER_WARP) {
      thread.status = Thread::NORMAL;
      fixme("exit thread");
      Thread& root_thread = get_thread(root_tid);
      while(root_thread.stack.size() > 1) {
	root_thread.pop_stack();
      }
    } else {
      assert(false);
    }
  }
}

// ライブラリなど、外部の関数へのポインタを取得する。
external_func_t Process::get_external_func(const Symbols::Symbol& name) {
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

/**
 * 組み込み関数用に引数を取り出すメソッドを作成するマクロ。
 * @param name メソッド名
 * @param type C++での実際の型
 * @param basic_type VM内の型
 */
#define M_READ_BUILTIN_PARAM(name, type, basic_type)			\
  type Process::name(const std::vector<uint8_t>& src, int* seek) {	\
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

// StackInfoのキャッシュを解決し、実行前の状態にする。
void Process::resolve_stackinfo_cache(Thread& thread, StackInfo* stackinfo) {
  // 関数
  if (stackinfo->func != VADDR_NON) {
    stackinfo->func_store = std::move(FuncStore::read(*this, *thread.memory, stackinfo->func));
  } else {
    stackinfo->func_store.reset(nullptr);
  }
  // 操作対象の型
  if (stackinfo->type != VADDR_NON) {
    stackinfo->type_operator = thread.get_operator(stackinfo->type);
    stackinfo->type_store = std::move(TypeStore::read(*thread.memory, stackinfo->type));

  } else {
    stackinfo->type_operator = nullptr;
    stackinfo->type_store = nullptr;
  }
}

// VMの初期設定をする。
void Process::run(const std::vector<std::string>& args,
		  const std::map<std::string, std::string>& envs) {
  // make root thread
  Thread& root_thread = 
    *threads.insert(Thread::alloc(delegate.assign_accessor(pid), root_tid)).
    first->second.get();
  active_threads.insert(root_thread.tid);

  VMemory::Accessor& memory = *root_thread.memory;
  
  // スレッドを初期化
  root_thread.join_waiting = JOIN_WAIT_ROOT;
  
  // main関数の取得
  auto it_main_func = globals.find(&symbols.get("main"));
  if (it_main_func == globals.end())
    throw_error_message(Error::SYM_NOT_FOUND, "main");
  std::unique_ptr<FuncStore> main_func(std::move(FuncStore::read(*this, *proc_memory,
								 it_main_func->second)));

  // main関数用のスタックを確保する
  vaddr_t main_stack = VADDR_NULL;
  if (main_func->normal_prop.stack_size != 0) {
    main_stack = memory.alloc(main_func->normal_prop.stack_size);
  }

  // main関数の内容に応じて、root_stackを作成する
  vaddr_t root_stack = VADDR_NULL;
  if (main_func->arg_num == 2 || main_func->arg_num == 3) {
    // main関数の戻り値と引数を格納するのに必要な領域サイズを計算
    const size_t ret_size = TypeStore::calc_type_size(memory, main_func->ret_type).first;
    size_t root_stack_size = ret_size + sizeof(vaddr_t) * args.size();
    for (unsigned int i = 0, arg_size = args.size(); i < arg_size; i ++) {
      root_stack_size += args.at(i).length() + 1;
    }
    // 第3引数まである場合はenvpに必要な領域サイズも計算
    if (main_func->arg_num == 3) {
      root_stack_size += sizeof(vaddr_t) * (envs.size() + 1);
      for (auto pair : envs) {
	// +2 は'='と'\0'用
	root_stack_size += pair.first.length() + pair.second.length() + 2;
      }
    }
    // 領域を確保
    root_stack = memory.alloc(root_stack_size);

    // main関数のスタックの先頭にargc, argvを格納する
    vm_int_t argc = args.size();
    vaddr_t  argv = root_stack + ret_size;
    memory.set<vm_int_t>(main_stack, argc);
    memory.set<vaddr_t>(main_stack + sizeof(vm_int_t), argv);

    // root_stack_dataにmain関数の戻り値、argvとして渡すポインタの配列、引数文字列、、を格納する
    vaddr_t sum = ret_size + sizeof(vaddr_t) * args.size();
    for (unsigned int i = 0, arg_size = args.size(); i < arg_size; i ++) {
      vaddr_t addr = root_stack + sum;
      memory.set<vaddr_t>(root_stack + ret_size + sizeof(vaddr_t) * i, addr);
      memory.set_copy(root_stack + sum,
		      reinterpret_cast<const uint8_t*>(args.at(i).c_str()),
		      args.at(i).length() + 1);
      sum += args.at(i).length() + 1;
    }

    // 第3引数まである場合はenvpとして渡すポインタの配列、環境変数文字列をを格納する
    if (main_func->arg_num == 3) {
      // main関数のスタックにenvpを格納する。
      unsigned int arg_size = sum;
      vaddr_t envp = root_stack + sum;
      memory.set<vaddr_t>(main_stack + 4 + sizeof(vaddr_t), envp);
      sum += sizeof(vaddr_t) * (envs.size() + 1);
      int i = 0;
      for (auto pair : envs) {
	vaddr_t addr = root_stack + sum;
	memory.set<vaddr_t>(root_stack + arg_size + sizeof(vaddr_t) * i, addr);
	sum += sprintf(reinterpret_cast<char*>(memory.get_raw_writable(root_stack + sum)),
		       "%s=%s", pair.first.c_str(), pair.second.c_str()) + 1;
	i ++;
      }
      memory.set<vaddr_t>(root_stack + arg_size + sizeof(vaddr_t) * i, VADDR_NULL);
    }

  } else if (main_func->arg_num != 0) {
    // int main()でもint main(int, char**)でもないようだ
    throw_error(Error::SPEC_VIOLATION);

  } else {
    // int main()の場合は引数を設定しない
    // main関数の戻り値格納先を確保する
    root_stack = memory.alloc(TypeStore::calc_type_size(memory, main_func->ret_type).first);
  }

  // mainのreturnを受け取るためのスタックを1段確保する
  vaddr_t root_stackaddr =
    StackInfo::alloc(memory, VADDR_NON, VADDR_NON, 0, 0, root_stack);
  std::unique_ptr<StackInfo> root_stackinfo(StackInfo::read(memory, root_stackaddr));
  root_stackinfo->output = root_stack;
  root_stackinfo->write(memory);
  root_thread.push_stack(root_stackaddr, std::move(root_stackinfo));
  
  vaddr_t main_stackaddr =
    StackInfo::alloc(memory, main_func->addr, root_stack, 0, 0, main_stack);
  root_thread.push_stack(main_stackaddr);
}

// 大域変数のアドレスを設定する。
void Process::set_global_value(const std::string& name, vaddr_t addr) {
  /// @todo 同一の名前が再利用されないことの確認
  globals.insert(std::make_pair(&symbols.get(name), addr));
}

// VMの初期設定をする。
void Process::setup() {

#define M_ALLOC_BASIC_TYPE(s, a, t)			\
  TypeStore::alloc_basic(*proc_memory, (s), (a), (t));	\
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
  native_ptr.insert(std::make_pair(VADDR_NULL, nullptr));

  print_debug("finish setup.\n");
}
