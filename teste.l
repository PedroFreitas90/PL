
%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
	int conta=0;
  int autor=0;
  int par=0;
char filename[200];
FILE * out;
%}


%x PAGE TITULO ATRIBUTO



%%
"<page>" {BEGIN PAGE;conta++;printf("NOVA PAGINA\n");}

<PAGE>"<title>"[^<]* {sprintf(filename,"%s.html",yytext+7);}
<PAGE>">{{Autor" {BEGIN TITULO;autor++;out=fopen(filename,"w");
fprintf(out,"<html><head><meta charset='UTF-8'/> </head><body><ul>");;}
<PAGE>"</page>" {printf("CONTA INTERMEDIO %d\n",conta);  BEGIN INITIAL;}

<TITULO>"Nome" {fprintf(out,"<h1>%s</h1>\n",yytext);}
<TITULO>[=][^\n]* {fprintf(out,"<br/><b>%s</b>",yytext+1);}

<TITULO>^"}}" {BEGIN PAGE;par++;fclose(out);}

<ATRIBUTO>[=][^\n]* {printf("%s\n",yytext);BEGIN TITULO;}
<*>(.|\n) {;}

%%


int yywrap(){
    return 1;
}

int main(int argc,char * argv[]){
    printf("Início da filtragem\n");
    yylex();
    printf(" tem %d\n paginas e %d autores e %d parenteses\n",conta,autor,par);
    printf("Fim da filtragem");


    return 0;
}
