
RM          = rm -f

OBJS        = llvm_asm_loader.o symbols.o usagi.o util.o vmachine.o vmemory.o \
              error.o func_store.o data_store.o type_store.o server.o xmpp.o convert.o \
              stackinfo.o type_based.o intrinsic_libc.o intrinsic_memory.o \
              intrinsic_posix.o intrinsic_va_arg.o

TARGETS     = usagi

default:
	echo "You should select a target platform."

all:$(TARGETS)

check-syntax:
	$(CXX) -Wall -Wextra -pedantic -fsyntax-only $(CHK_SOURCES)

clean:
	$(RM) *.o *~ $(TARGETS)

gtags:
	gtags -v

linux:
	$(MAKE) all \
	CXX="g++ -std=c++11" \
	LD="g++ -std=c++11" \
	CXXFLAGS="-g -O0 -Wall -I/usr/local/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS `pkg-config gloox --cflags`" \
	LDLIBS="-L/usr/local/lib -lLLVMAsmParser -lLLVMCore -lLLVMSupport -lcurses -ldl -lpthread -lffi `pkg-config gloox --libs`"

macosx:
	$(MAKE) all \
	CXX="clang++ -std=c++0x -stdlib=libc++" \
	LD="clang++ -std=c++0x -stdlib=libc++" \
	CXXFLAGS="-g -O0 -Wall -I/usr/include/ffi -I/usr/local/Cellar/llvm/3.5.1/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS `pkg-config gloox --cflags`" \
	LDLIBS="-L/usr/local/Cellar/llvm/3.5.1/lib -lLLVM-3.5 -lffi `pkg-config gloox --libs`"

usagi:$(OBJS)
	$(LD) -o $@ $^ $(LDLIBS)

.cpp.o:
	$(CXX) $(CXXFLAGS) -c $<

.PHONY:check-syntax clean default gtags

convert.hpp:definitions.hpp
convert.o:convert.cpp 
definitions.hpp:
error.hpp:
error.o:error.cpp error.hpp
func_store.hpp:definitions.hpp symbols.hpp
func_store.o:func_store.cpp func_store.hpp
intrinsic_libc.hpp:definitions.hpp
intrinsic_libc.o:intrinsic_libc.cpp intrinsic_libc.hpp vmachine.hpp
intrinsic_memory.hpp:definitions.hpp
intrinsic_memory.o:intrinsic_memory.cpp intrinsic_memory.hpp vmachine.hpp
intrinsic_posix.hpp:definitions.hpp
intrinsic_posix.o:intrinsic_posix.cpp intrinsic_posix.hpp vmachine.hpp
intrinsic_va_arg.hpp:definitions.hpp
intrinsic_va_arg.o:intrinsic_va_arg.cpp intrinsic_va_arg.hpp vmachine.hpp
llvm_asm_loader.hpp:definitions.hpp
llvm_asm_loader.o:llvm_asm_loader.cpp error.hpp instruction.hpp llvm_asm_loader.hpp util.hpp vmachine.hpp
data_store.hpp:definitions.hpp
data_store.o:
server.hpp:definitions.hpp vmachine.hpp xmpp.hpp
server.o:server.cpp convert.hpp error.hpp llvm_asm_loader.hpp server.hpp
stackinfo.hpp:definitions.hpp type_based.hpp
stackinfo.o:data_store.hpp func_store.hpp stackinfo.hpp
symbols.hpp:
symbols.o:symbols.cpp symbols.hpp
thread.hpp:definitions.hpp stackinfo.hpp
type_store.hpp:definitions.hpp
type_store.o:type_store.cpp error.hpp type_store.hpp util.hpp
type_based.hpp:definitions.hpp
type_based.o:type_based.cpp error.hpp type_based.hpp type_store.hpp util.hpp
usagi.o:usagi.cpp error.hpp llvm_asm_loader.hpp server.hpp vmachine.hpp
util.hpp:definitions.hpp
util.o:util.cpp util.hpp instruction.hpp
vmachine.hpp:error.hpp symbols.hpp thread.hpp vmemory.hpp
vmachine.o:vmachine.cpp error.hpp func_store.hpp instruction.hpp intrinsic_libc.hpp intrinsic_memory.hpp intrinsic_posix.hpp stackinfo.hpp type_based.hpp util.hpp vmachine.hpp
vmemory.hpp:data_store.hpp definitions.hpp func_store.hpp type_store.hpp
vmemory.o:vmemory.cpp error.hpp util.hpp vmemory.hpp
xmpp.hpp:
xmpp.o:xmpp.cpp util.hpp xmpp.hpp
