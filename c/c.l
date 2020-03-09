%option noyywrap
%{
#include "main.h"
%}
whitespace [ \n\t]
digit [0-9]
number [-|+]?{digit}+?(\.)?{digit}+?
type_name "char"|"short"|"int"|"long"|"float"|"double"|"void"
letter [a-zA-Z]
name {letter}({letter}|{digit})*?
%%
{whitespace}
";" {return SCOLON;}
"=" {return EQUAL;}
"(" {return LPAREN;}
")" {return RPAREN;}
"{" {return LBRACE;}
"}" {return RBRACE;}
"," {return COMMA;}
"+" {return PLUS;}
"-" {return MINUS;}
{type_name} {
	yylval.sval=(char*)malloc(yyleng+1);
	strcpy(yylval.sval,yytext);
	return TYPE;
}
{name} {
	yylval.sval=(char*)malloc(yyleng+1);
	strcpy(yylval.sval,yytext);
	return NAME;
}
{number} {
	yylval.dval=strtod(yytext,NULL);
	//printf("V: %f %s\n",yylval.dval,yytext);
	return NUM;
}
. {
	yyerror(" LEX ERR ");
}
%%
