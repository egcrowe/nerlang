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
dnl LM_STRUCT_EXCEPTION
dnl
dnl Check to see whether the system supports the matherr function
dnl and its associated type "struct exception".
dnl

AC_DEFUN([LM_STRUCT_EXCEPTION],
[AC_CACHE_CHECK([for struct exception (and matherr function)],
 ac_cv_struct_exception,
AC_TRY_COMPILE([#include <math.h>],
  [struct exception x; x.type = DOMAIN; x.type = SING;],
  ac_cv_struct_exception=yes, ac_cv_struct_exception=no))

case "${ac_cv_struct_exception}" in
  "yes" ) AC_DEFINE(USE_MATHERR,[1],
           [Define if you have matherr() function and struct exception type]) ;;
  *  ) ;;
esac[]dnl
])# LM_STRUCT_EXCEPTION
