%{
#include "parser.tab.hh"
#include <sstream>
using namespace std;
%}

%option noyywrap c++


%%

<<EOF>>         {   yyterminate();  }

[\n]+           {  return NEWLINES; }

[ \t]+          { }  

"function main ()" {   return FN_MAIN; }

"done"          {   return DONE;  }     

"do"            {   return DO;  }

"+"             {  
                    yylval.c_type = yytext[0];
                    return PLUS;  
                }

"-"             {   
                    yylval.c_type = yytext[0];
                    return MINUS;  
                }
                  
":="             {   
                    yylval.c_type = yytext[0];
                    return EQUALS;  
                }
                  
[1-9]*[0-9]+    {  
                    std::istringstream(yytext) 
                        >> yylval.i_type;
                    return NUMBER;  
                }  

[a-zA-Z]+       {
                    std::istringstream(yytext) 
                        >> yylval.s_type;
                    return VARIABLE;
                }

.               {  return UNKNOWN;  }

%%