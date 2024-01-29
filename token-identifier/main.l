/*Lex code to count total number of tokens */

%{ 
int n = 0 ; 
%}

%% 

"while"|"if"|"else" {n++;printf("\t Keywords : %s", yytext);} 

"int"|"float" {n++;printf("\t Keywords : %s", yytext);} 

[a-zA-Z_][a-zA-Z0-9_]* {n++;printf("\t Identifier : %s", yytext);} 

"<="|"=="|"="|"++"|"-"|"*"|"+" {n++;printf("\t Operator : %s", yytext);} 

[(){}|, ;] {n++;printf("\t Separator : %s", yytext);} 

[0-9]*"."[0-9]+ {n++;printf("\t Float : %s", yytext);} 

[0-9]+ {n++;printf("\t Integer : %s", yytext);}						 

. ; 
%% 

int yywrap(){ return 1; }

int main() 

{ 
	
	printf("Enter the Sentence : ");
	yylex();
	printf("\n Total no. of token = %d\n", n); 
	
} 
