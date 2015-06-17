dnl
dnl %CopyrightBegin%
dnl
dnl Copyright Ericsson AB 1998-2013. All Rights Reserved.
dnl
dnl The contents of this file are subject to the Erlang Public License,
dnl Version 1.1, (the "License"); you may not use this file except in
dnl compliance with the License. You should have received a copy of the
dnl Erlang Public License along with this software. If not, it can be
dnl retrieved online at http://www.erlang.org/.
dnl
dnl Software distributed under the License is distributed on an "AS IS"
dnl basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
dnl the License for the specific language governing rights and limitations
dnl under the License.
dnl
dnl %CopyrightEnd%
dnl

dnl ----------------------------------------------------------------------
dnl
dnl LM_SYS_IPV6
dnl
dnl Check for ipv6 support and what the in6_addr structure is called.
dnl (early linux used in_addr6 insted of in6_addr)
dnl

AC_DEFUN([LM_SYS_IPV6],
[AC_MSG_CHECKING(for IP version 6 support)
AC_CACHE_VAL(ac_cv_sys_ipv6_support,
[ok_so_far=yes
 AC_TRY_COMPILE([#include <sys/types.h>
#ifdef __WIN32__
#include <winsock2.h>
#include <ws2tcpip.h>
#elif __OSE__
#error "no ipv6"
#else
#include <netinet/in.h>
#endif],
   [struct in6_addr a6; struct sockaddr_in6 s6;], ok_so_far=yes, ok_so_far=no)

if test $ok_so_far = yes; then
  ac_cv_sys_ipv6_support=yes
else
  AC_TRY_COMPILE([#include <sys/types.h>
#ifdef __WIN32__
#include <winsock2.h>
#include <ws2tcpip.h>
#elif __OSE__
#error "no ipv6"
#else
#include <netinet/in.h>
#endif],
    [struct in_addr6 a6; struct sockaddr_in6 s6;],
    ac_cv_sys_ipv6_support=in_addr6, ac_cv_sys_ipv6_support=no)
fi
])dnl

dnl
dnl Have to use old style AC_DEFINE due to BC with old autoconf.
dnl

case ${ac_cv_sys_ipv6_support} in
  yes)
    AC_MSG_RESULT(yes)
    AC_DEFINE(HAVE_IN6,[1],[Define if ipv6 is present])
    ;;
  in_addr6)
    AC_MSG_RESULT([yes (but I am redefining in_addr6 to in6_addr)])
    AC_DEFINE(HAVE_IN6,[1],[Define if ipv6 is present])
    AC_DEFINE(HAVE_IN_ADDR6_STRUCT,[],
     [Early linux used in_addr6 instead of in6_addr, define if you have this])
    ;;
  *)
    AC_MSG_RESULT(no)
    ;;
esac[]dnl
])# LM_SYS_IPV6
