class Lattice{
 private:
  int _nr, _nphit, _npt, _nvzt;//number of r, \tilde{phi}_r, \tilde{p} and \tilde{v}_z
  float _rMax, _pMax, _vMax;//the max values for setting up r, p and vzt
  float *_r, *_phit, *_pt, *_vzt;//grids of r, \tilde{phi}_r, \tilde{p} and \tilde{v}_z
  float _t0;//The relation of the ordinary coordinates to these coordinates depends on _t0
 public:
  Lattice(int, int, int, int, float = 3.0f, float = 3.0f, float = 10.0f);
  ~Lattice();
  void calc();

  void set_t0(float);
  float get_t0();
  
  int get_nr();
  int get_nphit();
  int get_npt();
  int get_nvzt();
  float get_r(int);
  float get_phit(int);
  float get_pt(int);
  float get_vzt(int);

  //float get_phi(float t, );
  //float get_p(float t);
  //float get_vz(float t, float vzt);

  void toConstMem(const void*, const void*, const void*, const void*);

};
