#include "main.h"
void yyerror(char const* M)
{
	error_flag=1; // the printing flag
	printf("@");
	puts(M); // could put it to STDERR
//	exit(1); // stop immediatly if there is an error
}
char* unary_builtins[]={"neg","abs","exp","sqrt","log"};
int unary_builtins_amount=sizeof(unary_builtins)/sizeof(char*);
char* binary_builtins[]={"add","sub","mult","div","remainder","pow","max","min"};
int binary_builtins_amount=sizeof(binary_builtins)/sizeof(char*);
int Lookup(char* S,char** A,int C)
{
	int i;
	for(i=0;i<C;i++)
	{
		if(strcmp(A[i],S)==0)
			break;
	}
	return(i>C)?-1:i;
}
double Compute(char* S,int C,...)
{
	va_list val;
	//double d;
	int i;
	int index;
	double answer;
	// how to do argument hand off?
	// could do it at will?
	//  If didn't take out all of them then
	//   signal an error and take out the rest
	// Though it may not matter since va_end(
	//  only resets the argument list pointer
	va_start(val,C);
	/*
	for(i=0;i<C;i++)
	{
		d=va_arg(val,double);
		printf("%f\n",d);
	}
	*/
	if(C==1)
	{
		double x;
		// lookup will return negative
		//  if isn't there use an if and else
		index=Lookup(S,unary_builtins,unary_builtins_amount);
		x=va_arg(val,double);
		switch(index)
		{
		case 0: // NEG
			answer=-x;
			break;
		case 1: // ABS
			answer=fabs(x);
			break;
		case 2: // EXP
			answer=exp(x);
			break;
		case 3: // SQRT
			answer=sqrt(x);
			break;
		case 4: // LOG
			answer=log(x);
			break;
		}
	}
	else if(C==2)
	{
		double x,y;
		index=Lookup(S,binary_builtins,binary_builtins_amount);
		x=va_arg(val,double);
		y=va_arg(val,double);
		switch(index)
		{
		case 0: // ADD
			answer=x+y;
			break;
		case 1: // SUB
			answer=x-y;
			break;
		case 2: // MULT
			answer=x*y;
			break;
		case 3: // DIV
			answer=x/y;
			break;
		case 4: // REMAINDER
			answer=fmod(x,y);
			break;
		case 5: // POW
			answer=pow(x,y);
			break;
		case 6: // MAX
			answer=(x>y)?x:y;
			break;
		case 7: // MIN
			answer=(x<y)?x:y;
			break;
		}
	}
	else
	{
		// error here
		// also error for negative lookups
		yyerror("unknown argument level");
	}
	va_end(val);
	free(S); // allocated in lexer, decommit here
	return(answer);
}
int main(int ArgC,char* ArgV[])
{
	yyparse();
	return 0;
}
