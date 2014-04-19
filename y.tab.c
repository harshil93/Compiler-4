#ifndef lint
static const char yysccsid[] = "@(#)yaccpar	1.9 (Berkeley) 02/21/93";
#endif

#define YYBYACC 1
#define YYMAJOR 1
#define YYMINOR 9
#define YYPATCH 20121003

#define YYEMPTY        (-1)
#define yyclearin      (yychar = YYEMPTY)
#define yyerrok        (yyerrflag = 0)
#define YYRECOVERING() (yyerrflag != 0)

#define YYPREFIX "yy"

#define YYPURE 0

#line 2 "parse.y"
	#include <stdio.h>
	#include <stdlib.h>
	#include "iostream"
	#include <vector>
	#include <string>
	int yylex(void);
	void yyerror (char const *s) {
   		/*fprintf (stderr, "%s\n", s);*/
 	}
 	extern int lineNo;

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
 	};

 	node* root;

 	union utype
	{
		node* Node;
		char* s;
	};
	#define YYSTYPE utype
#line 74 "y.tab.c"

#ifndef YYSTYPE
typedef int YYSTYPE;
#endif

/* compatibility with bison */
#ifdef YYPARSE_PARAM
/* compatibility with FreeBSD */
# ifdef YYPARSE_PARAM_TYPE
#  define YYPARSE_DECL() yyparse(YYPARSE_PARAM_TYPE YYPARSE_PARAM)
# else
#  define YYPARSE_DECL() yyparse(void *YYPARSE_PARAM)
# endif
#else
# define YYPARSE_DECL() yyparse(void)
#endif

/* Parameters sent to lex. */
#ifdef YYLEX_PARAM
# define YYLEX_DECL() yylex(void *YYLEX_PARAM)
# define YYLEX yylex(YYLEX_PARAM)
#else
# define YYLEX_DECL() yylex(void)
# define YYLEX yylex()
#endif

/* Parameters sent to yyerror. */
#ifndef YYERROR_DECL
#define YYERROR_DECL() yyerror(const char *s)
#endif
#ifndef YYERROR_CALL
#define YYERROR_CALL(msg) yyerror(msg)
#endif

extern int YYPARSE_DECL();

