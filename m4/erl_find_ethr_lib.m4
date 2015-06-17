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
dnl ERL_FIND_ETHR_LIB
dnl
dnl NOTE! This macro may be changed at any time! Should *only* be used by
dnl       ERTS!
dnl
dnl Find a thread library to use. Sets ETHR_LIBS to libraries to link
dnl with, ETHR_X_LIBS to extra libraries to link with (same as ETHR_LIBS
dnl except that the ethread lib itself is not included), ETHR_DEFS to
dnl defines to compile with, ETHR_THR_LIB_BASE to the name of the
dnl thread library which the ethread library is based on, and ETHR_LIB_NAME
dnl to the name of the library where the ethread implementation is located.
dnl  ERL_FIND_ETHR_LIB currently searches for 'pthreads', and
dnl 'win32_threads'. If no thread library was found ETHR_LIBS, ETHR_X_LIBS,
dnl ETHR_DEFS, ETHR_THR_LIB_BASE, and ETHR_LIB_NAME are all set to the
dnl empty string.
dnl

AC_DEFUN([ERL_FIND_ETHR_LIB],
[

AC_ARG_ENABLE(native-ethr-impls,
              AS_HELP_STRING([--disable-native-ethr-impls],
                             [disable native ethread implementations]),
[ case "$enableval" in
    no) disable_native_ethr_impls=yes ;;
    *)  disable_native_ethr_impls=no ;;
  esac ], disable_native_ethr_impls=no)

test "X$disable_native_ethr_impls" = "Xyes" &&
  AC_DEFINE(ETHR_DISABLE_NATIVE_IMPLS, 1,
   [Define if you want to disable native ethread implementations])

AC_ARG_ENABLE(x86-out-of-order,
              AS_HELP_STRING(
               [--enable-x86-out-of-order],
               [enable x86/x84_64 out of order support (default disabled)]))

AC_ARG_ENABLE(prefer-gcc-native-ethr-impls,
              AS_HELP_STRING([--enable-prefer-gcc-native-ethr-impls],
                             [prefer gcc native ethread implementations]),
[ case "$enableval" in
    yes) enable_prefer_gcc_native_ethr_impls=yes ;;
    *)  enable_prefer_gcc_native_ethr_impls=no ;;
  esac ], enable_prefer_gcc_native_ethr_impls=no)

test $enable_prefer_gcc_native_ethr_impls = yes &&
  AC_DEFINE(ETHR_PREFER_GCC_NATIVE_IMPLS, 1,
   [Define if you prefer gcc native ethread implementations])

AC_ARG_WITH(libatomic_ops,
            AS_HELP_STRING(
             [--with-libatomic_ops=PATH],
             [specify and prefer usage of libatomic_ops in the ethread library]))

AC_ARG_WITH(with_sparc_memory_order,
            AS_HELP_STRING([--with-sparc-memory-order=TSO|PSO|RMO],
                           [specify sparc memory order (defaults to RMO)]))

LM_CHECK_THR_LIB
ERL_INTERNAL_LIBS

ethr_have_native_atomics=no
ethr_have_native_spinlock=no
ETHR_THR_LIB_BASE="$THR_LIB_NAME"
ETHR_THR_LIB_BASE_TYPE="$THR_LIB_TYPE"
ETHR_DEFS="$THR_DEFS"
ETHR_X_LIBS="$THR_LIBS $ERTS_INTERNAL_X_LIBS"
ETHR_LIBS=
ETHR_LIB_NAME=

ethr_modified_default_stack_size=

dnl Name of lib where ethread implementation is located
ethr_lib_name=ethread

