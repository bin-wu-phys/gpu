#define CUDA_STATUS(value){\
  cudaError_t _m_cudaStat = value;\
  if ( _m_cudaStat != cudaSuccess ){\
    fprintf( stderr , "Error %s at line %d in file %s \n", cudaGetErrorString(_m_cudaStat), __LINE__, __FILE__);\
    exit(1);\
  }\
}

