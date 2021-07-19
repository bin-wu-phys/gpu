class Kernel{
private:
  float _alphaS;
public:
  __device__ __host__ Kernel(float=0.3);
  __device__ __host__ float Cr();
};
