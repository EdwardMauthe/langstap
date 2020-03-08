%option noyywrap
%{
// had to add this header
//  because this header isn't added
#include "main.h"
int lexer_func_arguments=-1;
%}
digit [0-9]
number [-|+]?{digit}+?(\.)?{digit}+?
uni_func "neg"|"abs"|"exp"|"sqrt"|"log"
bin_func "add"|"sub"|"mult"|"div"|"remainder"|"pow"|"max"|"min"
%%
"\n" {
	return EOL;
}
"\t"
" "
"(" {
	return LPAREN;
}
")" {
	return RPAREN;
}
{number} {
	// the yylval is a union because
	//  it's always used
	yylval.dval=strtod(yytext,NULL);
	//printf("V: %f %s\n",yylval.dval,yytext);
	return NUM;
	}
"quit" {
	return QUIT;
}
{uni_func} {
	// how to free this pointer if its been used?
	//  perhaps could use realloc?
	lexer_func_arguments=1;
	yylval.sval=(char*)malloc(yyleng+1); // need the extra one
	strcpy(yylval.sval,yytext); // copies the null-terminated
	//puts(yytext);
	return FUNC;
}
{bin_func} {
	lexer_func_arguments=2;
	yylval.sval=(char*)malloc(yyleng+1);
	strcpy(yylval.sval,yytext);
	return FUNC;
}
. {
	yyerror("X lex err X");
}
%%
