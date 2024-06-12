%define parse.assert

%code{
#include <iostream>
#include <fstream>
#include <FlexLexer.h>
yyFlexLexer lexer;
int yylex(void)  {  return lexer.yylex();  }

extern "C" int yyerror(const char *s) { 
    std::cout << s << std::endl;
    return 0;
};
}

%union {
    int i_type;
    char c_type;
} 

%token <c_type> PLUS MINUS EQUALS
%token <i_type> NUMBER
%token UNKNOWN

%type <i_type> number subexpression addexpression
%type <i_type> expression calculation 

%start calculation

%%

calculation
: expression EQUALS { $$ = $1; std::cout << $1;}
;

expression
: addexpression { $$ = $1;}
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

%%
