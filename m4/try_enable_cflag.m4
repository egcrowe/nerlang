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
dnl LM_TRY_ENABLE_CFLAG
dnl
dnl
dnl Tries a CFLAG and sees if it can be enabled without compiler errors
dnl $1: textual cflag to add
dnl $2: variable to store the modified CFLAG in
dnl Usage example LM_TRY_ENABLE_CFLAG([-Werror=return-type], [CFLAGS])
dnl
dnl
AC_DEFUN([LM_TRY_ENABLE_CFLAG], [
    AC_MSG_CHECKING([if we can add $1 to $2 (via CFLAGS)])
    saved_CFLAGS=$CFLAGS;
    CFLAGS="$1 $$2";
    AC_TRY_COMPILE([],[return 0;],can_enable_flag=true,can_enable_flag=false)
    CFLAGS=$saved_CFLAGS;
    if test "X$can_enable_flag" = "Xtrue"; then
        AC_MSG_RESULT([yes])
        AS_VAR_SET($2, "$1 $$2")
    else
        AC_MSG_RESULT([no])
    fi[]dnl
])# LM_TRY_ENABLE_CFLAG
