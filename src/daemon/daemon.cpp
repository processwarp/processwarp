
#include <getopt.h>
#include <fcntl.h>
#include <paths.h>
#include <unistd.h>
#include <sys/stat.h>

#include <cassert>
#include <cerrno>
#include <csignal>
#include <cstdlib>
#include <iostream>

#include "daemon.hpp"

namespace processwarp {

/** Daemon run mode. */
static DaemonRunMode::Type run_mode = DaemonRunMode::DAEMON;

/**
 * Daemonize the process.
 * Reference: http://draft.scyphus.co.jp/series/daemon.ja/01_daemonize.html<br>
 * This function get process to daemon.
 * Existing process will be fork and parent process will be exit.
 * And daemon (child) process will be continue. 
 * @return 0 if daemonize was success.
 */
int daemonize() {
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
 * Show help messages to console.
 * You can choice output device stdout or stderr.
 * @param is_error Output help message to stderr if set it true.
 * @param command Command string.
 */
void show_help(bool is_error, const std::string& command) {
  std::ostream& out = (is_error ? std::cerr : std::cout);
  out << "usage: " << command << " [options]" << std::endl;
  out << "  -c --console      Run process warp node as console application." << std::endl;
  out << "  -d --daemon       Run process warp node as daemon (default)." << std::endl;
  out << "  -h --help         Show available options." << std::endl;
}

/**
 * Read command line arguments and set option values.
 * c(console) option was set, change run mode to DaemonRunMode::CONSOLE.<br>
 * d(daemon) option was set, change run mode to DaemonRunMode::DAEMON.<br>
 * h(help) option was set, change run mode to DaemonRunMode::HELP.<br>
 * @param argc Argc passed by entry function.
 * @param argv Argv passed by entry function.
 * @return False if options was wrong.
 */
bool read_options(int argc, char* argv[]) {
  int opt, option_index;
  option long_options[] = {
    {"console", no_argument, nullptr, 'c'},
    {"daemon",  no_argument, nullptr, 'd'},
    {"help",    no_argument, nullptr, 'h'},
    {0, 0, 0, 0}
  };

  while ((opt = getopt_long(argc, argv, "dc", long_options, &option_index)) != -1) {
    switch (opt) {
      case 'c': {
        run_mode = DaemonRunMode::CONSOLE;
      } break;

      case 'd': {
        run_mode = DaemonRunMode::DAEMON;
      } break;

      case 'h': {
        run_mode = DaemonRunMode::HELP;
      } break;
        
      case ':':
      case '?': {
        return false;
      } break;
    }
  }
  return true;
}

} // namespace processwarp

/**
 * Entry point.
 * Scan command line options and change run mode by option,
 * and pass the process to main loop.
 * @param argc Count of command line option.
 * @param argv Strings of command line options.
 * @return Exit status.
 */
int main(int argc, char* argv[]) {
  if (!processwarp::read_options(argc, argv)) {
    processwarp::show_help(true, argv[0]);
    return EXIT_FAILURE;
  }
  
  switch (processwarp::run_mode) {
    case processwarp::DaemonRunMode::CONSOLE: {
      // Do nothing.
    } break;

    case processwarp::DaemonRunMode::DAEMON: {
      if (processwarp::daemonize() != 0) {
        return EXIT_FAILURE;
      }
    } break;

    case processwarp::DaemonRunMode::HELP: {
      processwarp::show_help(false, argv[0]);
      return EXIT_SUCCESS;
    } break;

    default: {
      assert(false);
    } break;
  }
  
  return EXIT_SUCCESS;
}
