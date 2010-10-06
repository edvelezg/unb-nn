#include "MyNN.h"
#include <stdio.h>
#include <iostream>
#include <math.h>
#include <vector>

using namespace std;

int main (int argc, char *argv[])
{
    vector <int> inputs;
    vector <int> sums; 

    inputs.push_back(3);
    inputs.push_back(3);
    inputs.push_back(3);
    inputs.push_back(3);

    neuron n1;
    neuron n2;
    neuron n3;

    layer l1;

    l1.nrns.push_back(n1);
    l1.nrns.push_back(n2);
    l1.nrns.push_back(n3);

    for (int x = 0; x < l1.nrns.size(); ++x)
    {
        for (int ii = 0; ii < l1.nrns[x].weights.size(); ++ii) {
            cout << l1.nrns[x].weights[ii] << " ";
        }
        n1.compute_sum(inputs);
    }

    return(0);
}

neuron::neuron()
{
    weights.push_back(20);
    weights.push_back(20);
    weights.push_back(20);
    weights.push_back(20);
}


int neuron::compute_sum(vector <int> &input)
{
    int sum = 0;
    for (int i = 0; i < weights.size(); ++i)
    {
        sum += weights[i]*input[i];
    }
    cout << "sum: " << sum << endl;
    cout << endl;
    return sum;
}
