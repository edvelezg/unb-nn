# 
#  Makefile
#  postfix-class
#  
#  Created by Eduardo Gutarra on 2008-12-15.
#  Copyright 2008 __MyCompanyName__. All rights reserved.
# 

TARGET = postfix
OBJ    = postfix.o functor.o

CXXFLAGS = -I/opt/boost-1.37.0/include/boost-1_37 -gstabs
LDFLAGS = -L/opt/boost-1.37.0/lib -lboost_regex-xgcc40-mt-1_37

$(TARGET) : $(OBJ)
	g++ $(CXXFLAGS) $(LDFLAGS) -o $@ $^
	
clean:
	$(RM) -rf $(OBJ) $(TARGET)
