
#include <iostream>
#include <llvm/AsmParser/Parser.h>
#include <llvm/Support/ManagedStatic.h>
#include <llvm/Support/SourceMgr.h>
#include <memory>

#include "error.hpp"
#include "instruction.hpp"
#include "llvm_asm_loader.hpp"
#include "util.hpp"
#include "vmachine.hpp"

using namespace usagi;

/**
 * 値がロード済みかチェックし該当した場合、既存のアドレスを戻すマクロ
 * @param value チェック対象の値
 */
#define check_same_value(loaded, value) auto exist = loaded.find(value); if (exist != loaded.end())  return &(exist->second)

// コンストラクタ。
LlvmAsmLoader::LlvmAsmLoader(VMachine& vmachine_) :
  context(llvm::getGlobalContext()),
  vmachine(vmachine_) {
}

// デストラクタ。
LlvmAsmLoader::~LlvmAsmLoader() {
  llvm::llvm_shutdown();
}

// LLVMのアセンブリファイルを読み込んで仮想マシンにロードする。
void LlvmAsmLoader::load_file(const std::string& filename) {
  llvm::SMDiagnostic error;
  llvm::Module* module = llvm::ParseAssemblyFile(filename, error, context);
  if (module == nullptr)
    throw_error_message(Error::PARSE, error.getMessage().str() + "[" + filename + "]");
  load(module);
}

// LLVMのアセンブリファイルを読み込んで仮想マシンにロードする。
/*
void LlvmAsmLoader::load_string(const std::string& src) {
  llvm::SMDiagnostic error;
  llvm::Module* module = llvm::ParseAssemblyString(src, error, context);
  if (module == nullptr)
    throw_error(Error::PARSE, error.getMessage().str());
  load(module);
}
//*/

// ロード済みの値とアドレスの対応関係を登録する。
Value* LlvmAsmLoader::assign_loaded(const llvm::Value* v, const Value& src) {
  // 登録済LLVM変数が再度登録されることはない
  assert(loaded_value.find(v) == loaded_value.end());

  // 値が未登録なので登録する
  return &(loaded_value.insert(std::make_pair(v, src)).first->second);
}

// LLVMの型に対応するオペランドを取得する。
int LlvmAsmLoader::assign_operand(FunctionContext& fc, const llvm::Type* t) {
  vaddr_t addr = load_type(t);

  // load_typeで登録しているはず。
  assert(loaded_addr_type.find(addr) != loaded_addr_type.end());

  Value* type = &(loaded_addr_type.find(addr)->second);

  // 既存の定数の場合、その番号を戻す。
  for (int i = 0, size = fc.k.size(); i < size; i ++)
      // 定数の場合は1の補数表現の負数を戻す。
    if (type == fc.k[i]) return (- i) - 1;

  // 新規の場合末尾に割り当てる。
  fc.k.push_back(type);
  return -fc.k.size();
}

// LLVMの変数に対応する変数の番号を取得する。
int LlvmAsmLoader::assign_operand(FunctionContext& fc, const llvm::Value* v) {
  // 関数の引数は定数でもローカル変数に積むため、
  // ローカル変数判定を先に行う。
  // 既存のローカル変数の場合、その番号を戻す。
  for (unsigned int i = 0, size = fc.values.size(); i < size; i ++) {
    if (v == fc.values.at(i)) {
      return i;
    }
  }

  if (llvm::Constant::classof(v)) {
    // llvm::Constant->vaddr_tに変換
    Value* value = load(static_cast<const llvm::Constant*>(v));

    // 既存の定数の場合、その番号を戻す。
    for (int i = 0, size = fc.k.size(); i < size; i ++)
      // 定数の場合は1の補数表現の負数を戻す。
      if (value == fc.k[i]) return (- i) - 1;

    // 既存の定数でない場合、末尾に割り当てる。
    fc.k.push_back(value);
    return -fc.k.size();

  } else {
    // 既存のローカル変数でない場合、末尾に割り当ている。
    fc.values.push_back(v);
    return fc.values.size() - 1;
  }
}

