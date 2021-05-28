#include <ctime>
using namespace std;

class CompTime{
private:
  clock_t _tStart;
public:
  CompTime();
  void reset();
  float getTime();
};
