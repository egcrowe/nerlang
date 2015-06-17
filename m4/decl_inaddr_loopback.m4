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
dnl LM_DECL_INADDR_LOOPBACK
dnl
dnl Try to find declaration of INADDR_LOOPBACK, if nowhere provide a default
dnl

AC_DEFUN([LM_DECL_INADDR_LOOPBACK],
[AC_CACHE_CHECK([for INADDR_LOOPBACK in netinet/in.h],
 ac_cv_decl_inaddr_loopback,
[AC_TRY_COMPILE([#include <sys/types.h>
#include <netinet/in.h>], [int i = INADDR_LOOPBACK;],
ac_cv_decl_inaddr_loopback=yes, ac_cv_decl_inaddr_loopback=no)
])

if test ${ac_cv_decl_inaddr_loopback} = no; then
  AC_CACHE_CHECK([for INADDR_LOOPBACK in rpc/types.h],
                   ac_cv_decl_inaddr_loopback_rpc,
                   AC_TRY_COMPILE([#include <rpc/types.h>],
                                   [int i = INADDR_LOOPBACK;],
                                   ac_cv_decl_inaddr_loopback_rpc=yes,
                                   ac_cv_decl_inaddr_loopback_rpc=no))

   case "${ac_cv_decl_inaddr_loopback_rpc}" in
     "yes" )
        AC_DEFINE(DEF_INADDR_LOOPBACK_IN_RPC_TYPES_H,[],
         [Define if you need to include rpc/types.h to get \
          INADDR_LOOPBACK defined]) ;;
      * )
        AC_CACHE_CHECK([for INADDR_LOOPBACK in winsock2.h],
                   ac_cv_decl_inaddr_loopback_winsock2,
                   AC_TRY_COMPILE([#define WIN32_LEAN_AND_MEAN
                                   #include <winsock2.h>],
                                   [int i = INADDR_LOOPBACK;],
                                   ac_cv_decl_inaddr_loopback_winsock2=yes,
                                   ac_cv_decl_inaddr_loopback_winsock2=no))
        case "${ac_cv_decl_inaddr_loopback_winsock2}" in
          "yes" )
            AC_DEFINE(DEF_INADDR_LOOPBACK_IN_WINSOCK2_H,[],
             [Define if you need to include winsock2.h to get \
              INADDR_LOOPBACK defined]) ;;
          * )
            # couldn't find it anywhere
            AC_DEFINE(HAVE_NO_INADDR_LOOPBACK,[],
              [Define if you don't have a definition of INADDR_LOOPBACK]) ;;
        esac;;
   esac
fi[]dnl
])# LM_DECL_INADDR_LOOPBACK
