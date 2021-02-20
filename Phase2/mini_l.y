//Create the bison parser specification file using the MINI-L grammar. Ensure that you specify helpful syntax error messages to be outputted by the parser in the event of any syntax errors.
//Example: write the bison specification in a file named mini_l.y.

%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *msg);
extern int currentLine;
extern int currentPosition;
FILE *yyin;
%}

%union{
double dval;
int ival;
char* idval; 
}

%error-verbose
%start program

%token FUNCTION
%token BEGINPARAMS
%token ENDPARAMS
%token BEGINLOCALS
%token ENDLOCALS
%token BEGINBODY
%token ENDBODY
%token INTEGER 
%token ARRAY
%token OF
%token IF
%token THEN
%token ENDIF
%token ELSE
%token WHILE
%token DO
%token BEGINLOOP
%token ENDLOOP
%token BREAK
%token READ
%token WRITE
%token AND
%token OR
%token NOT
%token TRUE
%token FALSE
%token RETURN
%token SUB
%token ADD
%token MULT
%token DIV
%token MOD
%token EQ
%token NEQ
%token LT
%token GT
%token LTE
%token GTE
%token SEMICOLON
%token COLON
%token COMMA
%token L_PAREN
%token R_PAREN
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%token ASSIGN
%token <idval> IDENT
%token <ival> NUMBER



%%

program: {printf("program -> epsilon\n");}
|function {printf("program -> function\n");}
|function function_loop {printf("program -> function function_loop\n");} 
;

function_loop: function {printf("function_loop -> function\n");} 
|function_loop function {printf("function_loop -> function_loop function\n");}
;


function: FUNCTION IDENT SEMICOLON BEGINPARAMS dec_loop ENDPARAMS BEGINLOCALS dec_loop ENDLOCALS BEGINBODY stmt_loop ENDBODY
{printf("function -> FUNCTION IDENT SEMICOLON BEGINPARAMS dec_loop ENDPARAMS BEGINLOCALS dec_loop ENDLOCALS BEGINBODY stmt_loop ENDBODY\n");}
;

dec_loop: {printf("dec_loop -> epsilon\n");} |dec_loop declaration SEMICOLON {printf("dec_loop -> dec_loop declaration SEMICOLON\n");}
;

stmt_loop: statement SEMICOLON {printf("stmt_loop -> statement SEMICOLON\n");} | stmt_loop statement SEMICOLON {printf("stmt_loop -> stmt_loop statement SEMICOLON\n");}
;

declaration: ident_loop COLON INTEGER {printf("declaration ->  ident_loop COLON INTEGER\n");} 
|ident_loop COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {printf("declaration -> ident_loop COLON ARRAY L_SQUARE_BRACKET NUMBER %d  R_SQUARE_BRACKET OF INTEGER\n");}
;

ident_loop: IDENT {printf("ident_loop -> IDENT\n");} | ident_loop COMMA IDENT {printf("ident_loop -> ident_loop COMMA IDENT\n");}
;

statement: var ASSIGN expression {printf("statement -> var ASSIGN expression\n");}
|IF bool_expr THEN stmt_loop ENDIF{printf("statement -> IF bool_expr THEN stmt_loop ENDIF\n");}
|IF bool_expr THEN stmt_loop ELSE stmt_loop ENDIF {printf("statement -> IF bool_expr THEN stmt_loop ELSE stmt_loop ENDIF\n");}
|WHILE bool_expr BEGINLOOP stmt_loop ENDLOOP {printf("statement -> WHILE bool_expr BEGINLOOP stmt_loop ENDLOOP\n");}
|DO BEGINLOOP stmt_loop ENDLOOP WHILE bool_expr {printf("statement -> DO BEGINLOOP stmt_loop ENDLOOP WHILE bool_expr\n");}
|READ var_loop {printf("statement -> READ var_loop\n");}
|WRITE var_loop {printf("statement -> WRITE var_loop\n");}
|BREAK {printf("statement -> BREAK\n");}
|RETURN expression {printf("statement -> RETURN expression\n");}
;

var_loop: var {printf("var_loop -> var\n");} | var_loop COMMA var {printf("var_loop -> var_loop COMMA var\n");}
;

bool_expr: relation_and_expr {printf("bool_expr -> relation_and_expr\n");} | relation_and_expr OR relation_and_expr {printf("bool_expr -> relation_and_expr OR relation_and_expr\n");}
;

relation_and_expr: relation_expr {printf("relation_and_expr -> relation_expr\n");} | relation_expr AND relation_expr {printf("relation_and_expr -> relation_expr AND relation_expr\n");}
;

relation_expr: expression comp expression {printf("relation_expr -> expression comp expression\n");} | NOT expression comp expression {printf("relation_expr -> NOT expression comp expression\n");}
|TRUE {printf("relation_expr -> TRUE\n");} | NOT TRUE {printf("relation_expr -> NOT TRUE\n");}
|FALSE {printf("relation_expr -> FALSE\n");} | NOT FALSE {printf("relation_expr -> NOT FALSE\n");}
|L_PAREN bool_expr R_PAREN {printf("relation_expr -> L_PAREN bool_expr R_PAREN\n");} |NOT  L_PAREN bool_expr R_PAREN {printf("relation_expr -> NOT L_PAREN bool_expr R_PAREN\n");}
;

comp: EQ {printf("comp -> EQ\n");}|NEQ {printf("comp ->NEQ\n");}|LT {printf("comp -> LT\n");}|GT {printf("comp -> GT\n");}|LTE {printf("comp -> LTE\n");}|GTE {printf("comp -> GTE\n");}
;

expression: multiplicative_expr {printf("expression -> multiplicative_expr\n");} | multiplicative_expr ADD multiplicative_expr {printf("expression -> multiplicative_expr ADD multiplicative_expr\n");} |  multiplicative_expr SUB multiplicative_expr {printf("expression -> multiplicative_expr SUB multiplicative_expr\n");}
;

multiplicative_expr: term {printf("multiplicative_expr -> term\n");} | term MULT term {printf("multiplicative_expr -> term MULT term\n");} |  term DIV term {printf("multiplicative_expr -> term DIV term\n");} |  term MOD term {printf("multiplicative_expr -> term MOD term\n");}
;

term: var {printf("term -> var\n");} | SUB var {printf("term -> SUB var\n");} | NUMBER {printf("term -> NUMBER\n");} |SUB NUMBER {printf("term -> SUB NUMBER\n");} | L_PAREN expression R_PAREN {printf("term -> L_PAREN expression R_PAREN\n");}
|SUB L_PAREN expression R_PAREN {printf("term -> SUB L_PAREN expression R_PAREN\n");}|IDENT L_PAREN expr_loop R_PAREN {printf("term-> IDENT L_PAREN expr_loop R_PAREN\n");} | IDENT L_PAREN R_PAREN {printf("term ->  IDENT L_PAREN R_PAREN\n");}
;

expr_loop: expr_loop expression COMMA {printf("expr_loop -> expr_loop expression COMMA\n");} | expression {printf("expr_loop -> expression\n");}
;

var: IDENT {printf("var -> IDENT\n");} | IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET {printf("var -> IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");}
;

%%

int main(int argc, char **argv) {
   if (argc > 1) {
      yyin = fopen(argv[1], "r");
      if (yyin == NULL){
         printf("syntax: %s filename\n", argv[0]);
      }//end if
   }//end if
   yyparse(); // Calls yylex() for tokens.
   return 0;
}

void yyerror(const char *msg) {
   printf("** Line %d, position %d: %s\n", currentLine, currentPosition, msg);
}