// LLVMの定数を仮想マシンにロードする。
Value* LlvmAsmLoader::load(const llvm::Constant* constant) {
  check_same_value(loaded_value, constant);
  
  // 値の型に合わせて分岐
  switch(constant->getValueID()) {
    //case llvm::Value::ArgumentVal: {} break;
    //case llvm::Value::BasicBlockVal: {} break;
  case llvm::Value::FunctionVal:
    return load(static_cast<const llvm::Function*>(constant));

    //case llvm::Value::GlobalAliasVal: {} break;
    //case llvm::Value::GlobalVariableVal: {} break;
    //case llvm::Value::UndefValueVal: {} break;
    //case llvm::Value::BlockAddressVal: {} break;
  case llvm::Value::ConstantExprVal:
    return load(static_cast<const llvm::ConstantExpr*>(constant));
    
  case llvm::Value::ConstantAggregateZeroVal:
    return load(static_cast<const llvm::ConstantAggregateZero*>(constant));

  case llvm::Value::ConstantDataArrayVal:
    return load(static_cast<const llvm::ConstantDataArray*>(constant));

    //case llvm::Value::ConstantDataVectorVal: {} break;
  case llvm::Value::ConstantIntVal:
    return load(static_cast<const llvm::ConstantInt*>(constant));

  case llvm::Value::ConstantFPVal:
    return load(static_cast<const llvm::ConstantFP*>(constant));

  case llvm::Value::ConstantArrayVal:
    return load(static_cast<const llvm::ConstantArray*>(constant));

    //case llvm::Value::ConstantStructVal: {} break;
    //case llvm::Value::ConstantVectorVal: {} break;
    //case llvm::Value::ConstantPointerNullVal: {} break;
    //case llvm::Value::MDNodeVal: {} break;
    //case llvm::Value::MDStringVal: {} break;
    //case llvm::Value::InlineAsmVal: {} break;
    //case llvm::Value::InstructionVal: {} break;
  default: {
    print_debug("unsupport type : %d\n", constant->getValueID());
    constant->dump();

    throw_error(Error::UNSUPPORT);
  } break;
  }
}

// LLVMの定数(0うめ領域)を仮想マシンにロードする。
Value* LlvmAsmLoader::load(const llvm::ConstantAggregateZero* src) {
  check_same_value(loaded_value, src);

  // 領域サイズを取得
  unsigned int size = src->getType()->getScalarSizeInBits();
  // 領域確保
  Value value = vmachine.create_value_by_array(1, size, nullptr);
  // 0クリア
  memset(value.cache, 0, size);

  return assign_loaded(src, value);
}

// LLVMの定数(配列)を仮想マシンにロードする。
Value* LlvmAsmLoader::load(const llvm::ConstantArray* src) {
  check_same_value(loaded_value, src);

  // Typeの要素数とOperandsの要素数は同じはず
  assert(src->getType()->getNumElements() == src->getNumOperands());
  
  if (src->getType()->getElementType()->isPointerTy()) {
    // 要素がポインタの場合、要素の仮想アドレスを格納する
    // 領域確保
    Value value = vmachine.create_value_by_array(sizeof(vaddr_t),
						 src->getNumOperands(),
						 nullptr);
    // 仮想アドレスを格納する
    vaddr_t* cache = reinterpret_cast<vaddr_t*>(value.cache);
    for (int i = 0, num = src->getNumOperands(); i < num; i++) {
      Value* operand_value = load(src->getOperand(i));
      *(cache + i) = operand_value->get_address();
    }

    return assign_loaded(src, value);

  } else {
    // 値がどのように格納されるか未検証
    assert(false);
  }
}

// LLVMの定数(DataArray)を仮想マシンにロードする。
Value* LlvmAsmLoader::load(const llvm::ConstantDataArray* data_array) {
  check_same_value(loaded_value, data_array);

  return assign_loaded(data_array,
		       vmachine.create_value_by_array(data_array->getElementByteSize(),
						      data_array->getNumElements(),
						      data_array->getRawDataValues().data()));
}

