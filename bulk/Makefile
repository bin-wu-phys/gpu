CXX = g++
NVCC = nvcc
CUFLAGS = -dc -o
LFLAGS = -rdc=true -o
THREAD = fThread
BULK = bulk
LATT = Lattice
EXEC = main
OBJS = ${EXEC}.o ${BULK}.o ${THREAD}.o fCPU.o CompTime.o

${EXEC}: ${OBJS}
	${NVCC} ${LFLAGS} ${EXEC} ${OBJS}

${EXEC}.o: ${EXEC}.cpp ${BULK}.cuh fCPU.h CompTime.h
	${CXX} -c ${EXEC}.cpp

${BULK}.o: ${BULK}.cu ${BULK}.cuh
	${NVCC} ${CUFLAGS} ${BULK}.o ${BULK}.cu

${LATT}.o: ${LATT}.cu ${LATT}.cuh
	${NVCC} ${CUFLAGS} ${LATT}.o ${LATT}.cu

${THREAD}.o: ${THREAD}.cu ${THREAD}.cuh
	${NVCC} ${CUFLAGS} ${THREAD}.o ${THREAD}.cu

#testing

test.o: test.cu fThread.cuh
	${NVCC} ${CUFLAGS} test.o test.cu

test: test.o fThread.o
	${NVCC} ${LFLAGS} test test.o fThread.o

fCPU.o: fCPU.cpp fCPU.h
	${CXX} -c fCPU.cpp

CompTime.o: CompTime.cpp CompTime.h
	${CXX} -c CompTime.cpp

clean:
	rm -f *.o ${EXEC} *~
