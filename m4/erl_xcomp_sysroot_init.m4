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

AC_DEFUN([ERL_XCOMP_SYSROOT_INIT],
[
erl_xcomp_without_sysroot=no
if test "$cross_compiling" = "yes"; then
    test "$erl_xcomp_sysroot" != "" || erl_xcomp_without_sysroot=yes
    test "$erl_xcomp_isysroot" != "" || erl_xcomp_isysroot="$erl_xcomp_sysroot"
else
    erl_xcomp_sysroot=
    erl_xcomp_isysroot=
fi[]dnl
])# ERL_XCOMP_SYSROOT_INIT
