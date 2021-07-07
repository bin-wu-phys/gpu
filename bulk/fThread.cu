#include <iostream>
using namespace std;

#include "fThread.cuh"
#define Nc 3.0
#define PI 3.14159265

__device__ fThread::fThread(float* fIn_d, float* fOut_d, float t, float dt, float alphaS = 0.3){
  _fIn_d = fIn_d; _fOut_d = fOut_d; _t = t; _dt = dt;
  _idx = getIdx();
  _fNext = _fIn_d[_idx];

  setAlphaS(alphaS);
  //printf("%d ", _idx);
}

__device__ int fThread::getIdx(){
 return threadIdx.x + blockDim.x*(threadIdx.y + blockDim.y*(threadIdx.z + blockDim.z*(blockIdx.x + gridDim.x*(blockIdx.y + gridDim.y*blockIdx.z))));
}

__device__ void fThread::update(){
  _fOut_d[_idx] = _fNext;
}

__device__ float fThread::getC(){
  float c = 0.0;
  for(int i=0;i<_ntot;i++)
    c += _fIn_d[i]*_fIn_d[i]*_fIn_d[i]*_fIn_d[i];
  return c*_idx;
}

__device__ float fThread::Mgg2gg(float s, float t, float u){
  return _agg2gg*(3.0 - s*u/(t*t) - s*t/(u*u) - t*u/(s*s));
}

__device__ void fThread::nextTime(){
  _fNext = _fIn_d[_idx] + _dt* getC();
}

__device__
void fThread::print(){
  printf("Hello World from [%d]th thread with fIn = %f\n", _idx, _fIn_d[_idx]);
}

__device__ void fThread::setntot(int ntot){
  _ntot = ntot;
}

__device__ void fThread::setAlphaS(float alphaS){
  _alphaS = alphaS; _agg2gg = 128.0*PI*PI*_alphaS*_alphaS*Nc*Nc;
}
