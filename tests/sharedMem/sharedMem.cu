#include <iostream>
using namespace std;

#include <macros.h>
#include <CompTime.h>

#define DIMGRD 512
#define DIMBLK 1024

__device__ __host__ float fab(float a, float b){
  return a*b*a*b;
}

__global__ void sum_global(float *a_d, float *b_d, float *out_d){
  int idx = blockIdx.x * blockDim.x + threadIdx.x;
  out_d[idx] = fab(a_d[idx],  b_d[idx]);
}

int main(){
  int dim = DIMBLK*DIMGRD;
    float *a_d, *b_d, *out_d;
  float a_h[dim], b_h[dim], out_h[dim];
  for(int i=0; i<dim; i++){
    a_h[i] = (float) i; b_h[i] = (float) i;
  }
  //cout << "a_h and b_h has just been initialized!" << endl;
  
  CompTime stopwatch;
  for(int i=0; i<dim; i++){
    out_h[i] = fab(a_h[i], b_h[i]);
  }

  cout << "CPU computation time: " << scientific << stopwatch.getTime() << " s.\n" << endl;
    
  //cout << "a_h and b_h has just been initialized!" << endl;

  size_t _nbytes = dim * sizeof(float);
  CUDA_STATUS(cudaMalloc((void**) &a_d, _nbytes));
  CUDA_STATUS(cudaMalloc((void**) &b_d, _nbytes));
  CUDA_STATUS(cudaMalloc((void**) &out_d, _nbytes));
  CUDA_STATUS(cudaMemcpy(a_d, a_h, _nbytes, cudaMemcpyHostToDevice));
  CUDA_STATUS(cudaMemcpy(b_d, b_h, _nbytes, cudaMemcpyHostToDevice));
  stopwatch.reset();
  sum_global<<<DIMGRD, DIMBLK>>>(a_d, b_d, out_d);
  cudaError_t err = cudaGetLastError();
  if (err != cudaSuccess){
    printf("Kernel call in main:\n");
    fprintf( stderr , "Error %s at line %d in file %s \n", cudaGetErrorString(err), __LINE__, __FILE__);
    exit(1);
  }
  cout << "GPU with globalMem computation time with (" << DIMGRD << ", " << DIMBLK << "): " << stopwatch.getTime() << " s.\n" << endl;


  cudaFree((void*) a_d);
  cudaFree((void*) b_d);
  cudaFree((void*) out_d);
  return 0;
}
