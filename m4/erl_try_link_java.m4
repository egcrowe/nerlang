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

dnl ERL_TRY_LINK_JAVA(CLASSES, FUNCTION-BODY
dnl                   [ACTION_IF_FOUND [, ACTION-IF-NOT-FOUND]])
dnl Freely inspired by AC_TRY_LINK. (Maybe better to create a
dnl AC_LANG_JAVA instead...)
AC_DEFUN([ERL_TRY_LINK_JAVA],
[java_link='$JAVAC conftest.java 1>&AC_FD_CC'
changequote(, )dnl
cat > conftest.java <<EOF
$1
class conftest { public static void main(String[] args) {
   $2
   ; return; }}
EOF
changequote([, ])dnl
if AC_TRY_EVAL(java_link) && test -s conftest.class; then
   ifelse([$3], , :, [rm -rf conftest*
   $3])
else
   echo "configure: failed program was:" 1>&AC_FD_CC
   cat conftest.java 1>&AC_FD_CC
   echo "configure: PATH was $PATH" 1>&AC_FD_CC
ifelse([$4], , , [  rm -rf conftest*
  $4
])dnl
fi
rm -f conftest*[]dnl
])# ERL_TRY_LINK_JAVA
