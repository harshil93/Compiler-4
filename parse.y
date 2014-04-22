%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "iostream"
	#include <vector>
	#include <string>
	#include "sstream"
	#include <map>
	#include <vector>
	#include <string.h>
	int yylex(void);
	void yyerror (char const *s) {
   		//fprintf (stderr, "%s\n", s);
 	}

 	void printSymbolTable();
 	extern int lineNo;
 	extern char* yytext;
 	extern int yyleng;

 	#define START "START"
 	#define FUNCTION "FUNCTION"
 	#define DECLARATION "DECLARATION"
 	#define DECL_LIST "DECL_LIST"
 	#define FUNC_DEF "FUNC_DEF"
 	#define CMPD_STMT "CMPD_STMT"
 	#define STMT_LIST "STMT_LIST"
 	#define ITER_STMT "ITER_STMT"
 	#define COND_STMT "COND_STMT"
 	#define STMT "STMT"
 	#define EXPR "EXPR"
 	#define OPERATOR "OPERATOR"
 	#define NUMBER "NUMBER"
 	#define IDENTIFIER "IDENTIFIER"
 	#define OPERATOR "OPERATOR"
 	#define FUNC_CALL "FUNC_CALL"
 	#define EXTERN_DECL "EXTERN_DECL"
 	#define D_TYPE "D_TYPE"
 	#define START_ "START_"
 	#define ASSIGN "ASSIGN"
 	#define ADD "ADD"
 	#define SUB "SUB"
 	#define MUL "MUL"
 	#define DIV "DIV"
 	#define MOD "MOD"
 	#define LESS "LESS"
 	#define GREATER "GREATER"
 	#define LOOP_STMT "LOOP_STMT"
 	#define EQUALITY "EQUALITY"
 	#define INT "int"
 	#define FLOAT "float"
 	#define ERR_TYPE "err_type"

 	using namespace std;
 	struct node
 	{
 		string code;
 		vector<node*> v;
 		string id;
 		string dataType;
 	};

 	node* root;

 	union utype
	{
		node* Node;
		char* s;
	};
	#define YYSTYPE utype

	vector< map<string,string> > symbolTable;


	int scope = 0;

	bool semanticError = false;
	bool syntacticError = false;
	
	int findIdentifierScope(string id)
	{
		for(int i=scope;i>=0;i--)
		{
			if(symbolTable[i].find(id) != symbolTable[i].end())	return scope;
		}
		return -1;
	}
%}

%token ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN AND_ASSIGN XOR_ASSIGN OR_ASSIGN 
%token RIGHT_OP LEFT_OP INC_OP DEC_OP PTR_OP AND_OP OR_OP LE_OP GE_OP EQ_OP NE_OP 

%token ID DATA_TYPE 
%token IF ELSE WHILE FOR DO 
%token CONTINUE BREAK RETURN 
%token FLOATING_POINT INTEGER CHAR_LIT STRING
 

%%
strt:					strt_					{
													root = $1.Node;
													root->code = START;
												}

strt_:  					/*empty*/						{
																node* tempNode = new node;
																tempNode->code = START_;
																$$.Node = tempNode;
															}
						|external_declaration strt_			{
																node* tempNode = new node;
																tempNode->code = START_;
																(tempNode->v).push_back($1.Node);
																(tempNode->v).push_back($2.Node);
																$$.Node = tempNode;
															}
						;										

external_declaration: 	function_definition					{
																node* tempNode = new node;
																tempNode->code = EXTERN_DECL;
																(tempNode->v).push_back($1.Node);
																$$.Node = tempNode;
															}
						| declaration                       {
																node* tempNode = new node;
																tempNode->code = EXTERN_DECL;
																(tempNode->v).push_back($1.Node);
																$$.Node = tempNode;	
															}
						;

declaration: 			data_type id semi 					{
																node* tempNode = new node;
																tempNode->code = DECLARATION;
																
																
																// printSymbolTable();
																
																if(symbolTable[scope].find(($2.Node)->id)==symbolTable[scope].end())
																{
																	symbolTable[scope][($2.Node)->id] = ($1.Node)->id;
																}
																else
																{
																	semanticError = true;
																	cout << "Multiple declaration of " << ($2.Node)->id << " at line no. " << lineNo+1 << endl;
																}
																$$.Node = tempNode;
															}	
						;		

declaration_list: 		declaration 						{
																node* tempNode = new node;
																tempNode->code = DECL_LIST;
																(tempNode->v).push_back($1.Node);
																$$.Node = tempNode;
															}
						| declaration declaration_list		{
																node* tempNode = new node;
																tempNode->code = DECL_LIST;
																(tempNode->v).push_back($1.Node);
																(tempNode->v).push_back($2.Node);
																$$.Node = tempNode;
															}
						;

