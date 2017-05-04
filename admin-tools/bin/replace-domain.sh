#!/bin/bash

pushd $(dirname ${BASH_SOURCE:-$0})

source ../env

files=(
  ../../ldap/docker-compose.yml
  ../../nginx/docker-compose.yml
  ../../project/docker-compose.yml
  ../../nginx/config/conf.d/account.conf
  ../../nginx/config/conf.d/chat.conf
  ../../nginx/config/conf.d/default.conf
  ../../nginx/config/conf.d/gitlab.conf
  ../../nginx/config/conf.d/jenkins.conf
  ../../nginx/config/conf.d/owncloud.conf
  ../../nginx/config/conf.d/redmine.conf
)

for file in ${files[@]}; do
  OS_NAME=`uname -s`
  if [ $OS_NAME = 'Darwin' ]; then
    FILE_EXT="''"
  fi
  COMMAND="sed -i ${FILE_EXT} -e \"s/example.com/${HOST_NAME}/g\" ${file}"
  echo $COMMAND
  eval ${COMMAND}
done

popd
