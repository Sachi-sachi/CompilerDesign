%{
#include <stdio.h>
#include <ctype.h>
void swap_case(char *str) {
while (*str) {
if (islower(*str)) {
*str = toupper(*str);
} else if (isupper(*str)) {
*str = tolower(*str);
}
str++;
}
}
int yywrap(void) {
return 1; // Indicate end of file
}
%}
%%
"//".* { printf("%s", yytext); } // Preserve single-line comments
"/*"([^*]|\*+[^/*])*"*/" { printf("%s", yytext); } // Preserve multi-line
comments
[A-Za-z]+ { char buffer[256]; snprintf(buffer, sizeof(buffer), "%s",
yytext); swap_case(buffer); printf("%s", buffer); }
\n { printf("\n"); }
%%
int main(int argc, char **argv) {
if (argc != 2) {
fprintf(stderr, "Usage: %s input_file\n", argv[0]);
return 1;
}
FILE *file = fopen(argv[1], "r");
if (!file) {
perror("fopen");
return 1;
}
yyin = file;
yylex();
fclose(file);
return 0;
}
