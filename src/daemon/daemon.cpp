
#include <getopt.h>
#include <fcntl.h>
#include <paths.h>
#include <unistd.h>
#include <sys/stat.h>

#include <cassert>
#include <cerrno>
#include <csignal>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>

#include "daemon.hpp"
#include "daemon_mid.hpp"
#include "frontend_connector.hpp"
#include "logger.hpp"
#include "network_connector.hpp"
#include "router.hpp"
#include "util.hpp"
#include "worker_connector.hpp"

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
      if (!initialize_logger() ||
          !initialize_message() ||
          !initialize_cui()) {
        return EXIT_FAILURE;
      }
    } break;

    case RunMode:: SUBPROCESS: {
      if (!config_subprocess() ||
          !initialize_logger() ||
          !initialize_message() ||
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

  // Start libuv loop.
  return !uv_run(loop, UV_RUN_DEFAULT);
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

bool Daemon::initialize_cui() {
  assert(run_mode == RunMode::DAEMON || run_mode == RunMode::CONSOLE);

  loop = uv_default_loop();
  Router& router = Router::get_instance();
  NetworkConnector& network = NetworkConnector::get_instance();
  WorkerConnector& worker = WorkerConnector::get_instance();

  network.initialize(loop, config.at("server").get<std::string>());
  router.initialize(loop, config);
  worker.initialize(loop,
                    config.at("worker_pipe").get<std::string>(),
                    config.at("libs").get<picojson::array>(),
                    config.at("lib_filter").get<picojson::array>());

#warning TODO
  /*
  network.send_connect_node(config.at("account").get<std::string>(),
                            config.at("password").get<std::string>());
  */

  if (run_mode == RunMode::DAEMON) {
    Logger::info(DaemonMid::L3009, "daemon");
  } else {
    Logger::info(DaemonMid::L3009, "console");
  }

  return true;
}

/**
 * Initialize logger.
 * @return True if initialize was succeed.
 */
bool Daemon::initialize_logger() {
  logger.initialize("native");
  Logger::set_logger_delegate(&logger);
  return true;
}

/**
 * Initialize message.
 * Load message file selected by configure.
 * @return True if initialize was succeed.
 */
bool Daemon::initialize_message() {
  // Load messages.
  return Message::load(config.at("message").get<std::string>());
}

bool Daemon::initialize_subprocess() {
  assert(run_mode == RunMode::SUBPROCESS);

  loop = uv_default_loop();
  FrontendConnector& frontend = FrontendConnector::get_instance();
  Router& router = Router::get_instance();
  NetworkConnector& network = NetworkConnector::get_instance();
  WorkerConnector& worker = WorkerConnector::get_instance();

  network.initialize(loop, config.at("server").get<std::string>());
  router.initialize(loop, config);
  frontend.initialize(loop,
                      config.at("frontend_pipe").get<std::string>(),
                      config.at("frontend_key").get<std::string>());
  worker.initialize(loop,
                    config.at("worker_pipe").get<std::string>(),
                    config.at("libs").get<picojson::array>(),
                    config.at("lib_filter").get<picojson::array>());

  Logger::info(DaemonMid::L3009, "subprocess");

  return true;
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
