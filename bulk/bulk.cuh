class bulk{
private:
  float *_fIn_d, *_fOut_d;//pointer to gloabl memory on device
  float _t0, _t, _dt;//time and time step
  int _nx, _nphi, _npT, _npz, _ntot;//number of grids
  size_t _nbytes;
public:
  bulk(float* f0_h, float t0, float dt, int nx, int nphi, int npT, int npz);//initialize using pointer on the host
  ~bulk();
  void nextTime();
  void output(float* f_h);//output the results to f_h on the host
};
