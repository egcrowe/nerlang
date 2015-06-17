AM_V_GEN = $(am__v_GEN_@AM_V@)
am__v_GEN_ = $(am__v_GEN_@AM_DEFAULT_V@)
am__v_GEN_0 = @echo "  GEN     " $@;
am__v_GEN_1 =

AM_V_M4 = $(am__v_M4_@AM_V@)
am__v_M4_ = $(am__v_M4_@AM_DEFAULT_V@)
am__v_M4_0 = @echo "  M4      " $@;
am__v_M4_1 =

erlangbindir = $(prefix)/lib/erlang/bin

erlangbin_PROGRAMS = \
 beam

noinst_PROGRAMS = \
 hipe_mkliterals

srcs = \
 atom.c \
 benchmark.c \
 bif.c \
 big.c \
 binary.c \
 break.c \
 code_ix.c \
 copy.c \
 dist.c \
 driver_tab.c \
 efile_drv.c \
 elib_memmove.c \
 export.c \
 external.c \
 gzio.c \
 hash.c \
 index.c \
 inet_drv.c \
 io.c \
 module.c \
 packet_parser.c \
 preload.c \
 ram_file_drv.c \
 register.c \
 safe_hash.c \
 time.c \
 ttsl_drv.c \
 utils.c \
 zlib_drv.c

beam_srcs = \
 beam_bif_load.c \
 beam_bp.c \
 beam_catches.c \
 beam_debug.c \
 beam_emu.c \
 beam_load.c \
 beam_opcodes.c \
 beam_ranges.c

erl_srcs = \
 erl_afit_alloc.c \
 erl_alloc.c \
 erl_alloc_util.c \
 erl_ao_firstfit_alloc.c \
 erl_arith.c \
 erl_async.c \
 erl_atom_table.c \
 erl_bestfit_alloc.c \
 erl_bif_binary.c \
 erl_bif_chksum.c \
 erl_bif_ddll.c \
 erl_bif_guard.c \
 erl_bif_info.c \
 erl_bif_lists.c \
 erl_bif_op.c \
 erl_bif_os.c \
 erl_bif_port.c \
 erl_bif_re.c \
 erl_bif_table.c \
 erl_bif_timer.c \
 erl_bif_trace.c \
 erl_bif_wrap.c \
 erl_bits.c \
 erl_cpu_topology.c \
 erl_db.c \
 erl_db_hash.c \
 erl_db_tree.c \
 erl_db_util.c \
 erl_debug.c \
 erl_drv_thread.c \
 erl_fun.c \
 erl_gc.c \
 erl_goodfit_alloc.c \
 erl_init.c \
 erl_instrument.c \
 erl_lock_check.c \
 erl_lock_count.c \
 erl_map.c \
 erl_math.c \
 erl_md5.c \
 erl_message.c \
 erl_mmap.c \
 erl_monitors.c \
 erl_mseg.c \
 erl_mtrace.c \
 erl_mtrace_sys_wrap.c \
 erl_nif.c \
 erl_node_tables.c \
 erl_pbifs.c \
 erl_port_task.c \
 erl_posix_str.c \
 erl_printf_term.c \
 erl_process.c \
 erl_process_dict.c \
 erl_process_dump.c \
 erl_process_lock.c \
 erl_ptab.c \
 erl_sched_spec_pre_alloc.c \
 erl_sys_common_misc.c \
 erl_term.c \
 erl_thr_progress.c \
 erl_thr_queue.c \
 erl_time_sup.c \
 erl_trace.c \
 erl_unicode.c \
 erl_zlib.c

hipe_srcs = \
 hipe_amd64_bifs.S \
 hipe_amd64.c \
 hipe_amd64_glue.S \
 hipe_bif0.c \
 hipe_bif1.c \
 hipe_bif2.c \
 hipe_bif64.c \
 hipe_debug.c \
 hipe_gc.c \
 hipe_mode_switch.c \
 hipe_native_bif.c \
 hipe_stack.c \
 hipe_x86_signal.c \
 hipe_x86_stack.c

sys_unix_srcs = \
 unix/erl_main.c \
 unix/erl_unix_sys_ddll.c \
 unix/unix_efile.c \
 unix/sys.c \
 unix/sys_float.c \
 unix/sys_time.c

