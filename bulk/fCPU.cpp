#include "fCPU.h"

fCPU::fCPU(float* fIn_h, float* fOut_h, float t, float dt, unsigned int ntot){
  _fIn_h = fIn_h; _fOut_h = fOut_h; _ntot = ntot;
  _C_h = new float[_ntot]; _t = t; _dt = dt;
 }

fCPU::~fCPU()
{
  delete [] _C_h;
}

void fCPU::calcKernel(){
  for(int i=0;i<_ntot;i++){
    _C_h[i] = _fIn_h[i];
    /*_C_h[i] = 0.0;
    for(int j=0;j<_ntot;j++){
      _C_h[i]+=_fIn_h[j]*_fIn_h[j]*_fIn_h[j]*_fIn_h[j];
    }
    */
  }
}

void fCPU::nextTime(){
  calcKernel();
  for(int i=0;i<_ntot;i++){
    _fOut_h[i] = _fIn_h[i] + _dt*_C_h[i];
  }
}
