CFLAGS=-std=c11 -g -pedantic-errors
all: main

clean:
	rm *.o main

main: *.c
		gcc $(CFLAGS) -c *.c
		gcc -o main  *.o -no-pie