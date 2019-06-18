yaml_to_json: yaml_to_json.l  yaml_to_json.y
	flex  yaml_to_json.l
	yacc  yaml_to_json.y
	cc -o yaml_to_json  y.tab.c -ly -lm

test: yaml_to_json
	./ yaml_to_json

clean:
	rm -f y.tab.c lex.yy.c yaml_to_json *.json
