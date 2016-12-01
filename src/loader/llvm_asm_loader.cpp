
#include <llvm/AsmParser/Parser.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/ManagedStatic.h>
#include <llvm/Support/SourceMgr.h>

#include <iostream>
#include <map>
#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "error.hpp"
#include "instruction.hpp"
#include "llvm_asm_loader.hpp"
#include "llvm_util.hpp"
#include "loader_mid.hpp"
#include "logger.hpp"
#include "process.hpp"
#include "util.hpp"

namespace processwarp {

static const BasicOperator* OPERATORS[] = {
  nullptr,      // 0
  nullptr,      // 1 void
  new PointerOperator(),        // 2 pointer
  nullptr,      // 3 function
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
  nullptr,       // 10
  new PrimitiveOperator<uint8_t>(),     // 11 8bit整数型
  new PrimitiveOperator<uint16_t>(),    // 12 16bit整数型
  new PrimitiveOperator<uint32_t>(),    // 13 32bit整数型
  new PrimitiveOperator<uint64_t>(),    // 14 64bit整数型
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
  nullptr,      // 20
  new PrimitiveOperator<int8_t>(),      // 21 8bit整数型
  new PrimitiveOperator<int16_t>(),     // 22 16bit整数型
  new PrimitiveOperator<int32_t>(),     // 23 32bit整数型
  new PrimitiveOperator<int64_t>(),     // 24 64bit整数型
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
  nullptr,      // 30
  nullptr,      // 31
  new PrimitiveOperator<float>(),       // 32 float
  new PrimitiveOperator<double>(),      // 33 double
  nullptr,      // 34
  nullptr,      // 35 quad
};

const BasicOperator* get_operator(vaddr_t type) {
  assert(type < sizeof(OPERATORS) / sizeof(OPERATORS[0]));
  assert(OPERATORS[type] != nullptr);

  return OPERATORS[type];
}

// mapのキーとして格納するので<演算子の動作を定義する。
bool LlvmAsmLoader::ValueDest::operator<(const ValueDest& other) const {
  if (is_k) {
    if (other.is_k) {
      return addr.k < other.addr.k;
    } else {
      return true;
    }
  } else {
    if (other.is_k) {
      return false;
    } else {
      return addr.ptr < other.addr.ptr;
    }
  }
}

// コンストラクタ。
LlvmAsmLoader::LlvmAsmLoader(Process& proc_) :
    context(llvm::getGlobalContext()),
    proc(proc_),
    memory(*proc.proc_memory) {
}

// デストラクタ。
LlvmAsmLoader::~LlvmAsmLoader() {
  llvm::llvm_shutdown();
}

// LLVM-IRファイル(テキスト形式)を読み込んで仮想マシンにロードする。
void LlvmAsmLoader::load_ir_file(const std::string& filename) {
#if LLVM_VERSION_MAJOR == 3 && LLVM_VERSION_MINOR == 5
  llvm::SMDiagnostic error;
  llvm::Module* module = llvm::ParseAssemblyFile(filename, error, context);
  if (module == nullptr)
    throw_error_message(Error::PARSE, error.getMessage().str() + "[" + filename + "]");
  load_module(module);

#else
  // for 3.6
  llvm::SMDiagnostic error;
  std::unique_ptr<llvm::Module> module = llvm::parseAssemblyFile(filename, error, context);
  if (module == nullptr)
    throw_error_message(Error::PARSE, error.getMessage().str() + "[" + filename + "]");
  load_module(module.get());
#endif
}

// LLVM-Bitcodeファイル(バイナリ形式)を読み込んで仮想マシンにロードする。
void LlvmAsmLoader::load_bc_file(const std::string& filename) {
#if LLVM_VERSION_MAJOR == 3 && LLVM_VERSION_MINOR == 5
  llvm::SMDiagnostic error;
  llvm::Module* module = llvm::ParseIRFile(filename, error, context);
  if (module == nullptr)
    throw_error_message(Error::PARSE, error.getMessage().str() + "[" + filename + "]");
  load_module(module);

#else
  // for 3.6
  llvm::SMDiagnostic error;
  std::unique_ptr<llvm::Module> module = llvm::parseIRFile(filename, error, context);
  if (module == nullptr)
    throw_error_message(Error::PARSE, error.getMessage().str() + "[" + filename + "]");
  load_module(module.get());
#endif
}

// ロード済みの値とアドレスの対応関係を登録する。
void LlvmAsmLoader::assign_loaded(FunctionContext& fc, const llvm::Value* v) {
  // グローバル変数として確保されているか確認
  if (map_global.find(v) != map_global.end()) {
    // 登録済LLVM変数が再度登録されることはない
    assert(loaded_global.find(v) == loaded_global.end());
    loaded_global.insert(v);
    return;

  } else {
    assert(false);
  }
}

// LLVMの型に対応するオペランドを取得する。
int LlvmAsmLoader::assign_type(FunctionContext& fc, const llvm::Type* t, bool sign) {
  std::pair<const llvm::Type*, bool> key(t, sign);
  // ローカル定数に割り当てられている場合、そのまま戻す。
  if (fc.loaded_type.find(key) != fc.loaded_type.end()) {
    return fc.loaded_type.at(key);
  }

  // 新規割り当て
  vaddr_t type = load_type(t, sign);
  int k = fc.k.size();
  int align = data_layout->getABIIntegerTypeAlignment(sizeof(vaddr_t) * 8);
  if ((k % align) != 0) {
    k = (k / align + 1) * align;
  }
  fc.loaded_type.insert(std::make_pair(key, -k - 1));
  fc.k.resize(k + sizeof(vaddr_t));
  *reinterpret_cast<vaddr_t*>(&fc.k.at(k)) = type;

  return -k - 1;
}

// LLVMの変数に対応する変数の番号を取得する。
int LlvmAsmLoader::assign_operand(FunctionContext& fc, const llvm::Value* v) {
  // 関数の引数は定数でもローカル変数に積むため、
  // ローカル変数判定を先に行う。
  // 既存のローカル変数の場合、その番号を戻す。
  auto sv_find = fc.stack_value.find(v);
  if (sv_find != fc.stack_value.end()) {
    return sv_find->second;
  }

  // 異なる変数に同一のアドレスを割り当てないように最低1byteを確保する。
  int size = data_layout->getTypeAllocSize(v->getType());
  if (size == 0) size = 1;
  int align = data_layout->getPrefTypeAlignment(v->getType());

  // 割り当てサイズの確認
  assert(data_layout->getTypeStoreSize(v->getType()) <=
         data_layout->getTypeAllocSize(v->getType()));

  if (llvm::Constant::classof(v)) {
    // 既存の定数の場合、その番号を戻す。
    if (fc.loaded_value.find(v) != fc.loaded_value.end()) {
      return fc.loaded_value.at(v);
    }

    // 既存の定数でない場合、末尾に割り当てる。
    int k = fc.k.size();
    // 必要に応じてアライメントを合わせる
    if ((k % align) != 0) {
      k = (k / align + 1) * align;
    }
    ValueDest dst;
    dst.is_k = true;
    dst.addr.k = k;
    fc.k.resize(k + size);
    fc.loaded_value.insert(std::make_pair(v, -k - 1));
    load_constant(fc, dst, static_cast<const llvm::Constant*>(v));

    return -k - 1;

  } else {
    // 既存のローカル変数でない場合、末尾に割り当てている。
    // 必要に応じてアライメントを合わせる
    if ((fc.stack_sum % align) != 0) {
      fc.stack_sum = (fc.stack_sum / align + 1) * align;
    }
    fc.stack_value.insert(std::make_pair(v, fc.stack_sum));
    fc.stack_sum += size;

    return fc.stack_value.find(v)->second;
  }

  return 0;
}

// LLVMの定数をロードした実アドレスを取得する。
LlvmAsmLoader::ValueDest LlvmAsmLoader::get_loaded_ptr(FunctionContext& fc,
                                                       const llvm::Constant* src) {
  ValueDest dest;
  if (map_global.find(src) != map_global.end()) {
    // グローバル変数
    dest.is_k = false;
    dest.addr.ptr = memory.read_writable(map_global.at(src));

  } else {
    // ローカル定数
    int k = assign_operand(fc, src);
    assert(k < 0);  // 正の場合、変数なのでアドレスを確定できない。
    dest.is_k = true;
    dest.addr.k = -k - 1;
  }
  return dest;
}

// 値の格納先ValueDestから実際の格納位置のポインタを取得する。
uint8_t* LlvmAsmLoader::get_ptr_by_dest(FunctionContext& fc, ValueDest dst) {
  if (dst.is_k) {
    return &fc.k.at(dst.addr.k);
  } else {
    return dst.addr.ptr;
  }
}

// LLVMの定数(配列)を仮想マシンにロードする。
void LlvmAsmLoader::load_array(FunctionContext& fc, ValueDest dst, const llvm::ConstantArray* src) {
  // Typeの要素数とOperandsの要素数は同じはず
  assert(src->getType()->getNumElements() == src->getNumOperands());

  // 書き込み
  int one_size = data_layout->getTypeAllocSize(src->getType()->getElementType());
  for (unsigned int i = 0; i < src->getNumOperands(); i ++) {
    load_constant(fc, relocate_dest(dst, i * one_size), src->getOperand(i));
  }
}

// LLVMの定数(BlockAddress)を仮想マシンにロードする。
void LlvmAsmLoader::load_block(FunctionContext& fc, ValueDest dst, const llvm::BlockAddress* src) {
  // アドレスが未定なので格納場所を記録するだけ。
  block_addrs.insert(std::make_pair(dst, std::make_pair(src->getFunction(), src->getBasicBlock())));
}

// LLVMの定数を仮想マシンにロードする。
void LlvmAsmLoader::load_constant(FunctionContext& fc, ValueDest dst, const llvm::Constant* src) {
  // 値の型に合わせて分岐
  switch (src->getValueID()) {
    // case llvm::Value::ArgumentVal: {} break;
    // case llvm::Value::BasicBlockVal: {} break;
    case llvm::Value::FunctionVal: {
      const llvm::Function* func = static_cast<const llvm::Function*>(src);
      // まだ確保されていない関数
      if (map_func.find(func) == map_func.end()) {
        vaddr_t addr = memory.reserve_program_area();
        map_func.insert(std::make_pair(func, addr));
        left_func.insert(func);
      }
      *reinterpret_cast<vaddr_t*>(get_ptr_by_dest(fc, dst)) = map_func.at(func);
    } return;

      // case llvm::Value::GlobalAliasVal: {} break;
    case llvm::Value::GlobalVariableVal: {
      assert(map_global.find(src) != map_global.end());
      *reinterpret_cast<vaddr_t*>(get_ptr_by_dest(fc, dst)) =
          map_global.at(src);
    } break;

    case llvm::Value::UndefValueVal: {
      // 値が不定なので初期化を行わない
    } break;

    case llvm::Value::BlockAddressVal: {
      load_block(fc, dst, static_cast<const llvm::BlockAddress*>(src));
    } break;

    case llvm::Value::ConstantExprVal: {
      load_expr(fc, dst, static_cast<const llvm::ConstantExpr*>(src));
    } break;

    case llvm::Value::ConstantAggregateZeroVal: {
      load_zero(fc, dst, static_cast<const llvm::ConstantAggregateZero*>(src));
    } break;

    case llvm::Value::ConstantDataArrayVal:
    case llvm::Value::ConstantDataVectorVal: {
      load_data(fc, dst, static_cast<const llvm::ConstantDataSequential*>(src));
    } break;

    case llvm::Value::ConstantIntVal: {
      load_int(fc, dst, static_cast<const llvm::ConstantInt*>(src));
    } break;

    case llvm::Value::ConstantFPVal: {
      load_float(fc, dst, static_cast<const llvm::ConstantFP*>(src));
    } break;

    case llvm::Value::ConstantArrayVal: {
      load_array(fc, dst, static_cast<const llvm::ConstantArray*>(src));
    } break;

    case llvm::Value::ConstantStructVal: {
      load_struct(fc, dst, static_cast<const llvm::ConstantStruct*>(src));
    } break;

    case llvm::Value::ConstantVectorVal: {
      load_vector(fc, dst, static_cast<const llvm::ConstantVector*>(src));
    } break;

    case llvm::Value::ConstantPointerNullVal: {
      *reinterpret_cast<vaddr_t*>(get_ptr_by_dest(fc, dst)) = VADDR_NULL;
    } break;

      // case llvm::Value::MDNodeVal: {} break;
      // case llvm::Value::MDStringVal: {} break;
      // case llvm::Value::InlineAsmVal: {} break;
      // case llvm::Value::InstructionVal: {} break;
    default: {
      Logger::err(LoaderMid::L2006, "type", std::to_string(src->getValueID()).c_str());
      src->dump();
      throw_error(Error::UNSUPPORT);
    } break;
  }
}

// LLVMの定数(DataArray)を仮想マシンにロードする。
void LlvmAsmLoader::load_data(FunctionContext& fc, ValueDest dst,
                              const llvm::ConstantDataSequential* src) {
  memcpy(get_ptr_by_dest(fc, dst), src->getRawDataValues().data(),
         data_layout->getTypeAllocSize(src->getType()));
}

// LLVMの定数(Expr)を仮想マシンにロードする。
void LlvmAsmLoader::load_expr(FunctionContext& fc, ValueDest dst,
                              const llvm::ConstantExpr* src) {
  switch (src->getOpcode()) {
    /**
     * ConstantExprのうち、型キャストを行う
     * @param INS 命令
     * @param DSI キャスト先の型が符号ありの場合true
     * @param SSI キャスト元の型が符号ありの場合true
     */
#define M_LOAD_EXPR_CONV(INS, DSI, SSI)                                 \
    case llvm::Instruction::INS: {                                      \
      assert(src->getNumOperands() == 1);                               \
      vaddr_t dst_type = load_type(src->getType(), DSI);                \
      vaddr_t src_type = load_type(src->getOperand(0)->getType(), SSI); \
      const BasicOperator* src_op = get_operator(src_type);             \
      src_op->type_cast(get_ptr_by_dest(fc, dst), dst_type,             \
                        get_ptr_by_dest(fc, get_loaded_ptr(fc, src)));  \
    } break;

    M_LOAD_EXPR_CONV(Trunc, false, false);
    M_LOAD_EXPR_CONV(ZExt, false, false);
    M_LOAD_EXPR_CONV(SExt, true, false);
    M_LOAD_EXPR_CONV(FPTrunc, false, false);
    M_LOAD_EXPR_CONV(FPExt, false, false);
    M_LOAD_EXPR_CONV(UIToFP, false, false);
    M_LOAD_EXPR_CONV(SIToFP, false, true);
    M_LOAD_EXPR_CONV(FPToUI, false, false);
    M_LOAD_EXPR_CONV(FPToSI, true, false);
    M_LOAD_EXPR_CONV(PtrToInt, false, false);
    M_LOAD_EXPR_CONV(IntToPtr, false, false);
#undef M_LOAD_EXPR_CONV

    case llvm::Instruction::BitCast: {
      // 変換先を0埋め
      unsigned int alloc_size = data_layout->getTypeAllocSize(src->getType());
      std::memset(get_ptr_by_dest(fc, dst), 0, alloc_size);
      // 変換元の定数を読み込む
      assert(assign_operand(fc, src->getOperand(0)) < 0);
      uint8_t* src_ptr =
          fc.k.data() - assign_operand(fc, src->getOperand(0)) - 1;
      size_t size =
          data_layout->getTypeAllocSize(src->getOperand(0)->getType());
      if (size > data_layout->getTypeAllocSize(src->getType())) {
        size = data_layout->getTypeAllocSize(src->getType());
      }

      // データをそのままコピー
      std::memcpy(get_ptr_by_dest(fc, dst), src_ptr, size);
    } break;

      // case llvm::Instruction::AddrSpaceCast: {} break; //CastOps
      // case llvm::Instruction::Select: {} break; //Select
      // case llvm::Instruction::InsertElement: {} break; // InsertElement
      // case llvm::Instruction::ExtractElement: {} break; // ExtractElement
      // case llvm::Instruction::InsertValue: {} break; // InsertValue
      // case llvm::Instruction::ExtractValue: {} break; // ExtractValue
      // case llvm::Instruction::ShuffleVector: {} break; // ShuffleVector

    case llvm::Instruction::GetElementPtr: {
      const llvm::Value* tv = src->getOperand(0);
      assert(llvm::Constant::classof(tv));  // オペランドは定数のはず。
      // ポインタのアドレスを取得。
      /* vaddr_t target_value =
         load_constant(static_cast<const llvm::Constant*>(tv)); */
      assert(map_global.find(tv) != map_global.end());
      vaddr_t target_value = map_global.at(tv);
      llvm::Type* op_type = tv->getType()->getPointerElementType();
      assert(op_type->isSized());  // サイズが確定可能と想定
      int delta = 0;
      unsigned int num_operands = src->getNumOperands();
      for (unsigned int i = 1; i < num_operands; i ++) {
        // 2つ目以降のオペランドは数値のはず。
        assert(llvm::ConstantInt::classof(src->getOperand(i)));
        const llvm::ConstantInt* op =
            static_cast<const llvm::ConstantInt*>(src->getOperand(i));
        assert(data_layout->getTypeStoreSize(op_type) <=
               data_layout->getTypeAllocSize(op_type));

        if (i == 1) {
          // 先頭の番号は最初のポインタを基準としたアドレスの計算
          delta += (uint32_t)data_layout->getTypeAllocSize(op_type) * op->getSExtValue();

        } else if (llvm::SequentialType::classof(op_type)) {
          // pointer, array, vectorの場合、中身の型を見る。
          op_type = static_cast<const llvm::SequentialType*>(op_type)->getElementType();
          delta += (uint32_t)data_layout->getTypeAllocSize(op_type) * op->getSExtValue();

        } else if (llvm::StructType::classof(op_type)) {
          // 構造体型の中身を見る。
          unsigned int j = 0;
          for (j = 0; j < op->getZExtValue(); j ++) {
            llvm::Type* in_type = static_cast<const llvm::StructType*>(op_type)->getElementType(j);
            delta += (uint32_t)data_layout->getTypeAllocSize(in_type);
          }
          op_type = static_cast<const llvm::StructType*>(op_type)->getElementType(j);

        } else {
          assert(false);
        }
      }
      /// @todo 範囲チェック
      *reinterpret_cast<vaddr_t*>(get_ptr_by_dest(fc, dst)) = target_value + delta;
    } break;

    case llvm::Instruction::ICmp:
    case llvm::Instruction::FCmp: {
      switch (src->getPredicate()) {
#define M_CCMP_OPERATOR1(PRE, SI, OP, FOP, SOP)                         \
        case llvm::PRE: {                                               \
          vaddr_t op_type = load_type(src->getOperand(0)->getType(), SI); \
          const BasicOperator* op = get_operator(op_type);              \
          op->OP(get_ptr_by_dest(fc, dst),                              \
                 get_ptr_by_dest(fc, get_loaded_ptr(fc, src->getOperand(FOP))), \
                 get_ptr_by_dest(fc, get_loaded_ptr(fc, src->getOperand(SOP)))); \
        } break;

        case llvm::FCmpInst::FCMP_FALSE: {
          *get_ptr_by_dest(fc, dst) = 0x00;
        } break;

          M_CCMP_OPERATOR1(FCmpInst::FCMP_OEQ, false, op_equal, 0, 1);
          M_CCMP_OPERATOR1(FCmpInst::FCMP_OGT, false, op_greater, 0, 1);
          M_CCMP_OPERATOR1(FCmpInst::FCMP_OGE, false, op_greater_equal, 0, 1);
          M_CCMP_OPERATOR1(FCmpInst::FCMP_OLT, false, op_greater, 1, 0);
          M_CCMP_OPERATOR1(FCmpInst::FCMP_OLE, false, op_greater_equal, 1, 0);
          M_CCMP_OPERATOR1(FCmpInst::FCMP_ONE, false, op_not_equal, 0, 1);
          M_CCMP_OPERATOR1(FCmpInst::FCMP_ORD, false, op_not_nans, 0, 1);

          // FCmpInst::FCMP_UNO
          // FCmpInst::FCMP_UEQ
          // FCmpInst::FCMP_UGT
          // FCmpInst::FCMP_UGE
          // FCmpInst::FCMP_ULT
          // FCmpInst::FCMP_ULE
          // FCmpInst::FCMP_UNE
        case llvm::FCmpInst::FCMP_TRUE: {
          *get_ptr_by_dest(fc, dst) = I8_TRUE;
        } break;

          M_CCMP_OPERATOR1(ICmpInst::ICMP_EQ, false, op_equal, 0, 1);
          M_CCMP_OPERATOR1(ICmpInst::ICMP_NE, false, op_not_equal, 0, 1);
          M_CCMP_OPERATOR1(ICmpInst::ICMP_SGT, true, op_greater, 0, 1);
          M_CCMP_OPERATOR1(ICmpInst::ICMP_SGE, true, op_greater_equal, 0, 1);
          M_CCMP_OPERATOR1(ICmpInst::ICMP_SLT, true, op_greater, 1, 0);
          M_CCMP_OPERATOR1(ICmpInst::ICMP_SLE, true, op_greater_equal, 1, 0);
          M_CCMP_OPERATOR1(ICmpInst::ICMP_UGT, false, op_greater, 0, 1);
          M_CCMP_OPERATOR1(ICmpInst::ICMP_UGE, false, op_greater_equal, 0, 1);
          M_CCMP_OPERATOR1(ICmpInst::ICMP_ULT, false, op_greater, 1, 0);
          M_CCMP_OPERATOR1(ICmpInst::ICMP_ULE, false, op_greater_equal, 1, 0);
        default: {
          print_llvm_instruction();
          assert(false);
        } break;

#undef M_CCMP_OPERATOR1
      }
    } break;

      //

    default: {
      print_llvm_instruction();
      Logger::err(LoaderMid::L2006, "expr", src->getOpcodeName());
      throw_error(Error::UNSUPPORT);
    } break;
  }
}

// LLVMの定数(Floating-point)を仮想マシンにロードする。
void LlvmAsmLoader::load_float(FunctionContext& fc, ValueDest dst, const llvm::ConstantFP* src) {
  switch (src->getType()->getTypeID()) {
    case llvm::Type::FloatTyID: {
      *reinterpret_cast<float*>(get_ptr_by_dest(fc, dst)) = src->getValueAPF().convertToFloat();
    } break;

    case llvm::Type::DoubleTyID: {
      *reinterpret_cast<double*>(get_ptr_by_dest(fc, dst)) = src->getValueAPF().convertToDouble();
    } break;

    default: {
      Logger::err(LoaderMid::L2006, "type", std::to_string(src->getValueID()).c_str());
      src->dump();
      throw_error(Error::UNSUPPORT);
    } break;
  }
}

// LLVMの関数を仮想マシンにロードする。
void LlvmAsmLoader::load_function(const llvm::Function* function) {
  if (function->isDeclaration()) {
    // VM組み込み関数/ライブラリなど外部の関数
    // 名前を持つはず
    assert(function->hasName());

    vaddr_t addr = map_func.at(function);
    FuncStore::alloc_external(memory, addr,
                              proc.symbols.get(function->getName()),
                              load_type(function->getReturnType(), false),
                              function->arg_size(), function->isVarArg());
    left_func.erase(function);

  } else {
    // 通常の関数(VMで解釈、実行する)
    FuncStore::NormalProp prop;

    // 定数
    std::vector<uint8_t> k;
    // 定数の最初に0x0(false)と0x1(true)をロードできるように確保しておく
    k.push_back(I8_FALSE);
    k.push_back(I8_TRUE);
    // 変数
    std::map<const llvm::Value*, int> stack_values;

    // ブロックとそれに割り当てる名前
    std::map<const llvm::BasicBlock*, unsigned int> block_alias;
    // ブロック名とそれの開始位置
    std::map<unsigned int, unsigned int> block_start;

    FunctionContext fc = {prop.code, k, stack_values, 0, block_alias,
                          std::map<const llvm::Value*, int>(),
                          std::map<std::pair<const llvm::Type*, bool>, int>()};

    // 引数を変数の先頭に登録
    for (auto& arg : function->getArgumentList()) {
      stack_values.insert(std::make_pair(&arg, fc.stack_sum));

      assert(data_layout->getTypeStoreSize(arg.getType()) <=
             data_layout->getTypeAllocSize(arg.getType()));
      fc.stack_sum += data_layout->getTypeAllocSize(arg.getType());
    }

    // ブロックの名称を最初に作っておく
    unsigned int alias = 0;
    for (auto& b : *function) {
      block_alias.insert(std::make_pair(&b, alias ++));
    }

    for (auto& block : *function) {
      // ブロックの開始位置を格納しておく
      block_start.insert(std::make_pair(block_alias.at(&block), fc.code.size()));
      std::pair<const llvm::Function*, const llvm::BasicBlock*> func_info =
        std::make_pair(function, &block);
      block_addrs_start.insert(std::make_pair(func_info, fc.code.size()));

      // 命令を解析する
      for (auto& i : block) {
        save_llvm_instruction(&i);  // デバッグ用に命令を保存
        // LLVMに対応した命令に置き換え
        switch (i.getOpcode()) {
          case llvm::Instruction::Ret: {
            const llvm::ReturnInst& inst = static_cast<const llvm::ReturnInst&>(i);
            convert_inst_ret(fc, inst);
          } break;

          case llvm::Instruction::Call: {
            const llvm::CallInst& inst = static_cast<const llvm::CallInst&>(i);
            convert_inst_call(fc, inst);
          } break;

          case llvm::Instruction::Br: {
            const llvm::BranchInst& inst = static_cast<const llvm::BranchInst&>(i);
            convert_inst_br(fc, inst);
          } break;

          case llvm::Instruction::Switch: {
            const llvm::SwitchInst& inst = static_cast<const llvm::SwitchInst&>(i);
            convert_inst_switch(fc, inst);
          } break;

          case llvm::Instruction::IndirectBr: {
            const llvm::IndirectBrInst& inst = static_cast<const llvm::IndirectBrInst&>(i);
            convert_inst_indirectbr(fc, inst);
          } break;

          case llvm::Instruction::Invoke: {
            const llvm::InvokeInst& inst = static_cast<const llvm::InvokeInst&>(i);
            convert_inst_invoke(fc, inst);
          } break;

          case llvm::Instruction::Unreachable: {
            /* Unreachableはコンパイラの最適化のためだけにあるので、
               何も実行しなくて良い。*/
          } break;

          case llvm::Instruction::PHI: {
            const llvm::PHINode& inst = static_cast<const llvm::PHINode&>(i);
            convert_inst_phi(fc, inst);
          } break;

            /**
             * 加減乗除などの２項演算子命令作成マクロ
             * @param opcode オペコード
             * @param sign 符号考慮の場合true
             */
#define M_BIN_OPERATOR(opcode, sign)                                    \
            const llvm::BinaryOperator& inst = static_cast<const llvm::BinaryOperator&>(i); \
            assert(inst.getNumOperands() == 2);                         \
            /* set_type <ty> */                                         \
            push_code(fc, Opcode::SET_TYPE, assign_type(fc, inst.getType(), sign)); \
            /* set_output <result> */                                   \
            push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst)); \
            /* set_value <op1> */                                       \
            push_code(fc, Opcode::SET_VALUE, assign_operand(fc, inst.getOperand(0))); \
            /* opcode <op2> */                                          \
            push_code(fc, (opcode), assign_operand(fc, inst.getOperand(1)))

          case llvm::Instruction::Add:
          case llvm::Instruction::FAdd: {
            // add命令は符号考慮バージョンのみ
            M_BIN_OPERATOR(Opcode::ADD, true);
          } break;

          case llvm::Instruction::Sub:
          case llvm::Instruction::FSub: {
            // sub命令は符号考慮バージョンのみ
            M_BIN_OPERATOR(Opcode::SUB, true);
          } break;

          case llvm::Instruction::Mul:
          case llvm::Instruction::FMul: {
            // mul命令は符号考慮バージョンのみ
            M_BIN_OPERATOR(Opcode::MUL, true);
          } break;

          case llvm::Instruction::UDiv: {
            // 符号考慮なしのdiv
            M_BIN_OPERATOR(Opcode::DIV, false);
          } break;

          case llvm::Instruction::SDiv:
          case llvm::Instruction::FDiv: {
            // 符号考慮ありのdiv
            M_BIN_OPERATOR(Opcode::DIV, true);
          } break;

          case llvm::Instruction::URem: {
            // 符号考慮なしのrem
            M_BIN_OPERATOR(Opcode::REM, false);
          } break;

          case llvm::Instruction::SRem:
          case llvm::Instruction::FRem: {
            // 符号考慮ありのrem
            M_BIN_OPERATOR(Opcode::REM, true);
          } break;

          case llvm::Instruction::Shl: {
            // 左リシフトは符号に関係ないので考慮バージョンのみ実装
            M_BIN_OPERATOR(Opcode::SHL, true);
          } break;

          case llvm::Instruction::LShr: {
            // 符号考慮なし右シフト
            M_BIN_OPERATOR(Opcode::SHR, false);
          } break;

          case llvm::Instruction::AShr: {
            // 符号考慮あり右シフト
            M_BIN_OPERATOR(Opcode::SHR, true);
          } break;

          case llvm::Instruction::And: {
            // andは符号考慮バージョンのみ
            M_BIN_OPERATOR(Opcode::AND, true);
          } break;

          case llvm::Instruction::Or: {
            // orは符号考慮バージョンのみ
            M_BIN_OPERATOR(Opcode::OR, true);
          } break;

          case llvm::Instruction::Xor: {
            // xorは符号考慮バージョンのみ
            M_BIN_OPERATOR(Opcode::XOR, true);
          } break;

#undef M_BIN_OPERATOR

          case llvm::Instruction::ExtractElement: {
            const llvm::ExtractElementInst& inst = static_cast<const llvm::ExtractElementInst&>(i);
            convert_inst_extract_element(fc, inst);
          } break;

          case llvm::Instruction::InsertElement: {
            const llvm::InsertElementInst& inst = static_cast<const llvm::InsertElementInst&>(i);
            convert_inst_insert_element(fc, inst);
          } break;

          case llvm::Instruction::ShuffleVector: {
            const llvm::ShuffleVectorInst& inst = static_cast<const llvm::ShuffleVectorInst&>(i);
            convert_inst_shuffle_vector(fc, inst);
          } break;

          case llvm::Instruction::ExtractValue: {
            const llvm::ExtractValueInst& inst = static_cast<const llvm::ExtractValueInst&>(i);
            convert_inst_extract_value(fc, inst);
          } break;

          case llvm::Instruction::InsertValue: {
            const llvm::InsertValueInst& inst = static_cast<const llvm::InsertValueInst&>(i);
            convert_inst_insert_value(fc, inst);
          } break;

          case llvm::Instruction::Alloca: {
            const llvm::AllocaInst& inst = static_cast<const llvm::AllocaInst&>(i);
            convert_inst_alloca(fc, inst);
          } break;

          case llvm::Instruction::Load: {
            const llvm::LoadInst& inst = static_cast<const llvm::LoadInst&>(i);
            convert_inst_load(fc, inst);
          } break;

          case llvm::Instruction::Store: {
            const llvm::StoreInst& inst = static_cast<const llvm::StoreInst&>(i);
            convert_inst_store(fc, inst);
          } break;

          case llvm::Instruction::AtomicCmpXchg: {
            const llvm::AtomicCmpXchgInst& inst = static_cast<const llvm::AtomicCmpXchgInst&>(i);
            convert_inst_atomic_cmp_xchg(fc, inst);
          } break;

          case llvm::Instruction::AtomicRMW: {
            const llvm::AtomicRMWInst& inst = static_cast<const llvm::AtomicRMWInst&>(i);
            convert_inst_rmw(fc, inst);
          } break;

          case llvm::Instruction::GetElementPtr: {
            const llvm::GetElementPtrInst& inst = static_cast<const llvm::GetElementPtrInst&>(i);
            convert_inst_get_element_ptr(fc, inst);
          } break;

          case llvm::Instruction::Trunc:
          case llvm::Instruction::ZExt:
          case llvm::Instruction::FPTrunc:
          case llvm::Instruction::FPExt:
          case llvm::Instruction::FPToUI:
          case llvm::Instruction::UIToFP:
          case llvm::Instruction::PtrToInt:
          case llvm::Instruction::IntToPtr: {
            const llvm::CastInst& inst = static_cast<const llvm::CastInst&>(i);
            convert_inst_cast(fc, inst);
          } break;

          case llvm::Instruction::SExt:
          case llvm::Instruction::FPToSI:
          case llvm::Instruction::SIToFP: {
            const llvm::SExtInst& inst = static_cast<const llvm::SExtInst&>(i);
            convert_inst_sext(fc, inst);
          } break;

          case llvm::Instruction::BitCast: {
            const llvm::BitCastInst& inst = static_cast<const llvm::BitCastInst&>(i);
            convert_inst_bit_cast(fc, inst);
          } break;

          case llvm::Instruction::ICmp: {
            const llvm::ICmpInst& inst = static_cast<const llvm::ICmpInst&>(i);
            convert_inst_icmp(fc, inst);
          } break;

          case llvm::Instruction::FCmp: {
            const llvm::FCmpInst& inst = static_cast<const llvm::FCmpInst&>(i);
            convert_inst_fcmp(fc, inst);
          } break;

          case llvm::Instruction::Select: {
            const llvm::SelectInst& inst = static_cast<const llvm::SelectInst&>(i);
            convert_inst_select(fc, inst);
          } break;

          default: {
            Logger::err(LoaderMid::L2006, "instruction", i.getOpcodeName());
            throw_error_message(Error::UNSUPPORT,
                                "instruction:" +
                                Util::num2dec_str(i.getOpcode()));
          } break;
        }
      }
    }

