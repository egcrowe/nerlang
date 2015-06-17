SUBDIRS = . preload beam

AM_CPPFLAGS = \
 -I$(top_srcdir)/erts/src/beam \
 -I$(top_srcdir)/erts/src/beam/unix \
 -I$(top_srcdir)/erts/include/internal

LDADD = \
 -L$(top_builddir)/erts/lib/erts \
 -lerts_internal

bin_PROGRAMS = \
 ct_run \
 dialyzer \
 epmd \
 nerlc \
 escript \
 run_nerl \
 to_nerl \
 typer

erlangbindir = $(prefix)/lib/erlang/bin

erlangbin_PROGRAMS = \
 child_setup \
 dyn_nerl \
 nerlexec \
 heart \
 inet_gethost

erlangbin_SCRIPTS = beam.smp

child_setup_SOURCES = erl_child_setup.c

ct_run_SOURCES = ct_run.c

dialyzer_SOURCES = dialyzer.c

dyn_nerl_SOURCES = dyn_erl.c

epmd_SOURCES = \
 epmd.c \
 epmd_cli.c \
 epmd.h \
 epmd_int.h \
 epmd_srv.c

epmd_CPPFLAGS = $(AM_CPPFLAGS) -DEPMD_PORT_NO=4369

nerlc_SOURCES = erlc.c

nerlexec_SOURCES = erlexec.c

nerlexec_CPPFLAGS = $(AM_CPPFLAGS) -DOTP_SYSTEM_VERSION=\"17\"

escript_SOURCES = escript.c

heart_SOURCES = heart.c

inet_gethost_SOURCES = inet_gethost.c

run_nerl_SOURCES = \
 run_erl.c \
 run_erl_common.c \
 run_erl_common.h \
 run_erl_vsn.h \
 safe_string.c \
 safe_string.h

to_nerl_SOURCES = \
 to_erl.c \
 to_erl_common.c \
 to_erl_common.h \
 safe_string.c \
 safe_string.h

typer_SOURCES = typer.c

beam.smp:
	-rm -rf $@ && $(LN) -s $(top_builddir)/erts/src/beam/beam $@

CLEANFILES = $(erlangbin_SCRIPTS) beam.smp
