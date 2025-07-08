%{
#include <stdio.h>
%}
%%
.|\n { printf("Hello World\n"); }
%%
int yywrap() {
return 1; // Return 1 to indicate end of input
}
int main(int argc, char **argv) {
yylex();
return 0;
}
