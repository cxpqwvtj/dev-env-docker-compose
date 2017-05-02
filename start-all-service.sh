#!/bin/bash

# TODO:ネットワークの存在確認
# TODO:ネットワーク作成

pushd ldap > /dev/null
  docker-compose up -d
popd > /dev/null

# TODO:依存関係先のコンテナを先に作らないと起動に失敗する可能性がある？
pushd project > /dev/null
  docker-compose up -d
popd > /dev/null

pushd nginx > /dev/null
  docker-compose up -d
popd > /dev/null
