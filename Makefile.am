ACLOCAL_AMFLAGS = -I m4

SUBDIRS = erts lib bin

check_SCRIPTS = hello.sh

EXTRA_DIST = OTP_VERSION

distdir = $(PACKAGE_TARNAME)-$(OTP_VERSION)

TESTS = hello.sh

hello.sh: $(builddir)/erl
	echo '$(builddir)/erl -noshell \
	 -boot $(srcdir)/bin/start \
	 -pa $(builddir)/lib/kernel/ebin \
	 -pa $(builddir)/lib/stdlib/ebin \
	 -pa $(builddir)/lib/kernel/src \
	 -pa $(builddir)/lib/stdlib/src \
	 -s erlang display "Hello World" \
	 -s init stop | grep "Hello World"' > $@
	chmod +x $@

$(builddir)/erl: $(builddir)/bin/erl
	$(SED) -e 's;@BINDIR@;$(abspath $(builddir)/erts/src);' $< > $@
	$(CHMOD) +x $@

CLEANFILES = $(TESTS) $(builddir)/erl
