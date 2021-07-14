/*This is used to test class Lattice.*/
#include "Lattice.cu"
#define NR 32
#define NPHI 21
#define NP 16
#define NV 64

__constant__ float rc[NR], phic[NPHI], pc[NP], vc[NV];

__global__ void read(){

  printf("r = ");
  for(int i=0; i<NR; i++){
    printf("%f ", rc[i]);
  }

  printf("\n\n");

  printf("phi = ");
  for(int i=0; i<NPHI; i++){
    printf("%f ", phic[i]);
  }

  printf("\n\n");

  printf("p = ");
  for(int i=0; i<NP; i++){
    printf("%f ", pc[i]);
  }

  printf("\n\n");

  printf("vz = ");
  for(int i=0; i<NV; i++){
    printf("%f ", vc[i]);
  }
}

int main(){
  Lattice latt(NR, NPHI, NP, NV, 3.0f, 3.0f, 15.0f);
  latt.toConstMem(rc, phic, pc, vc);

  cout << "r = ";
  for(int i=0; i< NR; i++){
    cout << latt.get_r(i) << " ";
  }
  cout << endl;

  cout << "phi = ";
  for(int i=0; i< NPHI; i++){
    cout << latt.get_phit(i) << " ";
  }
  cout << endl;
  
  cout << "p = ";
  for(int i=0; i< NP; i++){
    cout << latt.get_pt(i) << " ";
  }
  cout << endl;
  
  cout << "vz = ";
  for(int i=0; i< NV; i++){
    cout << latt.get_vzt(i) << " ";
  }
  cout << endl;

  read<<<1,1>>>();
  CUDA_STATUS(cudaDeviceReset()); 
  return 0;
}
