#include "stdio.h"
#include "string"
#include "iostream"
#include "cstdlib"
#include "sstream"
using namespace std;
int main(int argc, char const *argv[])
{
	int count=1;
	stringstream ss;
	ss<<++count;
	cout<<typeof("r"+ss.str());
} 