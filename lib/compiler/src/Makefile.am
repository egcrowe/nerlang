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

EINC = -I$(top_srcdir)/lib -I$(srcdir) -I$(srcdir)/../include

ERLCFLAGS += -DCOMPILER_VSN=\'$(OTP_VERSION)\'

headers = \
 beam_disasm.hrl \
 beam_opcodes.hrl \
 core_parse.hrl \
 v3_kernel.hrl \
 v3_life.hrl

sources = \
 beam_a.erl \
 beam_asm.erl \
 beam_block.erl \
 beam_bool.erl \
 beam_bsm.erl \
 beam_clean.erl \
 beam_dead.erl \
 beam_dict.erl \
 beam_disasm.erl \
 beam_except.erl \
 beam_flatten.erl \
 beam_jump.erl \
 beam_listing.erl \
 beam_opcodes.erl \
 beam_peep.erl \
 beam_receive.erl \
 beam_split.erl \
 beam_trim.erl \
 beam_type.erl \
 beam_utils.erl \
 beam_validator.erl \
 beam_z.erl \
 cerl_clauses.erl \
 cerl.erl \
 cerl_inline.erl \
 cerl_trees.erl \
 compile.erl \
 core_lib.erl \
 core_lint.erl \
 core_parse.yrl \
 core_pp.erl \
 core_scan.erl \
 erl_bifs.erl \
 rec_env.erl \
 sys_core_dsetel.erl \
 sys_core_fold.erl \
 sys_core_inline.erl \
 sys_pre_attributes.erl \
 sys_pre_expand.erl \
 v3_codegen.erl \
 v3_core.erl \
 v3_kernel.erl \
 v3_kernel_pp.erl \
 v3_life.erl

beams = $(addsuffix .beam, $(basename $(sources)))

deps = $(addsuffix .Pbeam, $(basename $(sources)))

compiler_srcdir = $(prefix)/lib/erlang/lib/compiler/src

compiler_src_DATA = \
 compiler.app.src \
 compiler.appup.src \
 $(headers) \
 $(sources)

compiler_ebindir = $(prefix)/lib/erlang/lib/compiler/ebin

compiler_ebin_DATA = \
 compiler.app \
 compiler.appup \
 $(beams)

EXTRA_DIST = $(compiler_src_DATA)

CLEANFILES = $(compiler_ebin_DATA) core_parse.erl

DISTCLEANFILES = $(CLEANFILES)

clean-local:
	-rm -f $(deps)

.erl.beam:
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) $(EINC) $<

.yrl.erl:
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) $<

.erl.Pbeam:
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) $(EINC) -MD $<

.PHONY: core_parse.Pbeam

sinclude $(deps)

.app.src.app:
	$(AM_V_APP)$(SED) -e 's;%VSN%;$(OTP_VERSION);' $< > $@

.appup.src.appup:
	$(AM_V_APP)$(SED) -e 's;%VSN%;$(OTP_VERSION);' $< > $@
