
#include <getopt.h>
#include <fcntl.h>
#include <paths.h>
#include <unistd.h>
#include <sys/stat.h>

#include <cassert>
#include <cerrno>
#include <cmath>
#include <csignal>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>

#include "daemon.hpp"
#include "daemon_mid.hpp"
#include "frontend_connector.hpp"

#ifdef WITH_LOG_FLUENTD
#  include "logger_fluentd.hpp"
#endif
#include "logger_stdout.hpp"
#ifdef WITH_LOG_SYSLOG
#  include "logger_syslog.hpp"
#endif
#include "net/webrtc/webrtc_connector.hpp"
#include "router.hpp"
#include "utils.hpp"

namespace processwarp {
/**
 * Constructor, set default parameters value.
 */
Daemon::Daemon() {
  run_mode = RunMode::CONSOLE;
}

/**
 * Read JSON formated configuration from stdin for subprocess mode.
 * @return True if reading configuration has success.
 */
bool Daemon::config_subprocess() {
  picojson::value v;
  std::string err = picojson::parse(v, std::cin);
  if (err.empty()) {
    config = v.get<picojson::object>();

  } else {
    std::cerr << err << std::endl;
    return false;
  }

  return true;
}

/**
 * Actual entry process, passed by main.
 * Scan command line options and change run mode by option,
 * and pass the process to main loop.
 * @param argc Count of command line option.
 * @param argv Strings of command line options.
 * @return Exit status.
 */
int Daemon::entry(int argc, char* argv[]) {
  if (!read_options(argc, argv)) {
    show_help(true, argv[0]);
    return EXIT_FAILURE;
  }

  switch (run_mode) {
    case RunMode::CONSOLE:
    case RunMode::DAEMON: {
      if (!Logger::initialize_boot() ||
          !Message::load(config.at("message").get<std::string>()) ||
          !Logger::initialize(config, "native") ||
          !initialize_cui()) {
        return EXIT_FAILURE;
      }
    } break;

    case RunMode::SUBPROCESS: {
      if (!Logger::initialize_boot() ||
          !config_subprocess() ||
          !Message::load(config.at("message").get<std::string>()) ||
          !Logger::initialize(config, "native") ||
          !initialize_subprocess()) {
        return EXIT_FAILURE;
      }
    } break;

    case RunMode::HELP: {
      show_help(false, argv[0]);
      return EXIT_SUCCESS;
    } break;

    default: {
      assert(false);
    } break;
  }

  if (run_mode == RunMode::DAEMON) {
    if (daemonize() != 0) {
      return EXIT_FAILURE;
    }
  }

  // Start libuv loop.
  return !uv_run(loop, UV_RUN_DEFAULT);
}

void Daemon::server_connector_connect_on_success(
    ServerConnector& server_connector, const NodeID& my_nid) {
  /// @todo output log
}

void Daemon::server_connector_connect_on_failure(
    ServerConnector& server_connector, int code) {
  /// @todo output log
  exit(EXIT_FAILURE);
}

/**
 * The WorkerConnector module require creating vm,
 * relay this instruction to scheduler through router module.
 * @param caller The workerConnector instance (unused).
 * @param pid Target process-id.
 * @return Router(Scheduler)'s return value.
 */
bool Daemon::worker_connector_require_create_vm(WorkerConnector& caller, const vpid_t& pid) {
  Router& router = Router::get_instance();

  return router.require_create_vm(pid);
}

/**
 * Daemonize the process.
 * Reference: http://draft.scyphus.co.jp/series/daemon.ja/01_daemonize.html<br>
 * This function get process to daemon.
 * Existing process will be fork and parent process will be exit.
 * And daemon (child) process will be continue. 
 * @return 0 if daemonize was success.
 */
int Daemon::daemonize() {
  /* Saved sigaction  */
  struct sigaction saved_sa;
  /* Sigaction for signal configuration */
  struct sigaction sa;
  /* File descriptor of /dev/null */
  int fd;
  /* Group ID */
  pid_t newgrp;
  /* Saved errno */
  int saved_errno;
  /* Value returned by sigaction */
  int saved_sa_flag;

  /* A SIGHUP may be thrown when the parent exits below according to the
     FreeBSD's daemon(3) implementation. */
  sigemptyset(&sa.sa_mask);
  sa.sa_handler = SIG_IGN;
  sa.sa_flags = 0;
  saved_sa_flag = sigaction(SIGHUP, &sa, &saved_sa);

  /* Fork and check the return value */
  switch (fork()) {
    case -1:
      /* Error */
      return -1;

    case 0:
      /* Continue if child */
      break;

    default:
      /* Exit if parent */
      exit(0);
  }

  /* Create new session and become the process leader.  N.B., To create new
     session, the process MUST NOT be a process leader. */
  newgrp = setsid();
  /* Save errno */
  saved_errno = errno;

  /* Check the returned value of setsid(); newgrp should same as getpid() */
  if (-1 == newgrp) {
    /* Setsid() failed. */
    errno = saved_errno;
    return -1;
  }

  /* Fork again to make sure that the process must not have tty, and then
     check the return value. */
  switch (fork()) {
    case -1:
      /* Error. */
      return -1;

    case 0:
      /* Continue if child. */
      break;

    default:
      /* Exit if parent. */
      exit(0);
  }

  /* Recover signal handlers. */
  if (-1 != saved_sa_flag) {
    /* Succeeded in sigaction, then recover the SIGHUP handling. */
    sigaction(SIGHUP, &saved_sa, NULL);
  }

  if (-1 != (fd = open(_PATH_DEVNULL, O_RDWR, 0))) {
    /* Close stdin, stdout and stderr if desired. */
    dup2(fd, STDIN_FILENO);
    dup2(fd, STDOUT_FILENO);
    dup2(fd, STDERR_FILENO);
    if (fd > 2) {
      /* If the /dev/null is not a special descriptor, then close it. */
      close(fd);
    }
  }
  return 0;
}

/**
 * Initialize modules used by CUI mode.
 * @return True if initialize has success.
 */
bool Daemon::initialize_cui() {
  assert(run_mode == RunMode::DAEMON || run_mode == RunMode::CONSOLE);

  loop = uv_default_loop();
  Router& router = Router::get_instance();
  ServerConnector& server = ServerConnector::get_instance();
  WebrtcConnector& webrtc = WebrtcConnector::get_instance();
  WorkerConnector& worker = WorkerConnector::get_instance();

  server.initialize(loop, config.at("server").get<std::string>());
  router.initialize(loop, config);
  webrtc.initialize(&server, loop, config);
  worker.initialize(*this, loop, config);

  if (config.find("account") != config.end()) {
    std::string password;
    if (config.find("password") != config.end()) {
      password = config.at("password").get<std::string>();
    } else {
      /// @todo get message from message file
      std::cout << "Please input a password:" << std::endl;
      set_stdin_echo(false);
      std::getline(std::cin, password);
      set_stdin_echo(true);
    }

    server.connect(this, config.at("account").get<std::string>(), password);
  }

  if (run_mode == RunMode::DAEMON) {
    Logger::info(DaemonMid::L3009, "daemon");
  } else {
    Logger::info(DaemonMid::L3009, "console");
  }

  return true;
}

/**
 * Initialize modules used by subprocess mode.
 * @return True if initialize has success.
 */
bool Daemon::initialize_subprocess() {
  assert(run_mode == RunMode::SUBPROCESS);

  loop = uv_default_loop();
  FrontendConnector& frontend = FrontendConnector::get_instance();
  Router& router = Router::get_instance();
  ServerConnector& server = ServerConnector::get_instance();
  WebrtcConnector& webrtc = WebrtcConnector::get_instance();
  WorkerConnector& worker = WorkerConnector::get_instance();

  server.initialize(loop, config.at("server").get<std::string>());
  router.initialize(loop, config);
  frontend.initialize(loop,
                      config.at("frontend_pipe").get<std::string>(),
                      config.at("frontend_key").get<std::string>());
  webrtc.initialize(&server, loop, config);
  worker.initialize(*this, loop, config);

  Logger::info(DaemonMid::L3009, "subprocess");

  return true;
}

/**
 * Change stdin flag to hide inputing string.
 * @param is_enable Set false to hide inputing string.
 */
void Daemon::set_stdin_echo(bool is_enable) {
#ifndef WIN32
  struct termios tty;
  tcgetattr(STDIN_FILENO, &tty);

  if (!is_enable) {
    tty.c_lflag &= ~ECHO;
  } else {
    tty.c_lflag |= ECHO;
  }

  tcsetattr(STDIN_FILENO, TCSANOW, &tty);

#else
  HANDLE h_stdin = GetStdHandle(STD_INPUT_HANDLE);
  DWORD mode;
  GetConsoleMode(h_stdin, &mode);

  if (!is_enable) {
    mode &= ~ENABLE_ECHO_INPUT;
  } else {
    mode |= ENABLE_ECHO_INPUT;
  }

  SetConsoleMode(h_stdin, mode);
#endif
}

/**
 * Show help messages to console.
 * You can choice output device stdout or stderr.
 * @param is_error Output help message to stderr if set it true.
 * @param command Command string.
 */
void Daemon::show_help(bool is_error, const std::string& command) {
  std::ostream& out = (is_error ? std::cerr : std::cout);
  out << "usage: " << command << " [options]" << std::endl;
  out << "  -c --console      Run process warp node as console application (default)." << std::endl;
  out << "  -d --daemon       Run process warp node as daemon." << std::endl;
  out << "  -s --subprocess   Run process warp node as a sub-process of the frontend." << std::endl;
  out << "  -f <config>       Uses the configure in the file config on run." << std::endl;
  out << "  -h --help         Show available options." << std::endl;
}

/**
 * Read config from selected file as JSON.
 * @param file Config file name.
 * @return False if couldn't read the file or wrong format.
 */
bool Daemon::read_config(const std::string& file) {
  std::ifstream conf_file(file);
  if (!conf_file.is_open()) {
    std::cerr << "Can't open configure file." << std::endl;
    return false;
  }

  picojson::value v;
  std::string err = picojson::parse(v, conf_file);
  conf_file.close();
  if (!err.empty()) {
    std::cerr << err << std::endl;
    return false;
  }

  config = v.get<picojson::object>();
  return true;
}

/**
 * Read command line arguments and set option values.
 * c(console) option was set, change run mode to RunMode::CONSOLE.<br>
 * d(daemon) option was set, change run mode to RunMode::DAEMON.<br>
 * f option was set, read config file from file selected by argument.<br>
 * h(help) option was set, change run mode to RunMode::HELP.<br>
 * @param argc Argc passed by entry function.
 * @param argv Argv passed by entry function.
 * @return False if options was wrong.
 */
bool Daemon::read_options(int argc, char* argv[]) {
  int opt, option_index;
  option long_options[] = {
    {"console",     no_argument, nullptr, 'c'},
    {"daemon",      no_argument, nullptr, 'd'},
    {"help",        no_argument, nullptr, 'h'},
    {"subprocess",  no_argument, nullptr, 's'},
    {0, 0, 0, 0}
  };

  while ((opt = getopt_long(argc, argv, "cdf:hs", long_options, &option_index)) != -1) {
    switch (opt) {
      case 'c': {
        run_mode = RunMode::CONSOLE;
      } break;

      case 'd': {
        run_mode = RunMode::DAEMON;
      } break;

      case 'f': {
        if (!read_config(std::string(optarg))) return false;
      } break;

      case 'h': {
        run_mode = RunMode::HELP;
      } break;

      case 's': {
        run_mode = RunMode::SUBPROCESS;
      } break;

      case ':':
      case '?': {
        return false;
      } break;
    }
  }
  return true;
}
}  // namespace processwarp

/**
 * Entry point, call actual entry process.
 * @param argc Count of command line option.
 * @param argv Strings of command line options.
 * @return Exit status.
 */
int main(int argc, char* argv[]) {
  processwarp::Daemon THIS;

  return THIS.entry(argc, argv);
}
