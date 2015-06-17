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

AC_DEFUN([ERL_INTERNAL_LIBS],
[

ERTS_INTERNAL_X_LIBS=

AC_CHECK_LIB(kstat, kstat_open,
[AC_DEFINE(HAVE_KSTAT, 1, [Define if you have kstat])
ERTS_INTERNAL_X_LIBS="$ERTS_INTERNAL_X_LIBS -lkstat"])

AC_SUBST(ERTS_INTERNAL_X_LIBS)[]dnl
])# ERL_INTERNAL_LIBS
