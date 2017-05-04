#!/bin/bash

source ../env

files=(
  ../../ldap/docker-compose.yml
  ../../nginx/docker-compose.yml
  ../../project/docker-compose.yml
)

for file in ${files[@]}; do
  OS_NAME=`uname -s`
  if [ $OS_NAME = 'Darwin' ]; then
    FILE_EXT="''"
  fi
  COMMAND="sed -i ${FILE_EXT} -e \"s/localhost/${HOST_NAME}/g\" ${file}"
  echo $COMMAND
  eval ${COMMAND}
done



