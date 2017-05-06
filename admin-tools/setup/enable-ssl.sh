#!/bin/bash

set -eu

pushd $(dirname ${BASH_SOURCE:-$0})

OS_NAME=`uname -s`
if [ $OS_NAME = 'Darwin' ]; then
  FILE_EXT="''"
fi

for file in `\find ../../nginx/nginx/config/conf.d -maxdepth 1 -type f -name "*.conf"`; do
  eval "sed -i $FILE_EXT -e \"s/listen 80/listen 443/g\" $file"
done

cp -f ../../nginx/nginx/config/conf.d/default.conf.ssl.example ../../nginx/nginx/config/conf.d/default.conf
