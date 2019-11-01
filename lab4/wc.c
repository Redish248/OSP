#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>

bool wantBytes = true;
bool wantLines = true;
bool wantWords = true;
bool hasFlags = false;

int fileCounter = 0;
int totalLines = 0;
int totalWords = 0;
int totalBytes = 0;

void wc(char* filename) {
    errno = 0;
    int fd = open(filename, O_RDONLY);
    if (fd == -1) {
        fprintf(stderr, "File %s doesn't exist!\n", filename);
        return;
    }
    struct stat s;
    if( stat(filename,&s) == 0 ) {
        if (S_ISDIR(s.st_mode)) {
            fprintf(stderr, "File %s is directory!\n", filename);
            return;
        }
    } else {
        fprintf(stderr, "Exception during opening file %s!\n", filename);
        return;
    }

    fileCounter++;

    int lines = 0;
    int words = 0;
    int bytes = 0;

    char *buf = (char*)malloc(1024);
    char *prevBuf = (char*)malloc(1024);

    while (read(fd, buf, sizeof(*buf))) {
        if (wantBytes) {
            bytes++;
        }
        if (wantLines) {
            if (strcmp(buf, "\n") == 0) {
                lines++;
            }
        }
        if (wantWords) {
            if (((strcmp(buf, " ") == 0) || (strcmp(buf, "\n") == 0) || (strcmp(buf, "\t") == 0)) && (strcmp(buf, prevBuf) != 0)) {
                words++;
            }
        }
        *prevBuf = *buf;
    }

    close(fd);

    totalWords += words;
    totalLines += lines;
    totalBytes += bytes;


    if (wantLines) printf("%d ", lines);
    if (wantWords) printf("%d ", words);
    if (wantBytes) printf("%d ", bytes);
    printf("%s\n", filename);
}


int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Incorrect number of arguments! Usage wc -lwc filename\n");
        return 0;
    }

    if ((argc > 2) && (strstr(argv[1],"-") != NULL) && ((strstr(argv[1],"l") != NULL) || (strstr(argv[1],"w") != NULL) || (strstr(argv[1],"c") != NULL))) {
            hasFlags = true;
            if (strstr(argv[1], "l") == NULL) {
                wantLines = false;
            }
            if (strstr(argv[1], "w") == NULL) {
                wantWords = false;
            }
            if (strstr(argv[1], "c") == NULL) {
                wantBytes = false;
            }

    } else {
        if ((argc > 2) && (strstr(argv[1],"-") != NULL)) {
            fprintf(stderr, "Incorrect arguments! Usage wc -lwc filename\n");
            return 0;
        }
    }

    for (int i = hasFlags ? 2 : 1; i < argc; i++) {
        wc(argv[i]);
    }

    if (fileCounter > 1) {
        if (wantLines) printf("%d ", totalLines);
        if (wantWords) printf("%d ", totalWords);
        if (wantBytes) printf("%d ", totalBytes);
        printf("total\n");
    }

    return 0;
}


