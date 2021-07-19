#include <iostream>
using namespace std;

#include "KinTran.cuh"
#include "fCPU.h"
#include "CompTime.h"

#define NR 32
#define NPHI 21
#define NP 16
#define NV 64


int main(){
  float t0 = 0.1, dt =1.0;

  Lattice latt(NR, NPHI, NP, NV, 3.0f, 3.0f, 15.0f);
  InitCond init(t0, &latt);
  KinTran bk(&init, dt);

  CompTime stopwatch;

  //cout << "Entering nextTime:\n";
  //bk.nextTime();

  cout << "Computation time: " << stopwatch.getTime() << " s." << endl;
  
  //cout << "Entering output:\n";
  //bk.output(f0);
  
  //cout << "Computation time: " << stopwatch.getTime() << " s." << endl;
  
  //delete [] f0;
  //delete [] fOut_h;
  return 0;
}
