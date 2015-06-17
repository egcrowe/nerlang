noinst_LIBRARIES = liberts.a liberts_internal.a

liberts_a_SOURCES = erl_memory_trace_parser.c

liberts_a_CPPFLAGS = \
 -I$(top_srcdir)/erts/include \
 -I$(top_srcdir)/erts/include/internal

liberts_internal_a_SOURCES = \
 erl_misc_utils.c \
 erl_printf.c \
 erl_printf_format.c

liberts_internal_a_CPPFLAGS = \
 -I$(top_srcdir)/erts/include/internal
