#include <iostream>
#include <string>
#include <stack>
#include <vector>
#include <boost/regex.hpp>

#include "functor.h"

using namespace std;

functor* addOp(functor* a, functor* b) {
	functor* c;
	int num = a->operand + b->operand;
	c = new functor(true, num, "");
	return c;
}

functor* mulOp(functor* a, functor* b) {
	functor* c;
	int num = a->operand * b->operand;
	c = new functor(true, num, "");
	return c;
}

functor* subOp(functor* a, functor* b) {
	functor* c;
	int num = a->operand - b->operand;
	c = new functor(true, num, "");
	return c;
}

void print(functor* tmp) {
	cout << tmp << " ";
}

int main (int argc, char const *argv[])
{
	std::stack<functor*> funcStack;
	std::vector<functor*> funcVec;

    functor *a, *b;                                     	// operands
	functor *func;
	std::string query = "3 8 + 6 2 + * ";
	
	boost::regex re(" ");                         			// Create the reg exp
    boost::sregex_token_iterator                  			// Create an iterator using a
        p(query.begin( ), query.end( ), re, -1);  			// sequence and that reg exp
    boost::sregex_token_iterator end;             			// Create an end-of-reg-exp

    string first;

    while( p != end)
    {
        first = *p++;
        if (first != "+" && first != "-" && first != "*")
        {
			func = new functor(true, strtol(first.c_str(),NULL,10), "");
			funcVec.push_back(func);
        }
		else 
		{
			if (first == "+") 
			{
				func = new functor(false, "+");
				funcVec.push_back(func);
			}
			else if (first == "-") 
			{
				func = new functor(false, "-");
				funcVec.push_back(func);
			}
			else
			{
				func = new functor(false, "*");
				funcVec.push_back(func);
			}
		}
	}
		
	for(size_t i = 0; i < funcVec.size(); ++i)
	{
		func = funcVec[i];
		func->print();
	}	
	cout << endl;

	for(size_t i = 0; i < funcVec.size(); ++i)
	{
		cout << "funcVec.size(): " << funcVec.size() << endl;
		func = funcVec[i];
		if(func->isOp == true)
		{
			funcStack.push(func);
		}
		else {
			b = funcStack.top();
			funcStack.pop();
			a = funcStack.top();
			funcStack.pop();
			if (func->operation == "+") 
			{
				funcStack.push(addOp(a,b));
			}
			else if (func->operation == "-") 
			{
				funcStack.push(subOp(a,b));
			}
			else
			{
				funcStack.push(mulOp(a,b));
			}
		}
	}
	cout << "The result is: " << endl;
	functor* tmp = funcStack.top();
	cout << "tmp->operand: " << tmp->operand << endl;
	
    return 0;
}