beam_SOURCES = \
 $(srcs) \
 $(beam_srcs) \
 $(erl_srcs) \
 $(hipe_srcs) \
 $(sys_unix_srcs)

beam_CFLAGS = -Wl,-export-dynamic

beam_CPPFLAGS = \
 -I$(top_srcdir)/erts/include/internal \
 -I$(srcdir)/unix \
 -I$(top_srcdir)/erts/lib/pcre \
 -I$(top_srcdir)/erts/lib/erts \
 -I$(top_srcdir)/erts/lib/ethread \
 -DLIBSCTP=$(LIBSCTP)

beam_DEPENDENCIES = hipe_mkliterals

KERNEL_POLL_OBJS = \
 beam-erl_poll.nkp.o \
 beam-erl_check_io.nkp.o

if KERNEL_POLL
KERNEL_POLL_OBJS  += \
 beam-erl_poll.kp.o \
 beam-erl_check_io.kp.o
endif

beam_LDADD = \
 $(KERNEL_POLL_OBJS) \
 $(top_builddir)/erts/lib/pcre/libecpre.a \
 -L$(top_builddir)/erts/lib/erts -lerts_internal \
 -L$(top_builddir)/erts/lib/ethread -lethread \
 -ltinfo \
 -lz \
 -lpthread \
 -lrt

hipe_mkliterals_SOURCES = hipe_mkliterals.c

hipe_mkliterals_CPPFLAGS = \
 -I$(top_srcdir)/erts/include/internal \
 -I$(srcdir)/unix

include_HEADERS = \
 erl_driver.h \
 erl_nif.h

noinst_HEADERS = \
 atom.h \
 beam_bp.h \
 beam_catches.h \
 beam_load.h \
 benchmark.h \
 bif.h \
 big.h \
 code_ix.h \
 dist.h \
 dtrace-wrapper.h \
 erl_afit_alloc.h \
 erl_alloc.h \
 erl_alloc_util.h \
 erl_ao_firstfit_alloc.h \
 erl_async.h \
 erl_bestfit_alloc.h \
 erl_bif_timer.h \
 erl_binary.h \
 erl_bits.h \
 erl_check_io.h \
 erl_cpu_topology.h \
 erl_db.h \
 erl_db_hash.h \
 erl_db_tree.h \
 erl_db_util.h \
 erl_debug.h \
 erl_drv_nif.h \
 erl_efile.h \
 erl_fun.h \
 erl_gc.h \
 erl_goodfit_alloc.h \
 erl_instrument.h \
 erl_lock_check.h \
 erl_lock_count.h \
 erl_map.h \
 erl_message.h \
 erl_mmap.h \
 erl_monitors.h \
 erl_mseg.h \
 erl_mtrace.h \
 erl_nif_api_funcs.h \
 erl_node_container_utils.h \
 erl_node_tables.h \
 erl_poll.h \
 erl_port.h \
 erl_port_task.h \
 erl_printf_term.h \
 erl_process_dict.h \
 erl_process.h \
 erl_process_lock.h \
 erl_ptab.h \
 erl_sched_spec_pre_alloc.h \
 erl_smp.h \
 erl_sock.h \
 erl_sys_driver.h \
 erl_term.h \
 erl_threads.h \
 erl_thr_progress.h \
 erl_thr_queue.h \
 erl_time.h \
 erl_trace.h \
 erl_unicode.h \
 erl_unicode_normalize.h \
 erl_util_queue.h \
 erl_utils.h \
 erl_vm.h \
 erl_zlib.h \
 error.h \
 export.h \
 external.h \
 global.h \
 gzio.h \
 gzio_zutil.h \
 hash.h \
 hipe_amd64_gc.h \
 hipe_amd64_glue.h \
 hipe_amd64.h \
 hipe_amd64_primops.h \
 hipe_arch.h \
 hipe_arm_gc.h \
 hipe_arm_glue.h \
 hipe_arm.h \
 hipe_arm_primops.h \
 hipe_bif0.h \
 hipe_bif1.h \
 hipe_bif64.h \
 hipe_debug.h \
 hipe_gbif_list.h \
 hipe_gc.h \
 hipe_mode_switch.h \
 hipe_native_bif.h \
 hipe_perfctr.h \
 hipe_ppc_gc.h \
 hipe_ppc_glue.h \
 hipe_ppc.h \
 hipe_ppc_primops.h \
 hipe_primops.h \
 hipe_process.h \
 hipe_risc_gc.h \
 hipe_risc_glue.h \
 hipe_signal.h \
 hipe_sparc_gc.h \
 hipe_sparc_glue.h \
 hipe_sparc.h \
 hipe_sparc_primops.h \
 hipe_stack.h \
 hipe_x86_gc.h \
 hipe_x86_glue.h \
 hipe_x86.h \
 hipe_x86_primops.h \
 index.h \
 module.h \
 packet_parser.h \
 register.h \
 safe_hash.h \
 sys.h \
 version.h \
 unix/erl_unix_sys.h