    // TEST/JUMP命令のジャンプ先をラベルから開始位置に書き換える
    for (unsigned int pc = 0, size = fc.code.size(); pc < size; pc ++) {
      instruction_t code = fc.code.at(pc);

      switch (Instruction::get_opcode(code)) {
#define M_REPLACE_LABEL(code_at)                                        \
        {                                                               \
          instruction_t& target = fc.code.at(code_at);                  \
          instruction_t label   = Instruction::get_operand(target);     \
          if (label != OperandMask::FILL) {                                  \
            target = Instruction::rewrite_operand(target, block_start.at(label)); \
          }                                                             \
        }

        case Opcode::CALL: {
          M_REPLACE_LABEL(pc + 1);
          M_REPLACE_LABEL(pc + 2);
          pc += 2;
        } break;

        case Opcode::TEST: {
          M_REPLACE_LABEL(pc + 1);
          pc += 1;
        } break;

        case Opcode::TEST_EQ: {
          M_REPLACE_LABEL(pc + 1);
          pc += 1;
        } break;

        case Opcode::JUMP: {
          M_REPLACE_LABEL(pc);
        } break;

        case Opcode::PHI: {
          if (Instruction::get_opcode(fc.code.at(pc + 1)) == Opcode::EXTRA) {
            M_REPLACE_LABEL(pc + 1);
            pc += 1;
          }
          while (Instruction::get_opcode(fc.code.at(pc + 1)) == Opcode::EXTRA &&
                 Instruction::get_opcode(fc.code.at(pc + 2)) == Opcode::EXTRA) {
            M_REPLACE_LABEL(pc + 2);
            pc += 2;
          }
        } break;
#undef M_REPLACE_LABEL
      }
    }

