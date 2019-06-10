%{
 #include <stdio.h>
 #include <math.h>
 int yyerror(char *s){
    fprintf(stderr,"Erro:%s\n",s);
 }
 int yylex();
%}

%token  KEY ATR VAL ELEMENTOVALUE ELEMENTOKEY KEYINSIDE TEXTO PARAGRAPH CONT
%union{
    char* key;
    char* atributo;
    char* value;
}

%type <key> KEY KEYINSIDE ELEMENTOKEY PARAGRAPH CONT
%type <atributo> b  ATR LISTAARRAY  ARRAYVALUES lista  OBJECT  CHAVESVALORESPAR KEY_LIST
%type <value> VAL  ELEMENTOVALUE AUX LISTA ELEMENTO  KEYVALUE TEXTO PARAGRAFO LISTATEXTO CONTEUDO
%%

conv :  CHAVESVALORESPAR   { printf("{\n\t%s \n}\n",$1);/* ISTO PÕE O PRIMEIRO E ÚLTIMO {} */ }
     ;

CHAVESVALORESPAR:KEY_LIST                     {$$ =$1;}
                | CHAVESVALORESPAR KEY_LIST   {asprintf(&$$,"%s,\n\t%s",$1,$2); /*   */ }
                | OBJECT                      {$$=$1;}
                | CHAVESVALORESPAR OBJECT     {asprintf(&$$,"%s,\n%s",$1,$2);}
                | PARAGRAFO                   {$$=$1;}
                | CHAVESVALORESPAR PARAGRAFO  {asprintf(&$$,"%s,\n%s",$1,$2);}
                | CONTEUDO                    {$$=$1;}
                | CHAVESVALORESPAR CONTEUDO   {asprintf(&$$,"%s,\n%s",$1,$2);}
                ;


KEY_LIST : KEY lista {asprintf(&$$,"\"%s\": [\n\t%s \n\t]",$1,$2);}
         | KEY LISTATEXTO {asprintf(&$$,"\"%s\" : \t\"%s\"",$1,$2);}
         ;

lista : b {$$=$1;}
      | lista b  {asprintf(&$$,"\t\"%s\",\n \t\t\"%s\"",$1,$2);}
      ;

b : ATR {$$=$1;}


OBJECT: KEY LISTA {asprintf(&$$,"\t\"%s\": {\n\t%s\n\t}",$1,$2);/* Object -> key e { }*/ }
      ;


LISTA: AUX          {asprintf(&$$,"%s",$1);}
    | LISTA AUX   {asprintf(&$$,"%s,\n\t%s",$1,$2);};
    ;

AUX:KEYVALUE        {asprintf(&$$,"%s",$1);  /* */ }
   |LISTAARRAY           {asprintf(&$$,"%s",$1);}
   ;


LISTAARRAY: KEYINSIDE ARRAYVALUES  {asprintf(&$$,"\t\"%s\": [\n\t%s\n\t\t]",$1,$2);}
    //      | LISTAARRAY KEYINSIDE ARRAYVALUE {asprintf(&$$,"%s\n%s",$1,$2);
          ;


ARRAYVALUES: ELEMENTO {asprintf(&$$,"%s",$1);}
          | ARRAYVALUES ELEMENTO {asprintf(&$$,"%s,\n\t%s",$1,$2);/*   */ }
          ;

ELEMENTO: ELEMENTOKEY ELEMENTOVALUE {asprintf(&$$,"\t  {\n\t\t\t  \"%s\": \"%s\"\n\t\t  }",$1,$2);}
        ;

KEYVALUE: KEYINSIDE VAL  {asprintf(&$$,"\t\"%s\": \"%s\"",$1,$2);}
        ;

PARAGRAFO: PARAGRAPH LISTATEXTO {asprintf(&$$,"\t\"%s\": \"%s\"",$1,$2);}
        ;
CONTEUDO: CONT LISTATEXTO {asprintf(&$$,"\t\"%s\": \"%s\"",$1,$2);}
        ;


LISTATEXTO: TEXTO        {asprintf(&$$,"%s",$1);}
          | LISTATEXTO TEXTO {asprintf(&$$,"%s%s",$1,$2);}
          ;
%%
    #include "lex.yy.c"

    int main(){
      yyparse();
      return 0;
   }
