%{
#include<iostream>
#include<map>
#include<stdio.h>
#define ID 1
#define OTH 2
#define EO 3
using namespace std;
map<string,int> varmap;
%}
%%
[i][f] {return(OTH);}
[g][o][t][o] {return(OTH);}
[a-zA-z]+[a-zA-z0-9]* {return(ID);}
[a-zA-z]+[a-zA-z0-9]*[:] {return(OTH);}
<<EOF>> {return(EO);}
(.|\n) {return(OTH);}
%%
int yywrap()
{
	return 1;
}
int main()
{
	int k,n=1;
	freopen("mid.txt","w",stdout);
	while(1)
	{
		k=yylex();
		if(k==ID)
		{
			printf("%0.*s\n",yyleng,yytext);
			n++;
		}
		else if(k==EO)
		{
			break;
		}
	}
	return 0;
}