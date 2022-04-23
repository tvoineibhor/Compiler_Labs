%{
#include "stdio.h"
#include <stdlib.h>
#include <string.h>
#include "../module.h"
#include "../tree.h"
void yyerror(char* s);
int yylex();

int yylineno;
%}

%code requires {
    
}

%union  {
    char* var;
    int num;
    struct node* node;
    struct Expression* expr;
    struct ExpressionList* lexpr;
}

%start s

%token <num> LOR <num> LAND TRUE FALSE LXOR LNOT ASSIGN COMMA LPARENT RPARENT
%token <var> IDENTIFIER

%type <expr> expression
%type <expr> boolean
%type <expr> id
%type <expr> func_call
%type <expr> call_param

%type <lexpr> line;
%type <lexpr> input;

%left LOR 
%left LAND
%left LXOR
%left LNOT
%right ASSIGN

%%

s: 
    input { module->root = $1; }

input: %empty { $$ = NULL; }
    | line '\n' input { yylineno++; $1->next = $3; $$ = $1; }
    ;

line: %empty { $$ = NULL; }
    | expression { $$ = addlst($1, _EXPRESSION); }
    ;

expression: expression LAND expression { $1->next = $3; $$ = add_node($1, _AND); }
    | expression LOR expression { $1->next = $3; $$ = add_node($1, _OR); }
    | expression LXOR expression { $1->next = $3; $$ = add_node($1, _XOR); }
    | id ASSIGN expression { $1->next = $3; $$ = add_node($1, _ASSIGN); }
    | LNOT expression { $$ = add_node($2, _NOT); }
    | LPARENT expression RPARENT { $$ = $2; }
    | boolean { $$ = $1; }
    | func_call { $$ = $1; }
    | id { $$ = $1; }
    ;

id: IDENTIFIER {$$ = create_node_str($1, _IDENTIFIER); } 

boolean: TRUE { $$ = create_node_num($1, _TRUE);  } | FALSE { $$ = create_node_num($1, _FALSE); };

func_call: id LPARENT call_param RPARENT {  $1->child = $3; $$ = add_node($1, _FUNC_CALL); } ;

call_param: %empty { $$ = NULL; }
    | expression COMMA call_param { $1->next = $3; $$ = $1; }
    | expression { $$ = $1; }
    ;

%%
