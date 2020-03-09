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
%token PLUS
%token MINUS
%%
Program: {
	printf(">"); // prints the first
}
|Program SuperStatement {
	printf(">");
	error_flag=0; // reset for next line read
}
;
SuperStatement:
TYPE NAME SCOLON {
	puts("HERE 0");
}
|TYPE NAME EQUAL NUM SCOLON {
	puts("HERE 1");
}
|TYPE NAME LPAREN ArgumentDefiningList RPAREN SCOLON {
	puts("HERE 2");
}
|TYPE NAME LPAREN ArgumentDefiningList RPAREN LBRACE Statements RBRACE {
	puts("HERE 3");
}
|error {
	puts("PANIC: Bison found a parsing error");
	puts(" I can't prove that Bison will be able to know how to recover");
	puts(" from whatever error this was so the compilation must be stopped.");
	exit(1);
}
;
ArgumentDefiningList:
DefiningArgument {
	puts("\tAN ARG");
}
|DefiningArgument COMMA ArgumentDefiningList {
	puts("\tMORE ARGS");
}
;
DefiningArgument:
TYPE NAME {
	puts("\t\tDefines type and Name!");
}
|TYPE {
	puts("\t\tDefines only type!");
}
;
Statements:
Statement {
}
|Statement Statements {
}
;
Statement:
TYPE NAME SCOLON {
	puts("\tDefinition");
}
|TYPE NAME EQUAL NUM SCOLON {
	puts("\tVariable Define");
}
|NAME EQUAL NUM SCOLON {
	puts("\tVariable Set");
}
|NAME LPAREN ArgumentList RPAREN SCOLON {
	puts("\tFunction Call");
}
;
ArgumentList:
Expression {
	puts("\tA calling ARG");
}
|Expression COMMA ArgumentList {
	puts("\tMore calling ARGS");
}
;
Expression:
Term {
	// how to do multiple terms?
}
|Term PLUS Expression {
}
|Term MINUS Expression {
}
;
Term:
NAME {
}
|NUM {
}
;
%%
