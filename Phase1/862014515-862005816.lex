/* 
1. Write the specification for a flex lexical analyzer for the MINI-L language. For this phase of the project, your lexical analyzer need only output the list of tokens identified from an inputted MINI-L program.
Example: write the flex specification in a file named mini_l.lex.
2. Run flex to generate the lexical analyzer for MINI-L using your specification.
Example: execute the command flex mini_l.lex. This will create a file called lex.yy.c in the current directory.
3. Compile your MINI-L lexical analyzer. This will require the -lfl flag for gcc.
Example: compile your lexical analyzer into the executable lexer with the following command: gcc -o lexer lex.yy.c -lfl. The program lexer should now be able to convert an inputted MINI-L program into the corresponding list of tokens.

Format of.lex file:
    definitions
    %%
    rules
    %%
    user code
*/


/*definitions/global variable declarations*/
%{
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
function	{printf("FUNCTION\n");currentPosition += yyleng;}
beginparams	{printf("BEGIN_PARAMS\n");currentPosition += yyleng;}
endparams	{printf("END_PARAMS\n");currentPosition += yyleng;}
beginlocals	{printf("BEGIN_LOCALS\n");currentPosition += yyleng;}
endlocals	{printf("END_LOCALS\n");currentPosition += yyleng;}
beginbody	{printf("BEGIN_BODY\n");currentPosition += yyleng;}
endbody		{printf("END_BODY\n");currentPosition += yyleng;}
integer		{printf("INTEGER\n");currentPosition += yyleng;}
array		{printf("ARRAY\n");currentPosition += yyleng;}
of		{printf("OF\n");currentPosition += yyleng;}
if		{printf("IF\n");currentPosition += yyleng;}
then		{printf("THEN\n");currentPosition += yyleng;}
endif		{printf("ENDIF\n");currentPosition += yyleng;}
else		{printf("ELSE\n");currentPosition += yyleng;}
while		{printf("WHILE\n");currentPosition += yyleng;}
do		{printf("DO\n");currentPosition += yyleng;}
beginloop	{printf("BEGINLOOP\n");currentPosition += yyleng;}
endloop		{printf("ENDLOOP\n");currentPosition += yyleng;}
continue	{printf("CONTINUE\n");currentPosition += yyleng;}
read		{printf("READ\n");currentPosition += yyleng;}
write		{printf("WRITE\n");currentPosition += yyleng;}
and		{printf("AND\n");currentPosition += yyleng;}
or		{printf("OR\n");currentPosition += yyleng;}
not		{printf("NOT\n");currentPosition += yyleng;}
true		{printf("TRUE\n");currentPosition += yyleng;}
false		{printf("FALSE\n");currentPosition += yyleng;}
return		{printf("RETURN\n"); currentPosition += yyleng;}
		/*arithmetic operators*/
"-"		{printf("SUB\n"); currentPosition += yyleng;}
"+"		{printf("ADD\n"); currentPosition += yyleng;}
"*"		{printf("MULT\n"); currentPosition += yyleng;}
"/"		{printf("DIV\n"); currentPosition += yyleng;}
"%"		{printf("MOD\n"); currentPosition += yyleng;}
		/*comparison operators*/
"=="		{printf("EQ\n"); currentPosition += yyleng;}
"<>"		{printf("NEQ\n"); currentPosition += yyleng;}
"<"		{printf("LT\n"); currentPosition += yyleng;}
">"		{printf("GT\n"); currentPosition += yyleng;}
"<="		{printf("LTE\n"); currentPosition += yyleng;}
">="		{printf("GTE\n"); currentPosition += yyleng;}
		/*other special symbols*/
";"		{printf("SEMICOLON\n"); currentPosition += yyleng;}
":"		{printf("COLON\n"); currentPosition += yyleng;}
","		{printf("COMMA\n"); currentPosition += yyleng;}
"("		{printf("L_PAREN\n"); currentPosition += yyleng;}
")"		{printf("R_PAREN\n"); currentPosition += yyleng;}
"["		{printf("L_SQUARE_BRACKET\n"); currentPosition += yyleng;}
"]"		{printf("R_SQUARE_BRACKET\n"); currentPosition += yyleng;}
":="		{printf("ASSIGN\n"); currentPosition += yyleng;}  

			/*identifiers and numbers*/
{DIGITS}+		{printf("NUMBER %s\n",yytext);currentPosition += yyleng;}

{IDENTIFIERS}		{printf("IDENT %s\n", yytext); currentPosition += yyleng;}

{BEGIN_ERROR}      	{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n",currentLine,currentPosition,yytext);currentPosition += yyleng;exit(0);} 

{END_ERROR}              {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n",currentLine,currentPosition,yytext);currentPosition += yyleng;exit(0);} 

		/*for ignoring whitespaces*/
[ \t]		{currentPosition += yyleng;} 
		/*for ignoring newlines*/	
[\n]		{currentLine = currentLine + 1; currentPosition = 1;} 
		/*for ignoring comments*/	
{COMMENTS}	{currentPosition += yyleng;} 

		/*unrecognized symbols*/
.		{printf("Error at line %d, column %d :unrecognized symbol \"%s\"\n",currentLine,currentPosition,yytext);exit(0);}
%%


/*main function calling yylex()*/
int main(int argc, char* argv[]){
    if(argc == 2){
	yyin = fopen(argv[1],"r");
    }
    else {
        yyin = stdin;
    }
    yylex();
}
