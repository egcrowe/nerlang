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

AC_DEFUN([ETHR_CHK_INTERLOCKED],
[
    ilckd="$1"
    AC_MSG_CHECKING([for ${ilckd}()])
    case "$2" in
        "1") ilckd_call="${ilckd}(var);";;
        "2") ilckd_call="${ilckd}(var, ($3) 0);";;
        "3") ilckd_call="${ilckd}(var, ($3) 0, ($3) 0);";;
        "4") ilckd_call="${ilckd}(var, ($3) 0, ($3) 0, arr);";;
    esac
    have_interlocked_op=no
    AC_TRY_LINK(
        [
        #define WIN32_LEAN_AND_MEAN
        #include <windows.h>
        #include <intrin.h>
        ],
        [
            volatile $3 *var;
            volatile $3 arr[2];

            $ilckd_call
            return 0;
        ],
        [have_interlocked_op=yes])
    test $have_interlocked_op = yes && $4
    AC_MSG_RESULT([$have_interlocked_op])[]dnl
])# ETHR_CHK_INTERLOCKED
