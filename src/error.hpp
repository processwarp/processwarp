#pragma once

#include <string>

namespace usagi {

#define throw_error(R) throw Error(__FILE__, __LINE__, (R), "")
#define throw_error_message(R, M) throw Error(__FILE__, __LINE__, (R), (M))

  /**
   * VM内例外クラス。
   * VMの内部に収まる(他のVMに影響がない)ロジック上の例外の伝搬に利用する。
   */
  class Error {
  public:
    enum Reason {
      PARSE,      ///< 入力ファイルのパースに失敗
      UNSUPPORT,  ///< 未サポートの機能(LLVMの仕様のうち)
      SPEC_VIOLATION, ///< 仕様違反
      INST_VIOLATION, ///< 不正命令
      TYPE_VIOLATION, ///< 型違反
      CAST_VIOLATION, ///< 型変換違反
      MOD_FUNCTION,   ///< 関数ポインタに対する演算
      SEGMENT_FAULT,  ///< セグメンテーションフォルト
      OUT_OF_MEMORY,  ///< メモリ不足
      SYM_NOT_FOUND,  ///< シンボルが見つけられなかった
      TOO_MANY_VALUE, ///< 変数、定数がオペランドで表現できない
      EXT_LIBRARY,    ///< 外部ライブラリの読み出しエラー
      EXT_CALL,       ///< 外部関数の読み出しエラー
    };

    /// 例外の理由
    const Reason reason;
    /// メッセージ
    const std::string mesg;

    /**
     * VM内例外のコンストラクタ。
     * @param file 例外出力元ファイル名
     * @param line 例外出力元行番号
     * @param reason_ 例外の理由
     * @param mesg_ メッセージ
     */
    Error(const std::string& file, int line, Reason reason_, const std::string& mesg_);
  };
}
