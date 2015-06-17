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
dnl LM_CHECK_THR_LIB
dnl
dnl This macro may be used by any OTP application.
dnl
dnl LM_CHECK_THR_LIB sets THR_LIBS, THR_DEFS, and THR_LIB_NAME. It also
dnl checks for some pthread headers which will appear in DEFS or config.h.
dnl

AC_DEFUN([LM_CHECK_THR_LIB],
[

NEED_NPTL_PTHREAD_H=no

dnl win32?
AC_MSG_CHECKING([for native win32 threads])
if test "X$host_os" = "Xwin32"; then
    AC_MSG_RESULT(yes)
    THR_DEFS="-DWIN32_THREADS"
    THR_LIBS=
    THR_LIB_NAME=win32_threads
    THR_LIB_TYPE=win32_threads
elif test "X$host_os" = "Xose"; then
    AC_MSG_RESULT(yes)
    THR_DEFS="-DOSE_THREADS"
    THR_LIBS=
    THR_LIB_NAME=ose_threads
    THR_LIB_TYPE=ose_threads
else
    AC_MSG_RESULT(no)
    THR_DEFS=
    THR_LIBS=
    THR_LIB_NAME=
    THR_LIB_TYPE=posix_unknown

dnl Try to find POSIX threads

dnl The usual pthread lib...
    AC_CHECK_LIB(pthread, pthread_create, THR_LIBS="-lpthread")

dnl Very old versions of FreeBSD have pthreads in special c library, c_r...
    if test "x$THR_LIBS" = "x"; then
        AC_CHECK_LIB(c_r, pthread_create, THR_LIBS="-lc_r")
    fi

dnl QNX has pthreads in standard C library
    if test "x$THR_LIBS" = "x"; then
        AC_CHECK_FUNC(pthread_create, THR_LIBS="none_needed")
    fi

dnl On ofs1 the '-pthread' switch should be used
    if test "x$THR_LIBS" = "x"; then
        AC_MSG_CHECKING([if the '-pthread' switch can be used])
        saved_cflags=$CFLAGS
        CFLAGS="$CFLAGS -pthread"
        AC_TRY_LINK([#include <pthread.h>],
                    pthread_create((void*)0,(void*)0,(void*)0,(void*)0);,
                    [THR_DEFS="-pthread"
                     THR_LIBS="-pthread"])
        CFLAGS=$saved_cflags
        if test "x$THR_LIBS" != "x"; then
            AC_MSG_RESULT(yes)
        else
            AC_MSG_RESULT(no)
        fi
    fi

    if test "x$THR_LIBS" != "x"; then
        THR_DEFS="$THR_DEFS -D_THREAD_SAFE -D_REENTRANT -DPOSIX_THREADS"
        THR_LIB_NAME=pthread
        if test "x$THR_LIBS" = "xnone_needed"; then
            THR_LIBS=
        fi
        case $host_os in
            solaris*)
                THR_DEFS="$THR_DEFS -D_POSIX_PTHREAD_SEMANTICS" ;;
            linux*)
                THR_DEFS="$THR_DEFS -D_POSIX_THREAD_SAFE_FUNCTIONS"

                LM_CHECK_GETCONF
                AC_MSG_CHECKING(for Native POSIX Thread Library)
                libpthr_vsn=`$GETCONF GNU_LIBPTHREAD_VERSION 2>/dev/null`
                if test $? -eq 0; then
                    case "$libpthr_vsn" in
                        *nptl*|*NPTL*) nptl=yes;;
                        *) nptl=no;;
                    esac
                elif test "$cross_compiling" = "yes"; then
                    case "$erl_xcomp_linux_nptl" in
                        "") nptl=cross;;
                        yes|no) nptl=$erl_xcomp_linux_nptl;;
                        *) AC_MSG_ERROR([Bad erl_xcomp_linux_nptl value: \
                                         $erl_xcomp_linux_nptl]);;
                    esac
                else
                    nptl=no
                fi
                AC_MSG_RESULT($nptl)
                if test $nptl = cross; then
                  nptl=yes
                  AC_MSG_WARN([result yes guessed because of cross compilation])
                fi
                if test $nptl = yes; then
                    THR_LIB_TYPE=posix_nptl
                    need_nptl_incldir=no
                    AC_CHECK_HEADER(nptl/pthread.h,
                                    [need_nptl_incldir=yes
                                     NEED_NPTL_PTHREAD_H=yes])
                    if test $need_nptl_incldir = yes; then
                        # Ahh...
                        nptl_path="$C_INCLUDE_PATH:$CPATH"
                        if test X$cross_compiling != Xyes; then
                          nptl_path="$nptl_path:/usr/local/include:/usr/include"
                        else
                            IROOT="$erl_xcomp_isysroot"
                            test "$IROOT" != "" || IROOT="$erl_xcomp_sysroot"
                            test "$IROOT" != "" ||
                             AC_MSG_ERROR([Don't know where to search for \
                                      includes! Please set erl_xcomp_isysroot])
             nptl_path="$nptl_path:$IROOT/usr/local/include:$IROOT/usr/include"
                        fi
                        nptl_ws_path=
                        save_ifs="$IFS"; IFS=":"
                        for dir in $nptl_path; do
                            if test "x$dir" != "x"; then
                                nptl_ws_path="$nptl_ws_path $dir"
                            fi
                        done
                        IFS=$save_ifs
                        nptl_incldir=
                        for dir in $nptl_ws_path; do
                            AC_CHECK_HEADER($dir/nptl/pthread.h,
                                            nptl_incldir=$dir/nptl)
                            if test "x$nptl_incldir" != "x"; then
                                THR_DEFS="$THR_DEFS -isystem $nptl_incldir"
                                break
                            fi
                        done
                        if test "x$nptl_incldir" = "x"; then
                   AC_MSG_ERROR(Failed to locate nptl system include directory)
                        fi
                    fi
                fi
                ;;
            *) ;;
        esac

        dnl We sometimes need THR_DEFS in order to find certain headers
        dnl (at least for pthread.h on osf1).
        saved_cppflags=$CPPFLAGS
        CPPFLAGS="$CPPFLAGS $THR_DEFS"

        dnl
        dnl Check for headers
        dnl

        AC_CHECK_HEADER(pthread.h,
                        AC_DEFINE(HAVE_PTHREAD_H, 1, \
[Define if you have the <pthread.h> header file.]))

        dnl Some Linuxes have <pthread/mit/pthread.h> instead of <pthread.h>
        AC_CHECK_HEADER(pthread/mit/pthread.h, \
                        AC_DEFINE(HAVE_MIT_PTHREAD_H, 1, \
[Define if the pthread.h header file is in pthread/mit directory.]))

        dnl restore CPPFLAGS
        CPPFLAGS=$saved_cppflags

    fi
fi[]dnl
])# LM_CHECK_THR_LIB
