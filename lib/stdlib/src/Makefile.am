SUFFIXES  = .erl .beam
SUFFIXES += .yrl .erl
SUFFIXES += .erl .Pbeam
SUFFIXES += .app .app.src
SUFFIXES += .appup .appup.src

AM_V_ERLC = $(am__v_ERLC_@AM_V@)
am__v_ERLC_ = $(am__v_ERLC_@AM_DEFAULT_V@)
am__v_ERLC_0 = @echo "  ERLC    " $@;
am__v_ERLC_1 =

AM_V_APP = $(am__v_APP_@AM_V@)
am__v_APP_ = $(am__v_APP_@AM_DEFAULT_V@)
am__v_APP_0 = @echo "  APP     " $@;
am__v_APP_1 =

EINC = -I$(top_srcdir)/lib -I$(srcdir)/../include

headers = \
 dets.hrl

sources = \
 array.erl \
 base64.erl \
 beam_lib.erl \
 binary.erl \
 calendar.erl \
 c.erl \
 dets.erl \
 dets_server.erl \
 dets_sup.erl \
 dets_utils.erl \
 dets_v8.erl \
 dets_v9.erl \
 dict.erl \
 digraph.erl \
 digraph_utils.erl \
 edlin.erl \
 edlin_expand.erl \
 epp.erl \
 erl_bits.erl \
 erl_compile.erl \
 erl_eval.erl \
 erl_expand_records.erl \
 erl_internal.erl \
 erl_lint.erl \
 erl_parse.yrl \
 erl_posix_msg.erl \
 erl_pp.erl \
 erl_scan.erl \
 erl_tar.erl \
 error_logger_file_h.erl \
 error_logger_tty_h.erl \
 escript.erl \
 ets.erl \
 eval_bits.erl \
 filelib.erl \
 filename.erl \
 file_sorter.erl \
 gb_sets.erl \
 gb_trees.erl \
 gen.erl \
 gen_event.erl \
 gen_fsm.erl \
 gen_server.erl \
 io.erl \
 io_lib.erl \
 io_lib_format.erl \
 io_lib_fread.erl \
 io_lib_pretty.erl \
 lib.erl \
 lists.erl \
 log_mf_h.erl \
 maps.erl \
 math.erl \
 ms_transform.erl \
 orddict.erl \
 ordsets.erl \
 otp_internal.erl \
 pg.erl \
 pool.erl \
 proc_lib.erl \
 proplists.erl \
 qlc.erl \
 qlc_pt.erl \
 queue.erl \
 random.erl \
 re.erl \
 sets.erl \
 shell_default.erl \
 shell.erl \
 slave.erl \
 sofs.erl \
 string.erl \
 supervisor_bridge.erl \
 supervisor.erl \
 sys.erl \
 timer.erl \
 unicode.erl \
 win32reg.erl \
 zip.erl

beams = $(addsuffix .beam, $(basename $(sources)))

deps = $(addsuffix .Pbeam, $(basename $(sources)))

stdlib_srcdir = $(prefix)/lib/erlang/lib/stdlib/src

stdlib_src_DATA = \
 stdlib.app.src \
 stdlib.appup.src \
 $(headers) \
 $(sources)

stdlib_ebindir = $(prefix)/lib/erlang/lib/stdlib/ebin

stdlib_ebin_DATA = \
 stdlib.app \
 stdlib.appup \
 $(beams)

EXTRA_DIST = $(stdlib_src_DATA)

CLEANFILES = $(stdlib_ebin_DATA) erl_parse.erl

DISTCLEANFILES = $(CLEANFILES)

clean-local:
	-rm -f $(deps)

.erl.beam:
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) $(EINC) $<

.yrl.erl:
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) $<

.erl.Pbeam:
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) $(EINC) -MD $<

.PHONY: erl_parse.Pbeam

sinclude $(deps)

.app.src.app:
	$(AM_V_APP)$(SED) -e 's;%VSN%;$(PACKAGE_VERSION);' $< > $@

.appup.src.appup:
	$(AM_V_APP)$(SED) -e 's;%VSN%;$(PACKAGE_VERSION);' $< > $@