#define ADD_ASSIGN 257
#define SUB_ASSIGN 258
#define MUL_ASSIGN 259
#define DIV_ASSIGN 260
#define MOD_ASSIGN 261
#define AND_ASSIGN 262
#define XOR_ASSIGN 263
#define OR_ASSIGN 264
#define RIGHT_OP 265
#define LEFT_OP 266
#define INC_OP 267
#define DEC_OP 268
#define PTR_OP 269
#define AND_OP 270
#define OR_OP 271
#define LE_OP 272
#define GE_OP 273
#define EQ_OP 274
#define NE_OP 275
#define ID 276
#define DATA_TYPE 277
#define IF 278
#define ELSE 279
#define WHILE 280
#define FOR 281
#define DO 282
#define CONTINUE 283
#define BREAK 284
#define RETURN 285
#define FLOATING_POINT 286
#define INTEGER 287
#define CHAR_LIT 288
#define STRING 289
#define iteration_stmt 290
#define YYERRCODE 256
static const short yylhs[] = {                           -1,
    0,    1,    1,    2,    2,    4,    8,    8,    3,   11,
   11,   14,   14,   15,   15,   15,   15,   15,   16,   17,
   17,   17,   17,   17,   19,   19,   19,   19,   20,   21,
   21,   22,   22,   22,   22,   22,    7,    7,    5,    5,
    6,    6,   23,   23,   18,   18,   18,    9,    9,   10,
   10,   12,   12,   13,   13,   24,   24,   25,   25,   26,
   26,
};
static const short yylen[] = {                            2,
    1,    0,    2,    1,    1,    3,    1,    2,    5,    2,
    3,    0,    2,    1,    1,    1,    1,    2,    5,    1,
    1,    3,    3,    3,    1,    1,    1,    1,    1,    1,
    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
    1,
};
static const short yydefred[] = {                         0,
   40,   39,    0,    1,    0,    4,    5,    0,    3,   42,
   41,    0,    0,   37,   48,    6,    0,   51,   50,    0,
   53,   52,    9,    0,    0,    0,   46,   45,   17,   54,
    0,    0,    0,   14,   15,   10,    0,    0,   16,    0,
    0,   49,    0,    8,    0,    0,   29,   30,   31,   32,
   33,   34,   35,   36,    0,    0,   25,   26,   27,   55,
   11,    0,   13,   38,   18,   28,    0,   42,    0,   24,
   23,   22,    0,   19,
};
static const short yydgoto[] = {                          3,
    4,    5,    6,   31,   32,   33,   16,   34,   17,   20,
   35,   24,   36,   37,   38,   39,   40,   41,   56,   57,
   58,   59,    0,    0,    0,    0,
};
static const short yysindex[] = {                      -228,
    0,    0,    0,    0, -228,    0,    0, -217,    0,    0,
    0,  -33,    0,    0,    0,    0,  -25,    0,    0, -102,
    0,    0,    0, -105,    0,  -29,    0,    0,    0,    0,
 -228, -217,  -28,    0,    0,    0,  -98,  -88,    0,  -46,
   10,    0, -220,    0,  -46,    0,    0,    0,    0,    0,
    0,    0,    0,    0,  -25, -220,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0, -220,    0,  -25,    0,
    0,    0,  -88,    0,
};
static const short yyrindex[] = {                        29,
    0,    0,    0,    0,   29,    0,    0,    0,    0,    0,
    0,    0,    4,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    1,    0,    0,    0,    0,    0,
  -83,    0,    9,    0,    0,    0,    0,  -94,    0,    0,
   17,    0,    0,    0,    0,  -39,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,  -37,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,
};
static const short yygindex[] = {                         0,
   32,    0,    0,   74,   77,   22,   25,   50,   47,   14,
   58,    0,   48,   46,   16,    0,    8,    0,   49,    0,
    0,    0,    0,    0,    0,    0,
};
#define YYTABLESIZE 291
static const short yytable[] = {                         42,
   55,   49,   42,   38,   42,   42,   15,   42,   54,   42,
   15,   15,   14,   52,   50,   19,   51,   22,   53,   30,
   22,   42,   42,   42,   42,   14,   30,    1,    2,   12,
   12,   48,   47,   49,   22,   68,    9,   42,   10,    7,
   42,    7,   42,   42,   49,   42,   54,   42,    2,   21,
   69,   52,   50,   45,   51,   11,   53,   20,   11,   42,
   42,   42,   42,   71,   65,   27,   28,   21,   70,   48,
   47,   49,   43,    7,   72,   20,    8,   23,    7,   55,
   44,    8,   73,   63,   61,   53,    0,   53,   74,   67,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,   53,    0,   53,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
   25,    0,    0,   21,    0,    0,    0,   60,    0,    0,
    0,    0,    0,    0,    0,    0,    0,   62,    0,    0,
   11,    2,   26,    0,    0,    0,    0,    0,    0,    0,
   27,   28,    0,    0,   29,    0,    0,   11,    2,   26,
    0,    0,    7,    0,    7,    0,    0,   27,   28,    0,
    0,   29,    7,    7,    0,    0,    7,    0,    0,   64,
    0,    0,    0,    0,    0,    0,   28,    0,   40,    0,
    0,    0,   13,    0,    0,    0,   42,   46,    0,    0,
   18,    0,    0,    0,    0,    0,   28,    0,   40,   53,
   53,    0,    0,    0,    0,    0,   28,   28,   53,   53,
    0,    0,   53,    0,    0,    0,   40,    0,    0,   38,
    0,    0,    0,    0,    0,   66,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,   40,   53,   53,    0,
   38,    0,    0,    0,    0,    0,   53,   53,    0,    0,
   53,
};
static const short yycheck[] = {                         37,
    0,   41,   40,    0,   42,   43,   40,   45,   37,   47,
   40,   40,   59,   42,   43,   41,   45,  123,   47,  125,
  123,   59,   60,   61,   62,   59,  125,  256,    0,    8,
  125,   60,   61,   62,  123,  256,    5,   37,  256,  123,
   40,  125,   42,   43,   41,   45,   37,   47,  277,   41,
   43,   42,   43,   32,   45,  276,   47,   41,  276,   59,
   60,   61,   62,   56,   40,  286,  287,   59,   55,   60,
   61,   62,   26,    0,   67,   59,    0,   20,    5,   33,
   31,    5,   69,   38,   37,  123,   -1,  125,   73,   41,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,  123,   -1,  125,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
  256,   -1,   -1,  256,   -1,   -1,   -1,  256,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,  256,   -1,   -1,
  276,  277,  278,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
  286,  287,   -1,   -1,  290,   -1,   -1,  276,  277,  278,
   -1,   -1,  276,   -1,  278,   -1,   -1,  286,  287,   -1,
   -1,  290,  286,  287,   -1,   -1,  290,   -1,   -1,  256,
   -1,   -1,   -1,   -1,   -1,   -1,  256,   -1,  256,   -1,
   -1,   -1,  256,   -1,   -1,   -1,  256,  256,   -1,   -1,
  256,   -1,   -1,   -1,   -1,   -1,  276,   -1,  276,  277,
  278,   -1,   -1,   -1,   -1,   -1,  286,  287,  286,  287,
   -1,   -1,  290,   -1,   -1,   -1,  256,   -1,   -1,  256,
   -1,   -1,   -1,   -1,   -1,  256,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,  276,  277,  278,   -1,
  277,   -1,   -1,   -1,   -1,   -1,  286,  287,   -1,   -1,
  290,
};
#define YYFINAL 3
#ifndef YYDEBUG
#define YYDEBUG 1
#endif
#define YYMAXTOKEN 290
#if YYDEBUG
static const char *yyname[] = {

"end-of-file",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,"'%'",0,0,"'('","')'","'*'","'+'","','","'-'",0,"'/'",0,0,0,0,0,0,0,0,0,0,
0,"';'","'<'","'='","'>'",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,"'['",0,"']'",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"'{'",
0,"'}'",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"ADD_ASSIGN","SUB_ASSIGN","MUL_ASSIGN",
"DIV_ASSIGN","MOD_ASSIGN","AND_ASSIGN","XOR_ASSIGN","OR_ASSIGN","RIGHT_OP",
"LEFT_OP","INC_OP","DEC_OP","PTR_OP","AND_OP","OR_OP","LE_OP","GE_OP","EQ_OP",
"NE_OP","ID","DATA_TYPE","IF","ELSE","WHILE","FOR","DO","CONTINUE","BREAK",
"RETURN","FLOATING_POINT","INTEGER","CHAR_LIT","STRING","iteration_stmt",
};
static const char *yyrule[] = {
"$accept : strt",
"strt : strt_",
"strt_ :",
"strt_ : external_declaration strt_",
"external_declaration : function_definition",
"external_declaration : declaration",
"declaration : data_type id semi",
"declaration_list : declaration",
"declaration_list : declaration declaration_list",
"function_definition : data_type id left_parenthesis right_parenthesis compound_stmts",
"compound_stmts : left_brace right_brace",
"compound_stmts : left_brace stmt_list right_brace",
"stmt_list :",
"stmt_list : stmt stmt_list",
"stmt : declaration_list",
"stmt : compound_stmts",
"stmt : conditional_stmt",
"stmt : iteration_stmt",
"stmt : expr semi",
"conditional_stmt : IF left_parenthesis expr right_parenthesis stmt",
"expr : number",
"expr : id",
"expr : number operator expr",
"expr : id operator expr",
"expr : id left_parenthesis right_parenthesis",
"operator : assignment_op",
"operator : relational_op",
"operator : binary_op",
"operator : error",
"assignment_op : '='",
"relational_op : '<'",
"relational_op : '>'",
"binary_op : '+'",
"binary_op : '-'",
"binary_op : '*'",
"binary_op : '/'",
"binary_op : '%'",
"semi : ';'",
"semi : error",
"data_type : DATA_TYPE",
"data_type : error",
"id : ID",
"id : error",
"integer : INTEGER",
"integer : error",
"number : INTEGER",
"number : FLOATING_POINT",
"number : error",
"left_parenthesis : '('",
"left_parenthesis : error",
"right_parenthesis : ')'",
"right_parenthesis : error",
"left_brace : '{'",
"left_brace : error",
"right_brace : '}'",
"right_brace : error",
"left_bracket : '['",
"left_bracket : error",
"right_bracket : ']'",
"right_bracket : error",
"comma : ','",
"comma : error",

};
#endif

