#!/bin/bash

_pwd=`pwd`
_libfilter="libfilter_ubuntu.json"

# install requirements package
if ! sudo apt-get install -y clang cmake git libssl-dev libboost-dev libboost-system-dev libboost-date-time-dev libboost-random-dev; then
    echo "failure to install requirements packages"
    exit 1;
fi

# compile Socket.IO C++ Client
if [ ! -d "socket.io-client-cpp" ]; then
    git clone --recurse-submodules https://github.com/socketio/socket.io-client-cpp.git
fi
cd socket.io-client-cpp
if ! git pull; then
    echo "failure to download Socket.IO C++ Client"
    exit 1;
fi
sed -i -e 's/cmake_minimum_required(VERSION 3.1.0/cmake_minimum_required(VERSION 2.8.12/' ./CMakeLists.txt
sed -i -e 's/set(BOOST_VER "1.55.0"/set(BOOST_VER "1.54.0"/' ./CMakeLists.txt
cmake -D CMAKE_CXX_FLAGS=-std=c++11 .
make
if ! make install; then
    echo "failure to compile Socket.IO C++ Client"
    exit 1;
fi
cd ${_pwd}

# compile PROCESS WARP
if [ ! -d "processwarp" ]; then
    git clone https://github.com/processwarp/processwarp.git
fi
cd processwarp
if ! git pull; then
    echo "failure to download PROCESS WARP"
    exit 1;
fi
mkdir build
cd build
cmake -D "SIO_DIR=${_pwd}/socket.io-client-cpp/build" ..
make
cd ${_pwd}

# copy file
if ! cp ${_pwd}/processwarp/build/src/core . ; then
    echo "failure to compile PROCESS WARP"
    exit 1;
fi

# edit configure
cp ${_pwd}/processwarp/conf/conf_sample.json ./conf.json
printf "success to compile PROCESS WARP\n"
printf "What is your account? : "
read account
printf "What is your password? : "
read -s pass
printf "\nWhat is device name? : "
read device

for i in `seq 1 1 10`; do
    pass=`printf "${pass}" | shasum -a 256 | cut -f 1 -d ' '`
done
pass="[10sha256]${pass}"

sed -i -e "s/<your account>/${account}/" ./conf.json
sed -i -e "s/<your password>/${pass}/" ./conf.json
sed -i -e "s/<device name>/${device}/" ./conf.json
sed -i -e "s/\"<full path to library for ffi>\"//" ./conf.json
sed -i -e "s:<full path to library name filter file>:${_pwd}/processwarp/conf/${_libfilter}:" ./conf.json

printf "finish setting PROCESS WARP\n"
