enum LattType{LT_r, LT_phit, LT_pt, LT_vzt};

class Lattice{
 private:
  int _nr, _nphit, _npt, _nvzt;//number of r, \tilde{phi}_r, \tilde{p} and \tilde{v}_z
  float _rMax, _pMax, _vMax;//the max values for setting up r, p and vzt
  float *_r, *_phit, *_pt, *_vzt;//grids of r, \tilde{phi}_r, \tilde{p} and \tilde{v}_z
 public:
  Lattice(int, int, int, int, float, float, float);
  void calc();
  ~Lattice();

  void toConstMem(const void*, const void*, const void*, const void*);

  int get_nr();
  int get_nphit();
  int get_npt();
  int get_nvzt();
  float get_r(int);
  float get_phit(int);
  float get_pt(int);
  float get_vzt(int);
};
