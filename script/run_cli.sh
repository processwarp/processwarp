#!/usr/bin/env bash

_pwd=`pwd`
_root=$(cd $(dirname $0)/.. && pwd)

if [ -e "${_root}/etc/config.json" ]; then
  echo "Using configration faile at ${_root}/etc/config.json"
else
  echo "You must setup configuration file at ${_root}/etc/config.json"
  exit 1
fi

export PATH=${_root}/local/bin:${PATH}
export LD_LIBRARY_PATH=${_root}/local/lib:${LD_LIBRARY_PATH}

${_root}/bin/processwarp -c -f ${_root}/etc/config.json
