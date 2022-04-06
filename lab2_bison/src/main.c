#include <stdio.h>
#include "util/lex.yy.h"

int yyparse();

void yyerror(char* s)
{
    printf("In line %d: syntax error\n", yylineno);
    
    exit(1);
}


int main(int argc, char* argv[])
{

    if(argc > 2)
    {
        printf("Enter one filename as an argument\n");
        exit(1);
    }

    if(argc == 2)
        yyin = fopen(argv[1], "r");    
    else
        yyin = stdin;
    
    if(!yyin)
    {
        printf("File doesn't exist\n");
        exit(1);
    }

    int result_code = yyparse();
    fclose(yyin);

    return 0;
}
