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

__global__ void fGrid(float* fIn_d, float *fOut_d, float t, float dt, int ntot){
  fThread fi = fThread(fIn_d, fOut_d, t, dt);
  //fi.print();
  fi.setntot(ntot);
  fi.nextTime();
  fi.update();
}


bulk::bulk(float* f0_h, float t0, float dt, int ntot){
  _ntot = ntot; _t = t0; _dt = dt;
  _nbytes = _ntot*sizeof(int);
  //cout << _ntot << ", " <<_nbytes << endl;
  CUDA_STATUS(cudaMalloc((void**) &_fIn_d, _nbytes));
  CUDA_STATUS(cudaMalloc((void**) &_fOut_d, _nbytes));
  CUDA_STATUS(cudaMemcpy(_fIn_d, f0_h, _nbytes, cudaMemcpyHostToDevice));
}

bulk::~bulk(){
  cudaFree((void*) _fIn_d);
  cudaFree((void*) _fOut_d);
}

void bulk::nextTime(){
  fGrid<<<_ntot, 1>>>(_fIn_d, _fOut_d, _t, _dt, _ntot);
  cudaError_t err = cudaGetLastError();
  if (err != cudaSuccess){
    printf("Kernel call in bulk::nextTime:\n");
    fprintf( stderr , "Error %s at line %d in file %s \n", cudaGetErrorString(err), __LINE__, __FILE__);
    exit(1);
  }
  
  CUDA_STATUS(cudaDeviceSynchronize());
  _t += _dt;
}

void bulk::output(float* f_h){
  CUDA_STATUS(cudaMemcpy(f_h, _fOut_d, _nbytes, cudaMemcpyDeviceToHost));
}
