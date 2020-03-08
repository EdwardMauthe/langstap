%{
#include "main.h"
int error_flag=0;
%}
%union
{
	double dval;
	char* sval;
}
%token <dval> NUM
%token <sval> FUNC
%token QUIT LPAREN RPAREN EOL
%type <dval> Expression
%%
Program: {
	printf(">"); // prints the first
}
|Program QUIT {
	// there is no cleanup to be done
	//  exit correctly
	exit(0);
}
|Program Expression EOL {
	if(!error_flag) // don't print if an error
		printf("%f\n",$2);
	printf(">");
	error_flag=0; // reset for next line read
}
;
Expression:
NUM {
	$$=$1;
}
|LPAREN FUNC Expression RPAREN {
	TEST_SYNTAX_BEGIN(1)
	{
		$$=Compute($2,1,$3);
	}
	TEST_SYNTAX_END()
}
|LPAREN FUNC Expression Expression RPAREN {
	TEST_SYNTAX_BEGIN(2)
	{
		$$=Compute($2,2,$3,$4);
	}
	TEST_SYNTAX_END()
}
|error {
	puts("PANIC: Bison found a parsing error");
	puts(" I can't prove that Bison will be able to know how to recover");
	puts(" from whatever error this was so the compilation must be stopped.");
	exit(1);
}
;
%%
