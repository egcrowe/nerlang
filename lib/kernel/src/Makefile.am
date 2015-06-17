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

ERLCFLAGS  = -Depmd_port_no=4369 -Depmd_node_type=110
ERLCFLAGS += -Depmd_dist_low=5 -Depmd_dist_high=5 -Derlang_daemon_port=4369

headers = \
 inet_dns_record_adts.hrl \
 inet_int.hrl \
 disk_log.hrl \
 hipe_ext_format.hrl \
 beam_disasm.hrl \
 hipe.hrl \
 erl_epmd.hrl \
 inet_dns.hrl \
 inet_boot.hrl \
 application_master.hrl \
 inet_config.hrl \
 inet_res.hrl

sources = \
 application_controller.erl \
 application.erl \
 application_master.erl \
 application_starter.erl \
 auth.erl \
 code.erl \
 code_server.erl \
 disk_log_1.erl \
 disk_log.erl \
 disk_log_server.erl \
 disk_log_sup.erl \
 dist_ac.erl \
 dist_util.erl \
 erl_boot_server.erl \
 erl_ddll.erl \
 erl_distribution.erl \
 erl_epmd.erl \
 erl_reply.erl \
 error_handler.erl \
 error_logger.erl \
 erts_debug.erl \
 file.erl \
 file_io_server.erl \
 file_server.erl \
 gen_sctp.erl \
 gen_tcp.erl \
 gen_udp.erl \
 global.erl \
 global_group.erl \
 global_search.erl \
 group.erl \
 heart.erl \
 hipe.erl \
 hipe_unified_loader.erl \
 inet6_sctp.erl \
 inet6_tcp_dist.erl \
 inet6_tcp.erl \
 inet6_udp.erl \
 inet_config.erl \
 inet_db.erl \
 inet_dns.erl \
 inet.erl \
 inet_gethost_native.erl \
 inet_hosts.erl \
 inet_parse.erl \
 inet_res.erl \
 inet_sctp.erl \
 inet_tcp_dist.erl \
 inet_tcp.erl \
 inet_udp.erl \
 kernel_config.erl \
 kernel.erl \
 net_adm.erl \
 net.erl \
 net_kernel.erl \
 os.erl \
 pg2.erl \
 ram_file.erl \
 rpc.erl \
 seq_trace.erl \
 standard_error.erl \
 user_drv.erl \
 user.erl \
 user_sup.erl \
 wrap_log_reader.erl

beams = $(addsuffix .beam, $(basename $(sources)))

deps = $(addsuffix .Pbeam, $(basename $(sources)))

kernel_srcdir = $(prefix)/lib/erlang/lib/kernel/src

kernel_src_DATA = \
 kernel.app.src \
 kernel.appup.src \
 $(headers) \
 $(sources)

kernel_ebindir = $(prefix)/lib/erlang/lib/kernel/ebin

kernel_ebin_DATA = \
 kernel.app \
 kernel.appup \
 $(beams)

EXTRA_DIST = $(kernel_src_DATA)

CLEANFILES = $(kernel_ebin_DATA)

DISTCLEANFILES = $(CLEANFILES)

clean-local:
	-rm -f $(deps)

.erl.beam:
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) $(EINC) $<

.yrl.erl:
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) $<

.erl.Pbeam:
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) $(EINC) -MD $<

sinclude $(deps)

.app.src.app:
	$(AM_V_APP)$(SED) -e 's;%VSN%;$(OTP_VERSION);' $< > $@

.appup.src.appup:
	$(AM_V_APP)$(SED) -e 's;%VSN%;$(OTP_VERSION);' $< > $@
