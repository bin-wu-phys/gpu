CXX = g++
NVCC = nvcc
CUFLAGS = -dc -o
LFLAGS = -rdc=true -o
THREAD = fThread
BULK = bulk
EXEC = main
OBJS = ${EXEC}.o ${BULK}.o ${THREAD}.o 

${EXEC}: ${OBJS}
	${NVCC} ${LFLAGS} ${EXEC} ${OBJS}

${EXEC}.o: ${EXEC}.cpp ${BULK}.cuh
	${CXX} -c ${EXEC}.cpp

${BULK}.o: ${BULK}.cu ${BULK}.cuh
	${NVCC} ${CUFLAGS} ${BULK}.o ${BULK}.cu

${THREAD}.o: ${THREAD}.cu ${THREAD}.cuh
	${NVCC} ${CUFLAGS} ${THREAD}.o ${THREAD}.cu

clean:
	rm -f *.o ${EXEC} *~
