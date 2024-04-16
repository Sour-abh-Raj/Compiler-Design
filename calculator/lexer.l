%{
    #include "parser.tab.h"
%}

%%
[0-9]+ {
        yylval.number = atoi(yytext);
        return NUMBER;
    }

[ \t] {
        /* ignore whitespace */
    }

\n {
        return EOL;
    }
"+" {
        return PLUS;
    }
"-" {
        return MINUS;
    }
"*" {
        return TIMES;
    }
"/" {
        return DIVIDE;
    }
"(" {
        return LP;
    }
")" {
        return RP;
    }
. {
        fprintf(stderr, "Unknown character %c\n", *yytext);
    }
%%

int yywrap() {
    return 1;
}
