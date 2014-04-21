%{
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <map>
#include <sstream>
using namespace std;
map <string,int> varmap;
int lookup(char *);
int yylex(void);
#define YYSTYPE char *
void yyerror (char const *s) {
   		//fprintf (stderr, "%s\n", s);
 }
FILE *temp;
extern char *yytext;
int labelcount=0;
string genLabel();
%}

%start lines
%token	NUM ID EQ
%token BINARY_OPERATORS
%token	PLUS	MINUS	TIMES	DIVIDE	
%token SMALLER SMALLEREQ GREATER GREATEREQ EQEQ 
%token IF GOTO
%token LABEL PARAM CALL COMMA LEFTSQPAR RIGSQPAR
%token STAR ANDP  UNARY_OPS PUSH
%%

lines:  	/* empty */
        	| lines line /* do nothing */ 

line: 		binary  
			| unary 
			| copy 
			|conditional_jump 
			|unconditional_jump 
			|parameters 
			| function_call 
			| indexed_copy
			| address_pointer_assignment 
			| label1
 
binary: 	identifier EQ identifiernum binary_ops identifiernum {
						
						if(strcmp($4,"+")==0)
						{

							int k=lookup($3);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$3);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}

							//pushing into stack first arg
							fprintf(temp,"sw $a0 0($sp)\n");
							fprintf(temp,"addiu $sp $sp -4\n");


							k=lookup($5);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$5);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}
							fprintf(temp,"lw $t1 4($sp)\n");
							fprintf(temp,"addiu $sp $sp 4\n");
							fprintf(temp,"add $a0 $a0 $t1\n");
							k=lookup($1);
							
							fprintf(temp,"sw $a0 %d($t0)\n",4*k - 4);
									
						}else if(strcmp($4,"-")==0){
							cout<<"MINUS"<<endl;
							int k=lookup($3);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$3);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}

							//pushing into stack first arg
							fprintf(temp,"sw $a0 0($sp)\n");
							fprintf(temp,"addiu $sp $sp -4\n");


							k=lookup($5);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$5);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}
							fprintf(temp,"lw $t1 4($sp)\n");
							fprintf(temp,"addiu $sp $sp 4\n");
							fprintf(temp,"sub $a0 $t1 $a0\n");
							k=lookup($1);
							
							fprintf(temp,"sw $a0 %d($t0)\n",4*k - 4);
									
						}else if(strcmp($4,"*")==0){
							int k=lookup($3);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$3);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}

							//pushing into stack first arg
							fprintf(temp,"sw $a0 0($sp)\n");
							fprintf(temp,"addiu $sp $sp -4\n");


							k=lookup($5);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$5);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}
							fprintf(temp,"lw $t1 4($sp)\n");
							fprintf(temp,"addiu $sp $sp 4\n");
							fprintf(temp,"mul $a0 $a0 $t1\n");
							k=lookup($1);
							
							fprintf(temp,"sw $a0 %d($t0)\n",4*k - 4);
									
						}else if(strcmp($4,"/")==0){
							int k=lookup($3);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$3);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}

							//pushing into stack first arg
							fprintf(temp,"sw $a0 0($sp)\n");
							fprintf(temp,"addiu $sp $sp -4\n");


							k=lookup($5);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$5);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}
							fprintf(temp,"lw $t1 4($sp)\n");
							fprintf(temp,"addiu $sp $sp 4\n");
							fprintf(temp,"div $a0 $a0 $t1\n");
							k=lookup($1);
							
							fprintf(temp,"sw $a0 %d($t0)\n",4*k - 4);
									
						}else if(strcmp($4,"<")==0){
							
							int k=lookup($3);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$3);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}

							//pushing into stack first arg
							fprintf(temp,"sw $a0 0($sp)\n");
							fprintf(temp,"addiu $sp $sp -4\n");


							k=lookup($5);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$5);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}
							fprintf(temp,"lw $t1 4($sp)\n");
							fprintf(temp,"addiu $sp $sp 4\n");
							fprintf(temp,"sub $a0 $a0 $t1\n");

							string l1 = genLabel();
							string l2 = genLabel();

							cout<<"l1 "<<l1<<endl;
							cout<<"l2 "<<l2<<endl;

							fprintf(temp, "bgtz $a0 %s\n", l1.c_str() );
							fprintf(temp, "li $a0 0\n" );
							fprintf(temp, "b %s\n",l2.c_str() );
							fprintf(temp, "%s:",l1.c_str() );
							fprintf(temp, "li $a0 1\n" );
							fprintf(temp, "%s:",l2.c_str() );
							k=lookup($1);
							
							fprintf(temp,"sw $a0 %d($t0)\n",4*k - 4);
									
						}else if(strcmp($4,">")==0){
							
							int k=lookup($3);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$3);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}

							//pushing into stack first arg
							fprintf(temp,"sw $a0 0($sp)\n");
							fprintf(temp,"addiu $sp $sp -4\n");


							k=lookup($5);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$5);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}
							fprintf(temp,"lw $t1 4($sp)\n");
							fprintf(temp,"addiu $sp $sp 4\n");
							fprintf(temp,"sub $a0 $t1 $a0\n");

							string l1 = genLabel();
							string l2 = genLabel();

							cout<<"l1 "<<l1<<endl;
							cout<<"l2 "<<l2<<endl;

							fprintf(temp, "bgtz $a0 %s\n", l1.c_str() );
							fprintf(temp, "li $a0 0\n" );
							fprintf(temp, "b %s\n",l2.c_str() );
							fprintf(temp, "%s:",l1.c_str() );
							fprintf(temp, "li $a0 1\n" );
							fprintf(temp, "%s:",l2.c_str() );
							k=lookup($1);
							
							fprintf(temp,"sw $a0 %d($t0)\n",4*k - 4);
									
						}else if(strcmp($4,"==")==0){
							
							int k=lookup($3);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$3);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}

							//pushing into stack first arg
							fprintf(temp,"sw $a0 0($sp)\n");
							fprintf(temp,"addiu $sp $sp -4\n");


							k=lookup($5);
							if(k==-1)
							{
								fprintf(temp,"li $a0 %s\n",$5);
							}
							else
							{
								fprintf(temp,"lw $a0 %d($t0)\n",4*k - 4);
							}
							fprintf(temp,"lw $t1 4($sp)\n");
							fprintf(temp,"addiu $sp $sp 4\n");
							

							string l1 = genLabel();
							string l2 = genLabel();

							cout<<"l1 "<<l1<<endl;
							cout<<"l2 "<<l2<<endl;

							fprintf(temp, "beq $a0 $t1 %s\n", l1.c_str() );
							fprintf(temp, "li $a0 0\n" );
							fprintf(temp, "b %s\n",l2.c_str() );
							fprintf(temp, "%s:",l1.c_str() );
							fprintf(temp, "li $a0 1\n" );
							fprintf(temp, "%s:",l2.c_str() );
							k=lookup($1);
							
							fprintf(temp,"sw $a0 %d($t0)\n",4*k - 4);
									
						}
					}
			