// LLVMの定数(Expr)を仮想マシンにロードする。
Value* LlvmAsmLoader::load(const llvm::ConstantExpr* expr) {
  check_same_value(loaded_value, expr);

  switch(expr->getOpcode()) {
    // case llvm::Instruction::Trunc:
    // case llvm::Instruction::ZExt:
    // case llvm::Instruction::SExt:
    // case llvm::Instruction::FPTrunc:
    // case llvm::Instruction::FPExt:
    // case llvm::Instruction::UIToFP:
    // case llvm::Instruction::SIToFP:
    // case llvm::Instruction::FPToUI:
    // case llvm::Instruction::FPToSI:
    // case llvm::Instruction::PtrToInt:
    // case llvm::Instruction::IntToPtr:
    // case llvm::Instruction::BitCast:
    // case llvm::Instruction::AddrSpaceCast: {} break; //CastOps
    // case llvm::Instruction::Select: {} break; //Select
    // case llvm::Instruction::InsertElement: {} break; // InsertElement
    // case llvm::Instruction::ExtractElement: {} break; // ExtractElement
    // case llvm::Instruction::InsertValue: {} break; // InsertValue
    // case llvm::Instruction::ExtractValue: {} break; // ExtractValue
    // case llvm::Instruction::ShuffleVector: {} break; // ShuffleVector
  case llvm::Instruction::GetElementPtr: {
    const llvm::Value* tv = expr->getOperand(0);
    assert(llvm::Constant::classof(tv)); // オペランドは定数のはず。
    Value* target_value = load(static_cast<const llvm::Constant*>(tv));
    assert(target_value->type == Value::POINTER_DATA); // 1つ目のオペランドはポインタのはず。
    llvm::Type* op_type = tv->getType()->getPointerElementType();
    assert(op_type->isSized()); // サイズが確定可能と想定
    int delta = 0;
    // delta = Σ(size(n) * operand(n))を計算
    /// TODO バグあり、vmachine.cppのGET_EPのアルゴリズムを参考に書き換えること
    for (unsigned int i = 1, num_operands = expr->getNumOperands(); i < num_operands; i ++) {
      // 2つ目以降のオペランドは数値のはず。
      assert(llvm::ConstantInt::classof(expr->getOperand(i)));
      const llvm::ConstantInt* op = static_cast<const llvm::ConstantInt*>(expr->getOperand(i));
      delta += (uint32_t)data_layout->getTypeStoreSize(op_type) * op->getSExtValue();
      print_debug("(%d|%d) x %lld\n",
		  (uint32_t)data_layout->getTypeStoreSize(op_type),
		  (uint32_t)data_layout->getTypeAllocSize(op_type),
		  op->getSExtValue());
      assert((uint32_t)data_layout->getTypeStoreSize(op_type) ==
	     (uint32_t)data_layout->getTypeAllocSize(op_type)); // どちらの値を取るべきか？
      if (llvm::SequentialType::classof(op_type)) {
	// pointer, array, vectorの場合、中身の型を見る。
	op_type = static_cast<const llvm::SequentialType*>(op_type)->getElementType();

      } else if (llvm::StructType::classof(op_type)) {
	// structの場合、n番目の要素の型を見る。
	op_type = static_cast<const llvm::StructType*>(op_type)->getElementType(op->getZExtValue());
      }
    }
    return assign_loaded(expr, vmachine.create_pointer(target_value, delta));
  } break;

    // case Instruction::ICmp:
    // case Instruction::FCmp: {} break; // Cmp
    //default: {} break; // Binary
  default: {
    print_debug("unsupport expr : %d %s\n", expr->getOpcode(), expr->getOpcodeName());
    throw_error(Error::UNSUPPORT);
  } break;
  }
}

// LLVMの定数(Floating-point)を仮想マシンにロードする。
Value* LlvmAsmLoader::load(const llvm::ConstantFP* src) {
  check_same_value(loaded_value, src);

  switch(src->getType()->getTypeID()) {
  case llvm::Type::FloatTyID:
    return assign_loaded(src, vmachine.create_value_by_primitive
			 (src->getValueAPF().convertToFloat()));
    
  case llvm::Type::DoubleTyID:
    return assign_loaded(src, vmachine.create_value_by_primitive
			 (src->getValueAPF().convertToDouble()));

  default: {
    print_debug("unsupport type : %d\n", src->getType()->getTypeID());
    src->dump();
    throw_error(Error::UNSUPPORT);
  } break;
  };
}