    prop.stack_size = fc.stack_sum;
    // 定数領域を作成
    prop.k = memory.alloc(k.size());
    memory.write_copy(prop.k, k.data(), k.size());

    // 定数、変数の数がオペランドで表現可能な上限を超えた場合エラー
    if (stack_values.size() > ((OperandMask::FILL >> 1) - 1) ||
        k.size() > ((OperandMask::FILL >> 1) - 1)) {
      throw_error_message(Error::TOO_MANY_VALUE, function->getName().str());
    }

    vaddr_t addr = map_func.at(function);
    FuncStore::alloc_normal(memory, addr,
                            proc.symbols.get(function->getName().str()),
                            load_type(function->getReturnType(), false),
                            function->arg_size(), function->isVarArg(), prop);
    left_func.erase(function);
  }
}

// LLVMの大域変数を仮想マシンにロードする。
void LlvmAsmLoader::load_globals
(const llvm::Module::GlobalListType& variables) {
  // 実際の値をロードする前に割当先アドレスを決定する。
  // 定数の合計サイズを計算する
  vaddr_t sum = 0;
  for (auto& gl : variables) {
    // 異なる変数に同一のアドレスを割り当てないように最低1byteを確保する。
    size_t size = data_layout->getTypeAllocSize(gl.getType()->getElementType());
    if (size == 0) size = 1;

    // 割り当てサイズの確認
    assert(data_layout->getTypeStoreSize(gl.getType()->getElementType()) <=
           data_layout->getTypeAllocSize(gl.getType()->getElementType()));

    if (gl.isConstant()) {
      // 定数の場合、仮のアドレスを割り当てる
      map_global.insert(std::make_pair(&gl, sum));
      sum += size;

    } else {
      // 変数の場合、それぞれのアドレスを確保する
      vaddr_t new_addr = memory.alloc(size);
      map_global.insert(std::make_pair(&gl, new_addr));
    }
  }

  // 定数領域を割り当て
  if (map_global.size() != 0) {
    vaddr_t global_addr = VADDR_NULL;
    if (sum != 0) {
      global_addr = memory.alloc(sum);
    }
    // 割り当てたアドレスを元に仮のアドレスから実際のアドレスに変更する
    for (auto& it : map_global) {
      if (static_cast<const llvm::GlobalVariable*>(it.first)->isConstant()) {
        assert(global_addr != VADDR_NULL);
        it.second += global_addr;
      }
    }
  }

  // 読み込み用にダミーの格納先を作成
  FuncStore::NormalProp prop;
  std::vector<uint8_t> k;
  std::map<const llvm::Value*, int> stack_values;
  std::map<const llvm::BasicBlock*, unsigned int> block_alias;
  FunctionContext fc = {prop.code, k, stack_values, 0, block_alias,
                        std::map<const llvm::Value*, int>(),
                        std::map<std::pair<const llvm::Type*, bool>, int>()};
  // 初期値がある場合は値をロードする
  for (auto& it : map_global) {
    const llvm::GlobalVariable* gl =
        static_cast<const llvm::GlobalVariable*>(it.first);
    if (gl->hasInitializer()) {
      ValueDest dst;
      dst.is_k = false;
      dst.addr.ptr = memory.read_writable(it.second);
      load_constant(fc, dst, gl->getInitializer());
    }
  }
}

