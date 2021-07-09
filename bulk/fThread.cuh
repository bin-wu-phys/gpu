/*
The class for f at point i in the (discretized) phase space.
*/

class fThread{
private:
  float _t, _dt;//time and time step
  float* _fIn_d, *_fOut_d;//pointers to the distribution function in global memory
  float _fNext; //fi at _t + _dt 
  int _idx;//mapping (threadIdx, blockIdx) to _idx as a function of (x,p)
  int _ntot;//the dimension of the input f
  float _alphaS;//alpha strong
  float _agg2gg;//the effective coupling for gg<->gg
public:
  __device__ fThread(float *, float *, float, float, float = 0.3);//intialize *_f, _t, _dt 
  __device__ int getIdx();//calculate _idx from threadIdx and blockIdx;
  __device__ void update();//replace _f at _idx
  __device__ float getC();//calculate the kernel at i
  __device__ float Mgg2gg(float, float, float);//calculate the kernel at i
  __device__ void nextTime();//calculate _f[_idx] at _t + _dt
  __device__ void print();
  __device__ void setntot(int);
  __device__ void setAlphaS(float alphaS);
  
};
