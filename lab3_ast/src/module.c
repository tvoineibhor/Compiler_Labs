#include <stdio.h>
#include "util/parser.tab.h"
#include "util/lex.yy.h"
#include "module.h"
#include "tree.h"

void print_module()
{
    if(module->type == _FILE)
        printf("|%s\n|\n", "MODULE START (FILE)");
    else
        printf("|%s\n|\n", "MODULE START (STDIN)");

    ExpressionList* f = module->root;
    while(f != NULL)
    {
        preorder_traversal(f->child, 0, 0);
        printf("|\n");
        f = f->next;
    }
    printf("|MODULE END\n");
}

int parse(ModuleType type)
{
    module = malloc(sizeof(Module));
    module->type = type;

    int result_code = yyparse();

    if(result_code == 0)
        print_module();
    
    return result_code;
}
