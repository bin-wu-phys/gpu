#include <iostream>
using namespace std;

#include <cmath>
#include "InitCond.cuh"
#include "macros.h"

InitCond::InitCond(float tInit, Lattice* latt, float n0){
  _tInit = tInit; _latt = latt; _n0 = 0.5*n0/(PI*PI);
  _f0 = new float[_latt->get_nr()*_latt->get_nphit()*_latt->get_npt()*_latt->get_nvzt()];

  calc();
}

InitCond::~InitCond(){
  delete [] _f0;
}

float InitCond::Fbg(float r, float phir){
  return expf(-r*r);
}

float InitCond::Fp(float p){
  return 2.7305088f/(expf((p-1.0)/0.1) + 1.0);
}

float InitCond::Fv(float v){
  return 0.5;
}

void InitCond::calc(){
  int idx0, idx1, idx2, idx;
  for(int ir=0; ir<_latt->get_nr(); ir++){
    idx0 = ir;
    for(int iphi=0; iphi<_latt->get_nphit(); iphi++){
      idx1 = _latt->get_nphit()*idx0 + iphi;
      for(int ip=0; ip<_latt->get_npt(); ip++){
	idx2 = _latt->get_npt()*idx1 + ip;
	for(int iv=0; iv<_latt->get_nvzt(); iv++){
	  idx = _latt->get_nvzt()*idx2 + iv;
	  _f0[idx] = _n0*Fbg(_latt->get_r(ir), _latt->get_phit(iphi))*Fp(_latt->get_pt(ip))*Fv(_latt->get_vzt(iv));
	}
      }
    }
  }
}

void InitCond::toGlobalMem(float* f0_d){
  size_t nBytes = _latt->get_nr()*_latt->get_nphit()*_latt->get_npt()*_latt->get_nvzt()*sizeof(float);
  CUDA_STATUS(cudaMemcpy(f0_d, _f0, nBytes, cudaMemcpyHostToDevice));
}

float InitCond::get_tInit(){
  return _tInit;
}
