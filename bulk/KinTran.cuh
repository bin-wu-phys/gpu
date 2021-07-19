#include "InitCond.cuh"

class KinTran{
private:
  InitCond *_init;
  float *_f, *_fPre;//pointers to global memory at the current and previous time steps, respectively.
  float *_fIn_d, *_fOut_d;//pointer to gloabl memory on device
  float _t, _dt;//time and time step
  int _ntot;//number of grids
  size_t _nbytes;
public:
  KinTran(InitCond*, float);
  ~KinTran();
  void nextTime();
  void output(float* f_h);//output the results to f_h on the host
};