// LLVMの定数(Int)を仮想マシンにロードする。
void LlvmAsmLoader::load_int(FunctionContext& fc, ValueDest dst,
                             const llvm::ConstantInt* src) {
  if (src->getBitWidth() <= 0 || 512 < src->getBitWidth()) {
    Logger::err(LoaderMid::L2006, "bitwidth",
                Convert::int2str(src->getBitWidth()).c_str());
    throw_error(Error::UNSUPPORT);
  }

  memcpy(get_ptr_by_dest(fc, dst), src->getValue().getRawData(),
         ((src->getBitWidth() - 1) / 8) + 1);
}

// LLVMのモジュールを仮想マシンにロードする。
void LlvmAsmLoader::load_module(llvm::Module* module) {
  /// @todo DataLayout, Tripleのチェック

  // データレイアウトの取得
#if LLVM_VERSION_MAJOR == 3 && LLVM_VERSION_MINOR <= 6
  data_layout = module->getDataLayout();
#else  // llvm ver 3.7~
  data_layout = &module->getDataLayout();
#endif
  // 大域変数の読み込み
  load_globals(module->getGlobalList());

  // 関数のアドレスを予約しておく
  for (auto& fn : *module) {
    vaddr_t addr = memory.reserve_program_area();
    map_func.insert(std::make_pair(&fn, addr));
    left_func.insert(&fn);
    /// @todo: スレッドローカル、セクション、公開の扱い
    proc.set_global_value(fn.getName().str(), addr);
  }

  // 関数の読み込み
  while (!left_func.empty()) {
    load_function(*left_func.begin());
  }

  // AliasListは未対応
  if (module->getAliasList().size() != 0) {
    throw_error(Error::UNSUPPORT);
  }

  // BlockAddressの書き出し
  for (auto it : block_addrs) {
    if (it.first.is_k) {
      vaddr_t func_addr = map_func.at(it.second.first);
      std::unique_ptr<FuncStore> func =
          FuncStore::read(proc, *proc.proc_memory, func_addr);
      memory.write<vaddr_t>
          (func->normal_prop.k + it.first.addr.k,
           static_cast<vaddr_t>(block_addrs_start.at(it.second)));

    } else {
      *reinterpret_cast<vaddr_t*>(it.first.addr.ptr) =
          static_cast<vaddr_t>(block_addrs_start.at(it.second));
    }
  }
}

