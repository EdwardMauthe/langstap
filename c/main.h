#ifndef __H_MAIN_H__
#define __H_MAIN_H__

#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#include<stdarg.h>
#include<math.h>

#include "c.tab.h"

double Compute(char*,int,...);
void yyerror(char const*); // used heavily by Bison, defined by caller

// these macros ensure that builtins have
//  the correct number of arguments
#define TEST_SYNTAX_BEGIN(A) if( \
	lexer_func_arguments>=0&&lexer_func_arguments!=A) \
	yyerror("Incorrect calling"); \
	else
#define TEST_SYNTAX_END() lexer_func_arguments=-1;
extern int lexer_func_arguments;
int yylex(void); // in Flex's generated

extern int error_flag;
int yyparse(void); // from Bison's generated
#endif
