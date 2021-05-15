CXX = g++
NVCC = nvcc
CUFLAGS = -dc -o
LFLAGS = -rdc=true -o
OBJS = Main.o GPU.o
EXEC = deviceQuery

${EXEC}: ${OBJS}
	${NVCC} ${LFLAGS} ${EXEC} ${OBJS}

Main.o: Main.cpp GPU.h
	${CXX} -c Main.cpp

GPU.o: GPU.cu GPU.h
	${NVCC} ${CUFLAGS} GPU.o GPU.cu

clean:
	rm -f *.o ${EXEC} *~
