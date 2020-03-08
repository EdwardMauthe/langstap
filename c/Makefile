LANG_NAME=c
all: lex.yy.o $(LANG_NAME).tab.o main.o
	gcc -o $(LANG_NAME) lex.yy.o $(LANG_NAME).tab.o main.o
$(LANG_NAME).tab.c: $(LANG_NAME).y main.h
	bison -d $(LANG_NAME).y
lex.yy.c: $(LANG_NAME).l main.h
	flex $(LANG_NAME).l
lex.yy.o: lex.yy.c $(LANG_NAME).tab.c
	gcc -c lex.yy.c
$(LANG_NAME).tab.o: $(LANG_NAME).tab.c
	gcc -c $(LANG_NAME).tab.c
main.o: main.c main.h
	gcc -c main.c
clean:
	rm *.o lex.yy.c $(LANG_NAME).tab.c $(LANG_NAME).tab.h $(LANG_NAME)
tests:
	sh testing.sh
