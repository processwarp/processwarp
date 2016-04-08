#!/bin/bash -eu

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
brew install cmake boost libffi libuv openssl

if ! type python >/dev/null 2>&1; then
    brew install python
fi

if ! type npm >/dev/null 2>&1; then
    brew install node
fi

# Compile native programes.
cd ${_root}
cmake -DCMAKE_BUILD_TYPE=Debug .
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
