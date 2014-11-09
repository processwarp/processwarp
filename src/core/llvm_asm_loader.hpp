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

#include "definitions.hpp"
#include "value.hpp"

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
    
    /**
     * LLVMのアセンブリ言語を文字列から読み込んで仮想マシンにロードする。
     * @param src 解析対象文字列
     */
    //void load_string(const std::string& src);
    
  private:
    /// 解析中の関数の命令/変数
    struct FunctionContext {
      /// 命令配列
      std::vector<uint32_t>& code;
      /// 定数
      std::vector<Value*>&  k;
      /// 変数
      std::vector<const llvm::Value*>& values;
    };

    /// LLVMのコンテキスト(複数ファイルを読み込むときに使い回す)
    llvm::LLVMContext& context;
    /// ロード先仮想マシン
    VMachine& vmachine;
    /// ロード済みの値とアドレスの対応関係
    std::map<const llvm::Value*, Value> loaded;

    /// 解析中のモジュールのデータレイアウト
    const llvm::DataLayout* data_layout;

    /**
     * ロード済みの値とアドレスの対応関係を登録する。
     * @param v LLVMの値
     * @param src 
     * @return 
     */
    Value* assign_loaded(const llvm::Value* v, const Value& src);

    /**
     * LLVMの変数に対応するオペランドを取得する。
     * @param fc 解析中の関数の命令/変数
     * @param v LLVMの変数。
     * @return オペランド。
     */
    int assign_operand(FunctionContext& fc, const llvm::Value* v);

    /**
     * LLVMの定数を仮想マシンにロードする。
     * @param constant LLVMの定数基底
     * @return 
     */
    Value* load(const llvm::Constant* constant);

    /**
     * LLVMの定数(DataArray)を仮想マシンにロードする。
     * @param data_array LLVMの定数
     * @return 
     */
    Value* load(const llvm::ConstantDataArray* data_array);

    /**
     * LLVMの定数(Expr)を仮想マシンにロードする。
     * @param expr LLVMの定数(Expr)基底
     * @return 
     */
    Value* load(const llvm::ConstantExpr* expr);

    /**
     * LLVMの関数を仮想マシンにロードする。
     * @param function LLVMの関数
     * @return 
     */
    Value* load(const llvm::Function* function);

    /**
     * LLVMの大域変数を仮想マシンにロードする。
     * @param variable 大域変数
     * @return 
     */
    Value* load(const llvm::GlobalVariable* variable);

    /**
     * LLVMのモジュールを仮想マシンにロードする。
     * @param module LLVMのモジュール
     */
    void load(const llvm::Module* module);

    /**
     * 現在解析中の関数の命令配列に命令を追記する。
     * @param fc 解析中の関数の命令/変数
     * @param opcode 命令コード
     * @param a オペランド1
     */
    void push_codeA(FunctionContext& fc, Opcode opcode, int a);

    /**
     * 現在解析中の関数の命令配列に命令を追記する。
     * @param fc 解析中の関数の命令/変数
     * @param opcode 命令コード
     * @param a オペランド1
     * @param b オペランド2
     */
    void push_codeAB(FunctionContext& fc, Opcode opcode, int a, int b);
  };
}
