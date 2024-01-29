%{
#include<stdio.h>
int lc=0,sc=0,tc=0,ch=0,wc=0;
%}

%%
[\n] { lc++; ch+=yyleng;}
[ \t] { sc++; ch+=yyleng;}
[^\t] { tc++; ch+=yyleng;}
[^\t\n ]+ { wc++; ch+=yyleng;} 
%%

int yywrap(){ return 1; }

int main(){
	printf("Enter the Sentence : ");
	yylex();
	printf("Number of lines : %d\n", lc);
	printf("Number of spaces : %d\n", sc);
	printf("Number of tabs : %d", tc);
	printf("Number of words : %d",wc);
	printf("Number of characters : %d", ch);
	return 0;
}
