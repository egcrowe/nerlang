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

sources = \
 leex.erl \
 yecc.erl \
 yeccgramm.yrl \
 yeccparser.erl \
 yeccscan.erl

beams = $(addsuffix .beam, $(basename $(sources)))

deps = $(addsuffix .Pbeam, $(basename $(sources)))

parsetools_srcdir = $(prefix)/lib/erlang/lib/parsetools/src

parsetools_src_DATA = \
 parsetools.app.src \
 parsetools.appup.src \
 $(headers) \
 $(sources)

parsetools_ebindir = $(prefix)/lib/erlang/lib/parsetools/ebin

parsetools_ebin_DATA = \
 parsetools.app \
 parsetools.appup \
 $(beams)

EXTRA_DIST = $(parsetools_src_DATA)

CLEANFILES = $(parsetools_ebin_DATA) yeccgramm.erl

DISTCLEANFILES = $(CLEANFILES)

clean-local:
	-rm -f $(deps)

.erl.beam:
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) $(EINC) $<

.yrl.erl:
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) $<

.erl.Pbeam:
	$(AM_V_ERLC)$(ERLC) $(ERLCFLAGS) $(EINC) -MD $<

.PHONY: yeccgramm.Pbeam

sinclude $(deps)

.app.src.app:
	$(AM_V_APP)$(SED) -e 's;%VSN%;$(OTP_VERSION);' $< > $@

.appup.src.appup:
	$(AM_V_APP)$(SED) -e 's;%VSN%;$(OTP_VERSION);' $< > $@