// LLVMの定数(struct)を仮想マシンにロードする。
void LlvmAsmLoader::load_struct(FunctionContext& fc, ValueDest dst,
                                const llvm::ConstantStruct* src) {
  // Typeの要素数とOperandsの要素数は同じはず
  assert(src->getType()->getNumElements() == src->getNumOperands());

  // 書き込み
  int sum_size = 0;
  for (unsigned int i = 0; i < src->getNumOperands(); i ++) {
    int one_size = data_layout->getTypeAllocSize(src->getOperand(i)->getType());
    load_constant(fc, relocate_dest(dst, sum_size), src->getOperand(i));
    sum_size += one_size;
  }
}

// LLVMの型を仮想マシンにロードする。
vaddr_t LlvmAsmLoader::load_type(const llvm::Type* type, bool sign) {
  std::pair<const llvm::Type*, bool> key(type, sign);
  // 既存の値の場合、それを戻す。
  auto exist = loaded_type.find(key);
  if (exist != loaded_type.end()) {
    return exist->second;
  }

  // 基本型の判定
  vaddr_t addr;
  switch (type->getTypeID()) {
    // 1:1t対応するもの
    case llvm::Type::VoidTyID:        addr = BasicTypeAddress::VOID;      break;
    case llvm::Type::FloatTyID:       addr = BasicTypeAddress::F32;       break;
    case llvm::Type::DoubleTyID:      addr = BasicTypeAddress::F64;       break;
    case llvm::Type::FunctionTyID:    addr = BasicTypeAddress::FUNCTION;  break;
    case llvm::Type::PointerTyID:     addr = BasicTypeAddress::POINTER;   break;

    case llvm::Type::IntegerTyID: {
      // intはサイズごとに切り替え
      if (sign) {
        if (type->getIntegerBitWidth() <= 8) {
          addr = BasicTypeAddress::SI8;
        } else if (type->getIntegerBitWidth() <= 16) {
          addr = BasicTypeAddress::SI16;
        } else if (type->getIntegerBitWidth() <= 32) {
          addr = BasicTypeAddress::SI32;
        } else if (type->getIntegerBitWidth() <= 64) {
          addr = BasicTypeAddress::SI64;
        } else if (type->getIntegerBitWidth() <= 128) {
          addr = BasicTypeAddress::SI128;
        } else if (type->getIntegerBitWidth() <= 256) {
          addr = BasicTypeAddress::SI256;
        } else if (type->getIntegerBitWidth() <= 512) {
          addr = BasicTypeAddress::SI512;
        } else {
          throw_error_message(Error::UNSUPPORT,
                              "integer bit-width:" +
                              Util::num2dec_str(type->getIntegerBitWidth()));
        }
      } else {
        if (type->getIntegerBitWidth() <= 8) {
          addr = BasicTypeAddress::UI8;
        } else if (type->getIntegerBitWidth() <= 16) {
          addr = BasicTypeAddress::UI16;
        } else if (type->getIntegerBitWidth() <= 32) {
          addr = BasicTypeAddress::UI32;
        } else if (type->getIntegerBitWidth() <= 64) {
          addr = BasicTypeAddress::UI64;
        } else if (type->getIntegerBitWidth() <= 128) {
          addr = BasicTypeAddress::UI128;
        } else if (type->getIntegerBitWidth() <= 256) {
          addr = BasicTypeAddress::UI256;
        } else if (type->getIntegerBitWidth() <= 512) {
          addr = BasicTypeAddress::UI512;
        } else {
          throw_error_message(Error::UNSUPPORT,
                              "integer bit-width:" +
                              Util::num2dec_str(type->getIntegerBitWidth()));
        }
      }
    } break;

    case llvm::Type::StructTyID: {
      // 構造体独自に判定してしまう
      std::vector<vaddr_t> member;
      for (int i = 0, size = type->getStructNumElements(); i < size; i ++) {
        member.push_back(load_type(type->getStructElementType(i), false));
      }
      vaddr_t addr = TypeStore::alloc_struct(memory, member);
      std::unique_ptr<TypeStore> store = TypeStore::read(memory, addr);
      loaded_type.insert(std::make_pair(key, addr));
      return addr;
    } break;

    case llvm::Type::ArrayTyID: {
      vaddr_t addr =
          TypeStore::alloc_array(memory,
                                 load_type(type->getArrayElementType(), false),
                                 type->getArrayNumElements());
      std::unique_ptr<TypeStore> store = TypeStore::read(memory, addr);
      loaded_type.insert(std::make_pair(key, addr));
      return addr;
    } break;

    case llvm::Type::VectorTyID: {
      /// @todo canceling vector type.
      assert(false);
      vaddr_t addr =
          TypeStore::alloc_vector(memory,
                                  load_type(type->getVectorElementType(),
                                            false),
                                  type->getVectorNumElements());
      std::unique_ptr<TypeStore> store = TypeStore::read(memory, addr);
      loaded_type.insert(std::make_pair(key, addr));
      return addr;
    } break;

    default:
      type->dump();
      throw_error_message(Error::UNSUPPORT,
                          "type:" + Util::num2dec_str(type->getTypeID()));
      break;
  }

  // 基本型はアドレスが固定なのでそのまま登録
  loaded_type.insert(std::make_pair(key, addr));
  return addr;
}

// LLVMの定数(vector)を仮想マシンにロードする。
void LlvmAsmLoader::load_vector(FunctionContext& fc, ValueDest dst,
                                const llvm::ConstantVector* src) {
  // Typeの要素数とOperandsの要素数は同じはず
  assert(src->getType()->getNumElements() == src->getNumOperands());

  // 書き込み
  int one_size =
      data_layout->getTypeAllocSize(src->getType()->getElementType());

  for (unsigned int i = 0; i < src->getNumOperands(); i ++) {
    load_constant(fc, relocate_dest(dst, one_size * i), src->getOperand(i));
  }
}

// LLVMの定数(0うめ領域)を仮想マシンにロードする。
void LlvmAsmLoader::load_zero(FunctionContext& fc, ValueDest dst,
                              const llvm::ConstantAggregateZero* src) {
  // 領域サイズを取得
  assert(data_layout->getTypeStoreSize(src->getType()) <=
         data_layout->getTypeAllocSize(src->getType()));
  unsigned int size = data_layout->getTypeAllocSize(src->getType());

  // 0クリア
  memset(get_ptr_by_dest(fc, dst), 0, size);
}

// 現在解析中の関数の命令配列に命令を追記する。
void LlvmAsmLoader::push_code(FunctionContext& fc, Opcode::Type opcode, int operand) {
  fc.code.push_back(Instruction::make_instruction(opcode, operand));
}

// 現在あるValueDestを元に、相対位置を変化させたValueDestを作成する。
LlvmAsmLoader::ValueDest LlvmAsmLoader::relocate_dest(ValueDest dst, int diff) {
  if (dst.is_k) {
    dst.addr.k += diff;
  } else {
    dst.addr.ptr += diff;
  }
  return dst;
}

void LlvmAsmLoader::convert_inst_ret(FunctionContext& fc,
                                     const llvm::ReturnInst& inst) {
  if (inst.getReturnValue() == nullptr) {
    // 戻り値がない場合
    // return (0xff..)
    push_code(fc, Opcode::RETURN, OperandMask::FILL);

  } else {
    // set_type <type>
    push_code(fc, Opcode::SET_TYPE,
              assign_type(fc, inst.getReturnValue()->getType()));
    // return <value>
    push_code(fc, Opcode::RETURN, assign_operand(fc, inst.getReturnValue()));
  }
}

