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
dnl LM_WINDOWS_ENVIRONMENT
dnl
dnl
dnl Tries to determine thw windows build environment, i.e.
dnl MIXED_CYGWIN_VC or MIXED_MSYS_VC
dnl

AC_DEFUN([LM_WINDOWS_ENVIRONMENT],
[
MIXED_CYGWIN=no
MIXED_MSYS=no

AC_MSG_CHECKING(for mixed cygwin or msys and native VC++ environment)
if test "X$host" = "Xwin32" -a "x$GCC" != "xyes"; then
  if test -x /usr/bin/cygpath; then
     CFLAGS="-O2"
     MIXED_CYGWIN=yes
     AC_MSG_RESULT([Cygwin and VC])
     MIXED_CYGWIN_VC=yes
     CPPFLAGS="$CPPFLAGS -DERTS_MIXED_CYGWIN_VC"
  elif test -x /usr/bin/msysinfo; then
     CFLAGS="-O2"
     MIXED_MSYS=yes
     AC_MSG_RESULT([MSYS and VC])
     MIXED_MSYS_VC=yes
     CPPFLAGS="$CPPFLAGS -DERTS_MIXED_MSYS_VC"
  else
     AC_MSG_RESULT([undeterminable])
     AC_MSG_ERROR([Seems to be mixed windows but not with cygwin, \
                   cannot handle this!])
  fi
else
  AC_MSG_RESULT([no])
  MIXED_CYGWIN_VC=no
  MIXED_MSYS_VC=no
fi
AC_SUBST(MIXED_CYGWIN_VC)
AC_SUBST(MIXED_MSYS_VC)

MIXED_VC=no
if test "x$MIXED_MSYS_VC" = "xyes" -o  "x$MIXED_CYGWIN_VC" = "xyes" ; then
   MIXED_VC=yes
fi

AC_SUBST(MIXED_VC)

if test "x$MIXED_MSYS" != "xyes"; then
  AC_MSG_CHECKING(for mixed cygwin and native MinGW environment)
  if test "X$host" = "Xwin32" -a "x$GCC" = x"yes"; then
    if test -x /usr/bin/cygpath; then
      CFLAGS="-O2"
      MIXED_CYGWIN=yes
      AC_MSG_RESULT([yes])
      MIXED_CYGWIN_MINGW=yes
      CPPFLAGS="$CPPFLAGS -DERTS_MIXED_CYGWIN_MINGW"
    else
      AC_MSG_RESULT([undeterminable])
      AC_MSG_ERROR([Seems to be mixed windows but not with cygwin, \
                    cannot handle this!])
    fi
  else
    AC_MSG_RESULT([no])
    MIXED_CYGWIN_MINGW=no
  fi
else
  MIXED_CYGWIN_MINGW=no
fi
AC_SUBST(MIXED_CYGWIN_MINGW)

AC_MSG_CHECKING(if we mix cygwin with any native compiler)
if test "X$MIXED_CYGWIN" = "Xyes"; then
        AC_MSG_RESULT([yes])
else
        AC_MSG_RESULT([no])
fi

AC_SUBST(MIXED_CYGWIN)

AC_MSG_CHECKING(if we mix msys with another native compiler)
if test "X$MIXED_MSYS" = "Xyes" ; then
        AC_MSG_RESULT([yes])
else
        AC_MSG_RESULT([no])
fi

AC_SUBST(MIXED_MSYS)[]dnl
])# LM_WINDOWS_ENVIRONMENT
