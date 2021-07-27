#include "Kernel.cuh"
#define Nc 3.0
#define PI 3.14159265


__device__ __host__ Kernel::Kernel(KernelParas *kps, float alphaS){
  setAlphaS(alphaS);
  
  _f_r = kps->_f_r; _nphit = kps->_nphit; _npt = kps->_npt; _nvzt = kps->_nvzt;
}

__device__ __host__ void Kernel::setAlphaS(float alphaS){
  _alphaS = alphaS; _agg2gg = 128.0*PI*PI*_alphaS*_alphaS*Nc*Nc;
}

__device__ __host__ float Kernel::Mgg2gg(float s, float t, float u){
  return _agg2gg*(3.0 - s*u/(t*t) - s*t/(u*u) - t*u/(s*s));
}

__device__ __host__ float Kernel::Cgg2gg(){
  float c = 0.0f;

  return c;
}
