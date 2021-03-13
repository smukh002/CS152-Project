parser: mini_l.lex mini_l.y
	 bison -v -d --file-prefix=y mini_l.y
	flex mini_l.lex
	gcc -o parser y.tab.c lex.yy.c -lfl

clean:
	 rm -f lex.yy.c y.tab.* y.output *.o parser

trial:
	chmod +x mil_run
	cat fibonacci.min | ./my_compiler > fibonacci.mil
	echo 5 > input.txt
	./mil_run fibonacci.mil < input.txt


