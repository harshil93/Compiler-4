%{
#include<stdio.h>
#include<iostream>
#include "y.tab.h"
using namespace std;
%}
%%
[i][f] {return(IF);}
[g][o][t][o] {return(GOTO);}
[a-zA-z]+[a-zA-z0-9]+ {return(ID);}
"==" {return(BINARY_OPERATORS);};
[-+*/<>] {cout<<"binary"<<endl; return(BINARY_OPERATORS);}
[0-9]+ {return(NUM);}
[=] {return(EQ);}
[[] {return(LEFTSQPAR);}
[]] {return(RIGSQPAR);}
[&] {return(ANDP);}
[a-zA-z]+[a-zA-z0-9]+[:] {return(LABEL);}
(.|\n)
%%
int yywrap()
{
	return 1;
}
