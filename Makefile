CC=clang++
CCDEBUGFLAGS=-g -Wall --std=c++1z
CCFLAGS=-O2 -Wall --std=c++1z
TARGET:test.out
LIBS= -L ./libs/libcli -lcli
OBJS=objs/graph.o \
	 objs/net.o	 \
	 objs/utils.o \
	 objs/nwcli.o

test.out:objs/testapp.o ${OBJS} libs/libcli/libcli.so.1.10
	${CC} ${CCDEBUGFLAGS} objs/testapp.o ${OBJS} -o test.out ${LIBS}

objs/testapp.o:src/testapp.cc
	${CC} ${CCDEBUGFLAGS} -c src/testapp.cc -o objs/testapp.o

objs/graph.o:src/graph.cc
	${CC} ${CCDEBUGFLAGS} -c -I . src/graph.cc -o objs/graph.o

objs/net.o:src/net.cc
	${CC} ${CCDEBUGFLAGS} -c -I . src/net.cc -o objs/net.o

objs/utils.o:src/utils.cc
	${CC} ${CCDEBUGFLAGS} -c -I . src/utils.cc -o objs/utils.o

objs/nwcli.o:src/nwcli.cc
	${CC} ${CCDEBUGFLAGS} -c -I . src/nwcli.cc -o objs/nwcli.o

libs/libcli/libcli.so.1.10:
	(cd libs/libcli; make)
	cp libs/libcli/libcli.so.1.10 .

clean:
	/bin/rm -r objs/
	/bin/rm *.out
	mkdir objs

all:
	make
	(cd libs/libcli; make)

cleanall:
	make clean
	(cd libs/libcli; make clean)