function_definition:	data_type id left_parenthesis right_parenthesis compound_stmts
															{
																node* tempNode = new node;
																tempNode->code = FUNC_DEF;
																(tempNode->v).push_back($1.Node);
																(tempNode->v).push_back($2.Node);
																(tempNode->v).push_back($5.Node);
																$$.Node = tempNode;
															}
						;


compound_stmts:		
						left_brace				{
													map<string,string>	temp;
													symbolTable.push_back(temp);
													scope++;
												}
						right_brace 
												{
													node* tempNode = new node;
													tempNode->code = CMPD_STMT;
													$$.Node = tempNode;
													symbolTable.pop_back();
													scope--;
												}
						| left_brace			
												{
													map<string,string>	temp;
													symbolTable.push_back(temp);
													scope++;
												}
						 stmt_list right_brace
												{
													node* tempNode = new node;
													tempNode->code = CMPD_STMT;
													(tempNode->v).push_back($3.Node);
													$$.Node = tempNode;
													symbolTable.pop_back();
													scope--;	
												}
						;

stmt_list:				/*empty*/				{
													node* tempNode = new node;
													tempNode->code = STMT_LIST;
													$$.Node = tempNode;	
												}
						|stmt stmt_list			{
													node* tempNode = new node;
													tempNode->code = STMT_LIST;
													(tempNode->v).push_back($1.Node);
													(tempNode->v).push_back($2.Node);
													$$.Node = tempNode;	
												}
						;

stmt:					declaration_list
												{
													node* tempNode = new node;
													tempNode->code = STMT;
													(tempNode->v).push_back($1.Node);
													$$.Node = tempNode;
												}
						| compound_stmts
												{
													node* tempNode = new node;
													tempNode->code = STMT;
													(tempNode->v).push_back($1.Node);
													$$.Node = tempNode;
												}
						| conditional_stmt
												{
													node* tempNode = new node;
													tempNode->code = STMT;
													(tempNode->v).push_back($1.Node);
													$$.Node = tempNode;
												}
						| iteration_stmt
												{
													node* tempNode = new node;
													tempNode->code = STMT;
													(tempNode->v).push_back($1.Node);
													$$.Node = tempNode;
												}
						| expr semi 			
												{
													node* tempNode = new node;
													tempNode->code = STMT;
													(tempNode->v).push_back($1.Node);
													$$.Node = tempNode;
												}
						;

iteration_stmt:			WHILE left_parenthesis expr right_parenthesis stmt 		
												{
													node* tempNode = new node;
													tempNode->code = LOOP_STMT;
													(tempNode->v).push_back($3.Node);
													(tempNode->v).push_back($5.Node);
													$$.Node = tempNode;								
												}
						;


conditional_stmt:		IF left_parenthesis expr right_parenthesis stmt 
												{
													node* tempNode = new node;
													tempNode->code = COND_STMT;
													(tempNode->v).push_back($3.Node);
													(tempNode->v).push_back($5.Node);
													$$.Node = tempNode;
												}
						;

expr:					number 
												{
													$$.Node = $1.Node;
												}
						| id 
												{
													int idScope = findIdentifierScope(($1.Node)->id);
													if(idScope == -1)
													{
														semanticError = true;
														cout << "Undeclared variable " << ($1.Node)->id << " line no. " << lineNo+1 << endl;	
													}
													else
													{
														($$.Node)->dataType = symbolTable[idScope][($1.Node)->id];
													} 
													$$.Node = $1.Node;
												}
						| number operator expr
												{
													node* tempNode = new node;
													if($2.s == NULL)
														tempNode->code = "" ;
													else{
														tempNode->code = string($2.s);
													}
													(tempNode->v).push_back($1.Node);
													(tempNode->v).push_back($3.Node);
													if(($1.Node)->dataType != ($3.Node)->dataType)
													{
														semanticError = true;
														printf("Mismatching data types of operands at %d\n",lineNo+1);
													}
													else
													{
														tempNode->dataType = ($3.Node)->dataType;
													}
													$$.Node = tempNode;
												}
						| id operator expr
												{
													node* tempNode = new node;
													if($2.s == NULL)
														tempNode->code = "" ;
													else{
														tempNode->code = string($2.s);
													}
													(tempNode->v).push_back($1.Node);
													(tempNode->v).push_back($3.Node);
													
													int idScope = findIdentifierScope(($1.Node)->id);
													if(idScope == -1)
													{
														semanticError = true;
														cout << "Undeclared variable " << ($1.Node)->id << " line no. " << lineNo+1 << endl;	
													}
													else if(symbolTable[idScope][($1.Node)->id] != ($3.Node)->dataType)
													{
														semanticError = true;
														printf("Mismatching data types of operands at %d\n",lineNo+1);
													}
													else
													{
														tempNode->dataType = ($3.Node)->dataType;
													}
													$$.Node = tempNode;
												}
						| id left_parenthesis right_parenthesis
												{
													node* tempNode = new node;
													tempNode->code = FUNC_CALL;
													if($1.s == NULL)
														tempNode->code = "" ;
													else{
														tempNode->id = string($1.s);
													}
													$$.Node = tempNode;
												}
						;

