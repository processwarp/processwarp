#pragma once

namespace processwarp {
/**
 * Pipe/server connection status.
 */
namespace ConnectStatus {
typedef int Type;
static const Type CLOSE     = 0;  ///< Pipe not opend or closed.
static const Type BEGIN     = 1;
static const Type OPEN      = 2;  ///< Opend pipe, waiting connect command.
static const Type AUTH      = 3;  ///< Received connect command, waiting authentication command.
static const Type CONNECT   = 4;  ///< Successed authentication, can pass other packets.
}  // namespace ConnectStatus

/**
 * Frontend type.
 */
namespace FrontendType {
typedef int Type;
static const Type GUI   = 0;  ///< GUI frontend.
static const Type CUI   = 1;  ///< CUI frontend.
}  // namespace FrontendType

/**
 * Programe run modes.
 */
namespace RunMode {
typedef int Type;
static const Type HELP          = 0;  ///< Show help.
static const Type CONSOLE       = 1;  ///< Node program run as console application.
static const Type DAEMON        = 2;  ///< Node program run as daemon.
static const Type SUBPROCESS    = 3;  ///< Node programe run as a sub-process of frontend.
}  // namespace RunMode
}  // namespace processwarp
