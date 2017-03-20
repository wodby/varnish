#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

docker-compose up -d
docker-compose exec varnish make check-ready -f /usr/local/bin/actions.mk
docker-compose exec varnish make flush -f /usr/local/bin/actions.mk
#docker-compose down