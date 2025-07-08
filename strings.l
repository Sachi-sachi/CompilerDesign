All strings of lowercase letters that contain the five vowels in
order.

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}
%%
.*aeiou.* {
printf("%s\n", yytext);
}
.|\n { /* Ignore other characters */ }
%%
// Define the yywrap function
int yywrap() {
return 1; // Return 1 to indicate no more input
}
int main(int argc, char **argv) {
if (argc != 2) {
fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
return 1;
}
FILE *input_file = fopen(argv[1], "r");
if (!input_file) {
perror("Error opening file");
return 1;
}
yyin = input_file; // Set the input file for Flex
yylex(); // Start lexical analysis
fclose(input_file); // Close the input file
return 0;
}

All strings of a's and b's with an even number of a's and an odd
number of b's.

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void print_matched_string(const char *str);
%}
%%
[a-b]* {
int count_a = 0;
int count_b = 0;
// Count occurrences of 'a' and 'b'
for (char *p = yytext; *p; p++) {
if (*p == 'a') count_a++;
else if (*p == 'b') count_b++;
}
// Check conditions: even number of 'a's and odd number of 'b's
if (count_a % 2 == 0 && count_b % 2 == 1) {
print_matched_string(yytext);
}
}
.|\n { /* Ignore other characters */ }
%%
// Function to print the matched string
void print_matched_string(const char *str) {
printf("%s\n", str);
}
// Define the yywrap function
int yywrap() {
return 1; // Return 1 to indicate no more input
}
int main(int argc, char **argv) {
if (argc != 2) {
fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
return 1;
}
FILE *input_file = fopen(argv[1], "r");
if (!input_file) {
perror("Error opening file");
return 1;
}
yyin = input_file; // Set the input file for Flex
yylex(); // Start lexical analysis
fclose(input_file); // Close the input file
return 0;
}
