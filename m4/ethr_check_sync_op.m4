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

AC_DEFUN([ETHR_CHK_SYNC_OP],
[
    AC_MSG_CHECKING([for $3-bit $1()])
    case "$2" in
        "1") sync_call="$1(&var);";;
        "2") sync_call="$1(&var, ($4) 0);";;
        "3") sync_call="$1(&var, ($4) 0, ($4) 0);";;
    esac
    have_sync_op=no
    AC_TRY_LINK([],
        [
            $4 res;
            volatile $4 var;
            res = $sync_call
        ],
        [have_sync_op=yes])
    test $have_sync_op = yes && $5
    AC_MSG_RESULT([$have_sync_op])[]dnl
])# ETHR_CHK_SYNC_OP
