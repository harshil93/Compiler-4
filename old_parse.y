%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "iostream"
	#include <vector>
	#include <string>
	#include "sstream"
	int yylex(void);
	void yyerror (char const *s) {
   		//fprintf (stderr, "%s\n", s);
 	}
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

 	using namespace std;
 	struct node
 	{
 		string code;
 		vector<node*> v;
 		string id;
 	};

 	node* root;

 	union utype
	{
		node* Node;
		char* s;
	};
	#define YYSTYPE utype
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
																node* tempNode1 = new node;
																tempNode1->id = string($2.s);
																tempNode1->code = IDENTIFIER;
																(tempNode->v).push_back(tempNode1);
																(tempNode->v).push_back($2.Node);
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
																node* tempNode1 = new node;
																tempNode1->id = string($2.s);
																tempNode1->code = IDENTIFIER;
																(tempNode->v).push_back(tempNode1);
																(tempNode->v).push_back($5.Node);
																$$.Node = tempNode;
															}
						;


compound_stmts:			left_brace right_brace 
												{
																node* tempNode = new node;
																tempNode->code = CMPD_STMT;
																$$.Node = tempNode;
												}
						| left_brace stmt_list right_brace
												{
																node* tempNode = new node;
																tempNode->code = CMPD_STMT;
																(tempNode->v).push_back($2.Node);
																$$.Node = tempNode;
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
													node* tempNode = new node;
													tempNode->code = NUMBER;
													tempNode->id = string($1.s);
													$$.Node = tempNode;
												}
						| id 
												{
													node* tempNode = new node;
													tempNode->code = IDENTIFIER;
													tempNode->id = string($1.s);
													$$.Node = tempNode;
												}
						| number operator expr
												{
													node* tempNode = new node;
													tempNode->code = $2.s;
													node* tempNode1 = new node;
													tempNode1->id = string($1.s);
													tempNode1->code = NUMBER;
													(tempNode->v).push_back(tempNode1);
													(tempNode->v).push_back($3.Node);
													$$.Node = tempNode;
												}
						| id operator expr
												{
													node* tempNode = new node;
													tempNode->code = $2.s;
													node* tempNode1 = new node;
													tempNode1->id = string($1.s);
													tempNode1->code = IDENTIFIER;
													(tempNode->v).push_back(tempNode1);
													(tempNode->v).push_back($3.Node);
													$$.Node = tempNode;
												}
						| id left_parenthesis right_parenthesis
												{
													node* tempNode = new node;
													tempNode->code = FUNC_CALL;
													tempNode->id = string($1.s);
													$$.Node = tempNode;
												}
						;

operator: 				assignment_op			{$$.s = $1.s;}
						| relational_op			{$$.s = $1.s;}
						| binary_op				{$$.s = $1.s;}
						| error			{printf("Missing operator at line no. %d\n",lineNo);}
						
assignment_op:		 	'='				{$$.s = ASSIGN;}
						;

relational_op:			'<'				{$$.s = LESS;}
						| '>'			{$$.s = GREATER;}
						;

binary_op:				'+'				{$$.s = ADD;}
						| '-'			{$$.s = SUB;}
						| '*'			{$$.s = MUL;}
						| '/'			{$$.s = DIV;}
						| '%'			{$$.s = MOD;}
						;

semi:					';'
						| error		{printf("Missing semicolon at line no. %d\n",lineNo);}
						;

data_type:				DATA_TYPE 	{
										node* tempNode = new node;
										tempNode->code = D_TYPE;
										$$.Node = tempNode;
									}
						| error		{printf("Missing data type at line no. %d\n",lineNo);}
						;

id:						ID 			{
										$$.s = (char *)(string(yytext,yyleng).c_str());
									}
						| error		{printf("Missing identifier at line no. %d\n",lineNo);}
						;

integer:				INTEGER 	{
										$$.s = (char *)(string(yytext,yyleng).c_str());
									}
						| error     {printf("Missing integer at line no. %d\n",lineNo);}
						;

number:					INTEGER {
										$$.s = (char *)(string(yytext,yyleng).c_str());
								}
						| FLOATING_POINT
						| error		{printf("Missing number at line no. %d\n",lineNo);}
						;

left_parenthesis:		'('
						| error 	{printf("Missing ( at line no. %d\n",lineNo);}
						;

right_parenthesis:		')'
						| error 	{printf("Missing ) at line no. %d\n",lineNo);}
						;

left_brace:				'{'
						| error 	{printf("Missing { at line no. %d\n",lineNo);}
						;

right_brace:			'}'
						| error 	{printf("Missing } at line no. %d\n",lineNo);}
						;

left_bracket:			'['
						| error 	{printf("Missing [ at line no. %d\n",lineNo);}
						;

right_bracket:			']'
						| error 	{printf("Missing ] at line no. %d\n",lineNo);}
						;

comma:					','
						| error 	{printf("Missing , at line no. %d\n",lineNo);}
						;
%%
void printSpace(int cnt)
{
	for(int i=0;i<cnt;i++) cout<<"\t";
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

string cgen(node *n,int cnt)
{
	printSpace(cnt);
	if(n!=NULL)	cout << n->code << endl;
	if(n==NULL) 
	{
		cout << "dummy" << endl;
		return "dummy";
	}
	else if(n->code == ASSIGN)
	{
		
		cout<<cgen((n->v)[0],cnt+1)<<" "<<cgen((n->v)[1],cnt+1);
	}
	else if(n->code == IDENTIFIER || n->code == NUMBER)
	{
		//do nothing
		return n->id;
	}
	else if(n->code == ADD)
	{
		string r1=cgen((n->v)[0],cnt+1);
		string r2=cgen((n->v)[1],cnt+1);
		string newReg=getNewReg();
		cout<<newReg<<" "<<r1<<" + "<<r2;
		return newReg;
		// printf("r%d = r%d + r%d\n",cnt,cnt,cnt+1);
	}
	else
	{
		for (int i = 0; i < (n->v).size(); ++i)
		{
			cgen((n->v)[i],cnt+1);
		}
	}
}


int main(){
	//yydebug = 1;
	yyparse();

	dfs(root,0);

	cgen(root,0);
	return 0 ;
}

