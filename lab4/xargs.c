#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char* argv[]) {
    char* command = (char*)malloc(1024*sizeof(char));
    char* arguments = (char*)malloc(1024* sizeof(char));

    if (argc > 1) {
        for (int i = 1; i < argc; i++) {
            strcat(command, argv[i]);
            strcat(command, " ");
        }
    }

    if (argc == 1) {
        strcat(command, "echo ");
    }

    while (scanf("%s", arguments) != EOF) {
        char* resultCommand = (char*)malloc(1024* sizeof(char));
        strcpy(resultCommand, command);
        strcat(resultCommand, " ");
        strcat(resultCommand, arguments);
        system(resultCommand);
    }


    return 0;
}