case "$THR_LIB_NAME" in

    win32_threads)
        ETHR_THR_LIB_BASE_DIR=win
        # * _WIN32_WINNT >= 0x0400 is needed for
        #   TryEnterCriticalSection
        # * _WIN32_WINNT >= 0x0403 is needed for
        #   InitializeCriticalSectionAndSpinCount
        # The ethread lib will refuse to build if _WIN32_WINNT < 0x0403.
        #
        # -D_WIN32_WINNT should have been defined in $CPPFLAGS; fetch it
        # and save it in ETHR_DEFS.
        found_win32_winnt=no
        for cppflag in $CPPFLAGS; do
            case $cppflag in
                -DWINVER*)
                    ETHR_DEFS="$ETHR_DEFS $cppflag"
                    ;;
                -D_WIN32_WINNT*)
                    ETHR_DEFS="$ETHR_DEFS $cppflag"
                    found_win32_winnt=yes
                    ;;
                *)
                    ;;
            esac
        done
        if test $found_win32_winnt = no; then
            AC_MSG_ERROR([-D_WIN32_WINNT missing in CPPFLAGS])
        fi

        AC_DEFINE(ETHR_WIN32_THREADS, 1, [Define if you have win32 threads])

        if test "X$disable_native_ethr_impls" = "Xyes"; then
            have_interlocked_op=no
            ethr_have_native_atomics=no
        else
            ETHR_CHK_INTERLOCKED([_InterlockedDecrement], [1], [long],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDDECREMENT, 1,
 [Define if you have _InterlockedDecrement()]))
            ETHR_CHK_INTERLOCKED([_InterlockedDecrement_rel], [1], [long],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDDECREMENT_REL, 1,
 [Define if you have _InterlockedDecrement_rel()]))
            ETHR_CHK_INTERLOCKED([_InterlockedIncrement], [1], [long],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDINCREMENT, 1,
 [Define if you have _InterlockedIncrement()]))
            ETHR_CHK_INTERLOCKED([_InterlockedIncrement_acq], [1], [long],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDINCREMENT_ACQ, 1,
 [Define if you have _InterlockedIncrement_acq()]))
            ETHR_CHK_INTERLOCKED([_InterlockedExchangeAdd], [2], [long],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDEXCHANGEADD, 1,
 [Define if you have _InterlockedExchangeAdd()]))
            ETHR_CHK_INTERLOCKED([_InterlockedExchangeAdd_acq], [2], [long],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDEXCHANGEADD_ACQ, 1,
 [Define if you have _InterlockedExchangeAdd_acq()]))
            ETHR_CHK_INTERLOCKED([_InterlockedAnd], [2], [long],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDAND, 1,
 [Define if you have _InterlockedAnd()]))
            ETHR_CHK_INTERLOCKED([_InterlockedOr], [2], [long],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDOR, 1,
 [Define if you have _InterlockedOr()]))
            ETHR_CHK_INTERLOCKED([_InterlockedExchange], [2], [long],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDEXCHANGE, 1,
 [Define if you have _InterlockedExchange()]))
            ETHR_CHK_INTERLOCKED([_InterlockedCompareExchange], [3], [long],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDCOMPAREEXCHANGE, 1,
 [Define if you have _InterlockedCompareExchange()]))
            test "$have_interlocked_op" = "yes" && ethr_have_native_atomics=yes
            ETHR_CHK_INTERLOCKED([_InterlockedCompareExchange_acq], [3], [long],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDCOMPAREEXCHANGE_ACQ, 1,
 [Define if you have _InterlockedCompareExchange_acq()]))
            test "$have_interlocked_op" = "yes" && ethr_have_native_atomics=yes
            ETHR_CHK_INTERLOCKED([_InterlockedCompareExchange_rel], [3], [long],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDCOMPAREEXCHANGE_REL, 1,
 [Define if you have _InterlockedCompareExchange_rel()]))
            test "$have_interlocked_op" = "yes" && ethr_have_native_atomics=yes
            ETHR_CHK_INTERLOCKED([_InterlockedDecrement64], [1], [__int64],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDDECREMENT64, 1,
 [Define if you have _InterlockedDecrement64()]))
            ETHR_CHK_INTERLOCKED([_InterlockedDecrement64_rel], [1], [__int64],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDDECREMENT64_REL, 1,
 [Define if you have _InterlockedDecrement64_rel()]))
            ETHR_CHK_INTERLOCKED([_InterlockedIncrement64], [1], [__int64],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDINCREMENT64, 1,
 [Define if you have _InterlockedIncrement64()]))
            ETHR_CHK_INTERLOCKED([_InterlockedIncrement64_acq], [1], [__int64],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDINCREMENT64_ACQ, 1,
 [Define if you have _InterlockedIncrement64_acq()]))
            ETHR_CHK_INTERLOCKED([_InterlockedExchangeAdd64], [2], [__int64],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDEXCHANGEADD64, 1,
 [Define if you have _InterlockedExchangeAdd64()]))
            ETHR_CHK_INTERLOCKED([_InterlockedExchangeAdd64_acq], [2], [__int64],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDEXCHANGEADD64_ACQ, 1,
 [Define if you have _InterlockedExchangeAdd64_acq()]))
            ETHR_CHK_INTERLOCKED([_InterlockedAnd64], [2], [__int64],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDAND64, 1,
 [Define if you have _InterlockedAnd64()]))
            ETHR_CHK_INTERLOCKED([_InterlockedOr64], [2], [__int64],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDOR64, 1,
 [Define if you have _InterlockedOr64()]))
            ETHR_CHK_INTERLOCKED([_InterlockedExchange64], [2], [__int64],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDEXCHANGE64, 1,
 [Define if you have _InterlockedExchange64()]))
            ETHR_CHK_INTERLOCKED([_InterlockedCompareExchange64], [3], [__int64],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDCOMPAREEXCHANGE64, 1,
 [Define if you have _InterlockedCompareExchange64()]))
            test "$have_interlocked_op" = "yes" && ethr_have_native_atomics=yes
            ETHR_CHK_INTERLOCKED([_InterlockedCompareExchange64_acq], [3], [__int64],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDCOMPAREEXCHANGE64_ACQ, 1,
 [Define if you have _InterlockedCompareExchange64_acq()]))
            test "$have_interlocked_op" = "yes" && ethr_have_native_atomics=yes
            ETHR_CHK_INTERLOCKED([_InterlockedCompareExchange64_rel], [3], [__int64],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDCOMPAREEXCHANGE64_REL, 1,
 [Define if you have _InterlockedCompareExchange64_rel()]))
            test "$have_interlocked_op" = "yes" && ethr_have_native_atomics=yes

            ETHR_CHK_INTERLOCKED([_InterlockedCompareExchange128], [4], [__int64],
 AC_DEFINE_UNQUOTED(ETHR_HAVE__INTERLOCKEDCOMPAREEXCHANGE128, 1,
 [Define if you have _InterlockedCompareExchange128()]))
        fi
        test "$ethr_have_native_atomics" = "yes" && ethr_have_native_spinlock=yes
        ;;

    pthread|ose_threads)
        case "$THR_LIB_NAME" in
             pthread)
                ETHR_THR_LIB_BASE_DIR=pthread
                AC_DEFINE(ETHR_PTHREADS, 1, [Define if you have pthreads])
                ;;
             ose_threads)
                AC_DEFINE(ETHR_OSE_THREADS, 1,
                   [Define if you have OSE style threads])
                ETHR_THR_LIB_BASE_DIR=ose
                AC_CHECK_HEADER(ose_spi/ose_spi.h,
                  AC_DEFINE(HAVE_OSE_SPI_H, 1,
                    [Define if you have the "ose_spi/ose_spi.h" header file.]))
                ;;
        esac
        if test "x$THR_LIB_NAME" = "xpthread"; then
        case $host_os in
            openbsd*)
                # The default stack size is insufficient for our needs
                # on OpenBSD. We increase it to 256 kilo words.
                ethr_modified_default_stack_size=256;;
            linux*)
                ETHR_DEFS="$ETHR_DEFS -D_GNU_SOURCE"

                if test X$cross_compiling = Xyes; then
                    case X$erl_xcomp_linux_usable_sigusrx in
                      X)
                        usable_sigusrx=cross;;
                      Xyes|Xno)
                        usable_sigusrx=$erl_xcomp_linux_usable_sigusrx;;
                      *)
                        AC_MSG_ERROR([Bad erl_xcomp_linux_usable_sigusrx value:\
                                      $erl_xcomp_linux_usable_sigusrx]);;
                    esac
                    case X$erl_xcomp_linux_usable_sigaltstack in
                      X)
                        usable_sigaltstack=cross;;
                      Xyes|Xno)
                        usable_sigaltstack=$erl_xcomp_linux_usable_sigaltstack;;
                      *)
                        AC_MSG_ERROR([Bad erl_xcomp_linux_usable_sigaltstack \
                         value: $erl_xcomp_linux_usable_sigaltstack]);;
                    esac
                else
                    # FIXME: Test for actual problems instead of kernel versions
                    linux_kernel_vsn_=`uname -r`
                    case $linux_kernel_vsn_ in
                        [[0-1]].*|2.[[0-1]]|2.[[0-1]].*)
                            usable_sigusrx=no
                            usable_sigaltstack=no;;
                        2.[[2-3]]|2.[[2-3]].*)
                            usable_sigusrx=yes
                            usable_sigaltstack=no;;
                        *)
                            usable_sigusrx=yes
                            usable_sigaltstack=yes;;
                    esac
                fi

                AC_MSG_CHECKING(if SIGUSR1 and SIGUSR2 can be used)
                AC_MSG_RESULT($usable_sigusrx)
                if test $usable_sigusrx = cross; then
                    usable_sigusrx=yes
                    AC_MSG_WARN([result yes guessed because of cross compilation])
                fi
                if test $usable_sigusrx = no; then
                    ETHR_DEFS="$ETHR_DEFS -DETHR_UNUSABLE_SIGUSRX"
                fi

                AC_MSG_CHECKING(if sigaltstack can be used)
                AC_MSG_RESULT($usable_sigaltstack)
                if test $usable_sigaltstack = cross; then
                    usable_sigaltstack=yes
                    AC_MSG_WARN([result yes guessed because of cross compilation])
                fi
                if test $usable_sigaltstack = no; then
                    ETHR_DEFS="$ETHR_DEFS -DETHR_UNUSABLE_SIGALTSTACK"
                fi
                ;;
            *) ;;
        esac

        fi
        dnl We sometimes need ETHR_DEFS in order to find certain headers
        dnl (at least for pthread.h on osf1).
        saved_cppflags="$CPPFLAGS"
        CPPFLAGS="$CPPFLAGS $ETHR_DEFS"

        dnl We need the thread library in order to find some functions
        saved_libs="$LIBS"
        LIBS="$LIBS $ETHR_X_LIBS"

        dnl
        dnl Check for headers
        dnl
        AC_CHECK_HEADER(pthread.h, \
                        AC_DEFINE(ETHR_HAVE_PTHREAD_H, 1, \
[Define if you have the <pthread.h> header file.]))

        dnl Some Linuxes have <pthread/mit/pthread.h> instead of <pthread.h>
        AC_CHECK_HEADER(pthread/mit/pthread.h, \
                        AC_DEFINE(ETHR_HAVE_MIT_PTHREAD_H, 1, \
[Define if the pthread.h header file is in pthread/mit directory.]))

        if test $NEED_NPTL_PTHREAD_H = yes; then
            AC_DEFINE(ETHR_NEED_NPTL_PTHREAD_H, 1, \
[Define if you need the <nptl/pthread.h> header file.])
        fi

        AC_CHECK_HEADER(sched.h, \
                        AC_DEFINE(ETHR_HAVE_SCHED_H, 1, \
[Define if you have the <sched.h> header file.]))

        AC_CHECK_HEADER(sys/time.h, \
                        AC_DEFINE(ETHR_HAVE_SYS_TIME_H, 1, \
[Define if you have the <sys/time.h> header file.]))

        AC_TRY_COMPILE([#include <time.h>
                        #include <sys/time.h>],
                        [struct timeval *tv; return 0;],
                        AC_DEFINE(ETHR_TIME_WITH_SYS_TIME, 1, \
[Define if you can safely include both <sys/time.h> and <time.h>.]))


        dnl
        dnl Check for functions
        dnl
        if test "x$THR_LIB_NAME" = "xpthread"; then
        AC_CHECK_FUNC(pthread_spin_lock, \
                        [ethr_have_native_spinlock=yes \
                         AC_DEFINE(ETHR_HAVE_PTHREAD_SPIN_LOCK, 1, \
[Define if you have the pthread_spin_lock function.])])

        have_sched_yield=no
        have_librt_sched_yield=no
        AC_CHECK_FUNC(sched_yield, [have_sched_yield=yes])
        if test $have_sched_yield = no; then
            AC_CHECK_LIB(rt, sched_yield,
                         [have_librt_sched_yield=yes
                          ETHR_X_LIBS="$ETHR_X_LIBS -lrt"])
        fi
        if test $have_sched_yield = yes || test $have_librt_sched_yield = yes; then
            AC_DEFINE(ETHR_HAVE_SCHED_YIELD, 1, [Define if you have the sched_yield() function.])
            AC_MSG_CHECKING([whether sched_yield() returns an int])
            sched_yield_ret_int=no
            AC_TRY_COMPILE([
                                #ifdef ETHR_HAVE_SCHED_H
                                #include <sched.h>
                                #endif
                           ],
                           [int sched_yield();],
                           [sched_yield_ret_int=yes])
            AC_MSG_RESULT([$sched_yield_ret_int])
            if test $sched_yield_ret_int = yes; then
                AC_DEFINE(ETHR_SCHED_YIELD_RET_INT, 1, [Define if sched_yield() returns an int.])
            fi
        fi

        have_pthread_yield=no
        AC_CHECK_FUNC(pthread_yield, [have_pthread_yield=yes])
        if test $have_pthread_yield = yes; then
            AC_DEFINE(ETHR_HAVE_PTHREAD_YIELD, 1, [Define if you have the pthread_yield() function.])
            AC_MSG_CHECKING([whether pthread_yield() returns an int])
            pthread_yield_ret_int=no
            AC_TRY_COMPILE([
                                #if defined(ETHR_NEED_NPTL_PTHREAD_H)
                                #include <nptl/pthread.h>
                                #elif defined(ETHR_HAVE_MIT_PTHREAD_H)
                                #include <pthread/mit/pthread.h>
                                #elif defined(ETHR_HAVE_PTHREAD_H)
                                #include <pthread.h>
                                #endif
                           ],
                           [int pthread_yield();],
                           [pthread_yield_ret_int=yes])
            AC_MSG_RESULT([$pthread_yield_ret_int])
            if test $pthread_yield_ret_int = yes; then
                AC_DEFINE(ETHR_PTHREAD_YIELD_RET_INT, 1, [Define if pthread_yield() returns an int.])
            fi
        fi

        have_pthread_rwlock_init=no
        AC_CHECK_FUNC(pthread_rwlock_init, [have_pthread_rwlock_init=yes])
        if test $have_pthread_rwlock_init = yes; then

            ethr_have_pthread_rwlockattr_setkind_np=no
            AC_CHECK_FUNC(pthread_rwlockattr_setkind_np,
                          [ethr_have_pthread_rwlockattr_setkind_np=yes])

            if test $ethr_have_pthread_rwlockattr_setkind_np = yes; then
                AC_DEFINE(ETHR_HAVE_PTHREAD_RWLOCKATTR_SETKIND_NP, 1, \
[Define if you have the pthread_rwlockattr_setkind_np() function.])

                AC_MSG_CHECKING([for PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP])
                ethr_pthread_rwlock_writer_nonrecursive_initializer_np=no
                AC_TRY_LINK([
                                #if defined(ETHR_NEED_NPTL_PTHREAD_H)
                                #include <nptl/pthread.h>
                                #elif defined(ETHR_HAVE_MIT_PTHREAD_H)
                                #include <pthread/mit/pthread.h>
                                #elif defined(ETHR_HAVE_PTHREAD_H)
                                #include <pthread.h>
                                #endif
                            ],
                            [
                                pthread_rwlockattr_t *attr;
                                return pthread_rwlockattr_setkind_np(attr,
                                    PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP);
                            ],
                            [ethr_pthread_rwlock_writer_nonrecursive_initializer_np=yes])
                AC_MSG_RESULT([$ethr_pthread_rwlock_writer_nonrecursive_initializer_np])
                if test $ethr_pthread_rwlock_writer_nonrecursive_initializer_np = yes; then
                    AC_DEFINE(ETHR_HAVE_PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP, 1, \
[Define if you have the PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP rwlock attribute.])
                fi
            fi
        fi

        if test "$force_pthread_rwlocks" = "yes"; then

            AC_DEFINE(ETHR_FORCE_PTHREAD_RWLOCK, 1, \
[Define if you want to force usage of pthread rwlocks])

            if test $have_pthread_rwlock_init = yes; then
                AC_MSG_WARN([Forced usage of pthread rwlocks. Note that this \
                             implementation may suffer from starvation issues.])
            else
                AC_MSG_ERROR([User forced usage of pthread rwlock, but no such \
                              implementation was found])
            fi
        fi

        AC_CHECK_FUNC(pthread_attr_setguardsize, \
                        AC_DEFINE(ETHR_HAVE_PTHREAD_ATTR_SETGUARDSIZE, 1, \
[Define if you have the pthread_attr_setguardsize function.]))

        linux_futex=no
        AC_MSG_CHECKING([for Linux futexes])
        AC_TRY_LINK([
                        #include <sys/syscall.h>
                        #include <unistd.h>
                        #include <linux/futex.h>
                        #include <sys/time.h>
                    ],
                    [
                        int i = 1;
                        syscall(__NR_futex, (void *) &i, FUTEX_WAKE, 1,
                                (void*)0,(void*)0, 0);
                        syscall(__NR_futex, (void *) &i, FUTEX_WAIT, 0,
                                (void*)0,(void*)0, 0);
                        return 0;
                    ],
                    linux_futex=yes)
        AC_MSG_RESULT([$linux_futex])
        test $linux_futex = yes && AC_DEFINE(ETHR_HAVE_LINUX_FUTEX, 1,
                         [Define if you have a linux futex implementation.])

        fi

        AC_CHECK_SIZEOF(int)
        AC_CHECK_SIZEOF(long)
        AC_CHECK_SIZEOF(long long)
        AC_CHECK_SIZEOF(__int128_t)

        if test "$ac_cv_sizeof_int" = "4"; then
            int32="int"
        elif test "$ac_cv_sizeof_long" = "4"; then
            int32="long"
        elif test "$ac_cv_sizeof_long_long" = "4"; then
            int32="long long"
        else
            AC_MSG_ERROR([No 32-bit type found])
        fi

        if test "$ac_cv_sizeof_int" = "8"; then
            int64="int"
        elif test "$ac_cv_sizeof_long" = "8"; then
            int64="long"
        elif test "$ac_cv_sizeof_long_long" = "8"; then
            int64="long long"
        else
            AC_MSG_ERROR([No 64-bit type found])
        fi

        int128=no
        if test "$ac_cv_sizeof___int128_t" = "16"; then
            int128="__int128_t"
        fi

        if test "X$disable_native_ethr_impls" = "Xyes"; then
            ethr_have_native_atomics=no
        else
            ETHR_CHK_SYNC_OP([__sync_val_compare_and_swap], [3], [32], [$int32],
              AC_DEFINE(ETHR_HAVE___SYNC_VAL_COMPARE_AND_SWAP32, 1,
                [Define if you have __sync_val_compare_and_swap() for \
                 32-bit integers]))
            test "$have_sync_op" = "yes" && ethr_have_native_atomics=yes
            ETHR_CHK_SYNC_OP([__sync_add_and_fetch], [2], [32], [$int32],
              AC_DEFINE(ETHR_HAVE___SYNC_ADD_AND_FETCH32, 1,
               [Define if you have __sync_add_and_fetch() for 32-bit integers]))
            ETHR_CHK_SYNC_OP([__sync_fetch_and_and], [2], [32], [$int32],
              AC_DEFINE(ETHR_HAVE___SYNC_FETCH_AND_AND32, 1,
               [Define if you have __sync_fetch_and_and() for 32-bit integers]))
            ETHR_CHK_SYNC_OP([__sync_fetch_and_or], [2], [32], [$int32],
              AC_DEFINE(ETHR_HAVE___SYNC_FETCH_AND_OR32, 1,
               [Define if you have __sync_fetch_and_or() for 32-bit integers]))

            ETHR_CHK_SYNC_OP([__sync_val_compare_and_swap], [3], [64], [$int64],
              AC_DEFINE(ETHR_HAVE___SYNC_VAL_COMPARE_AND_SWAP64, 1,
               [Define if you have __sync_val_compare_and_swap() for 64-bit \
                integers]))
            test "$have_sync_op" = "yes" && ethr_have_native_atomics=yes
            ETHR_CHK_SYNC_OP([__sync_add_and_fetch], [2], [64], [$int64],
              AC_DEFINE(ETHR_HAVE___SYNC_ADD_AND_FETCH64, 1,
               [Define if you have __sync_add_and_fetch() for 64-bit integers]))
            ETHR_CHK_SYNC_OP([__sync_fetch_and_and], [2], [64], [$int64],
              AC_DEFINE(ETHR_HAVE___SYNC_FETCH_AND_AND64, 1,
               [Define if you have __sync_fetch_and_and() for 64-bit integers]))
            ETHR_CHK_SYNC_OP([__sync_fetch_and_or], [2], [64], [$int64],
              AC_DEFINE(ETHR_HAVE___SYNC_FETCH_AND_OR64, 1,
               [Define if you have __sync_fetch_and_or() for 64-bit integers]))

            if test $int128 != no; then
                ETHR_CHK_SYNC_OP([__sync_val_compare_and_swap], [3], [128],
                 [$int128],
              AC_DEFINE(ETHR_HAVE___SYNC_VAL_COMPARE_AND_SWAP128, 1,
               [Define if you have __sync_val_compare_and_swap() for 128-bit \
                integers]))
            fi

            AC_MSG_CHECKING([for a usable libatomic_ops implementation])
            case "x$with_libatomic_ops" in
                xno | xyes | x)
                    libatomic_ops_include=
                    ;;
                *)
                    if test -d "${with_libatomic_ops}/include"; then
                        libatomic_ops_include="-I$with_libatomic_ops/include"
                        CPPFLAGS="$CPPFLAGS $libatomic_ops_include"
                    else
                        AC_MSG_ERROR([libatomic_ops include directory \
                         $with_libatomic_ops/include not found])
                    fi;;
            esac
            ethr_have_libatomic_ops=no
            AC_TRY_LINK([#include "atomic_ops.h"],
                        [
                        volatile AO_t x;
                        AO_t y;
                        int z;

                        AO_nop_full();
#if defined(AO_HAVE_store)
                        AO_store(&x, (AO_t) 0);
#elif defined(AO_HAVE_store_release)
                        AO_store_release(&x, (AO_t) 0);
#else
#error No store
#endif
#if defined(AO_HAVE_load)
                        z = AO_load(&x);
#elif defined(AO_HAVE_load_acquire)
                        z = AO_load_acquire(&x);
#else
#error No load
#endif
#if defined(AO_HAVE_compare_and_swap_full)
                        z = AO_compare_and_swap_full(&x, (AO_t) 0, (AO_t) 1);
#elif defined(AO_HAVE_compare_and_swap_release)
                        z = AO_compare_and_swap_release(&x, (AO_t) 0, (AO_t) 1);
#elif defined(AO_HAVE_compare_and_swap_acquire)
                        z = AO_compare_and_swap_acquire(&x, (AO_t) 0, (AO_t) 1);
#elif defined(AO_HAVE_compare_and_swap)
                        z = AO_compare_and_swap(&x, (AO_t) 0, (AO_t) 1);
#else
#error No compare_and_swap
#endif
                        ],
                        [ethr_have_native_atomics=yes
                         ethr_have_libatomic_ops=yes])
            AC_MSG_RESULT([$ethr_have_libatomic_ops])
            if test $ethr_have_libatomic_ops = yes; then
                AC_CHECK_SIZEOF(AO_t, ,
                                [
                                    #include <stdio.h>
                                    #include "atomic_ops.h"
                                ])
                AC_DEFINE_UNQUOTED(ETHR_SIZEOF_AO_T, $ac_cv_sizeof_AO_t,
                 [Define to the size of AO_t if libatomic_ops is used])

                AC_DEFINE(ETHR_HAVE_LIBATOMIC_OPS, 1,
                 [Define if you have libatomic_ops atomic operations])
                if test "x$with_libatomic_ops" != "xno" && \
                   test "x$with_libatomic_ops" != "x"; then
                    AC_DEFINE(ETHR_PREFER_LIBATOMIC_OPS_NATIVE_IMPLS, 1,
                     [Define if you prefer libatomic_ops native ethread \
                      implementations])
                fi
                ETHR_DEFS="$ETHR_DEFS $libatomic_ops_include"
            elif test "x$with_libatomic_ops" != "xno" && \
                 test "x$with_libatomic_ops" != "x"; then
                AC_MSG_ERROR([No usable libatomic_ops implementation found])
            fi

            case "$host_cpu" in
              sparc | sun4u | sparc64 | sun4v)
                    case "$with_sparc_memory_order" in
                        "TSO")
                            AC_DEFINE(ETHR_SPARC_TSO, 1,
                             [Define if only run in Sparc TSO mode]);;
                        "PSO")
                            AC_DEFINE(ETHR_SPARC_PSO, 1,
                             [Define if only run in Sparc PSO, or TSO mode]);;
                        "RMO"|"")
                            AC_DEFINE(ETHR_SPARC_RMO, 1,
                             [Define if run in Sparc RMO, PSO, or TSO mode]);;
                        *)
                            AC_MSG_ERROR([Unsupported Sparc memory order: \
                             $with_sparc_memory_order]);;
                    esac
                    ethr_have_native_atomics=yes;;
              i86pc | i*86 | x86_64 | amd64)
                    if test "$enable_x86_out_of_order" = "yes"; then
                      AC_DEFINE(ETHR_X86_OUT_OF_ORDER, 1,
                       [Define if x86/x86_64 out of order instructions should \
                        be synchronized])
                    fi
                    ethr_have_native_atomics=yes;;
              macppc | ppc | powerpc | "Power Macintosh")
                    ethr_have_native_atomics=yes;;
              tile)
                    ethr_have_native_atomics=yes;;
              *)
                    ;;
            esac

        fi

        test ethr_have_native_atomics = "yes" && ethr_have_native_spinlock=yes

        dnl Restore LIBS
        LIBS=$saved_libs
        dnl restore CPPFLAGS
        CPPFLAGS=$saved_cppflags

        ;;
    *)
        ;;
