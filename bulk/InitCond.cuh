#include "Lattice.cuh"

class InitCond{
private:
  float _t0;
  float _n0;//initial number density at _r=0
  float * _f0;
public:
  Lattice *_latt;
  InitCond(float, Lattice*, float=3.0);
  ~InitCond();
  void calc();//generate the initial condition _f0
  float Fbg(float r, float phir);//radial profile
  float Fp(float);//the initial p-distribution
  float Fv(float);//the initial v_z distribution

  void toGlobalMem(float*);//copy _f0 to global memeory
};
