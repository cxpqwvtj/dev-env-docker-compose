#!/bin/bash

pushd nginx > /dev/null
  docker-compose stop
popd > /dev/null

pushd project > /dev/null
  docker-compose stop
popd > /dev/null

pushd ldap > /dev/null
  docker-compose stop
popd > /dev/null
