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

ERLCFLAGS += -DCRYPTO_VSN=\'$(PACKAGE_VERSION)\'

sources = \
 crypto_ec_curves.erl \
 crypto.erl

beams = $(addsuffix .beam, $(basename $(sources)))

deps = $(addsuffix .Pbeam, $(basename $(sources)))

crypto_srcdir = $(prefix)/lib/erlang/lib/crypto/src

crypto_src_DATA = \
 crypto.app.src \
 crypto.appup.src \
 $(sources)

crypto_ebindir = $(prefix)/lib/erlang/lib/crypto/ebin

crypto_ebin_DATA = \
 crypto.app \
 crypto.appup \
 $(beams)

EXTRA_DIST = $(crypto_src_DATA)

CLEANFILES = \
 $(crypto_ebin_DATA) \
 $(deps)

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
