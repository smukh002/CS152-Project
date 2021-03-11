/*definitions/global variable declarations*/
%{
#include "y.tab.h"
int currentLine = 1; int currentPosition = 1;
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
function	{ currentPosition += yyleng; return FUNCTION; }
beginparams	{ currentPosition += yyleng; return BEGINPARAMS; }
endparams	{ currentPosition += yyleng; return ENDPARAMS; }
beginlocals	{ currentPosition += yyleng; return BEGINLOCALS; }
endlocals	{ currentPosition += yyleng; return ENDLOCALS; }
beginbody	{ currentPosition += yyleng; return BEGINBODY; }
endbody		{ currentPosition += yyleng; return ENDBODY; }
integer		{ currentPosition += yyleng; return INTEGER; }
array		{ currentPosition += yyleng; return ARRAY; }
of		{ currentPosition += yyleng; return OF; }
if		{ currentPosition += yyleng; return IF; }
then		{ currentPosition += yyleng; return THEN; }
endif		{ currentPosition += yyleng; return ENDIF; }
else		{ currentPosition += yyleng; return ELSE; }
while		{ currentPosition += yyleng; return WHILE; }
do		{ currentPosition += yyleng; return DO; }
beginloop	{ currentPosition += yyleng; return BEGINLOOP; }
endloop		{ currentPosition += yyleng; return ENDLOOP; }
break		{ currentPosition += yyleng; return BREAK; }
read		{ currentPosition += yyleng; return READ; }
write		{ currentPosition += yyleng; return WRITE; }
and		{ currentPosition += yyleng; return AND; }
or		{ currentPosition += yyleng; return OR; }
not		{ currentPosition += yyleng; return NOT; }
true		{ currentPosition += yyleng; return TRUE; }
false		{ currentPosition += yyleng; return FALSE; }
return		{ currentPosition += yyleng; return RETURN; }

		/*arithmetic operators*/
"-"		{ currentPosition += yyleng; return SUB; }
"+"		{ currentPosition += yyleng; return ADD; }
"*"		{ currentPosition += yyleng; return MULT; }
"/"		{ currentPosition += yyleng; return DIV; }
"%"		{ currentPosition += yyleng; return MOD; }

		/*comparison operators*/
"=="		{ currentPosition += yyleng; return EQ; }
"<>"		{ currentPosition += yyleng; return NEQ; }
"<"		{ currentPosition += yyleng; return LT; }
">"		{ currentPosition += yyleng; return GT; }
"<="		{ currentPosition += yyleng; return LTE; }
">="		{ currentPosition += yyleng; return GTE; }

		/*other special symbols*/
";"		{ currentPosition += yyleng; return SEMICOLON; }
":"		{ currentPosition += yyleng; return COLON; }
","		{ currentPosition += yyleng; return COMMA; }
"("		{ currentPosition += yyleng; return L_PAREN; }
")"		{ currentPosition += yyleng; return R_PAREN; }
"["		{ currentPosition += yyleng; return L_SQUARE_BRACKET; }
"]"		{ currentPosition += yyleng; return R_SQUARE_BRACKET; }
":="		{ currentPosition += yyleng; return ASSIGN; }

			/*identifiers and numbers*/
{DIGITS}+		{currentPosition += yyleng; yylval.ival = atoi(yytext); return NUMBER;}

{IDENTIFIERS}		{currentPosition += yyleng; yylval.idval = strdup(yytext); return IDENT;}

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


