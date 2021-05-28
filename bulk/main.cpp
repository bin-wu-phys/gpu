#include <iostream>
using namespace std;

#include "bulk.cuh"
#define N 10000

int main(){
  float f0[N], f[N];
  float t0 = 0.1, dt =1.0;
  cout << "f0:" << endl;
  for(int i=0;i<N;i++){
    f0[i] = (float) i;
  }

  bulk bk(f0, t0, dt, N);

  cout << "Entering nextTime:\n";
  bk.nextTime();
  
  cout << "Entering output:\n";
  bk.output(f);
  cout << "In main, after output:" << endl;
  for(int i=0;i<5;i++)
    cout << i << ", " << f[i] << endl;
  return 0;
}
