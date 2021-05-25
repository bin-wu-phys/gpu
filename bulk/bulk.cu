#include <cuda.h>
#include <iostream>
using namespace std;

#include "bulk.cuh"
#include "fThread.cuh"

#define CUDA_STATUS(value){\
  cudaError_t _m_cudaStat = value;\
  if ( _m_cudaStat != cudaSuccess ){\
    fprintf( stderr , "Error %s at line %d in file %s \n", cudaGetErrorString(_m_cudaStat), __LINE__, __FILE__);\
    exit(1);\
  }\
}

__global__ void fGrid(float* fIn_d, float *fOut_d, float t, float dt){
  fThread fi = fThread(fIn_d, fOut_d, t, dt);
  //fi.nextTime();
  fi.update();
}


bulk::bulk(float* f0_h, float t0, float dt, int ntot){
  _ntot = _ntot;
  _nbytes = ntot*sizeof(int);
  CUDA_STATUS(cudaMalloc((void**) &_fIn_d, _nbytes));
  CUDA_STATUS(cudaMalloc((void**) &_fOut_d, _nbytes));
  CUDA_STATUS(cudaMemcpy(_fIn_d, f0_h, _nbytes, cudaMemcpyHostToDevice));
}

bulk::~bulk(){
  cudaFree((void*) _fIn_d);
  cudaFree((void*) _fOut_d);
}

void bulk::nextTime(){
  fGrid<<<1, _ntot>>>(_fIn_d, _fOut_d, _t, _dt);
  cudaDeviceSynchronize();
}

void bulk::output(float* f_h){
  cout << "In output: " << endl;
  cout << f_h[5] << endl;
  CUDA_STATUS(cudaMemcpy(f_h, _fOut_d, _nbytes, cudaMemcpyDeviceToHost));
}
