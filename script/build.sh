#!/usr/bin/env bash

_pwd=`pwd`

if [ "$(uname -s)" == 'Darwin' ]; then
    bash -eu $(dirname $0)/build_darwin.sh

else
    echo "Sorry, this platform is not supported."
    exit 1
fi

cd ${pwd}