int      yydebug;
int      yynerrs;

int      yyerrflag;
int      yychar;
YYSTYPE  yyval;
YYSTYPE  yylval;

/* define the initial stack-sizes */
#ifdef YYSTACKSIZE
#undef YYMAXDEPTH
#define YYMAXDEPTH  YYSTACKSIZE
#else
#ifdef YYMAXDEPTH
#define YYSTACKSIZE YYMAXDEPTH
#else
#define YYSTACKSIZE 500
#define YYMAXDEPTH  500
#endif
#endif

#define YYINITSTACKSIZE 500

typedef struct {
    unsigned stacksize;
    short    *s_base;
    short    *s_mark;
    short    *s_last;
    YYSTYPE  *l_base;
    YYSTYPE  *l_mark;
} YYSTACKDATA;
/* variables for the parser stack */
static YYSTACKDATA yystack;
#line 324 "parse.y"
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


int main(){
	//yydebug = 1;
	yyparse();

	dfs(root,0);

	return 0 ;
}

#line 420 "y.tab.c"

#if YYDEBUG
#include <stdio.h>		/* needed for printf */
#endif

#include <stdlib.h>	/* needed for malloc, etc */
#include <string.h>	/* needed for memset */

/* allocate initial stack or double stack size, up to YYMAXDEPTH */
static int yygrowstack(YYSTACKDATA *data)
{
    int i;
    unsigned newsize;
    short *newss;
    YYSTYPE *newvs;

    if ((newsize = data->stacksize) == 0)
        newsize = YYINITSTACKSIZE;
    else if (newsize >= YYMAXDEPTH)
        return -1;
    else if ((newsize *= 2) > YYMAXDEPTH)
        newsize = YYMAXDEPTH;

    i = data->s_mark - data->s_base;
    newss = (short *)realloc(data->s_base, newsize * sizeof(*newss));
    if (newss == 0)
        return -1;

    data->s_base = newss;
    data->s_mark = newss + i;

    newvs = (YYSTYPE *)realloc(data->l_base, newsize * sizeof(*newvs));
    if (newvs == 0)
        return -1;

    data->l_base = newvs;
    data->l_mark = newvs + i;

    data->stacksize = newsize;
    data->s_last = data->s_base + newsize - 1;
    return 0;
}

