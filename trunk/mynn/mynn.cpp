#include "mynn.h"
#include <stdio.h>
#include <iostream>
#include <math.h>

using namespace std;


//vector<int> compute_layer(vector <int> &input);

int main (int argc, char *argv[])
{
    vector <int> inputs;
    vector <int> sums; 

    inputs.push_back(3);
    inputs.push_back(3);
    inputs.push_back(3);
    inputs.push_back(3);

    layer l1;
    sums = l1.compute_layer(inputs);

    for (int i = 0; i < sums.size(); ++i)
    {
        cout << "sums: " << sums[i] << endl;
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


layer::layer()
{
    neuron n1;
    neuron n2;
    neuron n3;

    nrns.push_back(n1);
    nrns.push_back(n2);
    nrns.push_back(n3);
}

vector<int> layer::compute_layer(vector <int> &input)
{
    vector<int> output;
    for (int x = 0; x < nrns.size(); ++x)
    {
        output.push_back(nrns[x].compute_sum(input));
    }
    return output;
}
