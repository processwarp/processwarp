#pragma once

namespace processwarp {
/**
 * Daemon run modes.
 */
namespace DaemonRunMode {
enum Type {
  CONSOLE,  ///< Node program run as console application.
  DAEMON,   ///< Node program run as daemon.
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
 * @todo
 */
namespace PipeStatus {
enum Type {
  SETUP,
  CONNECT,
  ERROR,
};
}  // namespace PipeStatus
}  // namespace processwarp
