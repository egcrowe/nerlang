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
dnl LM_DECL_SO_BSDCOMPAT
dnl
dnl Check if the system has the SO_BSDCOMPAT flag on sockets (linux)
dnl
AC_DEFUN([LM_DECL_SO_BSDCOMPAT],
[AC_CACHE_CHECK([for SO_BSDCOMPAT declaration], ac_cv_decl_so_bsdcompat,
AC_TRY_COMPILE([#include <sys/socket.h>], [int i = SO_BSDCOMPAT;],
               ac_cv_decl_so_bsdcompat=yes,
               ac_cv_decl_so_bsdcompat=no))

case "${ac_cv_decl_so_bsdcompat}" in
  "yes" ) AC_DEFINE(HAVE_SO_BSDCOMPAT,[],
                [Define if you have SO_BSDCOMPAT flag on sockets]) ;;
  * ) ;;
esac[]dnl
])# LM_DECL_SO_BSDCOMPAT
