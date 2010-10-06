CC=g++
CFLAGS=-c -Wall
LDFLAGS=
SOURCES=ex1.cpp
OBJECTS=$(SOURCES:.cpp=.o)
EXECUTABLE=ex1

all: $(SOURCES) $(EXECUTABLE)
	
$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@