TABLE_SRCS = \
 atom.names \
 bif.tab \
 hipe_amd64.tab \
 hipe_bif0.tab \
 hipe_bif1.tab \
 hipe_bif2.tab \
 hipe_bif64.tab

TABLES = \
 erl_atom_table.c \
 erl_atom_table.h \
 erl_bif_list.h \
 erl_bif_table.c \
 erl_bif_table.h \
 erl_bif_wrap.c \
 erl_pbifs.c

BEAMOPS_SRCS = \
 genop.tab \
 hipe_ops.tab \
 ops.tab

BEAMOPS = \
 beam_cold.h \
 beam_hot.h \
 beam_opcodes.c \
 beam_opcodes.h \
 beam_pred_funcs.h \
 beam_tr_funcs.h

M4_SRCS = \
 hipe_ppc_asm.m4 \
 hipe_x86_asm.m4 \
 hipe_bif_list.m4 \
 hipe_sparc_asm.m4 \
 hipe_amd64_asm.m4 \
 hipe_amd64_bifs.m4 \
 hipe_arm_asm.m4

TOOLS = \
 tools/beam_makeops \
 tools/make_compiler_flags \
 tools/make_preload \
 tools/make_version \
 tools/make_alloc_types \
 tools/make_driver_tab \
 tools/make_tables

HIPE_ASM_HDRS = \
 hipe_x86_asm.h hipe_amd64_asm.h hipe_sparc_asm.h \
 hipe_ppc_asm.h hipe_arm_asm.h

EXTRA_DIST = \
 $(BEAMOPS_SRCS) \
 $(TABLE_SRCS) \
 $(M4_SRCS) \
 $(TOOLS) \
 $(HIPE_ASM_HDRS) \
 erl_poll.c \
 erl_check_io.c \
 erl_alloc.types

BUILT_SOURCES = \
 $(TABLES) \
 $(BEAMOPS) \
 $(HIPE_ASM_HDRS) \
 erl_alloc_types.h \
 erl_compile_flags.h \
 erl_version.h \
 hipe_literals.h \
 $(KERNEL_POLL_OBJS)

DRIVER_OBJS = \
 efile_drv.o \
 inet_drv.o \
 zlib_drv.o \
 ram_file_drv.o \
 ttsl_drv.o

CLEANFILES = \
 $(TABLES) \
 $(BEAMOPS) \
 preload.c \
 driver_tab.c \
 erl_alloc_types.h \
 erl_compile_flags.h \
 erl_version.h \
 hipe_literals.h \
 hipe_amd64_bifs.S

PRELOAD_BEAMS = \
 $(top_builddir)/erts/src/preload/otp_ring0.beam \
 $(top_builddir)/erts/src/preload/init.beam \
 $(top_builddir)/erts/src/preload/prim_eval.beam \
 $(top_builddir)/erts/src/preload/prim_inet.beam \
 $(top_builddir)/erts/src/preload/prim_file.beam \
 $(top_builddir)/erts/src/preload/zlib.beam \
 $(top_builddir)/erts/src/preload/prim_zip.beam \
 $(top_builddir)/erts/src/preload/erl_prim_loader.beam \
 $(top_builddir)/erts/src/preload/erlang.beam \
 $(top_builddir)/erts/src/preload/erts_internal.beam

erl_alloc_types.h: erl_alloc.types
	$(AM_V_GEN)$(PERL) $(srcdir)/tools/make_alloc_types -src $< -dst $@ \
	 threads hipe nofrag unix

erl_atom_table.c erl_atom_table.h erl_bif_list.h erl_bif_table.c \
 erl_bif_table.h erl_bif_wrap.c erl_pbifs.c: $(TABLE_SRCS)
	$(AM_V_GEN)$(PERL) $(srcdir)/tools/make_tables -src . -include . $?

