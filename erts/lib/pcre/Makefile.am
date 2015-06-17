AM_V_GEN = $(am__v_GEN_@AM_V@)
am__v_GEN_ = $(am__v_GEN_@AM_DEFAULT_V@)
am__v_GEN_0 = @echo "  GEN     " $@;
am__v_GEN_1 =

noinst_LIBRARIES = libecpre.a

libecpre_a_SOURCES = \
 dftables.c \
 local_config.h \
 pcre_byte_order.c \
 pcre_chartables.c \
 pcre_compile.c \
 pcre_config.c \
 pcre_dfa_exec.c \
 pcre_exec.c \
 pcre_fullinfo.c \
 pcre_get.c \
 pcre_globals.c \
 pcre.h \
 pcre_internal.h \
 pcre_jit_compile.c \
 pcre_latin_1_table.c \
 pcre_maketables.c \
 pcre_newline.c \
 pcre_ord2utf8.c \
 pcre_refcount.c \
 pcre_string_utils.c \
 pcre_study.c \
 pcre_tables.c \
 pcre_ucd.c \
 pcre_valid_utf8.c \
 pcre_version.c \
 pcre_xclass.c \
 ucp.h

libecpre_a_CPPFLAGS = -DERLANG_INTEGRATION

BUILT_SOURCES = pcre_exec_loop_break_cases.inc

CLEANFILES = $(BUILT_SOURCES)

pcre_exec_loop_break_cases.inc: pcre_exec.c
	$(AM_V_GEN)for x in `grep -n COST_CHK $< | grep -v 'COST_CHK(N)' | \
	 awk -F: '{print $$1}'`; \
	do \
		N=`expr $$x + 100`; \
		echo "case $$N: goto L_LOOP_COUNT_$${x};"; \
	done > $@
