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


KinTran::KinTran(InitCond* init, float dt){
  _init = init;
  _ntot = _init->_latt->get_nr()*_init->_latt->get_nphit()*_init->_latt->get_npt()*_init->_latt->get_nvzt();
  _nbytes = _ntot*sizeof(float);
  _t = _init->get_tInit(); _dt = dt;
  //cout << _ntot << ", " <<_nbytes << endl;
  CUDA_STATUS(cudaMalloc((void**) &_f, _nbytes));
  CUDA_STATUS(cudaMalloc((void**) &_fPre, _nbytes));
  _init->toGlobalMem(_fPre);
}

KinTran::~KinTran(){
  cudaFree((void*) _f);
  cudaFree((void*) _fPre);
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
  CUDA_STATUS(cudaMemcpy(f_h, _f, _nbytes, cudaMemcpyDeviceToHost));
}
