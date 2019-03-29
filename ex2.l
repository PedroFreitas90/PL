%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    FILE * citacoes;

    char *nome;
    int len=0,len2=0;
    int flag=0;
%}

%x AUTOR NOME QUOTE PAGE


%%
"<page>"             {BEGIN PAGE;
                      fprintf(citacoes,"<html><head><meta charset='UTF-8'/>\n </head><body>\n");}
<PAGE>\<title>[^<]* {nome=strdup(yytext+7);}
<PAGE>">{{Autor"                      {BEGIN AUTOR; len++;flag=1;}
<AUTOR>[*][ ]*[']*"&quot;"           { printf("--------\nAUTOR: \n");BEGIN QUOTE;}
<AUTOR>"[["[Cc]"ategoria:"    {BEGIN INITIAL;flag=0;}
<QUOTE>[^&\n]* {if(flag)  {fprintf(citacoes, "<p><b>%s</b>",nome); BEGIN AUTOR;} else {BEGIN PAGE;}
                fprintf(citacoes,"  %s</p>\n",yytext); }
<PAGE>[*][ ]*[']*"&quot;" {BEGIN QUOTE;}
<*>(.|\n)                                        {;}
%%


int yywrap(){
    return 1;
}

int main(){
  citacoes=fopen("citacoes.html","w");
    yylex();
    fprintf(citacoes,"</body></html>");
    fclose(citacoes);

    return 0;
}
