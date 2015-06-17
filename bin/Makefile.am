bin_SCRIPTS = \
 erl

rootdir = $(prefix)/lib/erlang
erlangbindir = $(rootdir)/bin

erlangbin_SCRIPTS = \
 start.boot \
 start.script

EXTRA_DIST = start.boot start.script

install-exec-hook: $(DESTDIR)$(bindir)/erl
	$(SED) -i '/^ROOTDIR/d' $<
	$(SED) -i '/^BINDIR/i \
	ROOTDIR=$(DESTDIR)$(rootdir)' $<
	$(SED) -i '/^BINDIR/d' $<
	$(SED) -i '/^EMU/i \
	BINDIR=$$ROOTDIR/bin' $<
