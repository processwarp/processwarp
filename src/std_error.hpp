#pragma once

#include "definitions.hpp"

namespace processwarp {

#define throw_std_error(N) {						\
    vm_int_t e = (N);							\
    print_debug("std error (no:%d, file:%s, line:%d)\n", e, __FILE__, __LINE__); \
    throw StdError(e);							\
  }

  /**
   * Definition of std::errno.
   * This definition is generate from errno.h.
   */
  class StdError {
  public:
    static const vm_int_t PERM           = 1;
    static const vm_int_t NOENT          = 2;
    static const vm_int_t SRCH           = 3;
    static const vm_int_t INTR           = 4;
    static const vm_int_t IO             = 5;
    static const vm_int_t NXIO           = 6;
    static const vm_int_t TOOBIG         = 7;
    static const vm_int_t NOEXEC         = 8;
    static const vm_int_t BADF           = 9;
    static const vm_int_t CHILD          = 10;
    static const vm_int_t AGAIN          = 11;
    static const vm_int_t NOMEM          = 12;
    static const vm_int_t ACCES          = 13;
    static const vm_int_t FAULT          = 14;
    static const vm_int_t NOTBLK         = 15;
    static const vm_int_t BUSY           = 16;
    static const vm_int_t EXIST          = 17;
    static const vm_int_t XDEV           = 18;
    static const vm_int_t NODEV          = 19;
    static const vm_int_t NOTDIR         = 20;
    static const vm_int_t ISDIR          = 21;
    static const vm_int_t INVAL          = 22;
    static const vm_int_t NFILE          = 23;
    static const vm_int_t MFILE          = 24;
    static const vm_int_t NOTTY          = 25;
    static const vm_int_t TXTBSY         = 26;
    static const vm_int_t FBIG           = 27;
    static const vm_int_t NOSPC          = 28;
    static const vm_int_t SPIPE          = 29;
    static const vm_int_t ROFS           = 30;
    static const vm_int_t MLINK          = 31;
    static const vm_int_t PIPE           = 32;
    static const vm_int_t DOM            = 33;
    static const vm_int_t RANGE          = 34;
    static const vm_int_t DEADLK         = 35;
    static const vm_int_t NAMETOOLONG    = 36;
    static const vm_int_t NOLCK          = 37;
    static const vm_int_t NOSYS          = 38;
    static const vm_int_t NOTEMPTY       = 39;
    static const vm_int_t LOOP           = 40;
    static const vm_int_t WOULDBLOCK     = AGAIN;
    static const vm_int_t NOMSG          = 42;
    static const vm_int_t IDRM           = 43;
    static const vm_int_t CHRNG          = 44;
    static const vm_int_t L2NSYNC        = 45;
    static const vm_int_t L3HLT          = 46;
    static const vm_int_t L3RST          = 47;
    static const vm_int_t LNRNG          = 48;
    static const vm_int_t UNATCH         = 49;
    static const vm_int_t NOCSI          = 50;
    static const vm_int_t L2HLT          = 51;
    static const vm_int_t BADE           = 52;
    static const vm_int_t BADR           = 53;
    static const vm_int_t XFULL          = 54;
    static const vm_int_t NOANO          = 55;
    static const vm_int_t BADRQC         = 56;
    static const vm_int_t BADSLT         = 57;
    static const vm_int_t DEADLOCK       = DEADLK;
    static const vm_int_t BFONT          = 59;
    static const vm_int_t NOSTR          = 60;
    static const vm_int_t NODATA         = 61;
    static const vm_int_t TIME           = 62;
    static const vm_int_t NOSR           = 63;
    static const vm_int_t NONET          = 64;
    static const vm_int_t NOPKG          = 65;
    static const vm_int_t REMOTE         = 66;
    static const vm_int_t NOLINK         = 67;
    static const vm_int_t ADV            = 68;
    static const vm_int_t SRMNT          = 69;
    static const vm_int_t COMM           = 70;
    static const vm_int_t PROTO          = 71;
    static const vm_int_t MULTIHOP       = 72;
    static const vm_int_t DOTDOT         = 73;
    static const vm_int_t BADMSG         = 74;
    static const vm_int_t OVERFLOW       = 75;
    static const vm_int_t NOTUNIQ        = 76;
    static const vm_int_t BADFD          = 77;
    static const vm_int_t REMCHG         = 78;
    static const vm_int_t LIBACC         = 79;
    static const vm_int_t LIBBAD         = 80;
    static const vm_int_t LIBSCN         = 81;
    static const vm_int_t LIBMAX         = 82;
    static const vm_int_t LIBEXEC        = 83;
    static const vm_int_t ILSEQ          = 84;
    static const vm_int_t RESTART        = 85;
    static const vm_int_t STRPIPE        = 86;
    static const vm_int_t USERS          = 87;
    static const vm_int_t NOTSOCK        = 88;
    static const vm_int_t DESTADDRREQ    = 89;
    static const vm_int_t MSGSIZE        = 90;
    static const vm_int_t PROTOTYPE      = 91;
    static const vm_int_t NOPROTOOPT     = 92;
    static const vm_int_t PROTONOSUPPORT = 93;
    static const vm_int_t SOCKTNOSUPPORT = 94;
    static const vm_int_t OPNOTSUPP      = 95;
    static const vm_int_t NOTSUP         = OPNOTSUPP;
    static const vm_int_t PFNOSUPPORT    = 96;
    static const vm_int_t AFNOSUPPORT    = 97;
    static const vm_int_t ADDRINUSE      = 98;
    static const vm_int_t ADDRNOTAVAIL   = 99;
    static const vm_int_t NETDOWN        = 100;
    static const vm_int_t NETUNREACH     = 101;
    static const vm_int_t NETRESET       = 102;
    static const vm_int_t CONNABORTED    = 103;
    static const vm_int_t CONNRESET      = 104;
    static const vm_int_t NOBUFS         = 105;
    static const vm_int_t ISCONN         = 106;
    static const vm_int_t NOTCONN        = 107;
    static const vm_int_t SHUTDOWN       = 108;
    static const vm_int_t TOOMANYREFS    = 109;
    static const vm_int_t TIMEDOUT       = 110;
    static const vm_int_t CONNREFUSED    = 111;
    static const vm_int_t HOSTDOWN       = 112;
    static const vm_int_t HOSTUNREACH    = 113;
    static const vm_int_t ALREADY        = 114;
    static const vm_int_t INPROGRESS     = 115;
    static const vm_int_t STALE          = 116;
    static const vm_int_t UCLEAN         = 117;
    static const vm_int_t NOTNAM         = 118;
    static const vm_int_t NAVAIL         = 119;
    static const vm_int_t ISNAM          = 120;
    static const vm_int_t REMOTEIO       = 121;
    static const vm_int_t DQUOT          = 122;
    static const vm_int_t NOMEDIUM       = 123;
    static const vm_int_t MEDIUMTYPE     = 124;
    static const vm_int_t CANCELED       = 125;
    static const vm_int_t NOKEY          = 126;
    static const vm_int_t KEYEXPIRED     = 127;
    static const vm_int_t KEYREVOKED     = 128;
    static const vm_int_t KEYREJECTED    = 129;
    static const vm_int_t OWNERDEAD      = 130;
    static const vm_int_t NOTRECOVERABLE = 131;
    static const vm_int_t RFKILL         = 132;
    static const vm_int_t HWPOISON       = 133;

    /// errno
    const vm_int_t std_errno;

    /**
     * Constractor with errno.
     * @param std_errno Errno.
     */
    StdError(vm_int_t std_errno);
  };
}
