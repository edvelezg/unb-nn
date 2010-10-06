#ifndef _MYNN_H_
#define _MYNN_H_

#include <stdio.h>
#include <iostream>
#include <math.h>
#include <vector.h>

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
