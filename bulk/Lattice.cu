#include <iostream>
#include <cmath>
using namespace std;

#include "Lattice.cuh"
#define PI 3.14159265
#include "macros.h"

Lattice::Lattice(int nr, int nphit, int npt, int nvzt, float rMax = 3.0f, float pMax = 3.0f, float vMax = 10.0f){
  _nr = nr; _nphit = nphit; _npt = npt; _nvzt = nvzt;
  _rMax = rMax; _pMax = pMax; _vMax = vMax;
  
  _r = new float[_nr]; _phit = new float[_nphit];
  _pt = new float[_npt]; _vzt = new float[_nvzt];

  calc();
}

void Lattice::calc(){
  float dl = _rMax/((float)(_nr - 1.0));

  for(int i=0; i<_nr; i++){
    _r[i] = dl*i;
    //cout << _r[i] << " ";
  }

  //cout << endl;

  dl = PI/((float)(_nphit - 1.0));

  for(int i=0; i<_nphit; i++){
    _phit[i] = dl*i;
    //cout << _phit[i] << " ";
  }

  //cout << endl;

  dl = _pMax/((float)(_npt - 1.0));

  for(int i=0; i<_npt; i++){
    _pt[i] = dl*i;
    //cout << _pt[i] << " ";
  }

  //cout << endl;

  dl = _vMax/((float)(_nvzt - 1.0));

  for(int i=0; i<_nvzt; i++){
    _vzt[i] = expl(dl*i);
    _vzt[i] = (_vzt[i] - 1.0)/(_vzt[i] + 1.0);
    //cout << _vzt[i] << " ";
  }

}

Lattice::~Lattice(){
  //The standard form of operator delete[] will take only one parameter.
  delete [] _r; delete [] _phit; delete [] _pt; delete [] _vzt;
}

void Lattice::toConstMem(const void* rc, const void* phitc, const void* ptc, const void* vztc){
  CUDA_STATUS(cudaMemcpyToSymbol(rc, _r, _nr*sizeof(float)));
  CUDA_STATUS(cudaMemcpyToSymbol(phitc, _phit, _nphit*sizeof(float)));
  CUDA_STATUS(cudaMemcpyToSymbol(ptc, _pt, _npt*sizeof(float)));
  CUDA_STATUS(cudaMemcpyToSymbol(vztc, _vzt, _nvzt*sizeof(float)));
}

