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
dnl AC_DOUBLE_MIDDLE_ENDIAN
dnl
dnl Checks whether doubles are represented in "middle-endian" format.
dnl Sets ac_cv_double_middle_endian={no,yes,unknown} accordingly,
dnl as well as DOUBLE_MIDDLE_ENDIAN.
dnl
dnl

AC_DEFUN([AC_C_DOUBLE_MIDDLE_ENDIAN],
[AC_CACHE_CHECK(whether double word ordering is middle-endian,
 ac_cv_c_double_middle_endian,
[# It does not; compile a test program.
AC_RUN_IFELSE(
[AC_LANG_SOURCE([[#include <stdlib.h>

int
main(void)
{
  int i = 0;
  int zero = 0;
  int bigendian;
  int zero_index = 0;

  union
  {
    long int l;
    char c[sizeof (long int)];
  } u;

  /* we'll use the one with 32-bit words */
  union
  {
    double d;
    unsigned int c[2];
  } vint;

  union
  {
    double d;
    unsigned long c[2];
  } vlong;

  union
  {
    double d;
    unsigned short c[2];
  } vshort;


  /* Are we little or big endian?  From Harbison&Steele.  */
  u.l = 1;
  bigendian = (u.c[sizeof (long int) - 1] == 1);

  zero_index = bigendian ? 1 : 0;

  vint.d = 1.0;
  vlong.d = 1.0;
  vshort.d = 1.0;

  if (sizeof(unsigned int) == 4)
    {
      if (vint.c[zero_index] != 0)
        zero = 1;
    }
  else if (sizeof(unsigned long) == 4)
    {
      if (vlong.c[zero_index] != 0)
        zero = 1;
    }
  else if (sizeof(unsigned short) == 4)
    {
      if (vshort.c[zero_index] != 0)
        zero = 1;
    }

  exit (zero);
}
]])],
              [ac_cv_c_double_middle_endian=no],
              [ac_cv_c_double_middle_endian=yes],
              [ac_cv_c_double_middle=unknown])])
case $ac_cv_c_double_middle_endian in
  yes)
    m4_default([$1],
      [AC_DEFINE([DOUBLE_MIDDLE_ENDIAN], 1,
        [Define to 1 if your processor stores the words in a double in
         middle-endian format (like some ARMs).])]) ;;
  no)
    $2 ;;
  *)
    m4_default([$3],
      [AC_MSG_WARN([unknown double endianness
presetting ac_cv_c_double_middle_endian=no (or yes) will help])]) ;;
esac[]dnl
])# AC_C_DOUBLE_MIDDLE_ENDIAN
