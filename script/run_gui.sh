#!/usr/bin/env bash

_pwd=`pwd`
_root=$(cd $(dirname $0)/.. && pwd)

export PATH=${_root}/local/bin:${PATH}
export LD_LIBRARY_PATH=${_root}/local/lib:${LD_LIBRARY_PATH}

electron ${_root}/src/electron
