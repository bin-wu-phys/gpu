#include <iostream>
using namespace std;

#include "bulk.cuh"
#include "fCPU.h"
#include "CompTime.h"
#define N 10000

int main(){
  float f0[N], f[N], fOut_h[N];
  float t0 = 0.1, dt =1.0;
  
  for(int i=0;i<N;i++){
    f0[i] = (float) i;
  }


  cout << "GPU:" << endl;
  bulk bk(f0, t0, dt, N);

  CompTime stopwatch;

  //cout << "Entering nextTime:\n";
  bk.nextTime();

  cout << "Computation time: " << stopwatch.getTime() << " s." << endl;
  
  //cout << "Entering output:\n";
  bk.output(f);
  
  cout << "Computation time: " << stopwatch.getTime() << " s." << endl;
  
  for(int i=0;i<5;i++)
    cout << i << ", " << f[i] << endl;
  for(int i=N-5;i<N;i++)
    cout << i << ", " << f[i] << endl;

  cout << "\nCPU:" << endl;
  stopwatch.reset();
  fCPU cpu(f0, fOut_h, t0, dt, N);
  cpu.nextTime();
  cout << "Computation time: " << stopwatch.getTime() << " s." << endl;
  
  for(int i=0;i<5;i++)
    cout << i << ", " << fOut_h[i] << endl;
  for(int i=N-5;i<N;i++)
    cout << i << ", " << fOut_h[i] << endl;
  
  return 0;
}
