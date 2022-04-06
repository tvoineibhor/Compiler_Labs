%option header-file="src/util/lex.yy.h"
%option noyywrap

%{
    #include <stdio.h>
    #include "parser.tab.h"
    void print_token(char* class, char* lexeme);
    void yyerror(char* s);
%}

TRUE T
FALSE F
ID [a-zA-Z_]
IDNUM [a-zA-Z0-9_]
IDENTIFIER {ID}{IDNUM}*
LPARENT \(
RPARENT \)
COMMA \,
LOR \|\|
LAND &&
LNOT !
LXOR \^
ASSIGN =
ERROR [^TFa-zA-Z_\(\),\|&!\^=\t \r\n]+


%%

{TRUE}        return TRUE;   
{FALSE}       return FALSE; 
{IDENTIFIER}  return IDENTIFIER; 
{LPARENT}     return LPARENT; 
{RPARENT}     return RPARENT; 
{COMMA}       return COMMA; 
{LOR}         return LOR; 
{LAND}        return LAND; 
{LNOT}        return LNOT; 
{LXOR}        return LXOR; 
{ASSIGN}      return ASSIGN; 


[\r\t ] { }
[\n] { ++yylineno; return '\n'; }

{ERROR} { yyerror(yytext); }



%%
