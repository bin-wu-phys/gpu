class fCPU{
private:
  float _t, _dt;//time and time step
  unsigned int _ntot;//number of grid points of f
  float* _fIn_h, *_fOut_h, *_C_h;//pointers to the distribution functions and the kernel.
public:
  fCPU(float *, float *, float, float, unsigned int);//intialize *_f, _t, _dt
  ~fCPU();
  void calcKernel();//calculate the kernel at i
  void nextTime();//calculate _f[_idx] at _t + _dt

};
