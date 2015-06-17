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
dnl LM_FIND_EMU_CC
dnl
dnl
dnl Tries fairly hard to find a C compiler that can handle jump tables.
dnl Defines the @EMU_CC@ variable for the makefiles and
dnl inserts NO_JUMP_TABLE in the header if one cannot be found...
dnl

AC_DEFUN([LM_FIND_EMU_CC],
        [AC_CACHE_CHECK(for a compiler that handles jumptables,
                        ac_cv_prog_emu_cc,
                        [
AC_TRY_COMPILE([],[
#if defined(__clang_major__) && __clang_major__ >= 3
    /* clang 3.x or later is fine */
#elif defined(__llvm__)
#error "this version of llvm is unable to correctly compile beam_emu.c"
#endif
    __label__ lbl1;
    __label__ lbl2;
    int x = magic();
    static void *jtab[2];

    jtab[0] = &&lbl1;
    jtab[1] = &&lbl2;
    goto *jtab[x];
lbl1:
    return 1;
lbl2:
    return 2;
],ac_cv_prog_emu_cc=$CC,ac_cv_prog_emu_cc=no)

if test $ac_cv_prog_emu_cc = no; then
        for ac_progname in emu_cc.sh gcc-4.2 gcc; do
                IFS="${IFS=     }"; ac_save_ifs="$IFS"; IFS=":"
                ac_dummy="$PATH"
                for ac_dir in $ac_dummy; do
                        test -z "$ac_dir" && ac_dir=.
                        if test -f $ac_dir/$ac_progname; then
                                ac_cv_prog_emu_cc=$ac_dir/$ac_progname
                                break
                        fi
                done
                IFS="$ac_save_ifs"
                if test $ac_cv_prog_emu_cc != no; then
                        break
                fi
        done
fi

if test $ac_cv_prog_emu_cc != no; then
        save_CC=$CC
        save_CFLAGS=$CFLAGS
        save_CPPFLAGS=$CPPFLAGS
        CC=$ac_cv_prog_emu_cc
        CFLAGS=""
        CPPFLAGS=""
        AC_TRY_COMPILE([],[
#if defined(__clang_major__) && __clang_major__ >= 3
    /* clang 3.x or later is fine */
#elif defined(__llvm__)
#error "this version of llvm is unable to correctly compile beam_emu.c"
#endif
        __label__ lbl1;
        __label__ lbl2;
        int x = magic();
        static void *jtab[2];

        jtab[0] = &&lbl1;
        jtab[1] = &&lbl2;
        goto *jtab[x];
        lbl1:
        return 1;
        lbl2:
        return 2;
        ],ac_cv_prog_emu_cc=$CC,ac_cv_prog_emu_cc=no)
        CC=$save_CC
        CFLAGS=$save_CFLAGS
        CPPFLAGS=$save_CPPFLAGS
fi
])
if test $ac_cv_prog_emu_cc = no; then
        AC_DEFINE(NO_JUMP_TABLE,[],
         [Defined if no found C compiler can handle jump tables])
        EMU_CC=$CC
else
        EMU_CC=$ac_cv_prog_emu_cc
fi
AC_SUBST(EMU_CC)[]dnl
])# LM_FIND_EMU_CC