beam_cold.h beam_hot.h beam_opcodes.c beam_opcodes.h beam_pred_funcs.h \
 beam_tr_funcs.h: $(BEAMOPS_SRCS)
	$(AM_V_GEN)$(PERL) $(srcdir)/tools/beam_makeops -wordsize 64 -outdir . \
	 -DUSE_VM_PROBES=0 -emulator $?

erl_version.h:
	$(AM_V_GEN)$(PERL) $(srcdir)/tools/make_version -o $@ \
	 17 $(PACKAGE_VERSION) $(OTP_VERSION) $(host)

driver_tab.c:
	$(AM_V_GEN)$(PERL) $(srcdir)/tools/make_driver_tab -o $@ -nifs \
	 -drivers $(DRIVER_OBJS)

preload.c: $(PRELOAD_BEAMS)
	$(AM_V_GEN)$(PERL) $(srcdir)/tools/make_preload -old $? > $@

erl_compile_flags.h:
	$(AM_V_GEN)$(PERL) $(srcdir)/tools/make_compiler_flags -o $@ \
	 -f CONFIG_H "$(top_srcdir)/config.h" -v CFLAGS "$(CFLAGS)" -v \
	 LDFLAGS "$(LDFLAGS)"

.m4.h:
	$(AM_V_M4)$(M4) -DTARGET=$(host) -DOPSYS=$(host_os) -DARCH=amd64 $< > $@

hipe_amd64_bifs.S: hipe_amd64_bifs.m4
	$(AM_V_M4)$(M4) -DTARGET=$(host) -DOPSYS=$(host_os) -DARCH=amd64 $< > $@

hipe_literals.h: hipe_mkliterals
	$(AM_V_GEN)./$< -c > $@

if KERNEL_POLL
beam-erl_poll.kp.o: erl_poll.c
	$(AM_V_CC)$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
	 -DERTS_KERNEL_POLL_VERSION $(beam_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) \
	 $(CFLAGS) -MT $@ -MD -MP -MF $(DEPDIR)/beam-erl_poll.kp.Tpo -c -o $@ \
	 `test -f '$<' || echo '$(srcdir)/'`$<
	$(AM_V_at)$(am__mv) $(DEPDIR)/beam-erl_poll.kp.Tpo \
	 $(DEPDIR)/beam-erl_poll.kp.Po

beam-erl_check_io.kp.o: erl_check_io.c
	$(AM_V_CC)$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
	 -DERTS_KERNEL_POLL_VERSION $(beam_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) \
	 $(CFLAGS) -MT $@ -MD -MP -MF $(DEPDIR)/beam-erl_check_io.kp.Tpo -c -o \
	 $@ `test -f '$<' || echo '$(srcdir)/'`$<
	$(AM_V_at)$(am__mv) $(DEPDIR)/beam-erl_check_io.kp.Tpo \
	 $(DEPDIR)/beam-erl_check_io.kp.Po
endif
beam-erl_poll.nkp.o: erl_poll.c
	$(AM_V_CC)$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
	 -DERTS_KERNEL_NO_POLL_VERSION $(beam_CPPFLAGS) $(CPPFLAGS) \
	 $(AM_CFLAGS) $(CFLAGS) -MT $@ -MD -MP -MF \
	 $(DEPDIR)/beam-erl_poll.nkp.Tpo -c -o $@ \
	 `test -f '$<' || echo '$(srcdir)/'`$<
	$(AM_V_at)$(am__mv) $(DEPDIR)/beam-erl_poll.nkp.Tpo \
	 $(DEPDIR)/beam-erl_poll.nkp.Po

beam-erl_check_io.nkp.o: erl_check_io.c
	$(AM_V_CC)$(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
	 -DERTS_KERNEL_NO_POLL_VERSION $(beam_CPPFLAGS) $(CPPFLAGS) \
	 $(AM_CFLAGS) $(CFLAGS) -MT $@ -MD -MP -MF \
	 $(DEPDIR)/beam-erl_check_io.nkp.Tpo -c -o $@ \
	 `test -f '$<' || echo '$(srcdir)/'`$<
	$(AM_V_at)$(am__mv) $(DEPDIR)/beam-erl_check_io.nkp.Tpo \
	 $(DEPDIR)/beam-erl_check_io.nkp.Po
