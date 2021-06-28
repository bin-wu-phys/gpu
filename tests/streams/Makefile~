CXX = g++
NVCC = nvcc
CUFLAGS = -dc -o
LFLAGS = -rdc=true -o

IBULK = -I../../bulk/
LBULK = ../../bulk/

EXEC = sharedMem
OBJS = ${EXEC}.o

${EXEC}: ${OBJS}
	${NVCC} ${LFLAGS} ${EXEC} ${OBJS} ${LBULK}CompTime.o

${EXEC}.o: ${EXEC}.cu
	${NVCC} ${IBULK} ${CUFLAGS} ${EXEC}.o ${EXEC}.cu

clean:
	rm -f *.o ${EXEC} *~
