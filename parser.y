%{
	#include <stdio.h>
	#include <stdlib.h>
	int yylex(void);
	void yyerror (char const *s) {
   		//fprintf (stderr, "%s\n", s);
 	}
 	extern int lineNo;
%}

%token ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN AND_ASSIGN XOR_ASSIGN OR_ASSIGN 
%token RIGHT_OP LEFT_OP INC_OP DEC_OP PTR_OP AND_OP OR_OP LE_OP GE_OP EQ_OP NE_OP 

%token ID DATA_TYPE 
%token IF ELSE WHILE FOR DO 
%token CONTINUE BREAK RETURN 
%token FLOATING_POINT INTEGER CHAR_LIT STRING
 


%%

strt:  					/*empty*/
						|external_declaration strt 
						;

external_declaration: 	function_definition 
						| declaration
						;

declaration: 			data_type id semi
						| data_type id '=' expr semi
						| data_type id left_bracket integer right_bracket semi
						;		

declaration_list: 		declaration 
						| declaration declaration_list
						;

function_definition:	data_type id left_parenthesis arg_list right_parenthesis compound_stmts
						;

arg_list:				/* empty */
						| data_type id 
						| data_type id comma arg_list
						;
						
param_list:				/* empty */
						| id
						| id comma param_list
						;

compound_stmts:			left_brace right_brace 
						| left_brace stmt_list right_brace
						;

stmt_list:				/*empty*/
						|stmt stmt_list
						;

stmt:					declaration_list 
						| compound_stmts
						| conditional_stmt
						| iteration_stmt
						| jump_stmt
						| expr semi
						;

conditional_stmt:		IF left_parenthesis expr right_parenthesis stmt 
						| IF left_parenthesis expr right_parenthesis stmt ELSE stmt 
						;

iteration_stmt:			WHILE left_parenthesis expr right_parenthesis stmt 
						| DO stmt WHILE left_parenthesis expr right_parenthesis semi
						| FOR left_parenthesis expr semi expr semi expr right_parenthesis stmt
						;

jump_stmt:				CONTINUE semi
						| BREAK semi
						| RETURN semi
						| RETURN expr semi
						;

expr:					number 
						| id 
						| number operator expr
						| id operator expr
						| id left_parenthesis param_list right_parenthesis
						;

operator: 				assignment_op
						| relational_op
						| logical_op
						| binary_op
						| error			{printf("Missing operator at line no. %d\n",lineNo);}			
						
assignment_op:		 	'='
						| MUL_ASSIGN
						| DIV_ASSIGN
						| MOD_ASSIGN
						| ADD_ASSIGN
						| SUB_ASSIGN
						| AND_ASSIGN
						| XOR_ASSIGN
						| OR_ASSIGN
						;

relational_op:			'<'
						| '>'
						| LE_OP
						| GE_OP
						;

logical_op:				'!'
						| AND_OP
						| OR_OP
						;

binary_op:				'+'
						| '-'
						| '*'
						| '/'
						| '%'
						;

semi:					';'
						| error		{printf("Missing semicolon at line no. %d\n",lineNo);}
						;

data_type:				DATA_TYPE
						| error		{printf("Missing data type at line no. %d\n",lineNo);}
						;

id:						ID
						| error		{printf("Missing identifier at line no. %d\n",lineNo);}
						;

integer:				INTEGER
						| error     {printf("Missing integer at line no. %d\n",lineNo);}
						;

number:					INTEGER
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

int main(){
	//yydebug = 1;
	yyparse();
	return 0 ;
}

