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
 systools.hrl

sources = \
 alarm_handler.erl \
 erlsrv.erl \
 format_lib_supp.erl \
 misc_supp.erl \
 overload.erl \
 rb.erl \
 rb_format_supp.erl \
 release_handler_1.erl \
 release_handler.erl \
 sasl.erl \
 sasl_report.erl \
 sasl_report_file_h.erl \
 sasl_report_tty_h.erl \
 si.erl \
 si_sasl_supp.erl \
 systools.erl \
 systools_lib.erl \
 systools_make.erl \
 systools_rc.erl \
 systools_relup.erl

beams = $(addsuffix .beam, $(basename $(sources)))

deps = $(addsuffix .Pbeam, $(basename $(sources)))

sasl_srcdir = $(prefix)/lib/erlang/lib/sasl/src

sasl_src_DATA = \
 sasl.app.src \
 sasl.appup.src \
 $(headers) \
 $(sources)

sasl_ebindir = $(prefix)/lib/erlang/lib/sasl/ebin

sasl_ebin_DATA = \
 sasl.app \
 sasl.appup \
 $(beams)

EXTRA_DIST = $(sasl_src_DATA)

CLEANFILES = $(sasl_ebin_DATA)

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
	$(AM_V_APP)$(SED) -e 's;%VSN%;$(PACKAGE_VERSION);' $< > $@

.appup.src.appup:
	$(AM_V_APP)$(SED) -e 's;%VSN%;$(PACKAGE_VERSION);' $< > $@
