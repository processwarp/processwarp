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
}  // namespace processwarp
