%{
 #include <stdio.h>
 #include <math.h>
 int yyerror(char *s){ 
    fprintf(stderr,"Erro:%s\n",s);
 }
 int yylex();
%}

%token  KEY ATR
%union{
    char* key; 
    char* atributo;
}

%type <key> KEY
%type <atributo> b ATR lista KEY_LIST CHAVESVALORESPAR DIC KEYVALUE LISTA_KEYVALUE ARRAY ARRAY_VALUES

%%

conv : '-' CHAVESVALORESPAR   { printf("conv{\n %s \n}\n",$2);/* ISTO PÕE O PRIMEIRO E ÚLTIMO {} */ }
     ;

CHAVESVALORESPAR: KEY_LIST                  {$$ =$1;}
                | CHAVESVALORESPAR KEY_LIST {asprintf(&$$," CHAVESVALORESPAR %s\n%s",$1,$2);}
                | CHAVESVALORESPAR DIC
                ;


KEY_LIST : KEY lista {asprintf(&$$, " CHAVEVALORPAR   \"%s\": [\n  \"%s\" \n],",$1,$2);}
         ;

lista : b {$$=$1;}
      | lista b  {asprintf(&$$,"LISTA %s,\n %s",$1,$2);}
      ;

b : ATR {$$=$1;}

DIC: KEY LISTA_KEYVALUE ARRAY {$$ = $1 ; $$1 = $2;}
   | KEY ARRAY LISTA_KEYVALUE
   ;

ARRAY: KEY ':\n\t' ARRAY_VALUES 
     ;

ARRAY_VALUES : '-' KEYVALUE
             | ARRAY_VALUES KEYVALUE
             ;

LISTA_KEYVALUE : KEYVALUE
        | LISTA_KEYVALUE KEYVALUE
        ;

KV: KEY ':' VALUE {printf(" \"%s\" : \"%s\",\n",$2,$3);}
  ;

%%
    #include "lex.yy.c"

    int main(){
      printf("BEGIN\n");
      yyparse();
      return 0;
   }
