#include <iostream>
using namespace std;

#include "KinTran.cuh"
#include "fCPU.h"
#include "CompTime.h"

int main(){
  float *f0, *fOut_h;
  float t0 = 0.1, dt =1.0;

  int nx = 32, nphi = 32, npT = 16, npz = 64;
  int ntot = nx*nphi*npT*npz;
  
  f0 = new float[ntot]; fOut_h = new float[ntot];


  cout << "GPU:" << endl;
  KinTran bk(f0, t0, dt, nx, nphi, npT, npz);

  CompTime stopwatch;

  //cout << "Entering nextTime:\n";
  bk.nextTime();

  cout << "Computation time: " << stopwatch.getTime() << " s." << endl;
  
  //cout << "Entering output:\n";
  bk.output(f0);
  
  cout << "Computation time: " << stopwatch.getTime() << " s." << endl;
  
  delete [] f0;
  delete [] fOut_h;
  return 0;
}
