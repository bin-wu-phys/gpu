#include "Kernel.cuh"

__device__ __host__ Kernel::Kernel(float alphaS){
  _alphaS = alphaS;
}
