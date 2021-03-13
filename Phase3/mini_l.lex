/*definitions/global variable declarations*/

%{
#include "y.tab.h"
#include <iostream>
#define YY_DECL yy::parser::symbol yylex()
static yy::location = FOO;
int currentLine = 1; 
int currentPosition = 1;
%}

/*rules for regex*/
LETTERS      	[a-zA-Z]
DIGITS       	[0-9]
IDENTIFIERS	({LETTERS}({LETTERS}|{DIGITS}|"_")*({LETTERS}|{DIGITS}))|{LETTERS}
BEGIN_ERROR	[0-9_]+{IDENTIFIERS}
END_ERROR	{IDENTIFIERS}[_]+	
COMMENTS	[#][#].*

%%

		/*reserved words*/
function	{ /*currentPosition += yyleng;*/return yy::parser::FUNCTION(FOO); }
beginparams	{ /*currentPosition += yyleng;*/return yy::parser::BEGINPARAMS(FOO); }
endparams	{ /*currentPosition += yyleng;*/return yy::parser::ENDPARAMS(FOO);}
beginlocals	{ /*currentPosition += yyleng;*/return yy::parser::BEGINLOCALS(FOO); }
endlocals	{ /*currentPosition += yyleng;*/return yy::parser::ENDLOCALS(FOO); }
beginbody	{ /*currentPosition += yyleng;*/return yy::parser::BEGINBODY(FOO);}
endbody		{ /*currentPosition += yyleng;*/return yy::parser::ENDBODY(FOO); }
integer		{ /*currentPosition += yyleng;*/return yy::parser::INTEGER(FOO); }
array		{ /*currentPosition += yyleng;*/return yy::parser::ARRAY(FOO); }
of		{ /*currentPosition += yyleng;*/return yy::parser::OF(FOO);}
if		{ /*currentPosition += yyleng;*/return yy::parser::IF(FOO); }
then		{ /*currentPosition += yyleng;*/return yy::parser::THEN(FOO); }
endif		{ /*currentPosition += yyleng;*/return yy::parser::ENDIF(FOO); }
else		{ /*currentPosition += yyleng;*/return yy::parser::ELSE(FOO); }
while		{ /*currentPosition += yyleng;*/return yy::parser::WHILE(FOO); }
do		{ /*currentPosition += yyleng;*/return yy::parser::DO(FOO); }
beginloop	{ /*currentPosition += yyleng;*/return yy::parser::BEGINLOOP(FOO); }
endloop		{ /*currentPosition += yyleng;*/return yy::parser::ENDLOOP(FOO); }
break		{ /*currentPosition += yyleng;*/return yy::parser::BREAK(FOO); }
read		{ /*currentPosition += yyleng;*/return yy::parser::READ(FOO); }
write		{ /*currentPosition += yyleng;*/return yy::parser::WRITE(FOO); }
and		{ /*currentPosition += yyleng;*/return yy::parser::AND(FOO); }
or		{ /*currentPosition += yyleng;*/return yy::parser::OR(FOO); }
not		{ /*currentPosition += yyleng;*/return yy::parser::NOT(FOO); }
true		{ /*currentPosition += yyleng;*/return yy::parser::TRUE(FOO); }
false		{ /*currentPosition += yyleng;*/return yy::parser::FALSE(FOO); }
return		{ /*currentPosition += yyleng;*/return yy::parser::RETURN(FOO); }

		/*arithmetic operators*/
"-"		{ /*currentPosition += yyleng;*/return yy::parser::SUB(FOO); }
"+"		{ /*currentPosition += yyleng;*/return yy::parser::ADD(FOO); }
"*"		{ /*currentPosition += yyleng;*/return yy::parser::MULT(FOO); }
"/"		{ /*currentPosition += yyleng;*/return yy::parser::DIV(FOO); }
"%"		{ /*currentPosition += yyleng;*/return yy::parser::MOD(FOO); }

		/*comparison operators*/
"=="		{ /*currentPosition += yyleng;*/return yy::parser::EQ(FOO); }
"<>"		{ /*currentPosition += yyleng;*/return yy::parser::NEQ(FOO); }
"<"		{ /*currentPosition += yyleng;*/return yy::parser::LT(FOO); }
">"		{ /*currentPosition += yyleng;*/return yy::parser::GT(FOO); }
"<="		{ /*currentPosition += yyleng;*/return yy::parser::LTE(FOO); }
">="		{ /*currentPosition += yyleng;*/return yy::parser::GTE(FOO); }

		/*other special symbols*/
";"		{ /*currentPosition += yyleng;*/return yy::parser::SEMICOLON(FOO); }
":"		{ /*currentPosition += yyleng;*/return yy::parser::COLON(FOO); }
","		{ /*currentPosition += yyleng;*/return yy::parser::COMMA(FOO); }
"("		{ /*currentPosition += yyleng;*/return yy::parser::L_PAREN(FOO); }
")"		{ /*currentPosition += yyleng;*/return yy::parser::R_PAREN(FOO); }
"["		{ /*currentPosition += yyleng;*/return yy::parser::L_SQUARE_BRACKET(FOO); }
"]"		{ /*currentPosition += yyleng;*/return yy::parser::R_SQUARE_BRACKET(FOO); }
":="		{ /*currentPosition += yyleng;*/return yy::parser::ASSIGN(FOO); }

			/*identifiers and numbers*/
{DIGITS}+		{/*currentPosition += yyleng;*/ return yy::parser::NUMBER(atoi(yytext), FOO);}

{IDENTIFIERS}		{/*currentPosition += yyleng;*/ return yy::parser::IDENT(strdup(yytext), FOO);}

{BEGIN_ERROR}      	{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n",currentLine,currentPosition,yytext);currentPosition += yyleng;/*exit(0);*/} 

{END_ERROR}              {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n",currentLine,currentPosition,yytext);currentPosition += yyleng;/*exit(0)*/} 

		/*for ignoring whitespaces*/
[ \t]		{currentPosition += yyleng;} 
		/*for ignoring newlines*/	
[\n]		{currentLine = currentLine + 1; currentPosition = 1;} 
		/*for ignoring comments*/	
{COMMENTS}	{currentPosition += yyleng;} 

		/*unrecognized symbols*/
.		{printf("Error at line %d, column %d :unrecognized symbol \"%s\"\n",currentLine,currentPosition,yytext);currentPosition += yyleng;/*exit(0);*/}

%%

/*main function calling yylex()
int main(int argc, char* argv[]){
    if(argc == 2){
	yyin = fopen(argv[1],"r");
    }
    else {
        yyin = stdin;
    }
    yylex();
} */

