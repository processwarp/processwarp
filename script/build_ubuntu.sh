#!/bin/bash -eu

_pwd=`pwd`
_root=$(cd $(dirname $0)/.. && pwd)

# Install requirements package.
sudo apt-get install -y automake libtool libssl-dev libboost-dev libboost-system-dev libboost-date-time-dev libboost-random-dev libffi-dev wget

if ! type clang >/dev/null 2>&1; then
    sudo apt-get install -y clang
fi

if ! type python >/dev/null 2>&1; then
    sudo apt-get install -y python
fi

if ! type npm >/dev/null 2>&1; then
    sudo apt-get install -y node
fi

cd ${_root}
mkdir -p local
# Compile cmake
cd ${_root}/local
if ! [ -e cmake-3.5.0.tar.gz ]; then
    wget https://cmake.org/files/v3.5/cmake-3.5.0.tar.gz
fi
if ! [ -e cmake-3.5.0 ]; then
    tar vzxf cmake-3.5.0.tar.gz
fi
cd cmake-3.5.0
/configure --prefix=${_root}/local
make
make install

# Compile libuv
cd ${_root}/local
if ! [ -e libuv-v1.8.0.tar.gz ]; then
    wget http://dist.libuv.org/dist/v1.8.0/libuv-v1.8.0.tar.gz
fi
if ! [ -e libuv-v1.8.0 ]; then
    tar vzxf libuv-v1.8.0.tar.gz
fi
cd libuv-v1.8.0
sh autogen.sh
CC=clang CXX=clang++ ./configure --prefix=${_root}/local
make
make install

# Edit cmake of Socket.IO C++ Client.
sed -i -e 's/set(BOOST_VER "1.55.0"/set(BOOST_VER "1.54.0"/' ${_root}/lib/socket.io-client-cpp/CMakeLists.txt

# Compile native programes.
cd ${_root}
${_root}/local/bin/cmake .
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
