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
dnl ERL_TIME_CORRECTION
dnl
dnl In the presence of a high resolution realtime timer Erlang can adapt
dnl its view of time relative to this timer. On solaris such a timer is
dnl available with the syscall gethrtime(). On other OS's a fallback
dnl solution using times() is implemented. (However on e.g. FreeBSD times()
dnl is implemented using gettimeofday so it doesn't make much sense to
dnl use it there...) On second thought, it seems to be safer to do it the
dnl other way around. I.e. only use times() on OS's where we know it will
dnl work...
dnl

AC_DEFUN([ERL_TIME_CORRECTION],
[if test x$ac_cv_func_gethrtime = x; then
  AC_CHECK_FUNC(gethrtime)
fi
if test x$clock_gettime_correction = xunknown; then
        AC_TRY_COMPILE([#include <time.h>],
                        [struct timespec ts;
                         long long result;
                         clock_gettime(CLOCK_MONOTONIC,&ts);
                         result = ((long long) ts.tv_sec) * 1000000000LL +
                         ((long long) ts.tv_nsec);],
                        clock_gettime_compiles=yes,
                        clock_gettime_compiles=no)
else
        clock_gettime_compiles=no
fi


AC_CACHE_CHECK([how to correct for time adjustments], erl_cv_time_correction,
[
case $clock_gettime_correction in
  yes)
    erl_cv_time_correction=clock_gettime;;
  no|unknown)
    case $ac_cv_func_gethrtime in
      yes)
        erl_cv_time_correction=hrtime ;;
      no)
        case $host_os in
          linux*)
            case $clock_gettime_correction in
              unknown)
                if test x$clock_gettime_compiles = xyes; then
                  if test X$cross_compiling != Xyes; then
                    linux_kernel_vsn_=`uname -r`
                    case $linux_kernel_vsn_ in
                      [[0-1]].*|2.[[0-5]]|2.[[0-5]].*)
                        erl_cv_time_correction=times ;;
                      *)
                        erl_cv_time_correction=clock_gettime;;
                    esac
                  else
                    case X$erl_xcomp_linux_clock_gettime_correction in
                      X)
                        erl_cv_time_correction=cross;;
                      Xyes|Xno)
                        if test $erl_xcomp_linux_clock_gettime_correction = yes;
                        then
                            erl_cv_time_correction=clock_gettime
                        else
                            erl_cv_time_correction=times
                        fi;;
                      *)
                        AC_MSG_ERROR(
                         [Bad \
                         erl_xcomp_linux_clock_gettime_correction \
                         value: \
                         $erl_xcomp_linux_clock_gettime_correction]);;
                      esac
                  fi
                else
                    erl_cv_time_correction=times
                fi
                ;;
               *)
                 erl_cv_time_correction=times ;;
            esac
            ;;
          *)
            erl_cv_time_correction=none ;;
        esac
        ;;
    esac
    ;;
esac
])

xrtlib=""
case $erl_cv_time_correction in
  times)
    AC_DEFINE(CORRECT_USING_TIMES,[],
     [Define if you do not have a high-res. \
      timer & want to use times() instead])
    ;;
  clock_gettime|cross)
    if test $erl_cv_time_correction = cross; then
        erl_cv_time_correction=clock_gettime
        AC_MSG_WARN([result clock_gettime guessed because of cross compilation])
    fi
    xrtlib="-lrt"
    AC_DEFINE(GETHRTIME_WITH_CLOCK_GETTIME,[1],
        [Define if you want to use clock_gettime to simulate gethrtime])
    ;;
esac
dnl
dnl Check if gethrvtime is working, and if to use procfs ioctl
dnl or (yet to be written) write to the procfs ctl file.
dnl

