/* 1. Write the specification for a flex lexical analyzer for the MINI-L language. For this phase of the project, your lexical analyzer need only output the list of tokens identified from an inputted MINI-L program.
Example: write the flex specification in a file named mini_l.lex.
2. Run flex to generate the lexical analyzer for MINI-L using your specification.
Example: execute the command flex mini_l.lex. This will create a file called lex.yy.c in the current directory.
3. Compile your MINI-L lexical analyzer. This will require the -lfl flag for gcc.
Example: compile your lexical analyzer into the executable lexer with the following command: gcc -o lexer lex.yy.c -lfl. The program lexer should now be able to convert an inputted MINI-L program into the corresponding list of tokens.
*/


%{
   int currentLine = 1;
   int currentPosition = 1; 
%}

NUMBER         [0-9]
ALPHA          [A-Z|a-z]
ALPHANUMERIC   [a-z|A-Z|0-9]
VALID          {ALPHANUMERIC}|_

%%

"function"     { currentPosition += yyleng; return FUNCTION;         } 
"beginparams"  { currentPosition += yyleng; return BEGIN_PARAMS;     }
"endparams"    { currentPosition += yyleng; return END_PARAMS;       }
"beginlocals"  { currentPosition += yyleng; return BEGIN_LOCALS;     }
"endlocals"    { currentPosition += yyleng; return END_LOCALS;       }
"beginbody"    { currentPosition += yyleng; return BEGIN_BODY;       }
"endbody"      { currentPosition += yyleng; return END_BODY;         }
"integer"      { currentPosition += yyleng; return INTEGER;          }
"array"        { currentPosition += yyleng; return ARRAY;            }
"of"           { currentPosition += yyleng; return OF;               }
"if"           { currentPosition += yyleng; return IF;               }
"then"         { currentPosition += yyleng; return THEN;             }
"endif"        { currentPosition += yyleng; return ENDIF;            }
"else"         { currentPosition += yyleng; return ELSE;             }
"while"        { currentPosition += yyleng; return WHILE;            }
"do"           { currentPosition += yyleng; return DO;               }
"beginloop"    { currentPosition += yyleng; return BEGINLOOP;        }
"endloop"      { currentPosition += yyleng; return ENDLOOP;          }
"continue"     { currentPosition += yyleng; return CONTINUE;         }
"read"         { currentPosition += yyleng; return READ;             }
"write"        { currentPosition += yyleng; return WRITE;            }
"and"          { currentPosition += yyleng; return AND;              }
"or"           { currentPosition += yyleng; return OR;               }
"not"          { currentPosition += yyleng; return NOT;              }
"true"         { currentPosition += yyleng; return TRUE;             }
"false"        { currentPosition += yyleng; return FALSE;            }
"return"       { currentPosition += yyleng; return RETURN;           }

"-"            { currentPosition += yyleng; return SUB;              }
"+"            { currentPosition += yyleng; return ADD;              }
"*"            { currentPosition += yyleng; return MULT;             }
"/"            { currentPosition += yyleng; return DIV;              }
"%"            { currentPosition += yyleng; return MOD;              }

"=="           { currentPosition += yyleng; return EQ;               }
"<>"           { currentPosition += yyleng; return NEQ;              }
"<"            { currentPosition += yyleng; return LT;               }
">"            { currentPosition += yyleng; return GT;               }
"<="           { currentPosition += yyleng; return LTE;              }
">="           { currentPosition += yyleng; return GTE;              }

";"            { currentPosition += yyleng; return SEMICOLON;        }
":"            { currentPosition += yyleng; return COLON;            }
","            { currentPosition += yyleng; return COMMA;            }
"("            { currentPosition += yyleng; return L_PAREN;          }
")"            { currentPosition += yyleng; return R_PAREN;          }
"["            { currentPosition += yyleng; return L_SQUARE_BRACKET; }
"]"            { currentPosition += yyleng; return R_SQUARE_BRACKET; }
":="           { currentPosition += yyleng; return ASSIGN;           }
