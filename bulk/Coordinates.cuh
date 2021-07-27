class Coordinates{
private:
  float _t0, _t;
  float _tg, _p, _vz;//_tg = tan(phir/2)
public:
  __device__ __host__ Coordinates(float);
  __device__ __host__ Coordinates(float, float);
  __device__ __host__ void set_t(float);
  __device__ __host__ void calc(float, float, float, float);

  __device__ __host__ float sin_phir();
  __device__ __host__ float cos_phir();
};
