#pragma once

typedef enum Type { _AND = 1, _TRUE, _FALSE, _OR, _XOR, _NOT, _BOOL, _IDENTIFIER, _ASSIGN, _FUNC_CALL, _EXPRESSION, _MODULE } Type;

typedef struct Expression
{
    Type type;

    union {
        int item;
        char* str;
    } data;

    struct Expression* next;
    struct Expression* child;
} Expression;

typedef struct ExpressionList {
    struct Expression* child;
    struct ExpressionList* next;
} ExpressionList;

Expression* add_node(Expression* arg1, Type type);
ExpressionList* addlst(Expression* arg1, Type type);

Expression* create_node_num(int value, Type type);
Expression* create_node_str(char* value, Type type);
Expression* create_node__(void* value, Type type);

void preorder_traversal(Expression* root, int width, int arg);
