#!/bin/bash

set -eux

_pwd=`pwd`
_root=$(cd $(dirname $0)/.. && pwd)

# Set local environment path.
if [ -z "${env_path+x}" ] ; then
    export LOCAL_ENV_PATH=${_root}/local
fi
mkdir -p ${LOCAL_ENV_PATH}/src

# Check clang.
if ! type clang >/dev/null 2>&1; then
    echo "Please install clang before build processwarp."
    exit 1
fi

# Install requirement packages.
if ! type brew >/dev/null 2>&1; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew install cmake libffi libuv msgpack openssl

brew list | grep boost
if [ $? -eq 1 ]; then
    brew install boost
fi

if ! type python >/dev/null 2>&1; then
    brew install python
fi

if ! type npm >/dev/null 2>&1; then
    brew install node
fi

# Install libfluent
if [ -e ${LOCAL_ENV_PATH}/src/libfluent ]; then
    cd ${LOCAL_ENV_PATH}/src/libfluent
    git fetch
else
    cd ${LOCAL_ENV_PATH}/src
    git clone https://github.com/m-mizutani/libfluent.git
fi
cd ${LOCAL_ENV_PATH}/src/libfluent
git checkout 1be7405

mkdir -p ${LOCAL_ENV_PATH}/tmp/libfluent
cd ${LOCAL_ENV_PATH}/tmp/libfluent
cmake -DCMAKE_INSTALL_PREFIX:PATH=${LOCAL_ENV_PATH} ${LOCAL_ENV_PATH}/src/libfluent
make all install
# Remove dylib file to avoid dynamic-link because we cannot change DYLD_LIBRARY_PATH.
rm ${LOCAL_ENV_PATH}/lib/libfluent.dylib

# Install picojson
if [ -e ${LOCAL_ENV_PATH}/src/picojson ]; then
    cd ${LOCAL_ENV_PATH}/src/picojson
    git fetch
else
    cd ${LOCAL_ENV_PATH}/src
    git clone https://github.com/kazuho/picojson.git
fi
cd ${LOCAL_ENV_PATH}/src/picojson
git checkout 25fc213

# Install re2
if [ -e ${LOCAL_ENV_PATH}/src/re2 ]; then
    cd ${LOCAL_ENV_PATH}/src/re2
    git fetch
else
    cd ${LOCAL_ENV_PATH}/src
    git clone https://github.com/google/re2.git
fi
cd ${LOCAL_ENV_PATH}/src/re2
git checkout 09fc9ce

# Install socket.io
if [ -e ${LOCAL_ENV_PATH}/src/socket.io-client-cpp ]; then
    cd ${LOCAL_ENV_PATH}/src/socket.io-client-cpp
    git fetch
else
    cd ${LOCAL_ENV_PATH}/src
    git clone https://github.com/socketio/socket.io-client-cpp.git
fi
cd ${LOCAL_ENV_PATH}/src/socket.io-client-cpp
git checkout f02dc68
git submodule init
git submodule update


# Compile native programes.
cd ${_root}
cmake -DCMAKE_BUILD_TYPE=Debug -DLOCAL_ENV_PATH=${LOCAL_ENV_PATH} -DOPENSSL_ROOT_DIR=/usr/local/opt/openssl -DOPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include .
make
make install
make const_electron

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

# Install babel and convert js files.
cd ${_root}/src/electron
if ! type babel >/dev/null 2>&1; then
    npm -g install babel-cli
    npm install babel-preset-es2015
fi

mkdir -p dist
babel --no-babelrc --presets es2015 --retain-lines -o dist/constant.js constant.js
babel --no-babelrc --presets es2015 --retain-lines -o dist/main.js main.js
babel --no-babelrc --presets es2015 --retain-lines -o dist/packet_controller.js packet_controller.js

# Finish.
cd ${_pwd}

echo "Finish to build processwarp."
echo "Please input like below to run processwarp."
echo "  <processwarp path>/script/run_gui.sh"
