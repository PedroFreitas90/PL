%{
#include <stdio.h>
#include<string.h>
int flag=0;
void removeSpaces(char *str)
{
    // To keep track of non-space character count
    int count = 0;

    // Traverse the given string. If current character
    // is not space, then place it at index 'count++'
    for (int i = 0; str[i]; i++)
        if (str[i] != ' ')
            str[count++] = str[i]; // here count is
                                   // incremented
    str[count] = '\0';
}
%}

%option noyywrap yylineno
%x YAML  LISTAVALUE LISTA VALUE MAPPING ELEMENTOARRAY PARAGRAFO CONTENT VETOR


%%
[-][-][-]   {BEGIN YAML;}
<YAML>^[a-zA-Z0-9][^:]+ {yylval.key=strdup(yytext);flag=0; BEGIN LISTAVALUE;flag=0;return KEY;}
<YAML>"." {BEGIN INITIAL;}
<YAML>[-] {if(!flag) BEGIN LISTA; else BEGIN ELEMENTOARRAY;}
<YAML>[a-zA-Z0-9][^:]+ {BEGIN VALUE; flag=1;yylval.key=strdup(yytext);return KEYINSIDE ;}
<YAML>^[a-zA-Z0-9]+[:][ ]+[>][ ]*[\n] {BEGIN PARAGRAFO;removeSpaces(yytext);yylval.key=strndup(yytext,strlen(yytext)-3);return PARAGRAPH ;}
<YAML>^[a-zA-Z0-9]+[:][ ]+"|"[-]*[\n] {BEGIN CONTENT;removeSpaces(yytext);yylval.key=strndup(yytext,strlen(yytext)-4);return CONT ;}
<YAML>^[a-zA-Z0-9]+[:][ ]+"|"[ ]*[\n] {BEGIN CONTENT;removeSpaces(yytext);yylval.key=strndup(yytext,strlen(yytext)-3);return CONT ;}

<LISTAVALUE>[\n] {BEGIN YAML;}
<LISTAVALUE>[a-zA-Z0-9][^\n]+ {BEGIN VETOR; VETOR;yylval.value=strdup(yytext);return TEXTO;}

<VETOR>[\n]   {yylval.value=strdup(" ");return TEXTO;}
<VETOR>[^\n]* {yylval.value=strdup(yytext);return TEXTO;}
<VETOR>[\n]/[a-zA-Z0-9]     { BEGIN YAML;}


<LISTA>[a-zA-Z0-9][^\n]+    {BEGIN YAML;yylval.atributo=strdup(yytext);return ATR;}


<VALUE>[\n]            {BEGIN YAML;}
<VALUE>[a-zA-Z0-9][^\n]+    {BEGIN YAML;yylval.value=strdup(yytext);return VAL;}

<ELEMENTOARRAY>[a-zA-Z0-9][^:]+  {BEGIN MAPPING;yylval.key=strdup(yytext);return ELEMENTOKEY ;}

<MAPPING>[0-9a-zA-Z][^\n]*    {BEGIN YAML;yylval.value=strdup(yytext);return ELEMENTOVALUE;}
<MAPPING>[\n]   {BEGIN YAML;yylval.value=strdup("null");return ELEMENTOVALUE;}

<PARAGRAFO>[a-zA-Z0-9][^\n]+ {yylval.value=strdup(yytext);return TEXTO;}
<PARAGRAFO>[\n]     {yylval.value=strdup(" ");return TEXTO;}
<PARAGRAFO>[\n][\n]            {yylval.value=strdup("\\n");return TEXTO;}
<PARAGRAFO>[\n]/[a-zA-Z0-9]     { BEGIN YAML;yylval.value=strdup("\\n");return TEXTO;}



<CONTENT>[a-zA-Z0-9][^\n]+ {yylval.value=strdup(yytext);return TEXTO;}
<CONTENT>[\n]               {yylval.value=strdup("\\n ");return TEXTO;}
<CONTENT>[\n]/[a-zA-Z0-9]      { BEGIN YAML;}

<*>(.|\n) {;}
<*>"#".* {;}
%%
