%{
#include "parser.tab.h"
#include <sstream>
using namespace std;
%}

%option noyywrap c++


%%

<<EOF>>         {  yyterminate();  }

"+"             {  
                    yylval.c_type = yytext[0];
                    return PLUS;  
                }

"-"             {   
                    yylval.c_type = yytext[0];
                    return MINUS;  
                }
                  
"="             {   
                    yylval.c_type = yytext[0];
                    return EQUALS;  
                }
                  
[1-9]*[0-9]+    {  
                    std::istringstream(yytext) >> yylval.i_type;
                    return NUMBER;  
                }

.               {  return UNKNOWN;  }

%%