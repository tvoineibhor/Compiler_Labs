%{
#include "stdio.h"
void yyerror(char* s);
int yylex();
%}

%start input

%token LOR LAND TRUE FALSE LXOR LNOT ASSIGN IDENTIFIER COMMA LPARENT RPARENT

%left LOR LAND LXOR LNOT
%right ASSIGN

%%

input: %empty
    | input line '\n'
    ;

line: %empty
    | expression
    ;

expression: expression LAND expression
    | expression LOR expression
    | expression LXOR expression
    | LNOT expression
    | LPARENT expression RPARENT
    | boolean
    | func_call
    | IDENTIFIER
    | IDENTIFIER ASSIGN expression
    ;

boolean: TRUE | FALSE;

func_call: IDENTIFIER LPARENT call_param RPARENT;

call_param: %empty | call_param COMMA expression | expression;

%%
