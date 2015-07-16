#pragma once

#include <llvm/IR/Constants.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Value.h>
#include <llvm/IR/ValueSymbolTable.h>
#include <map>
#include <set>
#include <string>
#include <vector>

#include "basic_operator.hpp"
#include "definitions.hpp"
#include "vmemory.hpp"

namespace llvm {
  class LLVMContext;
  class Module;
}

namespace processwarp {
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
     * @param proc ロード先プロセス
     */
    LlvmAsmLoader(Process& proc);

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
      /// ローカル定数領域
      std::vector<uint8_t>& k;
      /// スタックに格納する変数と対応するオペランド
      std::map<const llvm::Value*, int>& stack_value;
      /// スタックに割り当て済みのサイズの合計
      int stack_sum;
      
      /// ローカル変数とアドレスの対応関係
      std::map<const llvm::Value*, int> loaded_value;
      std::map<std::pair<const llvm::Type*, bool>, int> loaded_type;
    };

    /// 値の格納先(拡張可能な定数領域k or 固定の定数領域
    class ValueDest {
    public:
      /// 拡張可能な定数領域kを指す場合true
      bool is_k;
      union {
	/// 拡張可能な定数領域kの先頭からの位置
	int k;
	/// 固定の定数領域へのポインタ
	uint8_t* ptr;
      } addr;

      // mapのキーとして格納するので<演算子の動作を定義する。
      bool operator<(const ValueDest& other) const;
    };

    /// LLVMのコンテキスト(複数ファイルを読み込むときに使い回す)
    llvm::LLVMContext& context;
    /// ロード先仮想マシン
    Process& proc;
    /** */
    VMemory::Accessor& memory;
    /// ロード済みの型とアドレスの対応関係
    std::map<std::pair<const llvm::Type*, bool>, vaddr_t> loaded_type;

    /// BlockAddressにより値を格納する場所
    std::map<ValueDest, std::pair<const llvm::Function*, const llvm::BasicBlock*>> block_addrs;
    /// ブロックと関数内での開始位置
    std::map<std::pair<const llvm::Function*, const llvm::BasicBlock*>, unsigned int> block_addrs_start;

    /// 関数とアドレスの対応関係
    std::map<const llvm::Function*, vaddr_t> map_func;
    /// ロード待ちの関数一覧
    std::set<const llvm::Function*> left_func;

    /// ロード済のグローバル変数の集合
    std::set<const llvm::Value*> loaded_global;
    /// グローバル変数とアドレスの対応関係
    std::map<const llvm::Value*, vaddr_t> map_global;

    /// 解析中のモジュールのデータレイアウト
    const llvm::DataLayout* data_layout;

    /**
     * ロード済みの値とアドレスの対応関係を登録する。
     * @param fc 解析中の関数の命令/変数
     * @param v LLVMの値
     */
    void assign_loaded(FunctionContext& fc, const llvm::Value* v);

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
     * LLVMの定数をロードした実アドレスを取得する。
     * @param fc 解析中の関数の命令/変数
     * @param src LLVMの定数
     * @return 定数がロードされている場所
     */
    ValueDest get_loaded_ptr(FunctionContext& fc, const llvm::Constant* src);

    /**
     * 値の格納先ValueDestから実際の格納位置のポインタを取得する。
     * 実際の格納位置のポインタはassign_operand等、他の関数を呼び出したタイミングで
     * 変わってしまう可能性があるので、memcpyや実際の読み書きの直前で取得すること。
     * @param fc 解析中の関数の命令/変数
     * @param dst 値の格納先ValueDest
     * @return 実際の格納位置地のポインタ
     */
    uint8_t* get_ptr_by_dest(FunctionContext& fc, ValueDest dst);

    /**
     * LLVMの定数(配列)を仮想マシンにロードする。
     * @param src LLVMの定数(配列)
     */
    void load_array(FunctionContext& fc, ValueDest dst, const llvm::ConstantArray* src);

    /**
     * LLVMの定数(BlockAddress)を仮想マシンにロードする。
     * @param fc 解析中の関数の命令/変数
     * @param dst ロード先
     * @param src LLVMの定数(ブロックアドレス)
     */
    void load_block(FunctionContext& fc, ValueDest dst, const llvm::BlockAddress* src);

    /**
     * LLVMの定数を仮想マシンにロードする。
     * @param constant LLVMの定数基底
     */
    void load_constant(FunctionContext& fc, ValueDest dst, const llvm::Constant* src);

    /**
     * LLVMの定数(DataArray/DataVector)を仮想マシンにロードする。
     * @param fc 解析中の関数の命令/変数
     * @param dst ロード先
     * @param data_array LLVMの定数
     * @return 
     */
    void load_data(FunctionContext& fc, ValueDest dst, const llvm::ConstantDataSequential* src);

    /**
     * LLVMの定数(Expr)を仮想マシンにロードする。
     * @param expr LLVMの定数(Expr)基底
     * @return 
     */
    void load_expr(FunctionContext& fc, ValueDest dst, const llvm::ConstantExpr* src);

    /**
     * LLVMの定数(Floating-point)を仮想マシンにロードする。
     * @param src llvmの定数(Floating-point)
     * @return
     */
    void load_float(FunctionContext& fc, ValueDest dst, const llvm::ConstantFP* src);

    /**
     * LLVMの関数を仮想マシンにロードする。
     * @param function LLVMの関数
     */
    void load_function(const llvm::Function* function);

    /**
     * LLVMの大域変数を仮想マシンにロードする。
     * @param variable 大域変数
     */
    void load_globals(const llvm::Module::GlobalListType& variables);

    /**
     * LLVMの定数(Int)を仮想マシンにロードする。
     * @param src LLVMの定数(Int)
     * @return
     */
    void load_int(FunctionContext& fc, ValueDest dst, const llvm::ConstantInt* src);

    /**
     * LLVMのモジュールを仮想マシンにロードする。
     * @param module LLVMのモジュール
     */
    void load_module(llvm::Module* module);

    /**
     * LLVMの定数(struct)を仮想マシンにロードする。
     * @param src LLVMの定数(struct)
     * @return
     */
    void load_struct(FunctionContext& fc, ValueDest dst, const llvm::ConstantStruct* src);

    /**
     * LLVMの型を仮想マシンにロードする。
     * @param type LLVMの型
     * @param sign i8などの整数で符号ありの場合trueを指定する
     * @return 型に対応するアドレス値
     */
    vaddr_t load_type(const llvm::Type* type, bool sign);

    /**
     * LLVMの定数(vector)を仮想マシンにロードする。
     * @param fc 解析中の関数の命令/変数
     * @param dst ロード先
     * @param src LLVMのvector
     */
    void load_vector(FunctionContext& fc, ValueDest dst, const llvm::ConstantVector* src);

    /**
     * LLVMの定数(0うめ領域)を仮想マシンにロードする。
     * @param src LLVMの定数(0うめ領域)
     * @return
     */
    void load_zero(FunctionContext& fc, ValueDest dst, const llvm::ConstantAggregateZero* src);

    /**
     * 現在解析中の関数の命令配列に命令を追記する。
     * @param fc 解析中の関数の命令/変数
     * @param opcode  オペコード
     * @param operand オペランド
     */
    void push_code(FunctionContext& fc, Opcode opcode, int operand);

    /**
     * 現在あるValueDestを元に、相対位置を変化させたValueDestを作成する。
     * @param dst 現在あるValueDest
     * @param diff 相対移動量
     * @return dstをdiff分だけずらしたValueDest
     */
    ValueDest relocate_dest(ValueDest dst, int diff);
  };
}