// LLVMの定数(Int)を仮想マシンにロードする。
Value* LlvmAsmLoader::load(const llvm::ConstantInt* src) {
  check_same_value(loaded_value, src);

  switch (src->getBitWidth()) {
  case 8:
    return assign_loaded(src, vmachine.create_value_by_array(1, 1, src->getValue().getRawData()));
  case 16:
    return assign_loaded(src, vmachine.create_value_by_array(2, 1, src->getValue().getRawData()));
  case 32:
    return assign_loaded(src, vmachine.create_value_by_array(4, 1, src->getValue().getRawData()));
  case 64:
    return assign_loaded(src, vmachine.create_value_by_array(8, 1, src->getValue().getRawData()));

  default: {
    print_debug("unsupport bit width : %d\n", src->getBitWidth());
    throw_error(Error::UNSUPPORT);
  } break;
  }
}

// LLVMの関数を仮想マシンにロードする。
Value* LlvmAsmLoader::load(const llvm::Function* function) {
  check_same_value(loaded_value, function);

  if (function->isDeclaration()) {
    // VM組み込み関数/ライブラリなど外部の関数
    // 名前を持つはず
    assert(function->hasName());
    return assign_loaded(function, vmachine.create_function(function->getName()));

  } else {
    // 通常の関数(VMで解釈、実行する)
    FuncStore::NormalProp prop;

    // 定数
    std::vector<Value*> k;
    // 変数
    std::vector<const llvm::Value*> values;
    // ブロックとそれに割り当てる名前
    std::map<const llvm::BasicBlock*, unsigned int> block_alias;
    // ブロック名とそれの開始位置
    std::map<unsigned int, unsigned int> block_start;

    FunctionContext fc = {prop.code, k, values };
    
    // 引数を変数の先頭に登録
    for (auto arg = function->getArgumentList().begin();
	 arg != function->getArgumentList().end(); arg ++) {
      assert(arg->hasName()); // 名前を持つはず
      const llvm::Value* arg_val = function->getValueSymbolTable().lookup(arg->getName());
      assert(arg_val != nullptr);
      values.push_back(arg_val);
    }

    // ブロックの名称を最初に作っておく
    unsigned int alias = 0;
    for (auto b = function->begin(); b != function->end(); b ++) {
      block_alias.insert(std::make_pair(b, alias ++));
    }

    for (auto block = function->begin(); block != function->end(); block ++) {
      // ブロックの開始位置を格納しておく
      block_start.insert(std::make_pair(block_alias.at(block), fc.code.size()));

      // 命令を解析する
      for (auto i = block->begin(); i != block->end(); i ++) {
	i->dump(); // TODO
	// LLVMに対応した命令に置き換え
	switch(i->getOpcode()) {
	case llvm::Instruction::Ret: {
	  const llvm::ReturnInst& inst = static_cast<const llvm::ReturnInst&>(*i);
	  if (inst.getReturnValue() == nullptr) {
	    // 戻り値がない場合、A = 0, B = 0
	    push_code_AB(fc, Opcode::RETURN, 0, 0, 0);

	  } else {
	    // 戻り値がある場合、A = 1, B = 値
	    push_code_AB(fc, Opcode::RETURN, 0,
			 1, assign_operand(fc, inst.getReturnValue()));
	  }
	} break;

	case llvm::Instruction::Call: {
	  const llvm::CallInst& inst = static_cast<const llvm::CallInst&>(*i);
	  // インラインアセンブラ未対応
	  if (inst.isInlineAsm()) throw_error(Error::UNSUPPORT);
	  
	  // CALL命令、関数
	  push_code_AB(fc, Opcode::CALL, 0,
		       assign_operand(fc, inst.getCalledFunction()),
		       /// TODO 末尾再帰の場合、Bに1を設定(llvmのtail callの定義が認識と違う？)
		       /*inst.isTailCall() ? 1 :*/ 0);
	  // 戻り値の型、格納先の命令を追加
	  push_code_AB(fc, Opcode::EXTRAARG2, 0,
		       assign_operand(fc, inst.getCalledFunction()->getReturnType()),
		       assign_operand(fc, &inst));

	  // 引数部分の命令(引数の型、引数〜)を追加
	  for (unsigned int arg_idx = 0, num = inst.getNumArgOperands();
	       arg_idx < num; arg_idx ++) {
	    int op_a = assign_operand(fc, inst.getArgOperand(arg_idx)->getType());
	    int op_b = assign_operand(fc, inst.getArgOperand(arg_idx));
	    push_code_AB(fc, Opcode::EXTRAARG2, 0, op_a, op_b);
	  }
	} break;

	case llvm::Instruction::Br: {
	  const llvm::IndirectBrInst& inst = static_cast<const llvm::IndirectBrInst&>(*i);
	  if (inst.getNumDestinations() == 0) {
	    // 無条件分岐の場合、無条件jump先の命令を追加
	    push_code_AB(fc, Opcode::JUMP, 0,
			 block_alias.at(inst.getDestination(-1)), 0);

	  } else {
	    // 条件分岐
	    assert(inst.getNumDestinations() == 2);
	    // jump先、判定対象の命令を追加
	    push_code_AB(fc, Opcode::TEST, 0,
			 block_alias.at(inst.getDestination(0)),
			 assign_operand(fc, inst.getAddress()));
	    // 無条件jump先の命令を追加
	    push_code_AB(fc, Opcode::JUMP, 0,
			 block_alias.at(inst.getDestination(1)), 0);
	  }
	} break;

	case llvm::Instruction::PHI: {
	  const llvm::PHINode& inst = static_cast<const llvm::PHINode&>(*i);
	  // 変数格納先、型の命令を追加
	  push_code_AB(fc, Opcode::PHI, 0,
		       assign_operand(fc, &inst),
		       assign_operand(fc, inst.getType()));
	  for (unsigned int i = 0, num = inst.getNumIncomingValues(); i < num; i ++) {
	    // Phiと最終jump先の命令を追加
	    push_code_AB(fc, Opcode::EXTRAARG2, 0,
			 assign_operand(fc, inst.getIncomingValue(i)),
			 block_alias.at(inst.getIncomingBlock(i)));
	  }
	} break;

	  /**
	   * 加減乗除などの２項演算子命令作成マクロ
	   * @param opcode
	   */
#define M_BIN_OPERATOR(opcode)						\
	  const llvm::BinaryOperator& inst =				\
	  static_cast<const llvm::BinaryOperator&>(*i);			\
	  assert(inst.getNumOperands() == 2);				\
	  /* 変数格納先、型の命令を追加	*/				\
	  push_code_AB(fc, (opcode), 0,					\
		       assign_operand(fc, &inst),			\
		       assign_operand(fc, inst.getType()));		\
	  /* 2項の命令を追加 */						\
	  push_code_AB(fc, Opcode::EXTRAARG2, 0,			\
		       assign_operand(fc, inst.getOperand(0)),		\
		       assign_operand(fc, inst.getOperand(1)))

	case llvm::Instruction::Add: {
	  M_BIN_OPERATOR(Opcode::ADD);
	} break;

	case llvm::Instruction::URem: {
	  M_BIN_OPERATOR(Opcode::UREM);
	} break;

	case llvm::Instruction::SRem: {
	  M_BIN_OPERATOR(Opcode::SREM);
	} break;

#undef M_BIN_OPERATOR

	case llvm::Instruction::Load: {
	  const llvm::LoadInst& inst = static_cast<const llvm::LoadInst&>(*i);
	  /* 変数格納先、アドレス格納元を追加 */
	  push_code_AB(fc, Opcode::LOAD, 0,
		       assign_operand(fc, &inst),
		       assign_operand(fc, inst.getPointerOperand()));
	} break;

	case llvm::Instruction::GetElementPtr: {
	  const llvm::GetElementPtrInst& inst = static_cast<const llvm::GetElementPtrInst&>(*i);
	  /* 変数格納先、アドレス格納元を追加 */
	  push_code_AB(fc, Opcode::GET_EP, 0,
		       assign_operand(fc, &inst),
		       assign_operand(fc, inst.getPointerOperand()));
	  /* ポインタの型、インデクスのサイズを追加 */
	  llvm::Type* idx_type = inst.getOperand(1)->getType();
	  assert(idx_type->isIntegerTy()); // int系のはず
	  push_code_AB(fc, Opcode::EXTRAARG2, 0,
		       assign_operand(fc, inst.getPointerOperandType()->getPointerElementType()),
		       idx_type->getIntegerBitWidth() / 8);
	  for (unsigned int i = 1, num = inst.getNumOperands(); i < num; i ++) {
	    // 型が同じはず
	    assert(inst.getOperand(i)->getType() == idx_type &&
		   i + 1 < num ? inst.getOperand(i + 1)->getType() == idx_type : true);
	    // インデクスを追加
	    push_code_AB(fc, Opcode::EXTRAARG2, 0,
			 assign_operand(fc, inst.getOperand(i ++)),
			 i < num ? assign_operand(fc, inst.getOperand(i ++)) : 0);
	  }
	} break;

	case llvm::Instruction::SExt: {
	  const llvm::SExtInst& inst = static_cast<const llvm::SExtInst&>(*i);
	  assert(inst.getNumOperands() == 1);
	  /* 変数格納先、キャスト後の型を追加 */
	  push_code_AB(fc, Opcode::SEXT, 0,
		       assign_operand(fc, &inst),
		       assign_operand(fc, inst.getDestTy()));
	  /* 変換元変数格納先、キャスト前の型を追加 */
	  push_code_AB(fc, Opcode::EXTRAARG2, 0,
		       assign_operand(fc, inst.getOperand(0)),
		       assign_operand(fc, inst.getSrcTy()));
	} break;

	default: {
	  print_debug("unsupport instruction : %s\n", i->getOpcodeName());
	  throw_error_message(Error::UNSUPPORT, "instruction:" + Util::num2dec_str(i->getOpcode()));
	} break;
	};
      }
    }

    // TEST/JUMP命令のジャンプ先を名前から開始位置に書き換える
    for (unsigned int pc = 0, size = fc.code.size(); pc < size; pc ++) {
      instruction_t code = fc.code[pc];
      switch (Instruction::get_opcode(code)) {
      case Opcode::JUMP: {
	unsigned int start = block_start.at(Instruction::get_code_A(code));
	fc.code[pc] = Instruction::rewrite_code_A(code, start);
      } break;

      case Opcode::TEST: {
	unsigned int start = block_start.at(Instruction::get_code_B(code));
	fc.code[pc] = Instruction::rewrite_code_B(code, start);
      } break;

      case Opcode::PHI: {
	// PHIの場合、ソレに続くextar arg内を書き換える
	while (Instruction::get_opcode(code = fc.code[pc + 1]) == Opcode::EXTRAARG2) {
	  unsigned int start = block_start.at(Instruction::get_code_B(code));
	  fc.code[pc + 1] = Instruction::rewrite_code_B(code, start);
	  pc ++;
	}
      } break;
      }
    }

    prop.is_var_arg = function->isVarArg();
    prop.arg_num    = function->arg_size();
    prop.val_num    = values.size();
    // codeは予めセットされている
    prop.k.resize(k.size());
    for (int i = 0, size = k.size(); i < size; i ++) {
      prop.k[i] = *k[i];
    }

    // 定数、変数の数がオペランドで表現可能な上限を超えた場合エラー
    if (values.size() > 2000 || k.size() > 2000)
      throw_error_message(Error::TOO_MANY_VALUE, function->getName().str());

    return assign_loaded(function,
			 vmachine.create_function(function->getName().str(), prop));
  }
}

