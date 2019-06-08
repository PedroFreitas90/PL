%code{
 #include <stdio.h>
 #include <math.h>
 int yyerror(char *s){ fprintf(stderr,"Erro:%s\n",s);}
 int yylex();
}
%token  KEY ATR
%union{
    char* key;
    char* atributo;
}

%type <key> KEY
%type <atributo> b ATR lista CHAVEVALORPAR CHAVESVALORESPAR

%%

conv : '-' CHAVESVALORESPAR   { printf("{ \n%s\n}\n",$2); }
    ;
CHAVESVALORESPAR: CHAVEVALORPAR                   {$$ =$1;}
                | CHAVESVALORESPAR CHAVEVALORPAR  {asprintf(&$$,"%s\n%s",$1,$2);}
                ;


CHAVEVALORPAR : KEY lista {asprintf(&$$, "%s: [\n  %s\n],",$1,$2);}
  ;

lista : b {$$=$1;}
      | lista b  {asprintf(&$$,"%s,\n %s",$1,$2);}
      ;

b : ATR {$$=$1;}

%%
    #include "lex.yy.c"
      int main(){
      yyparse();
      return 0;
   }