#if YYPURE || defined(YY_NO_LEAKS)
static void yyfreestack(YYSTACKDATA *data)
{
    free(data->s_base);
    free(data->l_base);
    memset(data, 0, sizeof(*data));
}
#else
#define yyfreestack(data) /* nothing */
#endif

#define YYABORT  goto yyabort
#define YYREJECT goto yyabort
#define YYACCEPT goto yyaccept
#define YYERROR  goto yyerrlab

int
YYPARSE_DECL()
{
    int yym, yyn, yystate;
#if YYDEBUG
    const char *yys;

    if ((yys = getenv("YYDEBUG")) != 0)
    {
        yyn = *yys;
        if (yyn >= '0' && yyn <= '9')
            yydebug = yyn - '0';
    }
#endif

    yynerrs = 0;
    yyerrflag = 0;
    yychar = YYEMPTY;
    yystate = 0;

#if YYPURE
    memset(&yystack, 0, sizeof(yystack));
#endif

    if (yystack.s_base == NULL && yygrowstack(&yystack)) goto yyoverflow;
    yystack.s_mark = yystack.s_base;
    yystack.l_mark = yystack.l_base;
    yystate = 0;
    *yystack.s_mark = 0;

yyloop:
    if ((yyn = yydefred[yystate]) != 0) goto yyreduce;
    if (yychar < 0)
    {
        if ((yychar = YYLEX) < 0) yychar = 0;
#if YYDEBUG
        if (yydebug)
        {
            yys = 0;
            if (yychar <= YYMAXTOKEN) yys = yyname[yychar];
            if (!yys) yys = "illegal-symbol";
            printf("%sdebug: state %d, reading %d (%s)\n",
                    YYPREFIX, yystate, yychar, yys);
        }
#endif
    }
    if ((yyn = yysindex[yystate]) && (yyn += yychar) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yychar)
    {
#if YYDEBUG
        if (yydebug)
            printf("%sdebug: state %d, shifting to state %d\n",
                    YYPREFIX, yystate, yytable[yyn]);
#endif
        if (yystack.s_mark >= yystack.s_last && yygrowstack(&yystack))
        {
            goto yyoverflow;
        }
        yystate = yytable[yyn];
        *++yystack.s_mark = yytable[yyn];
        *++yystack.l_mark = yylval;
        yychar = YYEMPTY;
        if (yyerrflag > 0)  --yyerrflag;
        goto yyloop;
    }
    if ((yyn = yyrindex[yystate]) && (yyn += yychar) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yychar)
    {
        yyn = yytable[yyn];
        goto yyreduce;
    }
    if (yyerrflag) goto yyinrecovery;

    yyerror("syntax error");

    goto yyerrlab;

yyerrlab:
    ++yynerrs;

yyinrecovery:
    if (yyerrflag < 3)
    {
        yyerrflag = 3;
        for (;;)
        {
            if ((yyn = yysindex[*yystack.s_mark]) && (yyn += YYERRCODE) >= 0 &&
                    yyn <= YYTABLESIZE && yycheck[yyn] == YYERRCODE)
            {
#if YYDEBUG
                if (yydebug)
                    printf("%sdebug: state %d, error recovery shifting\
 to state %d\n", YYPREFIX, *yystack.s_mark, yytable[yyn]);
#endif
                if (yystack.s_mark >= yystack.s_last && yygrowstack(&yystack))
                {
                    goto yyoverflow;
                }
                yystate = yytable[yyn];
                *++yystack.s_mark = yytable[yyn];
                *++yystack.l_mark = yylval;
                goto yyloop;
            }
            else
            {
#if YYDEBUG
                if (yydebug)
                    printf("%sdebug: error recovery discarding state %d\n",
                            YYPREFIX, *yystack.s_mark);
#endif
                if (yystack.s_mark <= yystack.s_base) goto yyabort;
                --yystack.s_mark;
                --yystack.l_mark;
            }
        }
    }
    else
    {
        if (yychar == 0) goto yyabort;
#if YYDEBUG
        if (yydebug)
        {
            yys = 0;
            if (yychar <= YYMAXTOKEN) yys = yyname[yychar];
            if (!yys) yys = "illegal-symbol";
            printf("%sdebug: state %d, error recovery discards token %d (%s)\n",
                    YYPREFIX, yystate, yychar, yys);
        }
#endif
        yychar = YYEMPTY;
        goto yyloop;
    }

yyreduce:
#if YYDEBUG
    if (yydebug)
        printf("%sdebug: state %d, reducing by rule %d (%s)\n",
                YYPREFIX, yystate, yyn, yyrule[yyn]);
#endif
    yym = yylen[yyn];
    if (yym)
        yyval = yystack.l_mark[1-yym];
    else
        memset(&yyval, 0, sizeof yyval);
    switch (yyn)
    {
case 1:
#line 68 "parse.y"
	{
													root = yystack.l_mark[0].Node;
													root->code = START;
												}
break;
case 2:
#line 72 "parse.y"
	{
																node* tempNode = new node;
																tempNode->code = START_;
																yyval.Node = tempNode;
															}
break;
case 3:
#line 77 "parse.y"
	{
																node* tempNode = new node;
																tempNode->code = START_;
																(tempNode->v).push_back(yystack.l_mark[-1].Node);
																(tempNode->v).push_back(yystack.l_mark[0].Node);
																yyval.Node = tempNode;
															}
break;
case 4:
#line 86 "parse.y"
	{
																node* tempNode = new node;
																tempNode->code = EXTERN_DECL;
																(tempNode->v).push_back(yystack.l_mark[0].Node);
																yyval.Node = tempNode;
															}
break;
case 5:
#line 92 "parse.y"
	{
																node* tempNode = new node;
																tempNode->code = EXTERN_DECL;
																(tempNode->v).push_back(yystack.l_mark[0].Node);
																yyval.Node = tempNode;	
															}
break;
case 6:
#line 100 "parse.y"
	{
																node* tempNode = new node;
																tempNode->code = DECLARATION;
																(tempNode->v).push_back(yystack.l_mark[-2].Node);
																(tempNode->v).push_back(yystack.l_mark[-1].Node);
																yyval.Node = tempNode;	
															}
break;
case 7:
#line 109 "parse.y"
	{
																node* tempNode = new node;
																tempNode->code = DECL_LIST;
																(tempNode->v).push_back(yystack.l_mark[0].Node);
																yyval.Node = tempNode;
															}
break;
case 8:
#line 115 "parse.y"
	{
																node* tempNode = new node;
																tempNode->code = DECL_LIST;
																(tempNode->v).push_back(yystack.l_mark[-1].Node);
																(tempNode->v).push_back(yystack.l_mark[0].Node);
																yyval.Node = tempNode;
															}
break;
case 9:
#line 125 "parse.y"
	{
																node* tempNode = new node;
																tempNode->code = FUNC_DEF;
																(tempNode->v).push_back(yystack.l_mark[-4].Node);
																(tempNode->v).push_back(yystack.l_mark[-3].Node);
																(tempNode->v).push_back(yystack.l_mark[0].Node);
																yyval.Node = tempNode;
															}
break;
case 10:
#line 137 "parse.y"
	{
																node* tempNode = new node;
																tempNode->code = CMPD_STMT;
																yyval.Node = tempNode;
												}
break;
case 11:
#line 143 "parse.y"
	{
																node* tempNode = new node;
																tempNode->code = CMPD_STMT;
																(tempNode->v).push_back(yystack.l_mark[-1].Node);
																yyval.Node = tempNode;
												}
break;
case 12:
#line 151 "parse.y"
	{
													node* tempNode = new node;
													tempNode->code = STMT_LIST;
													yyval.Node = tempNode;	
												}
break;
case 13:
#line 156 "parse.y"
	{
													node* tempNode = new node;
													tempNode->code = STMT_LIST;
													(tempNode->v).push_back(yystack.l_mark[-1].Node);
													(tempNode->v).push_back(yystack.l_mark[0].Node);
													yyval.Node = tempNode;	
												}
break;
case 14:
#line 166 "parse.y"
	{
													node* tempNode = new node;
													tempNode->code = STMT;
													(tempNode->v).push_back(yystack.l_mark[0].Node);
													yyval.Node = tempNode;
												}
break;
case 15:
#line 173 "parse.y"
	{
													node* tempNode = new node;
													tempNode->code = STMT;
													(tempNode->v).push_back(yystack.l_mark[0].Node);
													yyval.Node = tempNode;
												}
break;
case 16:
#line 180 "parse.y"
	{
													node* tempNode = new node;
													tempNode->code = STMT;
													(tempNode->v).push_back(yystack.l_mark[0].Node);
													yyval.Node = tempNode;
												}
break;
case 17:
#line 187 "parse.y"
	{
													node* tempNode = new node;
													tempNode->code = STMT;
													(tempNode->v).push_back(yystack.l_mark[0].Node);
													yyval.Node = tempNode;
												}
break;
case 18:
#line 194 "parse.y"
	{
													node* tempNode = new node;
													tempNode->code = STMT;
													(tempNode->v).push_back(yystack.l_mark[-1].Node);
													yyval.Node = tempNode;
												}
break;
case 19:
#line 203 "parse.y"
	{
													node* tempNode = new node;
													tempNode->code = COND_STMT;
													(tempNode->v).push_back(yystack.l_mark[-2].Node);
													(tempNode->v).push_back(yystack.l_mark[0].Node);
													yyval.Node = tempNode;
												}
break;
case 20:
#line 213 "parse.y"
	{
													node* tempNode = new node;
													tempNode->code = NUMBER;
													yyval.Node = tempNode;
												}
break;
case 21:
#line 219 "parse.y"
	{
													node* tempNode = new node;
													tempNode->code = IDENTIFIER;
													yyval.Node = tempNode;
												}
break;
case 22:
#line 225 "parse.y"
	{
													node* tempNode = new node;
													tempNode->code = yystack.l_mark[-1].s;
													(tempNode->v).push_back(yystack.l_mark[-2].Node);
													(tempNode->v).push_back(yystack.l_mark[0].Node);
													yyval.Node = tempNode;
												}
break;
case 23:
#line 233 "parse.y"
	{
													node* tempNode = new node;
													tempNode->code = yystack.l_mark[-1].s;
													(tempNode->v).push_back(yystack.l_mark[-2].Node);
													(tempNode->v).push_back(yystack.l_mark[0].Node);
													yyval.Node = tempNode;
												}
break;
case 24:
#line 241 "parse.y"
	{
													node* tempNode = new node;
													tempNode->code = FUNC_CALL;
													yyval.Node = tempNode;
												}
break;
case 25:
#line 248 "parse.y"
	{yyval.s = yystack.l_mark[0].s;}
break;
case 26:
#line 249 "parse.y"
	{yyval.s = yystack.l_mark[0].s;}
break;
case 27:
#line 250 "parse.y"
	{yyval.s = yystack.l_mark[0].s;}
break;
case 28:
#line 251 "parse.y"
	{printf("Missing operator at line no. %d\n",lineNo);}
break;
case 29:
#line 253 "parse.y"
	{yyval.s = ASSIGN;}
break;
case 30:
#line 256 "parse.y"
	{yyval.s = LESS;}
break;
case 31:
#line 257 "parse.y"
	{yyval.s = GREATER;}
break;
case 32:
#line 260 "parse.y"
	{yyval.s = ADD;}
break;
case 33:
#line 261 "parse.y"
	{yyval.s = SUB;}
break;
case 34:
#line 262 "parse.y"
	{yyval.s = MUL;}
break;
case 35:
#line 263 "parse.y"
	{yyval.s = DIV;}
break;
case 36:
#line 264 "parse.y"
	{yyval.s = MOD;}
break;
case 38:
#line 268 "parse.y"
	{printf("Missing semicolon at line no. %d\n",lineNo);}
break;
case 39:
#line 271 "parse.y"
	{
										node* tempNode = new node;
										tempNode->code = D_TYPE;
										yyval.Node = tempNode;
									}
break;
case 40:
#line 276 "parse.y"
	{printf("Missing data type at line no. %d\n",lineNo);}
break;
case 41:
#line 279 "parse.y"
	{
										node* tempNode = new node;
										tempNode->code = IDENTIFIER;
										yyval.Node = tempNode;
									}
break;
case 42:
#line 284 "parse.y"
	{printf("Missing identifier at line no. %d\n",lineNo);}
break;
case 44:
#line 288 "parse.y"
	{printf("Missing integer at line no. %d\n",lineNo);}
break;
case 47:
#line 293 "parse.y"
	{printf("Missing number at line no. %d\n",lineNo);}
break;
case 49:
#line 297 "parse.y"
	{printf("Missing ( at line no. %d\n",lineNo);}
break;
case 51:
#line 301 "parse.y"
	{printf("Missing ) at line no. %d\n",lineNo);}
break;
case 53:
#line 305 "parse.y"
	{printf("Missing { at line no. %d\n",lineNo);}
break;
case 55:
#line 309 "parse.y"
	{printf("Missing } at line no. %d\n",lineNo);}
break;
case 57:
#line 313 "parse.y"
	{printf("Missing [ at line no. %d\n",lineNo);}
break;
case 59:
#line 317 "parse.y"
	{printf("Missing ] at line no. %d\n",lineNo);}
break;
case 61:
#line 321 "parse.y"
	{printf("Missing , at line no. %d\n",lineNo);}
break;
#line 955 "y.tab.c"
    }
    yystack.s_mark -= yym;
    yystate = *yystack.s_mark;
    yystack.l_mark -= yym;
    yym = yylhs[yyn];
    if (yystate == 0 && yym == 0)
    {
#if YYDEBUG
        if (yydebug)
            printf("%sdebug: after reduction, shifting from state 0 to\
 state %d\n", YYPREFIX, YYFINAL);
#endif
        yystate = YYFINAL;
        *++yystack.s_mark = YYFINAL;
        *++yystack.l_mark = yyval;
        if (yychar < 0)
        {
            if ((yychar = YYLEX) < 0) yychar = 0;
#if YYDEBUG
            if (yydebug)
            {
                yys = 0;
                if (yychar <= YYMAXTOKEN) yys = yyname[yychar];
                if (!yys) yys = "illegal-symbol";
                printf("%sdebug: state %d, reading %d (%s)\n",
                        YYPREFIX, YYFINAL, yychar, yys);
            }
#endif
        }
        if (yychar == 0) goto yyaccept;
        goto yyloop;
    }
    if ((yyn = yygindex[yym]) && (yyn += yystate) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yystate)
        yystate = yytable[yyn];
    else
        yystate = yydgoto[yym];
#if YYDEBUG
    if (yydebug)
        printf("%sdebug: after reduction, shifting from state %d \
to state %d\n", YYPREFIX, *yystack.s_mark, yystate);
#endif
    if (yystack.s_mark >= yystack.s_last && yygrowstack(&yystack))
    {
        goto yyoverflow;
    }
    *++yystack.s_mark = (short) yystate;
    *++yystack.l_mark = yyval;
    goto yyloop;

yyoverflow:
    yyerror("yacc stack overflow");

yyabort:
    yyfreestack(&yystack);
    return (1);

yyaccept:
    yyfreestack(&yystack);
    return (0);
}