operator: 				assignment_op			{$$.s = $1.s;}
						| relational_op			{$$.s = $1.s;}
						| binary_op				{$$.s = $1.s;}
						| error			
						{
							syntacticError = true;
							printf("Missing operator at line no. %d\n",lineNo+1);
						}
						
assignment_op:		 	'='				{$$.s = strdup(ASSIGN);}
						;

relational_op:			'<'				{$$.s = strdup(LESS);}
						| '>'			{$$.s = strdup(GREATER);}
						| EQ_OP			{$$.s = strdup(EQUALITY);}
						;

binary_op:				'+'				{$$.s = strdup(ADD);}
						| '-'			{$$.s = strdup(SUB);}
						| '*'			{$$.s = strdup(MUL);}
						| '/'			{$$.s = strdup(DIV);}
						| '%'			{$$.s = strdup(MOD);}
						;

semi:					';'
						| error		
						{
							syntacticError = true;
							printf("Missing semicolon at line no. %d\n",lineNo+1);
						}
						;

data_type:				DATA_TYPE 	{
										node* tempNode = new node;
										tempNode->code = D_TYPE;
										tempNode->id = string(yytext,yyleng);	
										$$.Node = tempNode;
									}
						| error		
						{
							syntacticError = true;
							printf("Missing data type at line no. %d\n",lineNo+1);
						}
						;

id:						ID 			{
										node* tempNode = new node;
										tempNode->code = IDENTIFIER;
										tempNode->id = string(yytext,yyleng);
										$$.Node = tempNode;
									}
						| error		
						{
							syntacticError = true;
							printf("Missing identifier at line no. %d\n",lineNo+1);
						}
						;

integer:				INTEGER 	{
										node* tempNode = new node;
										tempNode->code = NUMBER;
										tempNode->dataType = "int";
										tempNode->id = string(yytext,yyleng);
										$$.Node = tempNode;
									}
						| error     
						{
							syntacticError = true;
							printf("Missing integer at line no. %d\n",lineNo+1);
						}
						;

number:					INTEGER {
										node* tempNode = new node;
										tempNode->code = NUMBER;
										tempNode->dataType = "int";
										tempNode->id = string(yytext,yyleng);
										$$.Node = tempNode;
								}
						| FLOATING_POINT
								{
									node* tempNode = new node;
									tempNode->code = NUMBER;
									tempNode->dataType = "float";
									tempNode->id = string(yytext,yyleng);
									$$.Node = tempNode;
								}
						| error		
						{
							syntacticError = true;
							printf("Missing number at line no. %d\n",lineNo+1);
						}
						;

left_parenthesis:		'('
						| error 	
						{
							syntacticError = true;
							printf("Missing ( at line no. %d\n",lineNo+1);
						}
						;

right_parenthesis:		')'
						| error 	
						{
							syntacticError = true;
							printf("Missing ) at line no. %d\n",lineNo+1);
						}
						;

left_brace:				'{'
						| error 	
						{
							syntacticError = true;
							printf("Missing { at line no. %d\n",lineNo+1);
						}
						;

right_brace:			'}'
						| error 	
						{
							syntacticError = true;
							printf("Missing } at line no. %d\n",lineNo+1);
						}
						;


comma:					','
						| error 	
						{
							syntacticError = true;
							printf("Missing , at line no. %d\n",lineNo+1);
						}
						;
%%
void printSpace(int cnt)
{
	for(int i=0;i<cnt;i++) cout<<"\t";
}

void printSymbolTable(){
	for(int i = 0 ; i< symbolTable.size(); i++ ){
		cout<<"Scope "<<i<<endl;
		for ( auto it = symbolTable[i].begin() ; it!= symbolTable[i].end() ; it++){
			cout<<it->first<<" "<<it->second<<endl;
		}
	}
}
void dfs(node *n,int cnt)
{

	printSpace(cnt);
	if(n==NULL){
		cout<<"NULL";
		return;
	}

	cout <<n->code<<endl;
	for (int i = 0; i < (n->v).size(); ++i)
	{
		dfs((n->v)[i],cnt+1);
	}
}

string getNewReg()
{
	static int count=0;
	stringstream ss;
	ss<<++count;
	return string("r"+ss.str());
}

