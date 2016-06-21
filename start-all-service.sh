#!/bin/bash

# TODO:ネットワークの存在確認
# TODO:ネットワーク作成

pushd ldap > /dev/null
  docker-compose up -d
popd > /dev/null

pushd project > /dev/null
  docker-compose up -d
popd > /dev/null

pushd proxy > /dev/null
  docker-compose up -d
popd > /dev/null
