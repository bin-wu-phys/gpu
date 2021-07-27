#include <cuda.h>
#include <iostream>
using namespace std;

#include "KinTran.cuh"
#include "fThread.cuh"
#include "macros.h"

__global__ void fGrid(float* fIn_d, float *fOut_d, float t, float dt, KernelParas *kps_all){
  KernelParas kps;
  kps._f_r = fIn_d + blockIdx.x*kps_all->_nphit*kps_all->_npt*kps_all->_nvzt;
  kps._nphit = kps_all->_nphit; kps._npt = kps_all->_npt; kps._nvzt = kps_all->_nvzt;
  fThread fi = fThread(fIn_d, fOut_d, t, dt, &kps);
  //fi.print();
  fi.nextTime();
  fi.update();
}


KinTran::KinTran(InitCond* init, float dt){
  _latt = init-> _latt;
  _ntot = _latt->get_nr()*_latt->get_nphit()*_latt->get_npt()*_latt->get_nvzt();
  _nbytes = _ntot*sizeof(float);
  _t = init->get_tInit(); _dt = dt;
  //cout << _ntot << ", " <<_nbytes << endl;
  CUDA_STATUS(cudaMalloc((void**) &_f, _nbytes));
  CUDA_STATUS(cudaMalloc((void**) &_fPre, _nbytes));
  init->toGlobalMem(_fPre);
}

KinTran::~KinTran(){
  cudaFree((void*) _f);
  cudaFree((void*) _fPre);
}

void KinTran::nextTime(){
  KernelParas kps;
  kps._f_r = _f; kps._nphit = _latt->get_nphit();
  kps._npt = _latt->get_npt(); kps._nvzt = _latt->get_nvzt();
  
  fGrid<<<_latt->get_nr(), dim3(_latt->get_nphit(), _latt->get_npt(), _latt->get_nvzt())>>>(_f, _fPre, _t, _dt, &kps);
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
