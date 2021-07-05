#include<iostream>
using namespace std;

#include <omp.h>
#include "CompTime.h"
#include "StreamNaive.cuh"

int main(){
  StreamNaive sn(4);
  sn.start();
  sn.run();
  float dt = sn.stop();
  cout << "Computation time by using events: " << dt << " ms." << endl;

  //CompTime stopwatch;
  double wt = omp_get_wtime();
  sn.run();
  sn.setSync(deviceSync);
  cout << "Computation time by cpu time: " << (omp_get_wtime() - wt)*1e3 << " ms." << endl;

  cout << "Existing the host!\n";
  return 0;
}
