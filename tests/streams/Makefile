CXX = g++
NVCC = nvcc
CUFLAGS = -dc -o
LFLAGS = -rdc=true -o

IBULK = -I../../bulk/
LBULK = ../../bulk/

SS = StreamNaive
OBJS = ${EXEC}.o ${SS}.o

all: ${EXEC}

${EXEC}: ${OBJS}
	${NVCC} ${LFLAGS} ${EXEC} ${OBJS} ${LBULK}CompTime.o -lgomp

${EXEC}.o: ${EXEC}.cpp ${SS}.cuh
	${NVCC} ${IBULK} -Xcompiler -fopenmp ${CUFLAGS} ${EXEC}.o ${EXEC}.cpp

${SS}.o: ${SS}.cu ${SS}.cuh
	${NVCC} ${IBULK} -Xcompiler -fopenmp ${CUFLAGS} ${SS}.o ${SS}.cu

clean:
	rm -f *.o ${EXEC} *~
