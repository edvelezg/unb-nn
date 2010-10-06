#ifndef _MYNN_H_
#define _MYNN_H_

#include <stdio.h>
#include <iostream>
#include <math.h>
#include <vector.h>

class neuron {
public:
    vector <int> weights;
    neuron();
    int compute_sum (vector <int> &input);
};

class layer
{
public:
    vector <neuron> nrns;
};

#endif /*_MYNN_H_*/
