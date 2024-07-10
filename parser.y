%define parse.assert
%define api.value.type variant
%language "c++"

%code{
#include <iostream>
#include <fstream>
#include <FlexLexer.h>
#include "liba.h"


yyFlexLexer lexer;

struct YYSTYPE;
struct YYLTYPE;

int yylex (YYSTYPE*, YYLTYPE*);

extern "C" int yyerror(const char *s) { 
    std::cout << s << std::endl;
    return 0;
};

Symbol_table symtab;
}


%token <char> PLUS MINUS EQUALS
%token <int> NUMBER 
%token <std::string> VARIABLE
%token FN_MAIN DO DONE NEWLINES UNKNOWN

%type <int> number subexpression addexpression
%type <int> expression assignment

%start fn_main

%%

fn_main 
: FN_MAIN fn_body { }

fn_body
: DO NEWLINES statements DONE

statements
: statement NEWLINES
| statement NEWLINES statements ;

statement
: assignment 
| var_declaration

assignment
: VARIABLE EQUALS expression { 
    symtab.fill_entry($1, $3);
}
;

var_declaration: 
VARIABLE { symtab.add_entry($1); }

expression
: addexpression { $$ = $1; std::cout << $1 << std::endl;}
;

addexpression
: subexpression { $$ = $1; }
| addexpression PLUS subexpression  { $$ = $1 + $3; }
;

subexpression
: number    { $$ = $1; }
| subexpression MINUS number    { $$ = $1 - $3; }
;

number
: NUMBER    { $$ = $1; }
;

error_nt 
: UNKNOWN    { throw std::runtime_error("compilation error"); }
;

%%
