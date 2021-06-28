CXX = g++
NVCC = nvcc
CUFLAGS = -dc -o
LFLAGS = -rdc=true -o

IBULK = -I../../bulk/
LBULK = ../../bulk/

SS = StreamNaive
EXEC = main
OBJS = ${EXEC}.o ${SS}.o

all: ${EXEC}

${EXEC}: ${OBJS}
	${NVCC} ${LFLAGS} ${EXEC} ${OBJS}

${EXEC}.o: ${EXEC}.cpp ${SS}.cuh
#	${CXX} -c ${EXEC}.cpp
	${NVCC} ${IBULK} ${CUFLAGS} ${EXEC}.o ${EXEC}.cpp

${SS}.o: ${SS}.cu ${SS}.cuh
	${NVCC} ${IBULK} ${CUFLAGS} ${SS}.o ${SS}.cu

clean:
	rm -f *.o ${EXEC} *~
