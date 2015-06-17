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
dnl LM_STRUCT_SOCKADDR_SA_LEN
dnl
dnl Check if the sockaddr structure has the field sa_len
dnl

AC_DEFUN([LM_STRUCT_SOCKADDR_SA_LEN],
[AC_CACHE_CHECK([whether struct sockaddr has sa_len field],
                ac_cv_struct_sockaddr_sa_len,
AC_TRY_COMPILE([#include <sys/types.h>
#include <sys/socket.h>], [struct sockaddr s; s.sa_len = 10;],
  ac_cv_struct_sockaddr_sa_len=yes, ac_cv_struct_sockaddr_sa_len=no))

dnl FIXME convbreak
case ${ac_cv_struct_sockaddr_sa_len} in
  "no" ) AC_DEFINE(NO_SA_LEN,[1],[Define if you dont have salen]) ;;
  *) ;;
esac[]dnl
])# LM_STRUCT_SOCKADDR_SA_LEN
