#!/bin/bash -ex

_pwd=`pwd`
_root=$(cd $(dirname $0)/.. && pwd)

echo $(which $CC)
echo $(which $CXX)

# Download submodules
cd ${_root}
git submodule init
git submodule update
cd ${_root}/lib/socket.io-client-cpp
git submodule init
git submodule update

# Install requirements package.
apt-get install -y automake build-essential libtool libssl-dev libboost-dev libboost-system-dev libboost-date-time-dev libboost-random-dev libffi-dev libncurses5-dev wget

if ! type python >/dev/null 2>&1; then
    apt-get install -y python
fi

if ! type npm >/dev/null 2>&1; then
    apt-get install -y npm
fi

cd ${_root}
mkdir -p tmp
mkdir -p local
export PATH=${_root}/local/bin:${PATH}
export LD_LIBRARY_PATH=${_root}/local/lib:${LD_LIBRARY_PATH}

# Compile cmake
cd ${_root}/tmp
if ! [ -e cmake-3.5.0.tar.gz ]; then
    wget https://cmake.org/files/v3.5/cmake-3.5.0.tar.gz
fi
if ! [ -e cmake-3.5.0 ]; then
    tar zxf cmake-3.5.0.tar.gz
fi
cd cmake-3.5.0
./configure --prefix=${_root}/local
make
make install

# Compile libuv
cd ${_root}/tmp
if ! [ -e libuv-v1.8.0.tar.gz ]; then
    wget http://dist.libuv.org/dist/v1.8.0/libuv-v1.8.0.tar.gz
fi
if ! [ -e libuv-v1.8.0 ]; then
    tar zxf libuv-v1.8.0.tar.gz
fi
cd libuv-v1.8.0
sh autogen.sh
./configure --prefix=${_root}/local
make
make install

ldconfig

# Edit cmake of Socket.IO C++ Client.
sed -i -e 's/set(BOOST_VER "1.55.0"/set(BOOST_VER "1.54.0"/' ${_root}/lib/socket.io-client-cpp/CMakeLists.txt

# Compile native programes.
cd ${_root}
${_root}/local/bin/cmake -DCMAKE_EXE_LINKER_FLAGS="-L${_root}/local/lib" -DUV_INCLUDE_DIRS=${_root}/local/include/ -DUV_LIBRARIES=uv -DWITH_RE2=ON -DCMAKE_BUILD_TYPE=Debug .
make
make install

# Install electron and requirement modules.
if ! type electron >/dev/null 2>&1; then
    npm -g install electron-prebuilt
fi

cd ${_root}/src/electron
if [ -e node_modules ]; then
    npm update
else
    npm install
fi

# Finish.
cd ${_pwd}

echo "Finish to build processwarp."
echo "Please input like below to run processwarp."
echo "  python <processwarp path>/script/run_gui.py"
