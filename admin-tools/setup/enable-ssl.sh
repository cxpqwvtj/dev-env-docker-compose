#!/bin/bash

set -e

pushd $(dirname ${BASH_SOURCE:-$0})

cp -f ../../nginx/nginx/config/conf.d/default.conf.ssl.example ../../nginx/nginx/config/conf.d/default.conf