void LlvmAsmLoader::convert_inst_call(FunctionContext& fc,
                                      const llvm::CallInst& inst) {
  // インラインアセンブラ未対応
  if (inst.isInlineAsm()) throw_error(Error::UNSUPPORT);
  if (!inst.getType()->isVoidTy()) {
    // 戻り値の型
    int type_operand = assign_type(fc, inst.getType());
    push_code(fc, Opcode::SET_TYPE, type_operand);
    // 出力先
    int dst_operand = assign_operand(fc, &inst);
    push_code(fc, Opcode::SET_OUTPUT, dst_operand);
  }

  // CALL命令、関数
  int func_operand = assign_operand(fc, inst.getCalledValue());
  push_code(fc, Opcode::CALL, func_operand);
  // 戻り値の型、格納先の命令を追加
  push_code(fc, Opcode::EXTRA, OperandMask::FILL);
  push_code(fc, Opcode::EXTRA, OperandMask::FILL);

  // 引数部分の命令(引数の型、引数〜)を追加
  for (unsigned int arg_idx = 0, num = inst.getNumArgOperands();
       arg_idx < num; arg_idx ++) {
    int type_operand = assign_type(fc, inst.getArgOperand(arg_idx)->getType());
    push_code(fc, Opcode::EXTRA, type_operand);
    int arg_operand = assign_operand(fc, inst.getArgOperand(arg_idx));
    push_code(fc, Opcode::EXTRA, arg_operand);
  }
}

void LlvmAsmLoader::convert_inst_br(FunctionContext& fc,
                                    const llvm::BranchInst& inst) {
  if (inst.isUnconditional()) {
    // 無条件分岐の場合、無条件jump先の命令を追加
    push_code(fc, Opcode::JUMP, fc.block_alias.at(inst.getSuccessor(0)));

  } else {
    // 条件分岐
    int cond_operand = assign_operand(fc, inst.getCondition());
    push_code(fc, Opcode::TEST, cond_operand);
    // cond == true の場合のジャンプ先
    unsigned int dst_true = fc.block_alias.at(inst.getSuccessor(0));
    push_code(fc, Opcode::EXTRA, dst_true);
    // cond != true の場合のジャンプ先
    unsigned int dst_false = fc.block_alias.at(inst.getSuccessor(1));
    push_code(fc, Opcode::JUMP, dst_false);
  }
}

void LlvmAsmLoader::convert_inst_switch(FunctionContext& fc,
                                        const llvm::SwitchInst& inst) {
  // set_type <intty>
  int type_operand = assign_type(fc, inst.getCondition()->getType());
  push_code(fc, Opcode::SET_TYPE, type_operand);
  // set_value <value>
  int value_operand = assign_operand(fc, inst.getCondition());
  push_code(fc, Opcode::SET_VALUE, value_operand);
  for (auto it = inst.case_begin(); it != inst.case_end(); it ++) {
    // test_eq <val>
    int case_operand = assign_operand(fc, it.getCaseValue());
    push_code(fc, Opcode::TEST_EQ, case_operand);
    // extra <dest>
    unsigned int dst_operand = fc.block_alias.at(it.getCaseSuccessor());
    push_code(fc, Opcode::EXTRA, dst_operand);
  }
  // jump <defaultdest>
  push_code(fc, Opcode::JUMP, fc.block_alias.at(inst.getDefaultDest()));
}

void LlvmAsmLoader::convert_inst_indirectbr(FunctionContext& fc,
                                            const llvm::IndirectBrInst& inst) {
  // indirect_jump <address>
  int addr_operand = assign_operand(fc, inst.getAddress());
  push_code(fc, Opcode::INDIRECT_JUMP, addr_operand);
}

void LlvmAsmLoader::convert_inst_invoke(FunctionContext& fc,
                                        const llvm::InvokeInst& inst) {
  if (!inst.getType()->isVoidTy()) {
    // 戻り値の型
    push_code(fc, Opcode::SET_TYPE, assign_type(fc, inst.getType()));
    // 出力先
    push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));
  }

  // CALL命令、関数
  int func_operand = assign_operand(fc, inst.getCalledValue());
  push_code(fc, Opcode::CALL, func_operand);
  // 正常時、異常時のジャンプ先を追加
  unsigned int dst_normal = fc.block_alias.at(inst.getNormalDest());
  push_code(fc, Opcode::EXTRA, dst_normal);
  unsigned int dst_unwind = fc.block_alias.at(inst.getUnwindDest());
  push_code(fc, Opcode::EXTRA, dst_unwind);

  // 引数部分の命令(引数の型、引数〜)を追加
  for (unsigned int arg_idx = 0, num = inst.getNumArgOperands();
       arg_idx < num; arg_idx ++) {
    int type_operand = assign_type(fc, inst.getArgOperand(arg_idx)->getType());
    push_code(fc, Opcode::EXTRA, type_operand);
    int arg_operand = assign_operand(fc, inst.getArgOperand(arg_idx));
    push_code(fc, Opcode::EXTRA, arg_operand);
  }
}

void LlvmAsmLoader::convert_inst_phi(FunctionContext& fc,
                                     const llvm::PHINode& inst) {
  // set_type <ty>
  push_code(fc, Opcode::SET_TYPE, assign_type(fc, inst.getType()));
  // set_output <result>
  push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));
  // phi <val0>
  // extra <label0>
  // extra <val1>
  // extra <label1>…
  unsigned int num = inst.getNumIncomingValues();
  for (unsigned int i = 0; i < num; i ++) {
    push_code(fc, (i == 0 ? Opcode::PHI : Opcode::EXTRA),
              assign_operand(fc, inst.getIncomingValue(i)));
    push_code(fc, Opcode::EXTRA,
              fc.block_alias.at(inst.getIncomingBlock(i)));
  }
}

void LlvmAsmLoader::convert_inst_extract_element
(FunctionContext& fc, const llvm::ExtractElementInst& inst) {
  // set_type <type>
  int type_operand = assign_type(fc, inst.getType());
  push_code(fc, Opcode::SET_TYPE, type_operand);
  // set_align 0
  push_code(fc, Opcode::SET_ALIGN, 0);
  // set_adr <val>
  int addr_operand = assign_operand(fc, inst.getVectorOperand());
  push_code(fc, Opcode::SET_ADR, addr_operand);
  // set_value <n>
  int value_operand = assign_operand(fc, inst.getIndexOperand());
  push_code(fc, Opcode::SET_VALUE, value_operand);
  // mul_adr <sizeof ty>
  int mul_operand =
      data_layout->getTypeAllocSize
      (inst.getVectorOperandType()->getElementType());
  push_code(fc, Opcode::MUL_ADR, mul_operand);
  // load <result>
  push_code(fc, Opcode::LOAD, assign_operand(fc, &inst));
}

void LlvmAsmLoader::convert_inst_insert_element
(FunctionContext& fc, const llvm::InsertElementInst& inst) {
  // set_type <n x <ty>>
  int type_operand_1 = assign_type(fc, inst.getType());
  push_code(fc, Opcode::SET_TYPE, type_operand_1);
  // set_output <result>
  int res_operand = assign_operand(fc, &inst);
  push_code(fc, Opcode::SET_OUTPUT, res_operand);
  // set <val>
  int dst_operand = assign_operand(fc, inst.getOperand(0));
  push_code(fc, Opcode::SET, dst_operand);
  // set_type <type>
  int type_operand_2 = assign_type(fc, inst.getType()->getElementType());
  push_code(fc, Opcode::SET_TYPE, type_operand_2);
  // set_align 0
  push_code(fc, Opcode::SET_ALIGN, 0);
  // set_adr <val>
  push_code(fc, Opcode::SET_ADR, dst_operand);
  // set_value <n>
  int num_operand = assign_operand(fc, inst.getOperand(2));
  push_code(fc, Opcode::SET_VALUE, num_operand);
  // mul_adr <sizeof ty>
  int mul_operand =
      data_layout->getTypeAllocSize(inst.getType()->getElementType());
  push_code(fc, Opcode::MUL_ADR, mul_operand);
  // store <val>
  int value_operand = assign_operand(fc, inst.getOperand(1));
  push_code(fc, Opcode::STORE, value_operand);
}

void LlvmAsmLoader::convert_inst_shuffle_vector
(FunctionContext& fc, const llvm::ShuffleVectorInst& inst) {
  // set_type <n x <ty>>
  int type_operand = assign_type(fc, inst.getOperand(0)->getType());
  push_code(fc, Opcode::SET_TYPE, type_operand);
  // set_output <result>
  push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));
  // set_value <v1>
  int value_1_operand = assign_operand(fc, inst.getOperand(0));
  push_code(fc, Opcode::SET_VALUE, value_1_operand);
  // shuffle <m>
  push_code(fc, Opcode::SHUFFLE, inst.getType()->getNumElements());
  // extra <mask>
  push_code(fc, Opcode::EXTRA, assign_operand(fc, inst.getMask()));
  // extra <v2>
  int value_2_operand = assign_operand(fc, inst.getOperand(1));
  push_code(fc, Opcode::EXTRA, value_2_operand);
}