string genNewLabel()
{
	static int label=0;
	stringstream ss;
	ss<<++label;
	return string("label"+ss.str()+":");
}
string cgen(node *n)
{
	if(n==NULL) 
	{
		return "";
	}
	if(n->code == CMPD_STMT)
	{
		scope++;
		map<string,string> temp;
		symbolTable.push_back(temp);
		
		if((n->v).size()==1) cgen((n->v)[0]);

		scope--;
		symbolTable.pop_back();
		return "";
	}
	if(n->code == COND_STMT)
	{
		string r1=cgen((n->v)[0]);
		string trueLabel = genNewLabel();
		string falseLabel = genNewLabel();
		cout<<"if "<<r1<<" goto "<<trueLabel<<endl;
		cout<<"goto "<<falseLabel<<endl;
		cout<<trueLabel<<endl;
		cgen((n->v)[1]);
		string newReg=getNewReg();
		cout<<falseLabel<<endl;
		return "";
	}
	if(n->code == LOOP_STMT)
	{
		string entryLabel = genNewLabel();
		cout<<entryLabel<<endl;
		string r1=cgen((n->v)[0]);
		string bodyLabel = genNewLabel();
		string exitLabel = genNewLabel();
		cout<<"if "<<r1<<" goto "<<bodyLabel<<endl;
		cout<<"goto "<<exitLabel<<endl;
		cout<<bodyLabel<<endl;
		cgen((n->v)[1]);
		cout<<"goto "<<entryLabel<<endl;
		cout<<exitLabel<<endl;
		return "";
	}
	if(n->code == ASSIGN)
	{
		
		cout<<cgen((n->v)[0])<<" = "<<cgen((n->v)[1])<<endl;
		return "";
	}
	if(n->code == IDENTIFIER)
	{
		stringstream ss;
		ss<<scope;

		return n->id+ss.str();
	}
	if(n->code == NUMBER){
		return n->id;
	}
	if(n->code == ADD)
	{
		string r1=cgen((n->v)[0]);
		string r2=cgen((n->v)[1]);
		string newReg=getNewReg();
		cout<<newReg<<" = "<<r1<<" + "<<r2<<endl;
		return newReg;
	}
	if(n->code == MUL)
	{
		string r1=cgen((n->v)[0]);
		string r2=cgen((n->v)[1]);
		string newReg=getNewReg();
		cout<<newReg<<" = "<<r1<<" * "<<r2<<endl;
		return newReg;
	}
	if(n->code == SUB)
	{
		string r1=cgen((n->v)[0]);
		string r2=cgen((n->v)[1]);
		string newReg=getNewReg();
		cout<<newReg<<" = "<<r1<<" - "<<r2<<endl;
		return newReg;
	}
	if(n->code == DIV)
	{
		string r1=cgen((n->v)[0]);
		string r2=cgen((n->v)[1]);
		string newReg=getNewReg();
		cout<<newReg<<" = "<<r1<<" / "<<r2<<endl;
		return newReg;
	}
	if(n->code == MOD)
	{
		string r1=cgen((n->v)[0]);
		string r2=cgen((n->v)[1]);
		string newReg=getNewReg();
		cout<<newReg<<" = "<<r1<<" % "<<r2<<endl;
		return newReg;
	}
	if(n->code == LESS)
	{
		string r1=cgen((n->v)[0]);
		string r2=cgen((n->v)[1]);
		string newReg=getNewReg();
		cout<<newReg<<" = "<<r1<<" < "<<r2<<endl;
		return newReg;
	}
	if(n->code == GREATER)
	{
		string r1=cgen((n->v)[0]);
		string r2=cgen((n->v)[1]);
		string newReg=getNewReg();
		cout<<newReg<<" = "<<r1<<" > "<<r2<<endl;
		return newReg;
	}
	if(n->code == EQUALITY)
	{
		string r1=cgen((n->v)[0]);
		string r2=cgen((n->v)[1]);
		string newReg=getNewReg();
		cout<<newReg<<" = "<<r1<<" == "<<r2<<endl;
		return newReg;
	}
	else
	{
		for (int i = 0; i < (n->v).size(); ++i)
		{
			cgen((n->v)[i]);
		}
		return "";
	}
}


int main(){

	map<string,string> temp;
	symbolTable.push_back(temp);
	yyparse();

	/*for(auto it = symbolTable.begin();it!=symbolTable.end();it++)
	{
		cout << it->first << " " << it->second << endl;
	}*/

	if(!syntacticError && !semanticError)
	{
		dfs(root,0);

		symbolTable.clear();
		map<string,string> temp;
		symbolTable.push_back(temp);
		scope = 0;

		cgen(root);
	}
	return 0 ;
}