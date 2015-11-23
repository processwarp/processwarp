#pragma once

namespace processwarp {
namespace DaemonRunMode {
/**
 * Daemon run modes.
 */
enum Type {
  CONSOLE, ///< Node program run as console application.
  DAEMON,  ///< Node program run as daemon.
  HELP,    ///< Show help.
};
} // namespace DaemonRunMode
} // namespace processwarp
