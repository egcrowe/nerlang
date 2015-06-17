SUFFIXES  = .erl .beam
SUFFIXES += .yrl .erl
SUFFIXES += .erl .Pbeam
SUFFIXES += .app .app.src
SUFFIXES += .appup .appup.src

AM_V_ERLC = $(am__v_ERLC_@AM_V@)
am__v_ERLC_ = $(am__v_ERLC_@AM_DEFAULT_V@)
am__v_ERLC_0 = @echo "  ERLC    " $@;
am__v_ERLC_1 =

AM_V_ESCRIPT = $(am__v_ESCRIPT_@AM_V@)
am__v_ESCRIPT_ = $(am__v_ESCRIPT_@AM_DEFAULT_V@)
am__v_ESCRIPT_0 = @echo "  ESCRIPT " $@;
am__v_ESCRIPT_1 =

AM_V_APP = $(am__v_APP_@AM_V@)
am__v_APP_ = $(am__v_APP_@AM_DEFAULT_V@)
am__v_APP_0 = @echo "  APP     " $@;
am__v_APP_1 =

headers = \
 zip_internal.hrl

sources = \
 erlang.erl \
 erl_prim_loader.erl \
 erts_internal.erl \
 init.erl \
 otp_ring0.erl \
 prim_eval.erl \
 prim_eval.S \
 prim_inet.erl \
 prim_file.erl \
 prim_zip.erl \
 zlib.erl

beams = $(addsuffix .beam, $(basename $(sources)))

deps = $(addsuffix .Pbeam, $(basename $(sources)))

erts_srcdir = $(prefix)/lib/erlang/erts/src

erts_src_DATA = \
 erts.app.src \
 $(headers) \
 $(sources)

erts_ebindir = $(prefix)/lib/erlang/lib/erts/ebin

erts_ebin_DATA = \
 erts.app

noinst_DATA = \
 $(beams)

EXTRA_DIST = $(erts_src_DATA)

CLEANFILES = $(erts_ebin_DATA) $(noinst_DATA) prim_eval.abstr

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

prim_eval.abstr: prim_eval.erl
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) -o. +dabstr $<

prim_eval.beam: prim_eval.S prim_eval.abstr
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) $<
	$(AM_V_ESCRIPT)$(ESCRIPT) $(srcdir)/add_abstract_code $(@F) \
	   prim_eval.abstr || (rm $@; exit 1)