void LlvmAsmLoader::convert_inst_extract_value
(FunctionContext& fc, const llvm::ExtractValueInst& inst) {
  // set_type <type>
  push_code(fc, Opcode::SET_TYPE, assign_type(fc, inst.getType()));
  // set_align 0
  push_code(fc, Opcode::SET_ALIGN, 0);
  // set_adr <val>
  int value_operand = assign_operand(fc, inst.getAggregateOperand());
  push_code(fc, Opcode::SET_ADR, value_operand);
  // add_adr <>
  int diff = 0;
  llvm::Type* type = inst.getAggregateOperand()->getType();
  for (auto idx = inst.idx_begin(); idx != inst.idx_end(); idx ++) {
    if (llvm::SequentialType::classof(type)) {
      // 配列の場合、1要素のサイズxN
      type = static_cast<const llvm::SequentialType*>(type)->getElementType();
      diff += data_layout->getTypeAllocSize(type) * *idx;

    } else if (llvm::StructType::classof(type)) {
      // 構造体の場合、N-1番目までの要素のサイズの合計
      unsigned int j = 0;
      for (j = 0; j < *idx; j++) {
        diff += data_layout->getTypeAllocSize
                (static_cast<const llvm::StructType*>(type)->getElementType(j));
      }
      type = static_cast<const llvm::StructType*>(type)->getElementType(j);

    } else {
      assert(false);
    }
  }
  push_code(fc, Opcode::ADD_ADR, diff);
  // load <result>
  push_code(fc, Opcode::LOAD, assign_operand(fc, &inst));
}

void LlvmAsmLoader::convert_inst_insert_value
(FunctionContext& fc, const llvm::InsertValueInst& inst) {
  // set_type <aggregate type>
  push_code(fc, Opcode::SET_TYPE,
            assign_type(fc, inst.getAggregateOperand()->getType()));
  // set_output <result>
  push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));
  // set <val>
  int agg_value_operand = assign_operand(fc, inst.getAggregateOperand());
  push_code(fc, Opcode::SET, agg_value_operand);
  // set_type <type>
  int type_operand =
      assign_type(fc, inst.getInsertedValueOperand()->getType());
  push_code(fc, Opcode::SET_TYPE, type_operand);
  // set_align 0
  push_code(fc, Opcode::SET_ALIGN, 0);
  // set_adr <val>
  push_code(fc, Opcode::SET_ADR, agg_value_operand);
  // add_adr <>
  int diff = 0;
  llvm::Type* type = inst.getAggregateOperand()->getType();
  for (auto idx = inst.idx_begin(); idx != inst.idx_end(); idx ++) {
    if (llvm::SequentialType::classof(type)) {
      // 配列の場合、1要素のサイズxN
      type = static_cast<const llvm::SequentialType*>(type)->
             getElementType();
      diff += data_layout->getTypeAllocSize(type) * *idx;

    } else if (llvm::StructType::classof(type)) {
      // 構造体の場合、N-1番目までの要素のサイズの合計
      unsigned int j = 0;
      for (j = 0; j < *idx; j++) {
        diff += data_layout->getTypeAllocSize
                (static_cast<const llvm::StructType*>(type)->
                 getElementType(j));
      }
      type = static_cast<const llvm::StructType*>(type)->
             getElementType(j);

    } else {
      assert(false);
    }
  }
  push_code(fc, Opcode::ADD_ADR, diff);
  // store <val>
  int value_operand = assign_operand(fc, inst.getInsertedValueOperand());
  push_code(fc, Opcode::STORE, value_operand);
}

void LlvmAsmLoader::convert_inst_alloca(FunctionContext& fc,
                                        const llvm::AllocaInst& inst) {
  // set_type <type>
  int type_operand = assign_type(fc, inst.getAllocatedType());
  push_code(fc, Opcode::SET_TYPE, type_operand);
  // set_align <alignment>
  push_code(fc, Opcode::SET_ALIGN, inst.getAlignment());
  // set_output <result>
  push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));
  // alloca <NumElements>
  int num_operand = assign_operand(fc, inst.getArraySize());
  push_code(fc, Opcode::ALLOCA, num_operand);
}

void LlvmAsmLoader::convert_inst_load(FunctionContext& fc,
                                      const llvm::LoadInst& inst) {
  // set_type <ty>
  int type_operand =
      assign_type(fc, inst.getPointerOperand()->getType()->
                  getPointerElementType());
  push_code(fc, Opcode::SET_TYPE, type_operand);
  // set_align <alignment>
  push_code(fc, Opcode::SET_ALIGN,
            inst.getAlignment());
  // set_ptr <pointer>
  push_code(fc, Opcode::SET_PTR,
            assign_operand(fc, inst.getPointerOperand()));
  // load <result>
  push_code(fc, Opcode::LOAD, assign_operand(fc, &inst));
}

void LlvmAsmLoader::convert_inst_store(FunctionContext& fc,
                                       const llvm::StoreInst& inst) {
  // set_type <ty>
  push_code(fc, Opcode::SET_TYPE,
            assign_type(fc, inst.getValueOperand()->getType()));
  // set_align <alignment>
  push_code(fc, Opcode::SET_ALIGN,
            inst.getAlignment());
  // set_ptr <pointer>
  push_code(fc, Opcode::SET_PTR,
            assign_operand(fc, inst.getPointerOperand()));
  // store <value>
  push_code(fc, Opcode::STORE,
            assign_operand(fc, inst.getValueOperand()));
}

void LlvmAsmLoader::convert_inst_atomic_cmp_xchg
(FunctionContext& fc, const llvm::AtomicCmpXchgInst& inst) {
  // set_type <ty>
  int type_operand = assign_type(fc, inst.getNewValOperand()->getType());
  push_code(fc, Opcode::SET_TYPE, type_operand);
  // set_output <result>
  push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));
  // set_ptr <pointer>
  int pointer_operand = assign_operand(fc, inst.getPointerOperand());
  push_code(fc, Opcode::SET_PTR, pointer_operand);
  // set_value <cmp>
  int cmp_operand = assign_operand(fc, inst.getCompareOperand());
  push_code(fc, Opcode::SET_VALUE, cmp_operand);
  // cmpxchg <new>
  int value_operand = assign_operand(fc, inst.getNewValOperand());
  push_code(fc, Opcode::CMPXCHG, value_operand);
}

void LlvmAsmLoader::convert_inst_rmw(FunctionContext& fc,
                                     const llvm::AtomicRMWInst& inst) {
  switch (inst.getOperation()) {
    /**
     * @param INS AtomicRMWの演算
     * @param OP 対応する仮想マシンのOpcode
     * @param SI 符号あり演算の場合trueを指定する。
     */
#define M_ATOMIC_RMW(INS, OP, SI)                                       \
    case llvm::AtomicRMWInst::INS: {                                    \
      /* set_type <ty> */                                               \
      int type_operand = assign_type                                    \
                         (fc, inst.getValOperand()->getType(), SI);     \
      push_code(fc, Opcode::SET_TYPE, type_operand);                    \
      /* set_output <old> */                                            \
      push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));     \
      /* set_ov_ptr <pointer> */                                        \
      int pointer_operand = assign_operand                              \
                            (fc, inst.getPointerOperand());             \
      push_code(fc, Opcode::SET_OV_PTR, pointer_operand);               \
      /* <operation> <value> */                                         \
      int value_operand = assign_operand                                \
                          (fc, inst.getValOperand());                   \
      push_code(fc, Opcode::OP, value_operand);                         \
    } break;

    M_ATOMIC_RMW(Xchg, SET, false);
    M_ATOMIC_RMW(Add,  ADD, false);
    M_ATOMIC_RMW(Sub,  SUB, false);
    M_ATOMIC_RMW(And,  AND, false);
    M_ATOMIC_RMW(Nand, NAND, false);
    M_ATOMIC_RMW(Or,   OR,  false);
    M_ATOMIC_RMW(Xor,  XOR, false);
    M_ATOMIC_RMW(Max,  MAX, true);
    M_ATOMIC_RMW(Min,  MIN, true);
    M_ATOMIC_RMW(UMax, MAX, false);
    M_ATOMIC_RMW(UMin, MIN, false);
#undef M_ATOMIC_RMW
    default: assert(false);
  }
}

void LlvmAsmLoader::convert_inst_get_element_ptr
(FunctionContext& fc, const llvm::GetElementPtrInst& inst) {
  // set_ptr <ptrval>
  push_code(fc, Opcode::SET_PTR,
            assign_operand(fc, inst.getPointerOperand()));

  llvm::Type* op_type = inst.getPointerOperandType()->getPointerElementType();
  for (unsigned int i = 1, num = inst.getNumOperands(); i < num; i ++) {
    if (i == 1) {
      // set_type <ty>
      push_code(fc, Opcode::SET_TYPE,
                assign_type(fc, inst.getOperand(i)->getType()));
      // set_value <idx>
      push_code(fc, Opcode::SET_VALUE, assign_operand(fc, inst.getOperand(i)));
      // mul_adr <>
      assert(data_layout->getTypeStoreSize(op_type) <=
             data_layout->getTypeAllocSize(op_type));
      push_code(fc, Opcode::MUL_ADR, data_layout->getTypeAllocSize(op_type));

    } else if (llvm::SequentialType::classof(op_type)) {
      op_type =
          static_cast<const llvm::SequentialType*>(op_type)->getElementType();
      // set_type <ty>
      push_code(fc, Opcode::SET_TYPE,
                assign_type(fc, inst.getOperand(i)->getType()));
      // set_value <idx>
      push_code(fc, Opcode::SET_VALUE, assign_operand(fc, inst.getOperand(i)));
      // mul_adr <>
      assert(data_layout->getTypeStoreSize(op_type) <=
             data_layout->getTypeAllocSize(op_type));
      push_code(fc, Opcode::MUL_ADR, data_layout->getTypeAllocSize(op_type));

    } else if (llvm::StructType::classof(op_type)) {
      unsigned int j = 0;
      int size_sum = 0;
      // int系のはず
      assert(llvm::ConstantInt::classof(inst.getOperand(i)));
      for (j = 0;
           j < static_cast<const llvm::ConstantInt*>
               (inst.getOperand(i))->getZExtValue();
           j ++) {
        llvm::Type* in_type =
            static_cast<const llvm::StructType*>(op_type)->getElementType(j);
        size_sum += data_layout->getTypeAllocSize(in_type);
      }
      // add_adr <>
      op_type =
          static_cast<const llvm::StructType*>(op_type)->getElementType(j);
      push_code(fc, Opcode::ADD_ADR, size_sum);

    } else {
      assert(false);
    }
  }
  // get_adr <result>
  push_code(fc, Opcode::GET_ADR,
            assign_operand(fc, &inst));
}

