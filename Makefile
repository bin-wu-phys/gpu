CXX = g++
NVCC = nvcc
CUFLAGS = -dc -o
LFLAGS = -rdc=true -o
THREAD = fThread
KT = KinTran
LATT = Lattice
INIT = InitCond
EXEC = main
COOR = Coordinates

OBJS = ${EXEC}.o ${KT}.o ${THREAD}.o ${LATT}.o ${INIT}.o fCPU.o CompTime.o
OBJSI = init.o InitCond.o Lattice.o 

${EXEC}: ${OBJS}
	${NVCC} ${LFLAGS} ${EXEC} ${OBJS}

${EXEC}.o: ${EXEC}.cpp ${KT}.cuh  ${INIT}.cuh ${LATT}.cuh fCPU.h CompTime.h
	${CXX} -c ${EXEC}.cpp

${KT}.o: ${KT}.cu ${KT}.cuh
	${NVCC} ${CUFLAGS} ${KT}.o ${KT}.cu

${LATT}.o: ${LATT}.cu ${LATT}.cuh macros.h
	${NVCC} ${CUFLAGS} ${LATT}.o ${LATT}.cu

${INIT}.o: ${INIT}.cu ${INIT}.cuh macros.h
	${NVCC} ${CUFLAGS} ${INIT}.o ${INIT}.cu

${THREAD}.o: ${THREAD}.cu ${THREAD}.cuh
	${NVCC} ${CUFLAGS} ${THREAD}.o ${THREAD}.cu

${COOR}.o: ${COOR}.cu ${COOR}.cuh
	${NVCC} ${CUFLAGS} $@ $<

#testing

## test InitCond and Lattice
init: ${OBJSI}
	${NVCC} ${LFLAGS} $@ ${OBJSI}

## test Coordinates
coor: coor.o ${COOR}.o
	${NVCC} ${LFLAGS} $@ $^

coor.o: coor.cu ${COOR}.cuh
	${NVCC} ${CUFLAGS} $@ $<

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
