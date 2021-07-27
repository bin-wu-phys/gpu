#include <iostream>
using namespace std;

#include "fThread.cuh"

__device__ fThread::fThread(float* fIn_d, float* fOut_d, float t, float dt, KernelParas *kps, float alphaS){
  _fIn_d = fIn_d; _fOut_d = fOut_d; _t = t; _dt = dt;
  _idx = getIdx();
  _fNext = _fIn_d[_idx];

  _kern = new Kernel(kps, alphaS);
  //if(_idx == 0)
  //  printf("%f", _agg2gg);
}

__device__ fThread::~fThread(){
  delete _kern;
}

__device__ int fThread::getIdx(){
 return threadIdx.x + blockDim.x*(threadIdx.y + blockDim.y*(threadIdx.z + blockDim.z*(blockIdx.x + gridDim.x*(blockIdx.y + gridDim.y*blockIdx.z))));
}

__device__ void fThread::update(){
  _fOut_d[_idx] = _fNext;
}

__device__ void fThread::nextTime(){
  _fNext = _fIn_d[_idx] + _dt* _kern->Cgg2gg();
}

__device__
void fThread::print(){
  printf("Hello World from [%d]th thread with fIn = %f\n", _idx, _fIn_d[_idx]);
}

__device__ void fThread::setntot(int ntot){
  _ntot = ntot;
}
