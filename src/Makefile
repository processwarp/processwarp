CXX         = clang++ -std=c++0x -stdlib=libc++
LD          = clang++ -std=c++0x -stdlib=libc++
#CXX         = g++-4.9 -std=c++11 -fsanitize=address
#LD          = g++-4.9 -std=c++11 -fsanitize=address
#CXX        = g++ -std=c++11 -fpermissive
#LD         = g++ -std=c++11
RM          = rm -f
CXXFLAGS    = -g -O0 -Wall -I/usr/local/Cellar/llvm/3.5.0/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS `pkg-config gloox --cflags`
LDLIBS      = -L/usr/local/Cellar/llvm/3.5.0/lib -lLLVM-3.5 -lffi `pkg-config gloox --libs`
#CXXFLAGS    = -g -O0 -Wall -I/usr/local/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS `pkg-config gloox --cflags`
#LDLIBS      = -L/usr/local/lib -lLLVMAsmParser -lLLVMCore -lLLVMSupport -lcurses -ldl -lpthread -lffi `pkg-config gloox --libs`

OBJS        = llvm_asm_loader.o symbols.o usagi.o util.o vmachine.o vmemory.o \
              error.o func_store.o data_store.o type_store.o server.o xmpp.o convert.o \
              stackinfo.o type_based.o

TARGETS     = usagi

all:$(TARGETS)

check-syntax:
	$(CXX) -Wall -Wextra -pedantic -fsyntax-only $(CHK_SOURCES)

clean:
	$(RM) *.o *~ $(TARGETS)

gtags:
	gtags -v

usagi:$(OBJS)
	$(LD) -o $@ $^ $(LDLIBS)

.cpp.o:
	$(CXX) $(CXXFLAGS) -c $<

.PHONY:check-syntax clean gtags

convert.hpp:definitions.hpp
convert.o:convert.cpp 
definitions.hpp:
error.hpp:
error.o:error.cpp error.hpp
func_store.hpp:definitions.hpp symbols.hpp
func_store.o:func_store.cpp func_store.hpp
llvm_asm_loader.hpp:definitions.hpp
llvm_asm_loader.o:llvm_asm_loader.cpp error.hpp instruction.hpp llvm_asm_loader.hpp util.hpp vmachine.hpp
data_store.hpp:definitions.hpp
data_store.o:
server.hpp:definitions.hpp vmachine.hpp xmpp.hpp
server.o:server.cpp convert.hpp llvm_asm_loader.hpp server.hpp
stackinfo.hpp:definitions.hpp type_based.hpp
stackinfo.o:data_store.hpp func_store.hpp stackinfo.hpp
symbols.hpp:
symbols.o:symbols.cpp symbols.hpp
thread.hpp:definitions.hpp stackinfo.hpp
type_store.hpp:definitions.hpp
type_store.o:type_store.cpp error.hpp type_store.hpp util.hpp
type_based.hpp:definitions.hpp
type_based.o:type_based.cpp type_based.hpp
usagi.o:usagi.cpp error.hpp llvm_asm_loader.hpp server.hpp vmachine.hpp
util.hpp:definitions.hpp
util.o:util.cpp util.hpp instruction.hpp
vmachine.hpp:error.hpp symbols.hpp thread.hpp vmemory.hpp
vmachine.o:vmachine.cpp error.hpp func_store.hpp instruction.hpp stackinfo.hpp type_based.hpp util.hpp vmachine.hpp
vmemory.hpp:data_store.hpp definitions.hpp func_store.hpp type_store.hpp
vmemory.o:vmemory.cpp error.hpp util.hpp vmemory.hpp
xmpp.hpp:
xmpp.o:xmpp.cpp util.hpp xmpp.hpp
