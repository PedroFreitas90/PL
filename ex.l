%{
    #include<stdio.h>
    #include<stdlib.h>
    #include <glib.h>
    #include<string.h>
	int conta=0;
  int autor=0;
  int par=0;
  int cat = 0;
char filename[200];
GTree * categorias; 
FILE * out;
GTree * aut;

char* categoria;
char refs[200];

void inserir(char* c,char filename[200]);

%}




%x PAGE AUTOR ATRIBUTO BIO CAT



%%
"<page>" {BEGIN PAGE;conta++;}



<PAGE>"<title>"[^<]* {sprintf(filename,"%s.html",yytext+7);}
<PAGE>">{{Autor" {BEGIN AUTOR;autor++;out=fopen(filename,"w");fprintf(out,"<html><head><meta charset='UTF-8'/>\n </head><body><ul>\n");
fprintf(out,"<h1>%s</h1>\n",filename);
}
<PAGE>"</page>" {BEGIN INITIAL;}

<AUTOR>"Nome" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Wikipedia" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Wikicommons" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Foto" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Gutenberg" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Cervantes" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Cor" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Wikisource" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"DominioPu" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"DomiPubli" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"EbooksG" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>[=][^\n|}]* {fprintf(out,": %s</p>\n",yytext+1);}
<AUTOR>"}}" {BEGIN CAT;par++;fprintf(out,"</ul></body></html>");fclose(out);}

<CAT>"[["[Cc]"ategoria:"[^]]* {cat++;categoria= strdup(yytext+12);sprintf(refs,"<li><a href=%s>  </a></li>\n",filename);inserir(categoria,refs); /*prin   tf("%s\n",categoria);*/}
<CAT>"</text>" {BEGIN PAGE;} 

<ATRIBUTO>[=][^\n]* {BEGIN AUTOR;}
<*>(.|\n) {;}

%%

gboolean printsons(gpointer key, gpointer value, gpointer data){
    printf("    Value Key-> %s \n",key);
    printf("        Value value-> %s \n",value);
    return FALSE;
}


gboolean print(gpointer key, gpointer value, gpointer data){
    printf("KEY -> %s \n",key);
    GTree* aux = (GTree*) value;
    g_tree_foreach(aux,printsons,NULL);
    return FALSE;

}



void inserir(char* c,char filename[200]){
    gpointer t = g_tree_lookup(categorias,c);
    if ( !t ){
        GTree* aux = g_tree_new(strcmp);
        g_tree_insert(aux,strdup(filename),strdup(filename));
        g_tree_insert(categorias,c,aux);
    }
    else{
        GTree* aux1 = (GTree*) t;
        g_tree_insert(t,strdup(filename),strdup(filename));
    }
}




int yywrap(){
    return 1;
}

int main(int argc,char * argv[]){
    printf("Início da filtragem\n");
    categorias = g_tree_new(strcmp);

    yylex();

    //printf(" tem %d\n paginas e %d autores e %d parenteses\n",conta,autor,par);
    printf("Fim da filtragem\n");
    printf("Olá\n");
    g_tree_foreach(categorias,print,NULL);

    return 0;
}