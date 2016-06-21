#!/bin/bash

pushd ldap > /dev/null
  docker-compose rm -fv
popd > /dev/null

pushd project > /dev/null
  docker-compose rm -fv
popd > /dev/null

pushd proxy > /dev/null
  docker-compose rm -fv
popd > /dev/null