AC_MSG_CHECKING([if gethrvtime works and how to use it])
AC_TRY_RUN([
/* gethrvtime procfs ioctl test */
/* These need to be undef:ed to not break activation of
 * micro level process accounting on /proc/self
 */
#ifdef _LARGEFILE_SOURCE
#  undef _LARGEFILE_SOURCE
#endif
#ifdef _FILE_OFFSET_BITS
#  undef _FILE_OFFSET_BITS
#endif
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/signal.h>
#include <sys/fault.h>
#include <sys/syscall.h>
#include <sys/procfs.h>
#include <fcntl.h>

int main() {
    long msacct = PR_MSACCT;
    int fd;
    long long start, stop;
    int i;
    pid_t pid = getpid();
    char proc_self[30] = "/proc/";

    sprintf(proc_self+strlen(proc_self), "%lu", (unsigned long) pid);
    if ( (fd = open(proc_self, O_WRONLY)) == -1)
        exit(1);
    if (ioctl(fd, PIOCSET, &msacct) < 0)
        exit(2);
    if (close(fd) < 0)
        exit(3);
    start = gethrvtime();
    for (i = 0; i < 100; i++)
        stop = gethrvtime();
    if (start == 0)
        exit(4);
    if (start == stop)
        exit(5);
    exit(0); return 0;
}
],
erl_gethrvtime=procfs_ioctl,
erl_gethrvtime=false,
[
case X$erl_xcomp_gethrvtime_procfs_ioctl in
  X)
    erl_gethrvtime=cross;;
  Xyes|Xno)
    if test $erl_xcomp_gethrvtime_procfs_ioctl = yes; then
      erl_gethrvtime=procfs_ioctl
    else
      erl_gethrvtime=false
    fi;;
  *)
    AC_MSG_ERROR([Bad erl_xcomp_gethrvtime_procfs_ioctl value: \
                  $erl_xcomp_gethrvtime_procfs_ioctl]);;
esac
])

case $erl_gethrvtime in
  procfs_ioctl)
    AC_DEFINE(HAVE_GETHRVTIME_PROCFS_IOCTL,[1],
     [define if gethrvtime() works and uses ioctl() to /proc/self])
    AC_MSG_RESULT(uses ioctl to procfs)
    ;;
  *)
    if test $erl_gethrvtime = cross; then
      erl_gethrvtime=false
      AC_MSG_RESULT(cross)
      AC_MSG_WARN([result 'not working' guessed because of cross compilation])
    else
      AC_MSG_RESULT(not working)
    fi

    dnl
    dnl Check if clock_gettime (linux) is working
    dnl

    AC_MSG_CHECKING([if clock_gettime can be used to get process CPU time])
    save_libs=$LIBS
    LIBS="-lrt"
    AC_TRY_RUN([
    #include <stdlib.h>
    #include <unistd.h>
    #include <string.h>
    #include <stdio.h>
    #include <time.h>
    int main() {
      long long start, stop;
      int i;
      struct timespec tp;

      if (clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &tp) < 0)
        exit(1);
      start = ((long long)tp.tv_sec * 1000000000LL) + (long long)tp.tv_nsec;
      for (i = 0; i < 100; i++)
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &tp);
      stop = ((long long)tp.tv_sec * 1000000000LL) + (long long)tp.tv_nsec;
      if (start == 0)
        exit(4);
      if (start == stop)
        exit(5);
      exit(0); return 0;
      }
        ],
        erl_clock_gettime=yes,
        erl_clock_gettime=no,
        [
        case X$erl_xcomp_clock_gettime_cpu_time in
            X) erl_clock_gettime=cross;;
            Xyes|Xno) erl_clock_gettime=$erl_xcomp_clock_gettime_cpu_time;;
            *) AC_MSG_ERROR([Bad erl_xcomp_clock_gettime_cpu_time value: \
                $erl_xcomp_clock_gettime_cpu_time]);;
        esac
        ])
        LIBS=$save_libs
        case $host_os in
          linux*)
            AC_MSG_RESULT([no; not stable])
            LIBRT=$xrtlib
            ;;
          *)
            AC_MSG_RESULT($erl_clock_gettime)
              case $erl_clock_gettime in
                yes)
                  AC_DEFINE(HAVE_CLOCK_GETTIME,[],
                   [define if clock_gettime() works for getting process time])
                  LIBRT=-lrt
                  ;;
                cross)
                  erl_clock_gettime=no
                  AC_MSG_WARN([result no guessed because of cross compilation])
                  LIBRT=$xrtlib
                  ;;
                *)
                  LIBRT=$xrtlib
                  ;;
              esac
              ;;
        esac
        AC_SUBST(LIBRT)
        ;;
esac[]dnl
])# ERL_TIME_CORRECTION
