include Makefile.test

CC=g++
CFLAGS=-Wall -fpermissive -std=c++11
BISON=bison --debug

all: build

build: reset compile clean

clean:
	rm -rf lexer/*.gch parser/*.gch

reset:
	rm -rf parser/syntax.cc parser/syntax.hh parser/location.hh
	rm -rf *.o *.out

syntax: parser/syntax.yy
	$(BISON) parser/syntax.yy --output=parser/syntax.cc

compile: syntax
	$(CC) $(CFLAGS) parser/syntax.cc parser/syntax.hh parser/location.hh \
	    parser/driver.cc parser/driver.hh \
	    lexer/lexer.cc lexer/lexer.hh \
	    lexer/checkers.cc lexer/checkers.hh \
	    parser/ast.cc parser/ast.hh \
	    main.cc
