%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include <glib.h>
    FILE * estatisticas;
    GTree * aux;
    char *nome;
    int flag=0;
    int conta_quotes=0;
    int conta_quotes_autor=0;
    int conta_autores= 0;
    void insereAutor(char * autor);
%}

%x AUTOR NOME QUOTE PAGE


%%
"<page>"             {BEGIN PAGE;}
<PAGE>\<title>[^<]* {nome=strdup(yytext+7);}
<PAGE>">{{Autor"                      {BEGIN AUTOR;flag=1;}
<AUTOR>[*][ ]*[']*"&quot;"           {BEGIN QUOTE;conta_quotes++;conta_quotes_autor++;}
<AUTOR>"[["[Cc]"ategoria:"    {BEGIN INITIAL;flag=0;}
<QUOTE>[^&\n]* {if(flag)  {BEGIN AUTOR; insereAutor(nome);} else {BEGIN PAGE;}}
<PAGE>[*][ ]*[']*"&quot;" {BEGIN QUOTE;conta_quotes++;}
<*>(.|\n)                                        {;}
%%


int yywrap(){
    return 1;
}

void insereAutor(char * autor){
  gpointer t = g_tree_lookup(aux,autor);
    int * x;
    if (t == NULL){
        x = (int *) malloc(sizeof(int));
        *x = 1;
        g_tree_insert(aux,autor,x);
        conta_autores++;
    }
    else{
        x = (int *) t;
        int m = *x;
        m++;
        (*x) = m;
    }
}
gboolean preencheTabela(gpointer key, gpointer value, gpointer data){
    char * autor = (char * ) key;
    int * n = (int *) value;
    fprintf(estatisticas, "<tr>");
    fprintf(estatisticas, "<td>%s</td>\n",autor);
    fprintf(estatisticas, "<td>%d</td>",*n);
    fprintf(estatisticas, "</tr>");
    return FALSE;
}

void table(){
  fprintf(estatisticas,"<style>table, th, td {border: 1px solid black;}");
  fprintf(estatisticas,"</style></head><body>\n");
  fprintf(estatisticas,"<table style=\"width:100%\">");
  fprintf(estatisticas,"<tr>\n");
  fprintf(estatisticas,"<th>Autor</th>\n<th>Numero de citações</th>\n");
  fprintf(estatisticas,"</tr>\n");

}

int main(){
  int *conta = (int *) malloc(sizeof(int));
    aux = g_tree_new(strcmp);
  estatisticas=fopen("estatisticas.html","w");
    fprintf(estatisticas,"<html><head><meta charset='UTF-8'/>\n");
    table();
    yylex();
      g_tree_foreach(aux,preencheTabela, &conta);
  fprintf(estatisticas,"</table>");
    fprintf(estatisticas,"<p><b> Existem %d quotes das quais %d têm autor</b></p>",conta_quotes,conta_quotes_autor);
    fprintf(estatisticas,"<p><b> Existem no total %d autores</b></p>",conta_autores);
    fprintf(estatisticas,"</table></body></html>");
    fclose(estatisticas);

    return 0;
}
