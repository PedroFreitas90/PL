%{
    #include<stdio.h>
    #include<stdlib.h>
    #include <glib.h>
    #include<string.h>
	int conta=0;
  int autor=0;
  int par=0;
  int cat = 0;
  int n_autores=1;
  int flag=0;
char filename[200];
char username[128];
char userId[10];
char id[10];
char timestamp[100];
char title[250];
char* linke;
GTree * categorias;
FILE * out;
FILE * ind;
FILE * estatisticas;
GTree * aut;

char* categoria;
char refs[200];

void inserir(char* c,char filename[200]);
void remove_espacos(char filename [200]);

%}




%x PAGE AUTOR BIO CAT CONTRIBUIDOR REVISION



%%
"<page>" {BEGIN PAGE;conta++;}



<PAGE>"<title>"[^<]* {sprintf(filename,"post-%d.html",n_autores),sprintf(title,"%s",yytext+7);}
<PAGE>"<id>"[^<]*   {sprintf(id,"%s",yytext+4);}
<PAGE>"<revision>" {BEGIN REVISION;}
<PAGE>"<timestamp>"[^<]* {sprintf(timestamp,"%s",yytext+11);}
<PAGE>"<contributor>" {BEGIN CONTRIBUIDOR;}
<PAGE>">{{Autor" {BEGIN AUTOR;n_autores++;out=fopen(filename,"w");fprintf(out,"<html><head><meta charset='UTF-8'/>\n </head><body><ul>\n");
fprintf(out,"<h1>%s</h1>\n",filename);
fprintf(out,"<p><b>Id</b>"); fprintf(out,": %s</p>\n",id);
fprintf(out,"<p><b>timestamp</b>"); fprintf(out,": %s</p>\n",timestamp);
if(flag){
fprintf(out,"<p><b>Contribuidor :</b></p>");
fprintf(out,"<p><b>Username</b>"); fprintf(out,": %s</p>\n",username);
fprintf(out,"<p><b>UserId</b>"); fprintf(out,": %s</p>\n",userId);
flag=0;
}
}
<PAGE>"</page>" {BEGIN INITIAL;}
<REVISION>"<id>" {BEGIN PAGE;}
<CONTRIBUIDOR>"<username>"[^<]* {sprintf(username,"%s",yytext+10);flag=1;}
<CONTRIBUIDOR>"<id>"[^<]* {sprintf(userId,"%s",yytext+4);}
<CONTRIBUIDOR>"contributor" {BEGIN PAGE;}
<AUTOR>"Nome" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Nombre" {fprintf(out,"<p><b>Nome</b>");}
<AUTOR>"Wikipedia" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Wikicommons" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Foto" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Gutenberg" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Cervantes" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Cor" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"Color" {fprintf(out,"<p><b>Cor</b>");}
<AUTOR>"Wikisource" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"DominioPu" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"DomiPubli" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>"EbooksG" {fprintf(out,"<p><b>%s</b>",yytext);}
<AUTOR>[=][^\n|}]* {fprintf(out,": %s</p>\n",yytext+1);}
<AUTOR>"}}" {BEGIN BIO;par++;}
<BIO>[^\*]* {fprintf(out,"%s",yytext);BEGIN CAT;fprintf(out,"</ul></body></html>");
fclose(out);}
<CAT>"[["[Cc]"ategoria:"[^]]* {cat++;categoria=strdup(yytext+12);
remove_espacos(filename);
sprintf(refs,"<li><a href=%s> %s </a></li>\n\n",linke,title);
inserir(categoria,refs);}

<CAT>"</text>" {BEGIN PAGE;}

<*>(.|\n) {;}

%%

gboolean printsons(gpointer key, gpointer value, gpointer data){

	char * aux=(char *) value;
FILE * ind = (FILE *) data;
    fprintf(ind,"%s",aux);
    return FALSE;
}

gboolean indiceCategorias(gpointer key, gpointer value, gpointer data){
    FILE * ind = (FILE *) data;
     char cat[200];
      char* KEY = (char *) key;
    sprintf(cat,"%s.html",KEY);
    remove_espacos(cat);
    sprintf(refs,"<li><a href=%s> %s </a></li>\n\n",linke,cat);
    fprintf(ind,"%s",refs);
    return FALSE;


}


gboolean print(gpointer key, gpointer value, gpointer data){
    GTree* aux = (GTree*) value;
    gint a = g_tree_nnodes(aux);
    int x = (int) a;
    fprintf(estatisticas,"<tr>");
    fprintf(estatisticas,"<td>%s</td>\n",key);
    fprintf(estatisticas,"<td>%d</td>",x);
    fprintf(estatisticas,"</tr>");
	FILE * ind = (FILE *) data;
    char aux2 [200];
    sprintf(aux2,"%s.html",key);
	ind=fopen(aux2,"w");
    g_tree_foreach(aux,printsons,ind);
	fclose(ind);
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
void table(){
  fprintf(estatisticas,"<style>table, th, td {border: 1px solid black;}");
  fprintf(estatisticas,"</style></head><body>\n");
  fprintf(estatisticas,"<table style=\"width:100%\">");
  fprintf(estatisticas,"<tr>\n");
  fprintf(estatisticas,"<th>Categoria</th>\n<th>Numero de Autores</th>\n");
  fprintf(estatisticas,"</tr>\n");
}


void remove_espacos(char filename [200]){

	 linke = (char*)malloc(sizeof(char)*200);
int i;
int j=0;
for(i=0;filename[i]!='\0';i++){
	if(filename[i]!=' '){
		linke[j++]=filename[i];
	}
	else{ linke[j++]='%';
	      linke[j++]='2';
	      linke[j++]='0';
	}

}
linke[j]='\0';

}



int yywrap(){
    return 1;
}
int main(int argc,char * argv[]){
    ind = fopen("Categorias.html","w");
    estatisticas=fopen("Estatisticas2.html","w");
    table();
    printf("Início da filtragem\n");
    categorias = g_tree_new(strcmp);
    yylex();
    int x= g_tree_nnodes(categorias);
    printf("Fim da filtragem\n");
    g_tree_foreach(categorias,print,ind);
    ind = fopen("Categorias.html","w");
    g_tree_foreach(categorias,indiceCategorias,ind);
    fprintf(estatisticas,"</table>\n<p><b> Existem %d categorias </b></p>",x);
    fprintf(estatisticas,"</table></body></html>");
fclose(ind);
fclose(estatisticas);

    return 0;
}
