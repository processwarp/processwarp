#pragma once

namespace processwarp {
/**
 * Daemon run modes.
 */
namespace DaemonRunMode {
enum Type {
  CONSOLE,  ///< Node program run as console application.
  DAEMON,   ///< Node program run as daemon.
  SUBPROCESS,   ///< Node programe run as a sub-process of frontend.
  HELP,     ///< Show help.
};
}  // namespace DaemonRunMode

/**
 * Frontend type.
 */
namespace FrontendType {
enum Type {
  GUI,  ///< GUI frontend.
  CUI,  ///< CUI frontend.
};
}  // namespace FrontendType

/**
 * Pipe connection status used in frontend.
 */
namespace PipeStatus {
enum Type {
  SETUP,    ///< Opend pipe but not received connect-frontend command.
  CONNECT,  ///< Successed connect-frontend command, can pass other packets.
};
}  // namespace PipeStatus

/**
 * Server connection status.
 */
namespace ServerStatus {
enum Type {
  SETUP,      ///< Going to open pipe.
  APPROACH1,  ///< Opened pipe but not replied connect-node command.
  APPROACH2,  ///< Replied connect-node command but not replied bind-node command.
  CONNECT,    ///< Success both connect-node and bind-node command, can pass other packets.
  CONNECT_FAILED,   ///< Failed by connect-node and disconnected.
  BIND_FAILED,      ///< Failed by bind-node and disconnected.
  CLOSE,      ///< Disconnect from server.
  ERROR,      ///< Error was occurred.
};
}  // namespace ServerStatus
}  // namespace processwarp
