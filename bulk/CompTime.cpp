#include "CompTime.h"

CompTime::CompTime(){
  reset();
}

void CompTime::reset(){
  _tStart = clock();
}

float CompTime::getTime(){
  return ((float)(clock() - _tStart))/CLOCKS_PER_SEC;
}
