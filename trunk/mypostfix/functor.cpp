// 
//  functor.cpp
//  mypostfix
//  
//  Created by Eduardo Gutarra on 2008-12-16.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
// 

#include <iostream>
#include "functor.h"

using namespace std;

functor::functor(bool isOp, int operand, std::string operation) 
{
	this->isOp      = isOp;
	this->operand   = operand;
	this->operation = operation;
}

functor::functor(bool isOp, std::string operation) 
{
	this->isOp      = isOp;
	this->operation = operation;
}

void functor::print()
{
	if (this->isOp)
	{
		cout << this->operand << " ";
	}
	else
	{
		cout << this->operation << " ";
	}
}
