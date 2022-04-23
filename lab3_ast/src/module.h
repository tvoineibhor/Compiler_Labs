#pragma once

typedef enum ModuleType { _STDIN, _FILE } ModuleType;

typedef struct Module {
    ModuleType type;
    struct ExpressionList* root;
} Module;

Module* module;

void print_module();
int parse(ModuleType type);
