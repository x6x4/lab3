rm -f parser.tab.c parser.tab.h lex.yy.cc

bison -d parser.y
flex scanner.l
g++ -o result lex.yy.cc parser.tab.h parser.tab.c parser.cc  
