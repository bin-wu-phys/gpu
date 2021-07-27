#include "Lattice.cuh"

class InitCond{
private:
  float _tInit;//Here, _tInit is not necessarily the same as _t0.
  float _nInit;//initial number density at _tInit
  float * _fInit;
public:
  Lattice *_latt;
  InitCond(float, Lattice*, float = 3.0);
  ~InitCond();
  void calc();//generate the initial condition _f0
  float Fbg(float r, float phir);//radial profile
  float Fp(float);//the initial p-distribution
  float Fv(float);//the initial v_z distribution

  void toGlobalMem(float*);//copy _f0 to global memeory

  float get_tInit();
};