// LLVMのモジュールを仮想マシンにロードする。
void LlvmAsmLoader::load(const llvm::Module* module) {
  /// todo: DataLayout, Tripleのチェック
  print_debug("DataLayout: %s\n", module->getDataLayoutStr().c_str());
  print_debug("Triple: %s\n",     module->getTargetTriple().c_str());
  
  // データレイアウトの取得
  data_layout = module->getDataLayout();
  // 大域変数の読み込み
  for (auto gl = module->global_begin(); gl != module->global_end(); gl ++) {
    /// @todo スレッドローカル、セクション、公開の扱い
    vmachine.set_global_value(gl->getName().str(), load(gl));
  }

  // 関数の読み込み
  for (auto fn = module->begin(); fn != module->end(); fn ++) {
    /// todo: スレッドローカル、セクション、公開の扱い
    vmachine.set_global_value(fn->getName().str(), load(fn));    
  }

  // AliasListは未対応
  if (module->getAliasList().size() != 0) {
    throw_error(Error::UNSUPPORT);
  }
}

// LLVMの大域変数を仮想マシンにロードする。
Value* LlvmAsmLoader::load(const llvm::GlobalVariable* variable) {
  check_same_value(loaded_value, variable);

  if (variable->hasInitializer()) {
    return assign_loaded(variable,
			 vmachine.create_pointer(load(variable->getInitializer()), 0));
  } else {
    assert(false); // あっている？
    return assign_loaded(variable,
			 vmachine.create_null());
  }
}

