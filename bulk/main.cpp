#include <iostream>
using namespace std;

#include "bulk.cuh"
#define N 10000

int main(){
  float f0[N], f[N]; f[5] = 0.1;
  float t0 = 0.1, dt =0.0;
  cout << "f0:" << endl;
  for(int i=0;i<N;i++){
    f0[i] = (float) i;
  }
  cout << 5 << ", " << f0[5] << endl;
  bulk bk(f0, t0, dt, N);
  bk.nextTime();
  cout << 5 << ", " << f[5] << endl;
  bk.output(f);
  cout << "f:" << endl;
  //for(int i=0;i<N;i++)
  cout << 5 << ", " << f[5] << endl;
  return 0;
}
