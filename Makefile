
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

clean-ex1:
		rm ex1
		rm lex.yy.c
		rm -f citacoes.html

clean-ex2:
		rm ex2
		rm lex.yy.c
		find . -maxdepth 1 -type f \! \( -name "*.l" -o -name "Makefile" -o -name 'README.md' -o -name 'ex1' -o -name 'citacoes.html' -o -name 'estatisticas.html' -o -name 'ex3' \) -delete 
clean-ex3:
		rm ex3
		rm lex.yy.c
		rm -f estatisticas.html
clean:
		rm -f ex1 ex2 ex3
		rm -f lex.yy.c
		rm -f *.html
