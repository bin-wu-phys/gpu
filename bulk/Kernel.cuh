#include "KernelParas.h"

class Kernel{
private:
  float _alphaS;
  float _agg2gg;//the effective coupling for gg<->gg
  float *_f_r;//f at r as a function of phirt, pt, vzt
  int _nphit, _npt, _nvzt;

public:
  __device__ __host__ Kernel(KernelParas*, float=0.3);
  __device__ __host__ float Cr();//from r gradient
  __device__ __host__ float Cg();
  __device__ __host__ float Cgg2gg();//kernel for gg<->gg
  __device__ __host__ void setAlphaS(float alphaS);
  __device__ __host__ float Mgg2gg(float, float, float);//calculate the kernel at i
};
