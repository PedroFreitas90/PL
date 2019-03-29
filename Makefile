
CFLAGS=$(shell pkg-config --cflags glib-2.0)

LFLAGS=$(shell pkg-config --libs glib-2.0)

ex: ex.l
	flex ex.l
	cc $(CFLAGS) -Wall -O3 -o ex lex.yy.c $(LFLAGS)