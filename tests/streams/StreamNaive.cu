#include<iostream>
using namespace std;

#define N 262144
#include "macros.h"
#include "StreamNaive.cuh"


__global__ void kernel_1(int stream)
{
    double sum = 0.0;

    for(int i = 0; i < N; i++)
    {
        sum = sum + tan(0.1) * tan(0.1);
    }
    printf("Kernel 1 on stream %d.\n", stream);
}

__global__ void kernel_2(int stream)
{
    double sum = 0.0;

    for(int i = 0; i < N; i++)
    {
        sum = sum + tan(0.1) * tan(0.1);
    }
    printf("Kernel 2 on stream %d.\n", stream);
}

__global__ void kernel_3(int stream)
{
    double sum = 0.0;

    for(int i = 0; i < N; i++)
    {
        sum = sum + tan(0.1) * tan(0.1);
    }
    printf("Kernel 3 on stream %d.\n", stream);
}

__global__ void kernel_4(int stream)
{
    double sum = 0.0;

    for(int i = 0; i < N; i++)
    {
        sum = sum + tan(0.1) * tan(0.1);
    }
    printf("Kernel 4 on stream %d.\n", stream);
}

StreamNaive::StreamNaive(int n){
  _n = n;
  //_streams = new cudaSream_t[_n];
  _streams = (cudaStream_t *) malloc(_n * sizeof(cudaStream_t));
  for(int i=0;i<_n;i++)
    CUDA_STATUS(cudaStreamCreate(&(_streams[i])));
}

StreamNaive::~StreamNaive(){
  for(int i=0;i<_n;i++)
    CUDA_STATUS(cudaStreamDestroy(_streams[i]));  
  delete [] _streams;
}

void StreamNaive::run(){
  dim3 block(1), grid(1);
  for (int i = 0; i < _n; i++){
      kernel_1<<<grid, block, 0, _streams[i]>>>(i);
      kernel_2<<<grid, block, 0, _streams[i]>>>(i);
      kernel_3<<<grid, block, 0, _streams[i]>>>(i);
      kernel_4<<<grid, block, 0, _streams[i]>>>(i);
  }

  CUDA_STATUS(cudaDeviceSynchronize());
}


