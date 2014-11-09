CXX         = clang++ -std=c++0x -stdlib=libc++
LD          = clang++ -std=c++0x -stdlib=libc++
#CXX         = g++-4.9 -std=c++11 -fsanitize=address
#LD          = g++-4.9 -std=c++11 -fsanitize=address
RM          = rm -f
CXXFLAGS    = -g -O0 -Wall -I/usr/local/Cellar/llvm/3.5.0/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS
LDLIBS      = -L/usr/local/Cellar/llvm/3.5.0/lib -lLLVM-3.5

OBJS        = llvm_asm_loader.o symbols.o usagi.o util.o value.o vmachine.o vmemory.o \
              error.o func_store.o data_store.o

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

callinfo.hpp:definitions.hpp
definitions.hpp:
error.hpp:
error.o:error.cpp error.hpp
func_store.hpp:definitions.hpp value.hpp
func_store.o:func_store.cpp func_store.hpp
llvm_asm_loader.hpp:definitions.hpp value.hpp
llvm_asm_loader.o:llvm_asm_loader.cpp error.hpp llvm_asm_loader.hpp util.hpp vmachine.hpp
data_store.hpp:
data_store.o:
symbols.hpp:
symbols.o:symbols.cpp symbols.hpp
thread.hpp:callinfo.hpp definitions.hpp value.hpp
usagi.o:usagi.cpp llvm_asm_loader.hpp
util.hpp:
util.o:util.cpp util.hpp
value.hpp:definitions.hpp
value.o:value.cpp value.hpp util.hpp
vmachine.hpp:symbols.hpp thread.hpp value.hpp vmemory.hpp
vmachine.o:vmachine.cpp callinfo.hpp error.hpp func_store.hpp util.hpp vmachine.hpp
vmemory.hpp:data_store.hpp definitions.hpp func_store.hpp
vmemory.o:vmemory.cpp error.hpp util.hpp vmemory.hpp
