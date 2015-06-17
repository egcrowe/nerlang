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

AC_DEFUN([LM_CHECK_GETCONF],
[
if test "$cross_compiling" != "yes"; then
    AC_CHECK_PROG([GETCONF], [getconf], [getconf], [false])
else
    dnl First check if we got a `<HOST>-getconf' in $PATH
    host_getconf="$host_alias-getconf"
    AC_CHECK_PROG([GETCONF], [$host_getconf], [$host_getconf], [false])
    if test "$GETCONF" = "false" && test "$erl_xcomp_sysroot" != ""; then
        dnl We should perhaps give up if we have'nt found it by now, but at
        dnl least in one Tilera MDE `getconf' under sysroot is a bourne
        dnl shell script which we can use. We try to find `<HOST>-getconf'
        dnl or `getconf' under sysconf, but only under sysconf since
        dnl `getconf' in $PATH is almost guaranteed to be for the build
        dnl machine.
        GETCONF=
        prfx="$erl_xcomp_sysroot"
        AC_PATH_TOOL([GETCONF], [getconf], [false],
                     ["$prfx/usr/bin:$prfx/bin:$prfx/usr/local/bin"])
    fi
fi[]dnl
])# LM_CHECK_GETCONF
