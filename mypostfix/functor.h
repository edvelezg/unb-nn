// 
//  functor.h
//  mypostfix
//  
//  Created by Eduardo Gutarra on 2008-12-16.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
// 

#ifndef _FUNCTOR_H_
#define _FUNCTOR_H_

#include <string>
#include <vector>

class functor
{
public:
	bool isOp;
	int operand;
    std::string operation;

	functor(bool isOp, int operand, std::string operation);
	functor(bool isOp, std::string operation);
	void print();
};

#endif /* _FUNCTOR_H_ */
