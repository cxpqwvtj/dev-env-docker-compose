#!/bin/bash

pushd proxy
  docker-compose stop
popd

pushd project
  docker-compose stop
popd

pushd ldap
  docker-compose stop
popd
