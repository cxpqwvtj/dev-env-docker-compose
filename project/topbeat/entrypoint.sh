#!/bin/bash

mkdir -p /topbeat/data

if [ -z $DRY_RUN ]; then
  # wait for elasticsearch to start up
  ELASTIC_PATH=${EXTERNAL_ELASTIC_HOST:-${HOST:-elasticsearch}}:${EXTERNAL_ELASTIC_PORT:-${PORT:-9200}}
  echo "Configure ${ELASTIC_PATH}"

  counter=0
  while [ ! "$(curl $ELASTIC_PATH 2> /dev/null)" -a $counter -lt 30  ]; do
    sleep 1
    ((counter++))
    echo "waiting for Elasticsearch to be up ($counter/30)"
  done

  echo "wait 30s..."
  sleep 30
  pushd beats-dashboards
  echo "post beats-dashboards configuration..."
  ./load.sh -url "http://elasticsearch:9200"
  popd

  topbeat -e -v -c /topbeat/config/topbeat.yml
fi
