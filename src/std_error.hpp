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
    static const vm_int_t PW_PERM           = 1;
    static const vm_int_t PW_NOENT          = 2;
    static const vm_int_t PW_SRCH           = 3;
    static const vm_int_t PW_INTR           = 4;
    static const vm_int_t PW_IO             = 5;
    static const vm_int_t PW_NXIO           = 6;
    static const vm_int_t PW_TOOBIG         = 7;
    static const vm_int_t PW_NOEXEC         = 8;
    static const vm_int_t PW_BADF           = 9;
    static const vm_int_t PW_CHILD          = 10;
    static const vm_int_t PW_AGAIN          = 11;
    static const vm_int_t PW_NOMEM          = 12;
    static const vm_int_t PW_ACCES          = 13;
    static const vm_int_t PW_FAULT          = 14;
    static const vm_int_t PW_NOTBLK         = 15;
    static const vm_int_t PW_BUSY           = 16;
    static const vm_int_t PW_EXIST          = 17;
    static const vm_int_t PW_XDEV           = 18;
    static const vm_int_t PW_NODEV          = 19;
    static const vm_int_t PW_NOTDIR         = 20;
    static const vm_int_t PW_ISDIR          = 21;
    static const vm_int_t PW_INVAL          = 22;
    static const vm_int_t PW_NFILE          = 23;
    static const vm_int_t PW_MFILE          = 24;
    static const vm_int_t PW_NOTTY          = 25;
    static const vm_int_t PW_TXTBSY         = 26;
    static const vm_int_t PW_FBIG           = 27;
    static const vm_int_t PW_NOSPC          = 28;
    static const vm_int_t PW_SPIPE          = 29;
    static const vm_int_t PW_ROFS           = 30;
    static const vm_int_t PW_MLINK          = 31;
    static const vm_int_t PW_PIPE           = 32;
    static const vm_int_t PW_DOM            = 33;
    static const vm_int_t PW_RANGE          = 34;
    static const vm_int_t PW_DEADLK         = 35;
    static const vm_int_t PW_NAMETOOLONG    = 36;
    static const vm_int_t PW_NOLCK          = 37;
    static const vm_int_t PW_NOSYS          = 38;
    static const vm_int_t PW_NOTEMPTY       = 39;
    static const vm_int_t PW_LOOP           = 40;
    static const vm_int_t PW_WOULDBLOCK     = PW_AGAIN;
    static const vm_int_t PW_NOMSG          = 42;
    static const vm_int_t PW_IDRM           = 43;
    static const vm_int_t PW_CHRNG          = 44;
    static const vm_int_t PW_L2NSYNC        = 45;
    static const vm_int_t PW_L3HLT          = 46;
    static const vm_int_t PW_L3RST          = 47;
    static const vm_int_t PW_LNRNG          = 48;
    static const vm_int_t PW_UNATCH         = 49;
    static const vm_int_t PW_NOCSI          = 50;
    static const vm_int_t PW_L2HLT          = 51;
    static const vm_int_t PW_BADE           = 52;
    static const vm_int_t PW_BADR           = 53;
    static const vm_int_t PW_XFULL          = 54;
    static const vm_int_t PW_NOANO          = 55;
    static const vm_int_t PW_BADRQC         = 56;
    static const vm_int_t PW_BADSLT         = 57;
    static const vm_int_t PW_DEADLOCK       = PW_DEADLK;
    static const vm_int_t PW_BFONT          = 59;
    static const vm_int_t PW_NOSTR          = 60;
    static const vm_int_t PW_NODATA         = 61;
    static const vm_int_t PW_TIME           = 62;
    static const vm_int_t PW_NOSR           = 63;
    static const vm_int_t PW_NONET          = 64;
    static const vm_int_t PW_NOPKG          = 65;
    static const vm_int_t PW_REMOTE         = 66;
    static const vm_int_t PW_NOLINK         = 67;
    static const vm_int_t PW_ADV            = 68;
    static const vm_int_t PW_SRMNT          = 69;
    static const vm_int_t PW_COMM           = 70;
    static const vm_int_t PW_PROTO          = 71;
    static const vm_int_t PW_MULTIHOP       = 72;
    static const vm_int_t PW_DOTDOT         = 73;
    static const vm_int_t PW_BADMSG         = 74;
    static const vm_int_t PW_OVERFLOW       = 75;
    static const vm_int_t PW_NOTUNIQ        = 76;
    static const vm_int_t PW_BADFD          = 77;
    static const vm_int_t PW_REMCHG         = 78;
    static const vm_int_t PW_LIBACC         = 79;
    static const vm_int_t PW_LIBBAD         = 80;
    static const vm_int_t PW_LIBSCN         = 81;
    static const vm_int_t PW_LIBMAX         = 82;
    static const vm_int_t PW_LIBEXEC        = 83;
    static const vm_int_t PW_ILSEQ          = 84;
    static const vm_int_t PW_RESTART        = 85;
    static const vm_int_t PW_STRPIPE        = 86;
    static const vm_int_t PW_USERS          = 87;
    static const vm_int_t PW_NOTSOCK        = 88;
    static const vm_int_t PW_DESTADDRREQ    = 89;
    static const vm_int_t PW_MSGSIZE        = 90;
    static const vm_int_t PW_PROTOTYPE      = 91;
    static const vm_int_t PW_NOPROTOOPT     = 92;
    static const vm_int_t PW_PROTONOSUPPORT = 93;
    static const vm_int_t PW_SOCKTNOSUPPORT = 94;
    static const vm_int_t PW_OPNOTSUPP      = 95;
    static const vm_int_t PW_NOTSUP         = PW_OPNOTSUPP;
    static const vm_int_t PW_PFNOSUPPORT    = 96;
    static const vm_int_t PW_AFNOSUPPORT    = 97;
    static const vm_int_t PW_ADDRINUSE      = 98;
    static const vm_int_t PW_ADDRNOTAVAIL   = 99;
    static const vm_int_t PW_NETDOWN        = 100;
    static const vm_int_t PW_NETUNREACH     = 101;
    static const vm_int_t PW_NETRESET       = 102;
    static const vm_int_t PW_CONNABORTED    = 103;
    static const vm_int_t PW_CONNRESET      = 104;
    static const vm_int_t PW_NOBUFS         = 105;
    static const vm_int_t PW_ISCONN         = 106;
    static const vm_int_t PW_NOTCONN        = 107;
    static const vm_int_t PW_SHUTDOWN       = 108;
    static const vm_int_t PW_TOOMANYREFS    = 109;
    static const vm_int_t PW_TIMEDOUT       = 110;
    static const vm_int_t PW_CONNREFUSED    = 111;
    static const vm_int_t PW_HOSTDOWN       = 112;
    static const vm_int_t PW_HOSTUNREACH    = 113;
    static const vm_int_t PW_ALREADY        = 114;
    static const vm_int_t PW_INPROGRESS     = 115;
    static const vm_int_t PW_STALE          = 116;
    static const vm_int_t PW_UCLEAN         = 117;
    static const vm_int_t PW_NOTNAM         = 118;
    static const vm_int_t PW_NAVAIL         = 119;
    static const vm_int_t PW_ISNAM          = 120;
    static const vm_int_t PW_REMOTEIO       = 121;
    static const vm_int_t PW_DQUOT          = 122;
    static const vm_int_t PW_NOMEDIUM       = 123;
    static const vm_int_t PW_MEDIUMTYPE     = 124;
    static const vm_int_t PW_CANCELED       = 125;
    static const vm_int_t PW_NOKEY          = 126;
    static const vm_int_t PW_KEYEXPIRED     = 127;
    static const vm_int_t PW_KEYREVOKED     = 128;
    static const vm_int_t PW_KEYREJECTED    = 129;
    static const vm_int_t PW_OWNERDEAD      = 130;
    static const vm_int_t PW_NOTRECOVERABLE = 131;
    static const vm_int_t PW_RFKILL         = 132;
    static const vm_int_t PW_HWPOISON       = 133;

    /// errno
    const vm_int_t std_errno;

    /**
     * Constractor with errno.
     * @param std_errno Errno.
     */
    StdError(vm_int_t std_errno);
  };
}
