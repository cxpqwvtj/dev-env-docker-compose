#!/bin/bash

# TODO:ネットワークの存在確認
# TODO:ネットワーク作成

pushd ldap
  docker-compose up -d
popd

pushd project
  docker-compose up -d
popd

pushd proxy
  docker-compose up -d
popd
