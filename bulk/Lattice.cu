#include <iostream>
#include <cmath>
using namespace std;

#include "Lattice.cuh"
#include "macros.h"

Lattice::Lattice(int nr, int nphit, int npt, int nvzt, float rMax, float pMax, float vMax){
  _nr = nr; _nphit = nphit; _npt = npt; _nvzt = nvzt;
  _rMax = rMax; _pMax = pMax; _vMax = vMax;
  
  _r = new float[_nr]; _phit = new float[_nphit];
  _pt = new float[_npt]; _vzt = new float[_nvzt];

  calc();
}

void Lattice::set_t0(float t0){
  _t0 = t0;
}

float Lattice::get_t0(){
  return _t0;
}

void Lattice::calc(){
  float dl = _rMax/((float)(_nr - 1.0));

  for(int i=1; i<=_nr; i++){
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

int Lattice::get_nr(){
  return _nr;
}

int Lattice::get_nphit(){
  return _nphit;
}

int Lattice::get_npt(){
  return _npt;
}

int Lattice::get_nvzt(){
  return _nvzt;
}

float Lattice::get_r(int i){
  if(i>=0 && i<_nr){
    return _r[i];
  }
  else{
    cout << "Error at line " << __LINE__ << " in file " << __FILE__ << ":\n";
    cout << "The index of Lattice::_r has to be in the range [0, " << _nr -1 << "]." << endl;
    exit(EXIT_FAILURE);
  }
}

float Lattice::get_phit(int i){
  if(i>=0 && i<_nphit){
    return _phit[i];
  }
  else{
    cout << "Error at line " << __LINE__ << " in file " << __FILE__ << ":\n";
    cout << "The index of Lattice::_phit has to be in the range [0, " << _nphit -1 << "]." << endl;
    exit(EXIT_FAILURE);
  }
}

float Lattice::get_pt(int i){
  if(i>=0 && i<_npt){
    return _pt[i];
  }
  else{
    cout << "Error at line " << __LINE__ << " in file " << __FILE__ << ":\n";
    cout << "The index of Lattice::_pt has to be in the range [0, " << _npt -1 << "]." << endl;
    exit(EXIT_FAILURE);
  }
}

float Lattice::get_vzt(int i){
  if(i>=0 && i<_nvzt){
    return _vzt[i];
  }
  else{
    cout << "Error at line " << __LINE__ << " in file " << __FILE__ << ":\n";
    cout << "The index of Lattice::_vzt has to be in the range [0, " << _nvzt -1 << "]." << endl;
    exit(EXIT_FAILURE);
  }
}


void Lattice::toConstMem(const void* rc, const void* phitc, const void* ptc, const void* vztc){
  CUDA_STATUS(cudaMemcpyToSymbol(rc, _r, _nr*sizeof(float)));
  CUDA_STATUS(cudaMemcpyToSymbol(phitc, _phit, _nphit*sizeof(float)));
  CUDA_STATUS(cudaMemcpyToSymbol(ptc, _pt, _npt*sizeof(float)));
  CUDA_STATUS(cudaMemcpyToSymbol(vztc, _vzt, _nvzt*sizeof(float)));
}
