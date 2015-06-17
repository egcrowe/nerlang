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
dnl LM_CHECK_FUNC_DECL( funname, declaration [, extra includes
dnl                     [, action-if-found [, action-if-not-found]]] )
dnl
dnl Checks if the declaration "declaration" of "funname" conflicts
dnl with the header files idea of how the function should be
dnl declared. It is useful on systems which lack prototypes and you
dnl need to provide your own (e.g. when you want to take the address
dnl of a function). The 4'th argument is expanded if conflicting,
dnl the 5'th argument otherwise
dnl
dnl

AC_DEFUN([LM_CHECK_FUNC_DECL],
[AC_MSG_CHECKING([for conflicting declaration of $1])
AC_CACHE_VAL(ac_cv_func_decl_$1,
[AC_TRY_COMPILE([#include <stdio.h>
$3],[$2
char *c = (char *)$1;
], eval "ac_cv_func_decl_$1=no", eval "ac_cv_func_decl_$1=yes")])
if eval "test \"`echo '$ac_cv_func_decl_'$1`\" = yes"; then
  AC_MSG_RESULT(yes)
  ifelse([$4], , :, [$4])
else
  AC_MSG_RESULT(no)
ifelse([$5], , , [$5
])dnl
fi
])
