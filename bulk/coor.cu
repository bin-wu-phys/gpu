#include <iostream>
using namespace std;

#include "Coordinates.cuh"

__global__ void test_coor(float r, float phirt, float pt, float vzt){
  Coordinates coor(0.1, 1.0);
  coor.calc(r, phirt, pt, vzt);

  printf("%f on (%d, %d).\n", coor.cos_phir(), blockIdx.x, threadIdx.x);

}

int main(){
  Coordinates coor(0.1, 1.0);
  float r = 1.0, phirt = 0.1, pt = 1.0, vzt = 0.3;
  coor.calc(r, phirt, pt, vzt);

  printf("%f on the host.\n", coor.cos_phir());

  test_coor<<<2, 3>>>(r, phirt, pt, vzt);

  cudaDeviceSynchronize();
  return 0;
}
