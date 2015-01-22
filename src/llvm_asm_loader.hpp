#pragma once

#include <llvm/IR/Constants.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Value.h>
#include <llvm/IR/ValueSymbolTable.h>
#include <map>
#include <string>
#include <vector>

#include "definitions.hpp"

namespace llvm {
  class LLVMContext;
  class Module;
}

namespace usagi {
  class VMachine;

  /**
   * LLVMのアセンブリ言語を解析し仮想マシンにロードするクラス。
   * アプリケーションが複数のファイル(LLVMのモジュール)で構成される場合、
   * 1つのLlvmAsmLoaderを利用する。
   * LlvmAsmLoaderの内部で持つLLVMContextがグローバルな値を管理しているため。
   * LlvmAsmLoaderのコンストラクタでgetGlobalContextを呼び出して初期化、
   * デストラクタでllvm_shutdownを呼び出して終了する。
   * LLVMContext(getGlobalContext, llvm_shutdown)が並列実行に対してどのような
   * 挙動をするか不明なため、複数のインスタンスを同時に生成しない:アプリケーションの
   * ロードを平行に実行しないこと。
   */
  class LlvmAsmLoader {
  public:
    /**
     * コンストラクタ。
     * LLVMのコンテキストを生成する。
     */
    LlvmAsmLoader(VMachine& vmachine_);

    /**
     * デストラクタ。
     * LLVMのコンテキストを破棄する。
     */
    virtual ~LlvmAsmLoader();
    
    /**
     * LLVMのアセンブリファイルを読み込んで仮想マシンにロードする。
     * @param filename ファイル名
     */
    void load_file(const std::string& filename);

  private:
    /// 解析中の関数の命令/変数
    struct FunctionContext {
      /// 命令配列
      std::vector<instruction_t>& code;
      /// 定数
      std::vector<vaddr_t>& k;
      /// スタックに格納する変数と対応するオペランド
      std::map<const llvm::Value*, int>& stack_value;
      /// スタックに割り当て済みのサイズの合計
      int stack_sum;
    };

    /// LLVMのコンテキスト(複数ファイルを読み込むときに使い回す)
    llvm::LLVMContext& context;
    /// ロード先仮想マシン
    VMachine& vmachine;
    /// ロード済みの型とアドレスの対応関係
    std::map<const llvm::Type*,  vaddr_t> loaded_type;

    /// ロード済みの値とアドレスの対応関係
    std::map<const llvm::Value*, vaddr_t> loaded_value;

    /// 解析中のモジュールのデータレイアウト
    const llvm::DataLayout* data_layout;

    /**
     * ロード済みの値とアドレスの対応関係を登録する。
     * @param v LLVMの値
     * @param addr アドレス
     * @return addrに指定したアドレス
     */
    vaddr_t assign_loaded(const llvm::Value* v, vaddr_t addr);

    /**
     * LLVMの型に対応するオペランドを取得する。
     * @param fc 解析中の関数の命令/変数
     * @param t LLVMの型。
     * @param sign i8などの整数で符号ありの場合trueを指定する
     * @return オペランド。
     */
    int assign_type(FunctionContext& fc, const llvm::Type* t, bool sign = false);

    /**
     * LLVMの変数に対応するオペランドを取得する。
     * @param fc 解析中の関数の命令/変数
     * @param v LLVMの変数。
     * @return オペランド。
     */
    int assign_operand(FunctionContext& fc, const llvm::Value* v);

    /**
     * LLVMの定数(配列)を仮想マシンにロードする。
     * @param src LLVMの定数(配列)
     * @return
     */
    vaddr_t load_array(const llvm::ConstantArray* src);

    /**
     * LLVMの定数を仮想マシンにロードする。
     * @param constant LLVMの定数基底
     * @return 
     */
    vaddr_t load_constant(const llvm::Constant* constant);

    /**
     * LLVMの定数(DataArray)を仮想マシンにロードする。
     * @param data_array LLVMの定数
     * @return 
     */
    vaddr_t load_data(const llvm::ConstantDataArray* data_array);

    /**
     * LLVMの定数(Expr)を仮想マシンにロードする。
     * @param expr LLVMの定数(Expr)基底
     * @return 
     */
    vaddr_t load_expr(const llvm::ConstantExpr* expr);

    /**
     * LLVMの定数(Floating-point)を仮想マシンにロードする。
     * @param src llvmの定数(Floating-point)
     * @return
     */
    vaddr_t load_float(const llvm::ConstantFP* src);

    /**
     * LLVMの関数を仮想マシンにロードする。
     * @param function LLVMの関数
     * @return 
     */
    vaddr_t load_function(const llvm::Function* function);

    /**
     * LLVMの大域変数を仮想マシンにロードする。
     * @param variable 大域変数
     * @return 
     */
    vaddr_t load_global(const llvm::GlobalVariable* variable);

    /**
     * LLVMの定数(Int)を仮想マシンにロードする。
     * @param src LLVMの定数(Int)
     * @return
     */
    vaddr_t load_int(const llvm::ConstantInt* src);

    /**
     * LLVMのモジュールを仮想マシンにロードする。
     * @param module LLVMのモジュール
     */
    void load_module(const llvm::Module* module);

    /**
     * LLVMの定数(struct)を仮想マシンにロードする。
     * @param src LLVMの定数(struct)
     * @return
     */
    vaddr_t load_struct(const llvm::ConstantStruct* src);

    /**
     * LLVMの型を仮想マシンにロードする。
     * @param type LLVMの型
     * @param sign i8などの整数で符号ありの場合trueを指定する
     * @return
     */
    vaddr_t load_type(const llvm::Type* type, bool sign);

    /**
     * LLVMの定数(0うめ領域)を仮想マシンにロードする。
     * @param src LLVMの定数(0うめ領域)
     * @return
     */
    vaddr_t load_zero(const llvm::ConstantAggregateZero* src);

    /**
     * 現在解析中の関数の命令配列に命令を追記する。
     * @param fc 解析中の関数の命令/変数
     * @param opcode  オペコード
     * @param operand オペランド
     */
    void push_code(FunctionContext& fc, Opcode opcode, int operand);
  };
}