esac

AC_MSG_CHECKING([whether default stack size should be modified])
if test "x$ethr_modified_default_stack_size" != "x"; then
        AC_DEFINE_UNQUOTED(ETHR_MODIFIED_DEFAULT_STACK_SIZE,
          $ethr_modified_default_stack_size,
           [Define if you want to modify the default stack size])
        AC_MSG_RESULT([yes; to $ethr_modified_default_stack_size kilo words])
else
        AC_MSG_RESULT([no])
fi

if test "x$ETHR_THR_LIB_BASE" != "x"; then
        ETHR_DEFS="-DUSE_THREADS $ETHR_DEFS"
        ETHR_LIBS="-l$ethr_lib_name -lerts_internal_r $ETHR_X_LIBS"
        ETHR_LIB_NAME=$ethr_lib_name
fi

AC_CHECK_SIZEOF(void *)
AC_DEFINE_UNQUOTED(ETHR_SIZEOF_PTR, $ac_cv_sizeof_void_p,
 [Define to the size of pointers])

AC_CHECK_SIZEOF(int)
AC_DEFINE_UNQUOTED(ETHR_SIZEOF_INT, $ac_cv_sizeof_int,
 [Define to the size of int])
AC_CHECK_SIZEOF(long)
AC_DEFINE_UNQUOTED(ETHR_SIZEOF_LONG, $ac_cv_sizeof_long,
 [Define to the size of long])
