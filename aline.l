%{
#include <stdio.h>
#include <string.h>
FILE *outputFile;
%}
%%
^a.* { fprintf(outputFile, "%s", yytext); } // Lines starting with 'a'
.*a$ { fprintf(outputFile, "%s", yytext); } // Lines ending with 'a'
\n { /* Ignore line breaks */ }
. { /* Ignore other lines */ }
%%
int yywrap() {
return 1; // Indicate that there are no more files to process
}
int main(int argc, char **argv) {
if (argc != 3) {
fprintf(stderr, "Usage: %s <input_file> <output_file>\n", argv[0]);
return 1;
}
FILE *inputFile = fopen(argv[1], "r");
if (!inputFile) {
perror("Could not open input file");
return 1;
}
outputFile = fopen(argv[2], "w");
if (!outputFile) {
perror("Could not open output file");
fclose(inputFile);
return 1;
}
yyin = inputFile; // Set the input file for Flex
yylex(); // Start scanning
fclose(inputFile);
fclose(outputFile);
return 0;
}
