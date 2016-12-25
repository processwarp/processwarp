#!/usr/bin/env bash

_pwd=`pwd`
_root=$(cd $(dirname $0)/.. && pwd)

export PATH=${_root}/local/bin:${PATH}
if [ "$(uname -s)" == 'Darwin' ]; then
    # for macOS
    electron ${_root}/src/electron

else
    # for other system
    export LD_LIBRARY_PATH=${_root}/local/lib:${LD_LIBRARY_PATH}
    electron ${_root}/src/electron
fi