AC_CHECK_SIZEOF(long long)
AC_DEFINE_UNQUOTED(ETHR_SIZEOF_LONG_LONG, $ac_cv_sizeof_long_long,
 [Define to the size of long long])
AC_CHECK_SIZEOF(__int64)
AC_DEFINE_UNQUOTED(ETHR_SIZEOF___INT64, $ac_cv_sizeof___int64,
 [Define to the size of __int64])
AC_CHECK_SIZEOF(__int128_t)
AC_DEFINE_UNQUOTED(ETHR_SIZEOF___INT128_T, $ac_cv_sizeof___int128_t,
 [Define to the size of __int128_t])


case X$erl_xcomp_bigendian in
    X) ;;
    Xyes|Xno) ac_cv_c_bigendian=$erl_xcomp_bigendian;;
    *) AC_MSG_ERROR([Bad erl_xcomp_bigendian value: $erl_xcomp_bigendian]);;
esac

AC_C_BIGENDIAN

if test "$ac_cv_c_bigendian" = "yes"; then
    AC_DEFINE(ETHR_BIGENDIAN, 1, [Define if bigendian])
fi

case X$erl_xcomp_double_middle_endian in
    X)
      ;;
    Xyes|Xno|Xunknown)
      ac_cv_c_double_middle_endian=$erl_xcomp_double_middle_endian;;
    *)
      AC_MSG_ERROR([Bad erl_xcomp_double_middle_endian value: \
        $erl_xcomp_double_middle_endian]);;
