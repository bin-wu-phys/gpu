#include <iostream>
using namespace std;

#include "InitCond.cuh"

int main(){
  Lattice latt(2, 3, 4, 5, 3.0f, 3.0f, 15.0f);
  InitCond init(0.1, &latt);
  return 0;
}
