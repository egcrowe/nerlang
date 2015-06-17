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

AC_DEFUN([LM_PRECIOUS_VARS],
[

dnl Tools
AC_ARG_VAR(CC, [C compiler])
AC_ARG_VAR(CFLAGS, [C compiler flags])
AC_ARG_VAR(STATIC_CFLAGS, [C compiler static flags])
AC_ARG_VAR(CFLAG_RUNTIME_LIBRARY_PATH,
 [runtime library path linker flag passed via C compiler])
AC_ARG_VAR(CPP, [C/C++ preprocessor])
AC_ARG_VAR(CPPFLAGS, [C/C++ preprocessor flags])
AC_ARG_VAR(CXX, [C++ compiler])
AC_ARG_VAR(CXXFLAGS, [C++ compiler flags])
AC_ARG_VAR(LD, [linker (is often overridden by configure)])
AC_ARG_VAR(LDFLAGS,
 [linker flags (can be risky to set since LD may be overriden by configure)])
AC_ARG_VAR(LIBS, [libraries])
AC_ARG_VAR(DED_LD,
 [linker for Dynamic Erlang Drivers (set all DED_LD* variables or none)])
AC_ARG_VAR(DED_LDFLAGS,
 [linker flags for Dynamic Erlang Drivers (set all DED_LD* variables or none)])
AC_ARG_VAR(DED_LD_FLAG_RUNTIME_LIBRARY_PATH,
 [runtime library path linker flag for Dynamic Erlang Drivers \
  (set all DED_LD* variables or none)])
AC_ARG_VAR(LFS_CFLAGS,
 [large file support C compiler flags (set all LFS_* variables or none)])
AC_ARG_VAR(LFS_LDFLAGS,
 [large file support linker flags (set all LFS_* variables or none)])
AC_ARG_VAR(LFS_LIBS,
 [large file support libraries (set all LFS_* variables or none)])
AC_ARG_VAR(RANLIB, [ranlib])
AC_ARG_VAR(AR, [ar])
AC_ARG_VAR(GETCONF, [getconf])

dnl Cross system root
AC_ARG_VAR(erl_xcomp_sysroot,
 [Absolute cross system root path (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_isysroot,
 [Absolute cross system root include path (only used when cross compiling)])

dnl Cross compilation variables
AC_ARG_VAR(erl_xcomp_bigendian,
 [big endian system: yes|no (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_double_middle_endian,
 [double-middle-endian system: yes|no (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_linux_clock_gettime_correction,
 [clock_gettime() can be used for time correction: yes|no \
  (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_linux_nptl,
 [have Native POSIX Thread Library: yes|no (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_linux_usable_sigusrx,
 [SIGUSR1 and SIGUSR2 can be used: yes|no (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_linux_usable_sigaltstack,
 [have working sigaltstack(): yes|no (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_poll,
 [have working poll(): yes|no (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_kqueue,
 [have working kqueue(): yes|no (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_putenv_copy,
 [putenv() stores key-value copy: yes|no (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_reliable_fpe,
 [have reliable floating point exceptions: yes|no \
  (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_getaddrinfo,
 [have working getaddrinfo() for both IPv4 and IPv6: yes|no \
  (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_gethrvtime_procfs_ioctl,
 [have working gethrvtime() which can be used with procfs ioctl(): yes|no \
  (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_clock_gettime_cpu_time,
 [clock_gettime() can be used for retrieving process CPU time: yes|no \
  (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_after_morecore_hook,
 [__after_morecore_hook can track malloc()s core memory usage: yes|no \
  (only used when cross compiling)])
AC_ARG_VAR(erl_xcomp_dlsym_brk_wrappers,
 [dlsym(RTLD_NEXT, _) brk wrappers can track malloc()s core memory usage: \
  yes|no (only used when cross compiling)])

dnl Cross compilation variables for OSE
AC_ARG_VAR(erl_xcomp_ose_ldflags_pass1,
 [Linker flags for the OSE module (pass 1) \
  (only used when cross compiling for OSE)])
AC_ARG_VAR(erl_xcomp_ose_ldflags_pass2,
 [Linker flags for the OSE module (pass 2) \
  (only used when cross compiling for OSE)])
AC_ARG_VAR(erl_xcomp_ose_OSEROOT,
 [OSE installation root directory (only used when cross compiling for OSE)])
AC_ARG_VAR(erl_xcomp_ose_STRIP,
 [Strip utility shipped with the OSE distribution \
  (only used when cross compiling for OSE)])
AC_ARG_VAR(erl_xcomp_ose_LM_POST_LINK,
 [OSE postlink tool (only used when cross compiling for OSE)])
AC_ARG_VAR(erl_xcomp_ose_LM_SET_CONF,
 [Sets the configuration for an OSE load module \
  (only used when cross compiling for OSE)])
AC_ARG_VAR(erl_xcomp_ose_LM_ELF_SIZE,
 [Prints the section size information for an OSE load module \
  (only used when cross compiling for OSE)])
AC_ARG_VAR(erl_xcomp_ose_LM_LCF,
 [OSE load module linker configuration file \
  (only used when cross compiling for OSE)])
AC_ARG_VAR(erl_xcomp_ose_BEAM_LM_CONF,
 [BEAM OSE load module default configuration file \
  (only used when cross compiling for OSE)])
AC_ARG_VAR(erl_xcomp_ose_EPMD_LM_CONF,
 [EPMD OSE load module default configuration file \
  (only used when cross compiling for OSE)])
AC_ARG_VAR(erl_xcomp_ose_RUN_ERL_LM_CONF,
 [run_erl_lm OSE load module default configuration file \
  (only used when cross compiling for OSE)])
AC_ARG_VAR(erl_xcomp_ose_CONFD, [OSE confd source file])
AC_ARG_VAR(erl_xcomp_ose_CRT0_LM, [OSE crt0 lm source file])[]dnl
])# LM_PRECIOUS_VARS
