#include<iostream>
using namespace std;

#include "CompTime.h"
#include "StreamNaive.cuh"

int main(){
  StreamNaive sn(4);
  sn.start();
  sn.runomp();
  float dt = sn.stop();
  cout << "Computation time by using events: " << dt << " ms." << endl;

  CompTime stopwatch;
  sn.runomp();
  sn.setSync(deviceSync);
  cout << "Computation time by cpu time: " << stopwatch.getTime()*1e3 << " ms." << endl;

  cout << "Existing the host!\n";
  return 0;
}
