AM_CPPFLAGS = \
 -I$(top_srcdir)/erts/src/beam

privdir = $(prefix)/lib/erlang/lib/crypto/priv

priv_LTLIBRARIES = \
 libcrypto.la \
 libcrypto_callback.la

libcrypto_la_SOURCES = \
 crypto.c

libcrypto_callback_la_SOURCES = \
 crypto_callback.c \
 crypto_callback.h

libcrypto_la_LDFLAGS = -version-info 0:0:0

libcrypto_callback_la_LDFLAGS = -version-info 0:0:0
