#include<iostream>
using namespace std;

#include "StreamNaive.cuh"

int main(){
  StreamNaive sn(4);
  sn.run();

  cout << "Existing the host!\n";
  return 0;
}
