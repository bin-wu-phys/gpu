#include "InitCond.cuh"

class KinTran{
private:
  float *_f, *_fPre;//pointers to global memory at the current and previous time steps, respectively.
  float _t, _dt;//time and time step
  int _ntot;//number of grids
  size_t _nbytes;
  Lattice *_latt;
public:
  KinTran(InitCond*, float);
  ~KinTran();
  void nextTime();
  void output(float* f_h);//output the results to f_h on the host
};
