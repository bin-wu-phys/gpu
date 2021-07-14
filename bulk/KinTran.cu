#include <cuda.h>
#include <iostream>
using namespace std;

#include "KinTran.cuh"
#include "fThread.cuh"
#include "macros.h"

__global__ void fGrid(float* fIn_d, float *fOut_d, float t, float dt, int ntot){
  fThread fi = fThread(fIn_d, fOut_d, t, dt);
  //fi.print();
  fi.setntot(ntot);
  fi.nextTime();
  fi.update();
}


KinTran::KinTran(float* f0_h, float t0, float dt, int nx, int nphi, int npT, int npz){
  _nx = nx; _nphi = nphi; _npT = npT; _npz = npz;
  _ntot = _nx*_nphi*_npT*_npz;
  _nbytes = _ntot*sizeof(float);
  _t = t0; _dt = dt;
  //cout << _ntot << ", " <<_nbytes << endl;
  CUDA_STATUS(cudaMalloc((void**) &_fIn_d, _nbytes));
  CUDA_STATUS(cudaMalloc((void**) &_fOut_d, _nbytes));
  CUDA_STATUS(cudaMemcpy(_fIn_d, f0_h, _nbytes, cudaMemcpyHostToDevice));
}

KinTran::~KinTran(){
  cudaFree((void*) _fIn_d);
  cudaFree((void*) _fOut_d);
}

void KinTran::nextTime(){
  int nt = 32*4;
  fGrid<<<(_ntot+nt-1)/nt, nt>>>(_fIn_d, _fOut_d, _t, _dt, _ntot);
  cudaError_t err = cudaGetLastError();
  if (err != cudaSuccess){
    printf("Kernel call in KinTran::nextTime:\n");
    fprintf( stderr , "Error %s at line %d in file %s \n", cudaGetErrorString(err), __LINE__, __FILE__);
    exit(1);
  }
  
  CUDA_STATUS(cudaDeviceSynchronize());
  _t += _dt;
}

void KinTran::output(float* f_h){
  CUDA_STATUS(cudaMemcpy(f_h, _fOut_d, _nbytes, cudaMemcpyDeviceToHost));
}
