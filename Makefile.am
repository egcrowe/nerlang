ACLOCAL_AMFLAGS = -I m4

SUBDIRS = erts lib bin

check_SCRIPTS = hello.sh

distdir = $(PACKAGE_TARNAME)-$(PACKAGE_VERSION)

TESTS = hello.sh

hello.sh: $(builddir)/nerl
	echo '$(builddir)/nerl -noshell \
	 -boot $(srcdir)/bin/start \
	 -pa $(builddir)/lib/kernel/ebin \
	 -pa $(builddir)/lib/stdlib/ebin \
	 -pa $(builddir)/lib/kernel/src \
	 -pa $(builddir)/lib/stdlib/src \
	 -s erlang display "Hello World" \
	 -s init stop | grep "Hello World"' > $@
	chmod +x $@

$(builddir)/nerl: $(builddir)/bin/nerl
	$(SED) -e 's;@BINDIR@;$(abspath $(builddir)/erts/src);' $< > $@
	$(CHMOD) +x $@

CLEANFILES = $(TESTS) $(builddir)/nerl
