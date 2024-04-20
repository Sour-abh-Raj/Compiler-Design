%{
#include <stdio.h>

struct SymbolTableEntry {
    int index;
    char token[256];
    char type[256];
};


struct SymbolTableEntry symbolTable[1000];
int symbolTableIndex = 0;

void insertIntoSymbolTable(char* token, char* type) {
    strcpy(symbolTable[symbolTableIndex].token, token);
    strcpy(symbolTable[symbolTableIndex].type, type);
    symbolTable[symbolTableIndex].index = symbolTableIndex; // Adding index
    symbolTableIndex++;
}


void printSymbolTableToFile() {
    FILE *file = fopen("symbol_table.txt", "w");
    if (file == NULL) {
        fprintf(stderr, "Error opening file for writing symbol table.\n");
        return;
    }

    fprintf(file, "Index\tToken\tType\n");
    for (int i = 0; i < symbolTableIndex; ++i) {
        fprintf(file, "%d\t%s\t%s\n", symbolTable[i].index, symbolTable[i].token, symbolTable[i].type);
    }

    fclose(file);
}
%}

%%

"#" { printf("Preprocessor Directive: %s\n", yytext); insertIntoSymbolTable(yytext, "Preprocessor Directive"); }
"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while" { printf("Keyword: %s\n", yytext); }
[0-9]+ { printf("Integer: %s\n", yytext); insertIntoSymbolTable(yytext, "Integer"); }
[a-zA-Z_][a-zA-Z0-9_]* { printf("Identifier: %s\n", yytext); insertIntoSymbolTable(yytext, "Identifier"); }
"=="|"!="|"<"|">"|"<="|">=" { printf("Relational Operator: %s\n", yytext); insertIntoSymbolTable(yytext, "Relational Operator"); }
"=" { printf("Assignment Operator: %s\n", yytext); insertIntoSymbolTable(yytext, "Assignment Operator"); }
"(" { printf("Left Parenthesis: %s\n", yytext); insertIntoSymbolTable(yytext, "Left Parenthesis"); }
")" { printf("Right Parenthesis: %s\n", yytext); insertIntoSymbolTable(yytext, "Right Parenthesis"); }
"{" { printf("Left Brace: %s\n", yytext); insertIntoSymbolTable(yytext, "Left Brace"); }
"}" { printf("Right Brace: %s\n", yytext); insertIntoSymbolTable(yytext, "Right Brace"); }
";" { printf("Semicolon: %s\n", yytext); insertIntoSymbolTable(yytext, "Semicolon"); }
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
    printSymbolTableToFile();
    return 0;
}
