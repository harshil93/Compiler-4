all:
	flex part1.l
	g++ lex.yy.c
	./a.out<in.txt
	yacc -d -v -t codegen.y
	flex part2.l
	g++ lex.yy.c y.tab.c y.tab.h -o parser -lfl
