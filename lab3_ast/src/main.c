#include <stdio.h>
#include "util/parser.tab.h"
#include "util/lex.yy.h"
#include "module.h"

int yyparse();

void yyerror(char* s)
{
    printf("In line %d: syntax error\n", yylineno);
    
    exit(1);
}

int main(int argc, char* argv[])
{
    int result_code;

    if(argc > 2)
    {
        printf("Enter one filename as an argument\n");
        exit(1);
    }

    if(argc == 2)
    {
        yyin = fopen(argv[1], "r");

        if(!yyin)
        {
            printf("File doesn't exist\n");
            exit(1);
        }

        result_code = parse(_FILE);
    }
    else
    {
        yyin = stdin;
        result_code = parse(_STDIN);
    }
    
    fclose(yyin);

    return result_code;
}
