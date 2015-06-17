bin_SCRIPTS = \
 nerl

rootdir = $(prefix)/lib/erlang
erlangbindir = $(rootdir)/bin

erlangbin_SCRIPTS = \
 start.boot \
 start.script

EXTRA_DIST = start.boot start.script

install-exec-hook: $(DESTDIR)$(bindir)/nerl
	$(SED) -i '/^ROOTDIR/d' $<
	$(SED) -i '/^BINDIR/i \
	ROOTDIR=$(DESTDIR)$(rootdir)' $<
	$(SED) -i '/^BINDIR/d' $<
	$(SED) -i '/^EMU/i \
	BINDIR=$$ROOTDIR/bin' $<
