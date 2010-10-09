#ifndef _MYNN_H_
#define _MYNN_H_

#include <stdio.h>
#include <iostream>
#include <math.h>
#include <vector>

class neuron {
public:
    neuron();
    vector<int> weights;
    int compute_sum (vector <int> &input);
};

class layer
{
public:
    layer();
    vector <neuron> nrns;
    vector<int> compute_layer (vector <int> &input);
};

#endif /*_MYNN_H_*/

C:\Users\Viper\Documents\UNB-Courses\NN\mynn>"C:\Program Files\SlickEditV15.0.1\win\vsbuild" -signal 51226 -command make -f "Makefile" CFG=Debug
VSLICKERRORPATH="C:\Users\Viper\Documents\UNB-Courses\NN\mynn"
make -f Makefile CFG=Debug 
g++ -c    -g -o "Debug/mynn.o"  "mynn.cpp"
In file included from mynn.cpp:1:
mynn.h:12: error: ISO C++ forbids declaration of `vector' with no type
mynn.h:12: error: expected `;' before '<' token
mynn.h:13: error: `vector' has not been declared
mynn.h:13: error: expected `,' or `...' before '<' token
mynn.h:13: error: ISO C++ forbids declaration of `parameter' with no type
mynn.h:20: error: ISO C++ forbids declaration of `vector' with no type
mynn.h:20: error: expected `;' before '<' token
mynn.h:21: error: ISO C++ forbids declaration of `vector' with no type
mynn.h:21: error: expected `;' before '<' token
mynn.cpp: In function `int main(int, char**)':
mynn.cpp:23: error: 'class layer' has no member named 'compute_layer'
mynn.cpp: In constructor `neuron::neuron()':
mynn.cpp:34: error: `weights' was not declared in this scope
mynn.cpp: At global scope:
mynn.cpp:41: error: prototype for `int neuron::compute_sum(std::vector<int, std::allocator<int> >&)' does not match any in class `neuron'
mynn.h:13: error: candidate is: int neuron::compute_sum(int)
mynn.cpp: In member function `int neuron::compute_sum(std::vector<int, std::allocator<int> >&)':
mynn.cpp:43: error: `weights' was not declared in this scope
mynn.cpp: In constructor `layer::layer()':
mynn.cpp:59: error: `nrns' was not declared in this scope
mynn.cpp: At global scope:
mynn.cpp:65: error: no `std::vector<int, std::allocator<int> > layer::compute_layer(std::vector<int, std::allocator<int> >&)' member function declared in class `layer'
mynn.cpp: In member function `std::vector<int, std::allocator<int> > layer::compute_layer(std::vector<int, std::allocator<int> >&)':
mynn.cpp:67: error: `nrns' was not declared in this scope
make: *** [Debug/mynn.o] Error 1