identifiernum : identifier {$$ = $1;}
				| num {$$ = $1;}

binary_ops: BINARY_OPERATORS { $$ = strdup(yytext); }	

identifier: ID { $$ = strdup(yytext); }

num: 		NUM {$$ = strdup(yytext);}

label : LABEL {$$ = strdup(yytext);}

unary: 		identifier EQ UNARY_OPS identifier {}

copy: 		identifier EQ identifier {
										int k = lookup($3);
										fprintf(temp,"lw $a0 %d($t0)\n",4*k-4);
										k = lookup($1);
										fprintf(temp,"sw $a0 %d($t0)\n",4*k-4);
									}
			| identifier EQ num 	{
										int k = lookup($1);
										fprintf(temp,"li $a0 %s\n",$3);
										fprintf(temp,"sw $a0 %d($t0)\n",4*k-4);
									}
label1: label
		{
			fprintf(temp,"%s\n",$1);
		}
conditional_jump : IF identifier GOTO label
					 {
					 	//remove : from label:
					 	int l=strlen($4);
					 	$4[l-1]=0;

					 	cout<<"yes1"<<endl;
					 	int k=lookup($2);
					 	fprintf(temp,"lw $a0 %d($t0)\n",4*k-4);
				   	 	fprintf(temp,"li $t1 0\n");
				   	 	fprintf(temp,"bne $a0 $t1 %s\n",$4);
											
					 }
				   | IF num GOTO label 
				   	 {
				   	 	//remove : from label:
				   	 	int l=strlen($4);
					 	$4[l-1]=0;
				   	 	cout<<"yes2"<<endl;
				   	 	fprintf(temp,"li $a0 %s\n",$1);
				   	 	fprintf(temp,"li $t1 0\n");
				   	 	fprintf(temp,"bne $a0 $t1 %s\n",$4);
				   	 }

unconditional_jump : GOTO label
					 {
					 	//remove : from label:
					 	
					 	int l=strlen($2);
					 	$2[l-1]=0;
					 	cout<<"yes3"<<endl;
					 	fprintf(temp,"b %s\n",$2);
					 }

parameters : PUSH identifier 
			| PUSH num {cout<<"yes6"<<endl;}

function_call : CALL LABEL COMMA num {cout<<"yes7"<<endl;}
indexed_copy : 	identifier EQ identifier LEFTSQPAR num RIGSQPAR 
				| identifier EQ identifier LEFTSQPAR identifier RIGSQPAR {cout<<"yes8"<<endl;}

address_pointer_assignment : 	STAR identifier EQ identifier 
								| identifier EQ STAR identifier | identifier EQ ANDP identifier |ANDP identifier EQ identifier | STAR identifier EQ num
								{cout<<"yes9"<<endl;}
%%
int lookup(char * a)
{
	string x(a);
	if(varmap.find(x)!=varmap.end())return varmap[x];
	else return -1;
}

string genLabel(){
	string l = "_lb";
	stringstream ss;
	ss<<labelcount;
	labelcount++;
	cout<<labelcount<<endl;
	
	return l+ss.str();
}
int main (void) {
	//printf("yes\n");
	char a[1000];
	temp=fopen("mid.txt","r");
	int k=1;
	while(fscanf(temp,"%s",a)!=EOF)
	{
		string b(a);
		//cout<<a<<endl;
		//fscanf(temp,"%d",&k);
		if(varmap.find(b)==varmap.end()){varmap[b]=k++;}
	}
	fclose(temp);
	//printf("yes\n");
	temp=fopen("out.s","w");
	fprintf(temp,"main:\n");
	fprintf(temp,"move $t0 $sp\n");
	fprintf(temp,"addiu $sp $sp %d\n",-4*k );
	yyparse ();
	fprintf(temp,"jr $ra\n" );
	fclose(temp);
	return 0;
}


int yyerror (char *s) {fprintf (stderr, "%s\n", s);}