void LlvmAsmLoader::convert_inst_cast(FunctionContext& fc,
                                      const llvm::CastInst& inst) {
  assert(inst.getNumOperands() == 1);
  // set_type <ty>
  push_code(fc, Opcode::SET_TYPE, assign_type(fc, inst.getSrcTy()));
  // set_output <result>
  push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));
  // set_value <value>
  push_code(fc, Opcode::SET_VALUE, assign_operand(fc, inst.getOperand(0)));
  // typecast <ty2>
  push_code(fc, Opcode::TYPE_CAST, assign_type(fc, inst.getDestTy()));
}

void LlvmAsmLoader::convert_inst_sext(FunctionContext& fc,
                                      const llvm::SExtInst& inst) {
  assert(inst.getNumOperands() == 1);
  // set_type <ty>
  push_code(fc, Opcode::SET_TYPE, assign_type(fc, inst.getSrcTy(), true));
  // set_output <result>
  push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));
  // set_value <value>
  push_code(fc, Opcode::SET_VALUE, assign_operand(fc, inst.getOperand(0)));
  // typecast <ty2>
  push_code(fc, Opcode::TYPE_CAST, assign_type(fc, inst.getDestTy(), true));
}

void LlvmAsmLoader::convert_inst_bit_cast(FunctionContext& fc,
                                          const llvm::BitCastInst& inst) {
  assert(inst.getNumOperands() == 1);
  // set_type <ty>
  push_code(fc, Opcode::SET_TYPE, assign_type(fc, inst.getSrcTy()));
  // set_output <result>
  push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));
  // set_value <value>
  push_code(fc, Opcode::SET_VALUE, assign_operand(fc, inst.getOperand(0)));
  // bitcast <ty2>
  push_code(fc, Opcode::BIT_CAST, assign_type(fc, inst.getDestTy()));
}

void LlvmAsmLoader::convert_inst_icmp(FunctionContext& fc,
                                      const llvm::ICmpInst& inst) {
  assert(inst.isIntPredicate());
  // set_type <ty>
  push_code(fc, Opcode::SET_TYPE,
            assign_type(fc, inst.getOperand(0)->getType(), inst.isSigned()));
  // set_output <result>
  push_code(fc, Opcode::SET_OUTPUT,
            assign_operand(fc, &inst));

  switch (inst.getPredicate()) {
    /**
     * icmpの比較演算を作るためのマクロ
     * @param PRE CmpInst::Predicateのメンバ
     * @param OPC VMの命令
     * @param FOP 比較対象左辺値
     * @param SOP 比較対象右辺値
     */
#define M_ICMP_OPERATOR(PRE, OPC, FOP, SOP)                             \
    case llvm::CmpInst::Predicate::PRE: {                               \
      push_code(fc, Opcode::SET_VALUE,                                  \
                assign_operand(fc, inst.getOperand(FOP)));              \
      push_code(fc, Opcode::OPC, assign_operand(fc, inst.getOperand(SOP))); \
    } break;

    M_ICMP_OPERATOR(ICMP_EQ, EQUAL, 0, 1);      // =
    M_ICMP_OPERATOR(ICMP_NE, NOT_EQUAL, 0, 1);  // !=
    M_ICMP_OPERATOR(ICMP_UGT, GREATER, 0, 1);   // > (unsigned)
    M_ICMP_OPERATOR(ICMP_UGE, GREATER_EQUAL, 0, 1);     // >= (unsigned)
    M_ICMP_OPERATOR(ICMP_ULT, GREATER, 1, 0);   // < (unsigned)
    M_ICMP_OPERATOR(ICMP_ULE, GREATER_EQUAL, 1, 0);     // <= (unsigned)
    M_ICMP_OPERATOR(ICMP_SGT, GREATER, 0, 1);   // > (signed)
    M_ICMP_OPERATOR(ICMP_SGE, GREATER_EQUAL, 0, 1);     // >= (signed)
    M_ICMP_OPERATOR(ICMP_SLT, GREATER, 1, 0);   // < (signed)
    M_ICMP_OPERATOR(ICMP_SLE, GREATER_EQUAL, 1, 0);     // <= (signed)
#undef M_ICMP_OPERATOR

    default: {
      assert(false);
    } break;
  }
}

void LlvmAsmLoader::convert_inst_fcmp(FunctionContext& fc,
                                      const llvm::FCmpInst& inst) {
  assert(inst.isFPPredicate());
  // set_type <ty>
  push_code(fc, Opcode::SET_TYPE,
            assign_type(fc, inst.getOperand(0)->getType()));
  // set_output <result>
  push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));

  switch (inst.getPredicate()) {
    /**
     * fcmpの比較演算を作るためのマクロ
     * @param PRE CmpInst::Predicateのメンバ
     * @param OPC VMの命令
     * @param FOP 比較対象左辺値
     * @param SOP 比較対象右辺値
     */
#define M_FCMP_OPERATOR1(PRE, OPC, FOP, SOP)                            \
    case llvm::CmpInst::PRE: {                                          \
      push_code(fc, Opcode::SET_VALUE,                                  \
                assign_operand(fc, inst.getOperand(FOP)));              \
      push_code(fc, Opcode::OPC, assign_operand(fc, inst.getOperand(SOP))); \
    } break;

    M_FCMP_OPERATOR1(FCMP_OEQ, EQUAL, 0, 1);    // =
    M_FCMP_OPERATOR1(FCMP_OGT, GREATER, 0, 1);  // >
    M_FCMP_OPERATOR1(FCMP_OGE, GREATER_EQUAL, 0, 1);    // >=
    M_FCMP_OPERATOR1(FCMP_OLT, GREATER, 1, 0);  // <
    M_FCMP_OPERATOR1(FCMP_OLE, GREATER_EQUAL, 1, 0);    // <=
    M_FCMP_OPERATOR1(FCMP_ONE, NOT_EQUAL, 0, 1);        // !=
    M_FCMP_OPERATOR1(FCMP_ORD, NOT_NANS, 0, 1);  // !isnan(v) && !isnan(A)
#undef M_FCMP_OPERATOR1

#define M_FCMP_OPERATOR2(PRE, OPC, FOP, SOP)                            \
    case llvm::CmpInst::PRE: {                                          \
      push_code(fc, Opcode::SET_VALUE,                                  \
                assign_operand(fc, inst.getOperand(FOP)));              \
      push_code(fc, Opcode::OR_NANS,                                    \
                assign_operand(fc, inst.getOperand(SOP)));              \
      push_code(fc, Opcode::OPC, assign_operand(fc, inst.getOperand(SOP))); \
    } break;

    M_FCMP_OPERATOR2(FCMP_UEQ, EQUAL, 0, 1);    // =
    M_FCMP_OPERATOR2(FCMP_UGT, GREATER, 0, 1);  // >
    M_FCMP_OPERATOR2(FCMP_UGE, GREATER_EQUAL, 0, 1);   // >=
    M_FCMP_OPERATOR2(FCMP_ULT, GREATER, 1, 0);  // <
    M_FCMP_OPERATOR2(FCMP_ULE, GREATER_EQUAL, 1, 0);   // <=
    M_FCMP_OPERATOR2(FCMP_UNE, NOT_EQUAL, 0, 1);       // !=
#undef M_FCMP_OPERATOR2

    case llvm::CmpInst::FCMP_UNO: {  // isnan(v) || isnan(A)
      push_code(fc, Opcode::SET_VALUE, assign_operand(fc, inst.getOperand(0)));
      push_code(fc, Opcode::OR_NANS, assign_operand(fc, inst.getOperand(1))); \
      // OR_NANSを使い比較不能かどうか調べ、pc+1分、
      // NOPを埋めることで都合をつける。
      push_code(fc, Opcode::NOP, 0);
    } break;

    case llvm::CmpInst::FCMP_FALSE: {  // false
      // set_type <i8?>
      push_code(fc, Opcode::SET_TYPE, assign_type(fc, inst.getType()));
      // set_output <result>
      push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));
      // set 定数
      push_code(fc, Opcode::SET, -1);  // 0x0をk(0)に割り当てておく
    } break;

    case llvm::CmpInst::FCMP_TRUE: {  // true
      // set_type <i8>
      push_code(fc, Opcode::SET_TYPE, assign_type(fc, inst.getType()));
      // set_output <result>
      push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));
      // set 定数
      push_code(fc, Opcode::SET, -2);  // 0x1をk(1)に割り当てておく
    } break;

    default: {
      Logger::err(LoaderMid::L2006, "predicate", std::to_string(inst.getPredicate()).c_str());
      assert(false);
    } break;
  }
}

void LlvmAsmLoader::convert_inst_select(FunctionContext& fc,
                                        const llvm::SelectInst& inst) {
  // set_type <ty>
  push_code(fc, Opcode::SET_TYPE,
            assign_type(fc, inst.getTrueValue()->getType()));
  // set_output <result>
  push_code(fc, Opcode::SET_OUTPUT, assign_operand(fc, &inst));
  // set_value <cond>
  push_code(fc, Opcode::SET_VALUE, assign_operand(fc, inst.getCondition()));
  // select <val1>
  push_code(fc, Opcode::SELECT, assign_operand(fc, inst.getTrueValue()));
  // extra <val2>
  push_code(fc, Opcode::EXTRA, assign_operand(fc, inst.getFalseValue()));
}

}  // namespace processwarp
