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
    void insereAutor(char * autor);
%}

%x AUTOR NOME QUOTE PAGE


%%
"<page>"             {BEGIN PAGE;}
<PAGE>\<title>[^<]* {nome=strdup(yytext+7);}
<PAGE>">{{Autor"                      {BEGIN AUTOR;flag=1;}
<AUTOR>[*][ ]*[']*"&quot;"           {BEGIN QUOTE;conta_quotes++;}
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
    int *aux = (int *) data;
    int x = *aux;
    x=x+(*n);
    *aux=x;
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
    int a= *conta;
    int x = conta_quotes-a;
    fprintf(estatisticas,"<p><b> Existem %d quotes das quais %d não tem autor</b></p>",conta_quotes,x);
    fprintf(estatisticas,"</table></body></html>");
    fclose(estatisticas);

    return 0;
}
