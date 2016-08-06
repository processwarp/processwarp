#!/bin/bash

set -e
set -u
set -x

_pwd=`pwd`

if [ "$(uname -s)" == 'Darwin' ]; then
    # Mac OSX
    bash -ex $(dirname $0)/build_darwin.sh

elif [ -e /etc/debian_version ] ||
         [ -e /etc/debian_release ]; then
    if [ -e /etc/lsb-release ]; then
        # Ubuntu
        bash $(dirname $0)/build_ubuntu.sh

    elif [ -e /etc/rpi-issue ]; then
        # RaspberryPi
        bash $(dirname $0)/build_raspbian.sh

    else
        # Debian
        echo "Thank you for useing. But sorry, this platform is not supported yet."
        exit 1
    fi

else
    echo "Thank you for useing. But sorry, this platform is not supported yet."
    exit 1
fi

cd ${_pwd}
