%{
#include "main.h"
int error_flag=0;
%}
%union
{
	double dval;
	char* sval;
}
%token <sval> TYPE
%token <sval> NAME
%token <dval> NUM
%token SCOLON
%token EQUAL
%token LPAREN RPAREN
%token LBRACE RBRACE
%token COMMA
%%
Program: {
	printf(">"); // prints the first
}
|Program Statement {
	printf(">");
	error_flag=0; // reset for next line read
}
;
Statement:
TYPE NAME SCOLON {
	puts("HERE 0");
}
|TYPE NAME EQUAL NUM SCOLON {
	puts("HERE 1");
}
|TYPE NAME LPAREN RPAREN SCOLON {
	puts("HERE 2");
}
|TYPE NAME LPAREN RPAREN LBRACE RBRACE {
	puts("HERE 3");
}
|error {
	puts("PANIC: Bison found a parsing error");
	puts(" I can't prove that Bison will be able to know how to recover");
	puts(" from whatever error this was so the compilation must be stopped.");
	exit(1);
}
;
%%
