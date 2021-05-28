#include <cuda.h>
#include <iostream>
using namespace std;

#include "fThread.cuh"

#define N 100


#define CUDA_STATUS(value){\
  cudaError_t _m_cudaStat = value;\
  if ( _m_cudaStat != cudaSuccess ){\
    fprintf( stderr , "Error %s at line %d in file %s \n", cudaGetErrorString(_m_cudaStat), __LINE__, __FILE__);\
    exit(1);\
  }\
}

__global__ void fGrid(float* fIn_d, float *fOut_d, float t, float dt){
  fThread fi = fThread(fIn_d, fOut_d, t, dt);
  fi.print();
  fi.nextTime();
  fi.update();
}

int main(){
  int _ntot = N;
  int _nbytes = _ntot*sizeof(int);

  float f0_h[N], fOut_h[N];
  float *_fIn_d, *_fOut_d;
  float _t = 0.1, _dt = 0.1;
  for(int i=0;i<N;i++){
    f0_h[i] = (float) i;
  }
  
  CUDA_STATUS(cudaMalloc((void**) &_fIn_d, _nbytes));
  CUDA_STATUS(cudaMalloc((void**) &_fOut_d, _nbytes));
  CUDA_STATUS(cudaMemcpy(_fIn_d, f0_h, _nbytes, cudaMemcpyHostToDevice));
  
  fGrid<<<1, _ntot>>>(_fIn_d, _fOut_d, _t, _dt);
  CUDA_STATUS(cudaDeviceSynchronize());

  CUDA_STATUS(cudaMemcpy(fOut_h, _fOut_d, _nbytes, cudaMemcpyDeviceToHost));
  cout << "In output after cudaMemcpy: " << endl;
  for(int i=0;i<=5;i++)
    cout << fOut_h[i] << endl;

  
  cudaFree((void*) _fIn_d);
  cudaFree((void*) _fOut_d);


  return 0;
}
