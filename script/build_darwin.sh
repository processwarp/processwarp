#!/bin/bash

set -e
set -u
set -x

_pwd=`pwd`
_root=$(cd $(dirname $0)/.. && pwd)

# Check clang.
if ! type clang >/dev/null 2>&1; then
    echo "Please install clang before build processwarp."
    exit 1
fi

# Download submodules
cd ${_root}
git submodule init
git submodule update
cd ${_root}/lib/socket.io-client-cpp
git submodule init
git submodule update

# Install requirement packages.
if ! type brew >/dev/null 2>&1; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew install cmake boost libffi libuv msgpack openssl

if ! type python >/dev/null 2>&1; then
    brew install python
fi

if ! type npm >/dev/null 2>&1; then
    brew install node
fi

# Compile libfluent
cd ${_root}
mkdir -p tmp/libfluent
mkdir -p local
cd ${_root}/tmp/libfluent
cmake -DCMAKE_INSTALL_PREFIX:PATH=${_root}/local ${_root}/lib/libfluent
make all install

# Compile native programes.
cd ${_root}
cmake -DCMAKE_BUILD_TYPE=Debug .
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
