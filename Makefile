
CFLAGS=$(shell pkg-config --cflags glib-2.0)

LFLAGS=$(shell pkg-config --libs glib-2.0)

ex1: ex1.l
	flex ex1.l
	cc $(CFLAGS) -Wall -o ex1 lex.yy.c $(LFLAGS)


ex2: ex2.l
		flex ex2.l
		cc $(CFLAGS) -Wall -o ex2 lex.yy.c $(LFLAGS)

ex3: ex3.l
		flex ex3.l
		cc $(CFLAGS) -Wall -o ex3 lex.yy.c $(LFLAGS)
