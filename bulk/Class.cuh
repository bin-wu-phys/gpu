class Kernel{
private:
  float _alphaS;
public:
  __device__ __host__ Kernel(float);
  __device__ __host__ float Cr();
};
