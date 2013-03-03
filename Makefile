
CC = gcc -g
LEX = flex
YACC = bison

all:format

format:	sql.tab.o sql.o adlist.o format.o
	${CC} -o format format.o sql.tab.o sql.o adlist.o

format.o:format.c

sql.tab.o:CFLAGS += -DYYDEBUG

sql.tab.c sql.tab.h:	sql.y
	${YACC} -vd sql.y

sql.c:	sql.l
	${LEX} -o $@ $<

sql.o: sql.c sql.tab.h

clean:
	rm -f format used_index sql.tab.c sql.tab.h sql.c sql.tab.o sql.o *.o sql.output

.SUFFIXES:	.l .y .c

