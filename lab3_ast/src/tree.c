#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tree.h"


ExpressionList* addlst(Expression* arg1, Type type)
{
    ExpressionList* lnode = malloc(sizeof(ExpressionList));
    lnode->child = arg1;

    return lnode;
}

Expression* add(Expression* arg1, Expression* arg2, Type type)
{
    Expression* nnode = malloc(sizeof(Expression));

    nnode->type = type;

    return nnode;
}

Expression* add_node(Expression* arg1, Type type)
{
    Expression* nnode = malloc(sizeof(Expression));

    nnode->type = type;
    nnode->child = arg1;

    return nnode;
}

Expression* create_node_num(int value, Type type) 
{
    Expression* nnode;
    
    nnode = malloc(sizeof(Expression));
    nnode->data.item = value;
    nnode->type = type;

    return nnode;
}

Expression* create_node_str(char* value, Type type) {

    Expression* nnode;
    
    nnode = malloc(sizeof(Expression));
    nnode->data.str = malloc(sizeof(value));
    memcpy(nnode->data.str, value, sizeof(value));
    nnode->type = type;

    return nnode;
}

void preorder_traversal(Expression* root, int width, int arg) {
    if (root == NULL) return;
    
    switch (root->type)
    {
        case _FUNC_CALL:
            printf("|%*s%d> %s \n", width, "", arg, "FUNC_CALL");
            break;
        case _TRUE:
            printf("|%*s%d> %s \n", width, "", arg, "TRUE");
            break;
        case _FALSE:
            printf("|%*s%d> %s \n", width, "", arg, "FALSE");
            break;
        case _AND:
            printf("|%*s%d> %s \n", width, "", arg, "AND");
            break;
        case _OR:
            printf("|%*s%d> %s \n", width, "", arg, "OR");
            break;
        case _IDENTIFIER:
            printf("|%*s%d> %s \n", width, "", arg, root->data.str);
            break;
        case _NOT:
            printf("|%*s%d> %s \n", width, "", arg, "NOT");
            break;
        case _ASSIGN:
            printf("|%*s%d> %s \n", width, "", arg, "ASSIGN");
            break;
        default:
            break;
    }

    preorder_traversal(root->child, width + 5, 0);
    preorder_traversal(root->next, width, arg + 1);
}