// LLVMの型を仮想マシンにロードする。
vaddr_t LlvmAsmLoader::load_type(const llvm::Type* type) {
  // 既存の値の場合、それを戻す。
  auto exist = loaded_type.find(type);
  if (exist != loaded_type.end()) {
    return exist->second;
  }

  // 基本方の判定
  BasicType addr;
  switch(type->getTypeID()) {
  // 1:1t対応するもの
  case llvm::Type::VoidTyID:        addr = BasicType::TY_VOID;      break;
  case llvm::Type::FloatTyID:       addr = BasicType::TY_F32;       break;
  case llvm::Type::DoubleTyID:      addr = BasicType::TY_F64;       break;
  case llvm::Type::FunctionTyID:    addr = BasicType::TY_FUNCTION;  break;
  case llvm::Type::PointerTyID:     addr = BasicType::TY_POINTER;   break;

  case llvm::Type::IntegerTyID: {
    // intはサイズごとに切り替え
    switch (type->getIntegerBitWidth()) {
    case 8:     addr = BasicType::TY_I8;    break;
    case 16:    addr = BasicType::TY_I16;   break;
    case 32:    addr = BasicType::TY_I32;   break;
    case 64:    addr = BasicType::TY_I64;   break;
    default:
      throw_error_message(Error::UNSUPPORT,
			  "integer bit-width:" +
			  Util::num2dec_str(type->getIntegerBitWidth()));
      break;
    }
  } break;

  case llvm::Type::StructTyID: {
    // 構造体独自に判定してしまう
    std::vector<vaddr_t> member;
    for (int i = 0, size = type->getStructNumElements(); i < size; i ++) {
      member.push_back(load_type(type->getStructElementType(i)));
    }
    Value value = vmachine.create_type(member);
    loaded_addr_type.insert(std::make_pair(value.get_address(), value));
    return loaded_type.insert(std::make_pair(type, value.get_address())).first->second;
  } break;

  case llvm::Type::ArrayTyID: {
    Value value = vmachine.create_type(load_type(type->getArrayElementType()),
				       type->getArrayNumElements());
    loaded_addr_type.insert(std::make_pair(value.get_address(), value));
    return loaded_type.insert(std::make_pair(type, value.get_address())).first->second;
  } break;

  default:
    throw_error_message(Error::UNSUPPORT, "type:" + Util::num2dec_str(type->getTypeID()));
    break;
  }
  
  // 基本型をvmachineから払い出し、キャッシュに登録
  Value value = vmachine.create_type(addr);
  loaded_addr_type.insert(std::make_pair(value.get_address(), value));
  return loaded_type.insert(std::make_pair(type, value.get_address())).first->second;
}

// 現在解析中の関数の命令配列に命令を追記する。
void LlvmAsmLoader::push_code_AB(FunctionContext& fc, Opcode opcode, int option, int a, int b) {
  fc.code.push_back(Instruction::make_AB(opcode, option, a, b));
  print_debug("push code %02x %02x %08x(%d) %08x(%d)\n", opcode, option, a, a, b, b);
}
