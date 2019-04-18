run:
	gawk -f processador.awk emigra.csv
	gawk -f processador-b.awk emigra.csv
	gawk -f processador-c.awk emigra.csv
	gawk -f processador.awk emigra.csv

processador-a:
	gawk -f processador.awk emigra.csv

processador-b:
	gawk -f processador-b.awk emigra.csv

processador-c:
	gawk -f processador-c.awk emigra.csv

processador-d:
	gawk -f processador-d.awk emigra.csv

clean:
	rm -f -r output/

clean-a:
	rm -f output/ex-a.html

clean-b:
	rm -f output/ex-b.html

clean-c:
	rm -f output/ex-c.html

clean-d:
	rm -f output/arvore.dot
	rm -f output/arvore.pdf