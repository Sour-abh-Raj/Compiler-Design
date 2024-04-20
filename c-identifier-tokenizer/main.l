%{
#include <stdio.h>
%}

%%

"#" { printf("Preprocessor Directive: %s\n", yytext); }
"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while" { printf("Keyword: %s\n", yytext); }
[0-9]+ { printf("Integer: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]* { printf("Identifier: %s\n", yytext); }
"=="|"!="|"<"|">"|"<="|">=" { printf("Relational Operator: %s\n", yytext); }
"=" { printf("Assignment Operator: %s\n", yytext); }
"(" { printf("Left Parenthesis: %s\n", yytext); }
")" { printf("Right Parenthesis: %s\n", yytext); }
"{" { printf("Left Brace: %s\n", yytext); }
"}" { printf("Right Brace: %s\n", yytext); }
";" { printf("Semicolon: %s\n", yytext); }
[ \t\n] { } // Ignore whitespace and newline
. { printf("Unknown: %s\n", yytext); }

%%

int main(int argc, char** argv) {
    // Set the input file
    if (argc > 1)
        yyin = fopen(argv[1], "r");
    else
        yyin = stdin;

    // Start parsing
    yylex();

    return 0;
}
