#include <iostream>
using namespace std;

#include "MyDevice.h"

__device__ void MyDevice::print(){
  printf("[b, t] = [%d, %d]\n", blockIdx.x, threadIdx.x);
}
