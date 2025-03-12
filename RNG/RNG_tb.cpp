
#include "RNG.h"
#include <iostream>

int main(void){

    float randFloatTest = 0;
    unsigned seed = 94;
    RNG(seed, randFloatTest);

    std::cout << "Pseudo random generated with HLS: " << randFloatTest << std::endl;

    return 0;
}