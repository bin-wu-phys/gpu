#include <cuda_runtime.h>

enum _sync {deviceSync, streamSync};

class StreamNaive{
private:
  int _n;//# of streams
  cudaStream_t *_streams;
  cudaEvent_t _start, _stop;
public:
  StreamNaive(int);
  ~StreamNaive();

  void setSync(_sync);
  void start();
  float stop();

  //Streams and events
  void run();
  
  //blocking streams
  void runBlock();
};
