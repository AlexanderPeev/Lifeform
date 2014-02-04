# Makefile for GNU g++

CC=g++
CFLAGS=-g -Wall -c
LDFLAGS=
OUTPUT_OPTION=-o

WILDCARD=*

EXECUTABLE_NAME=main

OBJEXT=o
CODEEXT=cpp
HEADEREXT=hpp

LIBDIR=lib
OBJDIR=obj
CODEDIR=code
BINDIR=bin

LIB=$(LIBDIR)/$(WILDCARD).$(HEADEREXT)
SOURCES=$(CODEDIR)/$(WILDCARD).$(CODEEXT)
SOURCE_HEADERS=$(CODEDIR)/$(WILDCARD).$(HEADEREXT)
OBJECTS=$(OBJDIR)/$(WILDCARD).$(OBJEXT)
EXECUTABLE=$(BINDIR)/$(EXECUTABLE_NAME)

all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $$(find ./$(OBJDIR) -name "$(WILDCARD).$(OBJEXT)") $(OUTPUT_OPTION) $(EXECUTABLE)

$(OBJECTS): $(SOURCES)
	find ./$(LIBDIR) ./$(CODEDIR) -name "$(WILDCARD).$(CODEEXT)" | sed -e 's:^./::' -e 's:.$(CODEEXT)::' | xargs -P 0 -n 1 -I {} $(CC) $(CFLAGS) "{}.$(CODEEXT)" $(OUTPUT_OPTION) "$(OBJDIR)/{}.$(OBJEXT)" 

clean:
	rm -f $(EXECUTABLE) $(OBJECTS)