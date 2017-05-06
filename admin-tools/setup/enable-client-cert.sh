#!/bin/bash

set -eu

pushd $(dirname ${BASH_SOURCE:-$0})

source ../env

COMMAND=sed
OS_NAME=`uname -s`
if [ $OS_NAME = 'Darwin' ]; then
  if hash gsed 2>/dev/null; then
    COMMAND=gsed
  else
    echo 'gsed command not found. exec `brew install gnu-sed`'
    exit
  fi
fi

CLIENT_CERT_DEF="\  # クライアント認証設定\n  ssl_verify_client on;\n  ssl_client_certificate /usr/local/nginx/config/cacert.pem;\n  ssl_crl /usr/local/nginx/config/crl.pem;\n"

for file in `\find ../../nginx/nginx/config/conf.d -maxdepth 1 -type f -name "*.conf"`; do
  $COMMAND -i "/client_max_body_size/i $CLIENT_CERT_DEF" $file
done

eval "$COMMAND -i -e \"s!#- /usr/local/nginx/config/cacert.pem!- $CA_CERT_PATH!g\" ../../nginx/docker-compose.yml"
eval "$COMMAND -i -e \"s!#- /usr/local/nginx/config/crl.pem!- $CRL_PATH!g\" ../../nginx/docker-compose.yml"

popd
