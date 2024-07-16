%{
#include "scanner.hh"
#include <sstream>
using namespace std;
%}

%option noyywrap c++
%option yyclass="Scanner"

%%

<<EOF>>         {   yyterminate();  }

[\n]+           {  return yy::parser::make_NEWLINES(); }

[ \t]+          { }  

"function main ()" {  return yy::parser::make_FN_MAIN(); }

"done"          {   return yy::parser::make_DONE();  }     

"do"            {   return yy::parser::make_DO();  }

t[rue]          {   return yy::parser::make_TRUE(Boolean(BoolVal::TRUE)); }
f[alse]         {   return yy::parser::make_FALSE(Boolean(BoolVal::FALSE)); }
u[ndef]         {   return yy::parser::make_UNDEF(Boolean(BoolVal::UNDEF)); }

empty           { return yy::parser::make_EMPTY(Cell(CellVal::EMPTY)); }
wall            { return yy::parser::make_WALL(Cell(CellVal::WALL)); }
box             { return yy::parser::make_BOX(Cell(CellVal::BOX)); }
exit            { return yy::parser::make_EXIT(Cell(CellVal::EXIT)); }
undef           { return yy::parser::make_UNDEF_CELL(Cell(CellVal::UNDEF)); } 

"^"             {  
                    return yy::parser::make_XOR(yytext[0]);  
                }

">"             {  
                    return yy::parser::make_GT(yytext[0]);  
                }

"<"             {  
                    return yy::parser::make_LT(yytext[0]);  
                }

"+"             {  
                    return yy::parser::make_PLUS(yytext[0]);  
                }

"-"             {   
                    return yy::parser::make_MINUS(*yytext);  
                }
                  
":="            {   
                    
                    return yy::parser::make_ASSIGN(yytext);  
                }

"="             {  
                    return yy::parser::make_EQ(yytext[0]);  
                }
                  
[1-9]*[0-9]+    {  
                    return yy::parser::make_NUMBER(Integer(atoi(yytext)));  
                }  

[a-zA-Z]+       { 
                    return yy::parser::make_VARIABLE(yytext);
                }

.               {  return yy::parser::make_UNKNOWN();  }

%%