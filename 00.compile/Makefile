CXX = g++
NVCC = nvcc
CUFLAGS = -dc -o
LFLAGS = -rdc=true -o
OBJS = Main.o HostDevice.o MyDevice.o 

Main: ${OBJS}
	${NVCC} ${LFLAGS} Main ${OBJS}

Main.o: Main.cpp HostDevice.h
	${CXX} -c Main.cpp

HostDevice.o: HostDevice.cu MyDevice.h
	${NVCC} ${CUFLAGS} HostDevice.o HostDevice.cu

MyDevice.o: MyDevice.cu MyDevice.h
	${NVCC} ${CUFLAGS} MyDevice.o MyDevice.cu
	
clean:
	rm -f *.o Main *~
