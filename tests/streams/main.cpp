#include<iostream>
using namespace std;

#include "CompTime.h"
#include "StreamNaive.cuh"

int main(){
  StreamNaive sn(4);
  sn.setSync(false);
  sn.start();
  sn.run();
  float dt = sn.stop();
  cout << "Computation time by using events: " << dt << " ms." << endl;

  CompTime stopwatch;
  sn.setSync(true);
  sn.run();
  cout << "Computation time by cpu time: " << stopwatch.getTime()*1e3 << " ms." << endl;

  cout << "Existing the host!\n";
  return 0;
}
