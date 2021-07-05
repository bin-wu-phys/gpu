#include<iostream>
using namespace std;

#include <omp.h>

#define N 262144
#include "macros.h"
#include "StreamNaive.cuh"

__global__ void kernel()
{
    double sum = 0.0;

    for(int i = 0; i < N; i++)
    {
        sum = sum + tan(0.1) * tan(0.1);
    }
    printf("Kernel on the default stream.\n");
}

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
  for(int i=0;i<_n;i++){
    CUDA_STATUS(cudaStreamCreate(&(_streams[i])));
  }

  CUDA_STATUS(cudaEventCreate(&_start));
  CUDA_STATUS(cudaEventCreate(&_stop));
}

StreamNaive::~StreamNaive(){
  for(int i=0;i<_n;i++)
    CUDA_STATUS(cudaStreamDestroy(_streams[i]));  
  delete [] _streams;

  CUDA_STATUS(cudaEventDestroy(_start));
  CUDA_STATUS(cudaEventDestroy(_stop));

  CUDA_STATUS(cudaDeviceReset());
}

void StreamNaive::run(){
  dim3 block(1), grid(1);
  for (int i = 0; i < _n; i++){
      kernel_1<<<grid, block, 0, _streams[i]>>>(i);
      kernel_2<<<grid, block, 0, _streams[i]>>>(i);
      kernel_3<<<grid, block, 0, _streams[i]>>>(i);
      kernel_4<<<grid, block, 0, _streams[i]>>>(i);
  }
}

void StreamNaive::runBlock(){
  dim3 block(1), grid(1);

  int i = 0;
  kernel_1<<<grid, block, 0, _streams[i]>>>(i);
  kernel_2<<<grid, block, 0, _streams[i]>>>(i);
  kernel_3<<<grid, block, 0, _streams[i]>>>(i);
  kernel_4<<<grid, block, 0, _streams[i]>>>(i);

  kernel<<<grid, block>>>();
  
  for (i = 1; i < _n; i++){
      kernel_1<<<grid, block, 0, _streams[i]>>>(i);
      kernel_2<<<grid, block, 0, _streams[i]>>>(i);
      kernel_3<<<grid, block, 0, _streams[i]>>>(i);
      kernel_4<<<grid, block, 0, _streams[i]>>>(i);
  }
}

void StreamNaive::runomp(){
  dim3 block(1), grid(1);

  omp_set_num_threads(_n);
#pragma omp parallel
  {
    int i = omp_get_thread_num();
    kernel_1<<<grid, block, 0, _streams[i]>>>(i);
    kernel_2<<<grid, block, 0, _streams[i]>>>(i);
    kernel_3<<<grid, block, 0, _streams[i]>>>(i);
    kernel_4<<<grid, block, 0, _streams[i]>>>(i);
    cout << "Stream " << i << "has been launched!" << endl;
  }
}

void StreamNaive::setSync(_sync sync){
  switch(sync){
  case deviceSync:
    CUDA_STATUS(cudaDeviceSynchronize());
    break;
  case streamSync:
    for (int i = 0; i < _n; i++){
      CUDA_STATUS(cudaStreamSynchronize(_streams[i]));
    }
  }
}

void StreamNaive::start(){
  CUDA_STATUS(cudaEventRecord(_start));
}

float StreamNaive::stop(){
  float dt;
  CUDA_STATUS(cudaEventRecord(_stop));
  CUDA_STATUS(cudaEventSynchronize(_stop));
  CUDA_STATUS(cudaEventElapsedTime(&dt, _start, _stop));
  return dt;
}
