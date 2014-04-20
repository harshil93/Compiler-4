#include "stdio.h"
#include "string"
#include "iostream"
#include "cstdlib"
#include "sstream"
using namespace std;
int main(int argc, char const *argv[])
{
	char *yytext = "Shobhit";
	printf("%s\n", (char *)(string(yytext,8).c_str()));
} 