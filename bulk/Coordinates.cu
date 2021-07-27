#include "Coordinates.cuh"


__device__ __host__ Coordinates::Coordinates(float t0){
  _t0 = t0; _t = _t0;
}

__device__ __host__ Coordinates::Coordinates(float t0, float t){
  _t0 = t0; _t = t;
}

__device__ __host__ void Coordinates::set_t(float t){
  _t = t;
}

__device__ __host__ void Coordinates::calc(float r, float phirt, float pt, float vzt){
  float vzt2 = vzt*vzt;
  float pcon = sqrtf(vzt2 + (1.0 - vzt2)*_t*_t/(_t0*_t0));
  
  _tg = tanf(0.5*phirt)*expf(-_t0*(pcon - 1.0)/(r*sqrtf(1.0-vzt2)));
  _p = pt*pcon; _vz = vzt*_t0/(_t*pcon);
}

__device__ __host__ float Coordinates::cos_phir(){
  return (1.0-_tg*_tg)/(1.0+_tg*_tg);
}

__device__ __host__ float Coordinates::sin_phir(){
  return 2.0*_tg/(1.0+_tg*_tg);
}

