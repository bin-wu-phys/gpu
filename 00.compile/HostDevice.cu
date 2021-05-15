#include <iostream>
using namespace std;

#include "MyDevice.h"

__global__ void frontEnd(){
  MyDevice md;
  md.print();
}

void HostDevice(unsigned int gd, unsigned int bd){
  frontEnd<<<gd, bd>>>();
  cudaDeviceSynchronize();
}