esac

AC_C_DOUBLE_MIDDLE_ENDIAN

ETHR_X86_SSE2_ASM=no
case "$GCC-$ac_cv_sizeof_void_p-$host_cpu" in
  yes-4-i86pc | yes-4-i*86 | yes-4-x86_64 | yes-4-amd64)
    AC_MSG_CHECKING([for gcc sse2 asm support])
    save_CFLAGS="$CFLAGS"
    CFLAGS="$CFLAGS -msse2"
    gcc_sse2_asm=no
    AC_TRY_COMPILE([],
        [
         long long x, *y;
         __asm__ __volatile__("movq %1, %0\n\t" : "=x"(x) : "m"(*y) : "memory");
        ],
        [gcc_sse2_asm=yes])
    CFLAGS="$save_CFLAGS"
    AC_MSG_RESULT([$gcc_sse2_asm])
    if test "$gcc_sse2_asm" = "yes"; then
      AC_DEFINE(ETHR_GCC_HAVE_SSE2_ASM_SUPPORT, 1, [Define if you use a gcc \
       that supports -msse2 and understand sse2 specific asm statements])
      ETHR_X86_SSE2_ASM=yes
    fi
    ;;
  *)
    ;;
esac

case "$GCC-$host_cpu" in
  yes-i86pc | yes-i*86 | yes-x86_64 | yes-amd64)
    gcc_dw_cmpxchg_asm=no
    AC_MSG_CHECKING([for gcc double word cmpxchg asm support])
    AC_TRY_COMPILE([],
        [
    char xchgd;
    long new[2], xchg[2], *p;
    __asm__ __volatile__(
#if ETHR_SIZEOF_PTR == 4 && defined(__PIC__) && __PIC__
        "pushl %%ebx\n\t"
        "movl %8, %%ebx\n\t"
#endif
#if ETHR_SIZEOF_PTR == 4
        "lock; cmpxchg8b %0\n\t"
#else
        "lock; cmpxchg16b %0\n\t"
#endif
        "setz %3\n\t"
#if ETHR_SIZEOF_PTR == 4 && defined(__PIC__) && __PIC__
        "popl %%ebx\n\t"
#endif
        : "=m"(*p), "=d"(xchg[1]), "=a"(xchg[0]), "=c"(xchgd)
        : "m"(*p), "1"(xchg[1]), "2"(xchg[0]), "3"(new[1]),
#if ETHR_SIZEOF_PTR == 4 && defined(__PIC__) && __PIC__
          "r"(new[0])
#else
          "b"(new[0])
#endif
        : "cc", "memory");

        ],
        [gcc_dw_cmpxchg_asm=yes])
    if test $gcc_dw_cmpxchg_asm = no && test $ac_cv_sizeof_void_p = 4; then
      AC_TRY_COMPILE([],
          [
      char xchgd;
      long new[2], xchg[2], *p;
#if !defined(__PIC__) || !__PIC__
#  error nope
#endif
      __asm__ __volatile__(
          "pushl %%ebx\n\t"
          "movl (%7), %%ebx\n\t"
          "movl 4(%7), %%ecx\n\t"
          "lock; cmpxchg8b %0\n\t"
          "setz %3\n\t"
          "popl %%ebx\n\t"
          : "=m"(*p), "=d"(xchg[1]), "=a"(xchg[0]), "=c"(xchgd)
          : "m"(*p), "1"(xchg[1]), "2"(xchg[0]), "3"(new)
        : "cc", "memory");

        ],
        [gcc_dw_cmpxchg_asm=yes])
      if test "$gcc_dw_cmpxchg_asm" = "yes"; then
        AC_DEFINE(ETHR_CMPXCHG8B_REGISTER_SHORTAGE, 1,
         [Define if you get a register shortage with cmpxchg8b and position \
          independent code])
      fi
    fi
    AC_MSG_RESULT([$gcc_dw_cmpxchg_asm])
    if test "$gcc_dw_cmpxchg_asm" = "yes"; then
      AC_DEFINE(ETHR_GCC_HAVE_DW_CMPXCHG_ASM_SUPPORT, 1, [Define if you use a \
                gcc that supports the double word cmpxchg instruction])
    fi;;
  *)
    ;;
esac

AC_DEFINE(ETHR_HAVE_ETHREAD_DEFINES, 1, \
[Define if you have all ethread defines])

AC_SUBST(ETHR_X_LIBS)
AC_SUBST(ETHR_LIBS)
AC_SUBST(ETHR_LIB_NAME)
AC_SUBST(ETHR_DEFS)
AC_SUBST(ETHR_THR_LIB_BASE)
AC_SUBST(ETHR_THR_LIB_BASE_DIR)
AC_SUBST(ETHR_X86_SSE2_ASM)[]dnl
])# ERL_FIND_ETHR_LIB
