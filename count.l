%{
#include <stdio.h>
#include <stdlib.h>
int char_count = 0;
int word_count = 0;
int line_count = 0;
FILE *output_file;
void write_output() {
fprintf(output_file, "Lines: %d\n", line_count+1);
fprintf(output_file, "Words: %d\n", word_count);
fprintf(output_file, "Characters: %d\n", char_count);
}
%}
%%
\n { line_count++; }
[ \t]+ { /* Ignore whitespace */ }
[a-zA-Z0-9]+ { word_count++; char_count += yyleng; }
. { char_count++; }
%%
int yywrap() {
return 1; // Return 1 to indicate end of input
}
int main(int argc, char **argv) {
// Check if an output file is provided as an argument
if (argc < 2) {
fprintf(stderr, "Usage: %s <output_file>\n", argv[0]);
return 1;
}
// Open the output file for writing
output_file = fopen(argv[1], "w");
if (output_file == NULL) {
perror("Error opening output file");
return 1;
}
yylex(); // Start processing the input
write_output(); // Write the output to the file
fclose(output_file); // Close the output file
return 0;
}
