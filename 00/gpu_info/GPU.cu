#include <iostream>
using namespace std;

#include "GPU.h"

int GPU::CoresPerSM(int major, int minor){
  int cores = 0;
  switch (major){
     case 2: // Fermi
      if (minor == 1) cores = 48;
      else cores = 32;
      break;
    case 3: // Kepler
      cores = 192;
      break;
    case 5: // Maxwell
      cores = 128;
      break;
    case 6: // Pascal
      if ((minor == 1) || (minor == 2)) cores = 128;
      else if (minor == 0) cores = 64;
      else printf("Unknown device type\n");
      break;
    case 7: // Volta and Turing
      if ((minor == 0) || (minor == 5)) cores = 64;
      else printf("Unknown device type\n");
      break;
    case 8: // Ampere
      if (minor == 0) cores = 64;
      else if (minor == 6) cores = 128;
      else printf("Unknown device type\n");
      break;
    default:
      printf("Unknown device type\n"); 
      break;
  } 
  return cores;
}

void GPU::info(){
  int nDevices;

  cudaGetDeviceCount(&nDevices);
  for (int i = 0; i < nDevices; i++) {
    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, i);
    cout << "Device Number: " <<  i << endl;
    cout << "  Device name: " << prop.name << endl;
    cout << "  Compute capability: " << prop.major << "." << prop.minor << endl;
    int cs = CoresPerSM(prop.major, prop.minor);
    cout << "  (SMs, Cuda cores/SM, Cuda cores): (" <<  prop.multiProcessorCount;
    cout << ", " << cs << ", " << cs* prop.multiProcessorCount << ")" << endl;
    cout << "  Maximum number of threads per block: " << prop.maxThreadsPerBlock << endl;
    cout << "  Warp Size: " << prop.warpSize << endl;
    cout << "  Maximum size of a block: (" << prop.maxThreadsDim[0] << ", ";
    cout << prop.maxThreadsDim[1] << ", " << prop.maxThreadsDim[2] << ")" << endl;
    cout << "  Maximum size of a grid: (" << prop.maxGridSize[0] << ", ";
    cout << prop.maxGridSize[1] << ", " << prop.maxGridSize[2] << ")" << endl;
    cout << "  Shared memory available per multiprocess: " << prop.sharedMemPerMultiprocessor/1024.0 << " kb" << endl;
    cout << "  Shared memory available per block: " << prop.sharedMemPerBlock/1024.0 << " kb" << endl;
    cout << "  Total number of registers available per block: " << prop.regsPerBlock << endl;
    cout << "  Total memory: " << prop.totalGlobalMem/1073741824 << " Gb" << endl;
    cout << "  Peak Memory Bandwidth " << 2.0*prop.memoryClockRate*(prop.memoryBusWidth/8)/1.0e6 << " Gb/s" << endl;
  }
}
