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
dnl LM_PROG_PERL5
dnl
dnl Try to find perl version 5. If found set PERL to the absolute path
dnl of the program, if not found set PERL to false.
dnl
dnl On some systems /usr/bin/perl is perl 4 and e.g.
dnl /usr/local/bin/perl is perl 5. We try to handle this case by
dnl putting a couple of
dnl Tries to handle the case that there are two programs called perl
dnl in the path and one of them is perl 5 and the other isn't.
dnl
AC_DEFUN([LM_PROG_PERL5],
[AC_PATH_PROGS(PERL, perl5 perl, false,
   /usr/local/bin:/opt/local/bin:/usr/local/gnu/bin:${PATH})
changequote(, )dnl
dnl[ That bracket is needed to balance the right bracket below
if test "$PERL" = "false" || $PERL -e 'exit ($] >= 5)'; then
changequote([, ])dnl
  ac_cv_path_PERL=false
  PERL=false
dnl  AC_MSG_WARN(perl version 5 not found)
fi[]dnl
])# LM_PROG_PERL5
