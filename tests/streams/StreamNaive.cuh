#include <cuda_runtime.h>

class StreamNaive{
private:
  int _n;//# of streams
  cudaStream_t *_streams;
public:
  StreamNaive(int);
  ~StreamNaive();

  void run();
};
