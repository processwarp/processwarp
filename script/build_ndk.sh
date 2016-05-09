#!/bin/bash -eu

_pwd=`pwd`
_root=$(cd $(dirname $0)/.. && pwd)
_path=${PATH}

PATH=${PATH}:${NDK_PATH:-""}:~/Library/Android/sdk/ndk-bundle

if ! type ndk-build >/dev/null 2>&1; then
    echo "Error: Program \"ndk-build\" not found in PATH"
    echo "PATH=[${_path}]"
    echo "Please set the path for ndk-build in PATH or NDK_PATH"
    exit 1
fi

ndk-build APP_OPTIM=debug -C ${_root}/src/android/app/src/main/jni/

# Finish.
cd ${_pwd}
