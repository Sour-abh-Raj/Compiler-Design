%{%}

%union {
  int number;
  char *string;
}

%token<number> NUMBER
%token EOL
%token PLUS
%token MINUS
%token TIMES
%token DIVIDE
%token LP
%token RP
%type<number> expr
%start input

%%
input: /* empty */
     | input line
     ;

line: expr EOL { printf("%d\n", $1); }
    ;

expr: NUMBER { $$ = $1; }
    | expr PLUS expr { $$ = $1 + $3; }
    | expr MINUS expr { $$ = $1 - $3; }
    | expr TIMES expr { $$ = $1 * $3; }
    | expr DIVIDE expr { $$ = $1 / $3; }
    | LP expr RP { $$ = $2; }
    ;
%%

int main() {
  yyparse();
  return 0;
}

int yyerror(char *s) {
  fprintf(stderr, "error: %s\n", s);
  return 0;
}
