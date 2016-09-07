#!/bin/bash

set -e
set -u
set -x

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
sudo apt-get install -y pkg-config automake build-essential libtool libssl-dev libffi-dev libncurses5-dev curl wget libgtk2.0-dev libmsgpack-dev
if sudo apt-get install -y libboost1.58-dev libboost-system1.58-dev libboost-date-time1.58-dev libboost-random1.58-dev >/dev/null
then
    echo libboost 1.58 installed
elif sudo apt-get install -y libboost1.55-dev libboost-system1.55-dev libboost-date-time1.55-dev libboost-random1.55-dev >/dev/null
then
    echo libboost 1.55 installed
fi

if ! type python >/dev/null 2>&1; then
    sudo apt-get install -y python
fi

cd ${_root}
mkdir -p tmp
mkdir -p local
export PATH=${_root}/local/bin:${PATH}
if [[ ! -v LD_LIBRARY_PATH ]]; then
    export LD_LIBRARY_PATH=
fi
export LD_LIBRARY_PATH=${_root}/local/lib:${LD_LIBRARY_PATH}
if [[ ! -v PKG_CONFIG_PATH ]]; then
    export PKG_CONFIG_PATH=
fi
export PKG_CONFIG_PATH=${_root}/local/lib/pkgconfig:${PKG_CONFIG_PATH}

# Compile cmake
if ${_root}/local/bin/cmake --version | grep -o 3.5.0 >/dev/null
then
    echo cmake 3.5.0 installed
else
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
fi

# Compile fluentd
cd ${_root}
mkdir -p tmp/libfluent
mkdir -p local
cd ${_root}/tmp/libfluent
${_root}/local/bin/cmake -DCMAKE_INSTALL_PREFIX:PATH=${_root}/local ${_root}/lib/libfluent
make all install

# Compile libuv
if pkg-config --modversion libuv | grep -o 1.8.0 >/dev/null
then
    echo libuv 1.8.0 installed
else
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
fi

# Node.js
cd ${_root}/tmp
if ! [ -e node-v4.4.7-linux-armv7l.tar.xz ]; then
    wget https://nodejs.org/dist/v4.4.7/node-v4.4.7-linux-armv7l.tar.xz
fi
if ! [ -e node-v4.4.7-linux-armv7l ]; then
    tar Jxf node-v4.4.7-linux-armv7l.tar.xz
fi
cp -Rfp node-v4.4.7-linux-armv7l/* ${_root}/local/

sudo ldconfig

# Compile native programes.
cd ${_root}
${_root}/local/bin/cmake -DCMAKE_EXE_LINKER_FLAGS="-L${_root}/local/lib" -DUV_INCLUDE_DIRS=${_root}/local/include/ -DUV_LIBRARIES=uv -DWITH_RE2=ON -DWITH_TEST=OFF -DCMAKE_BUILD_TYPE=Debug .
make
make install
make const_electron

# Install electron and requirement modules.
if ! type electron >/dev/null 2>&1; then
    ${_root}/local/bin/npm -g install electron-prebuilt
fi

cd ${_root}/src/electron
if [ -e node_modules ]; then
    ${_root}/local/bin/npm update
else
    ${_root}/local/bin/npm install
fi

# Install babel and convert js files.
cd ${_root}/src/electron
if ! type babel >/dev/null 2>&1; then
    ${_root}/local/bin/npm -g install babel-cli
    ${_root}/local/bin/npm install babel-preset-es2015
fi

mkdir -p dist
${_root}/local/bin/babel --no-babelrc --presets es2015 --retain-lines -o dist/constant.js constant.js
${_root}/local/bin/babel --no-babelrc --presets es2015 --retain-lines -o dist/main.js main.js
${_root}/local/bin/babel --no-babelrc --presets es2015 --retain-lines -o dist/packet_controller.js packet_controller.js

# Finish.
cd ${_pwd}

echo "Finish to build processwarp."
echo "Please input like below to run processwarp."
echo "  <processwarp path>/script/run_gui.sh"
