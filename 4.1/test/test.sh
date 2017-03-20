#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

docker-compose up -d
docker-compose exec varnish make check-ready -f /usr/local/bin/actions.mk
docker-compose exec varnish make flush -f /usr/local/bin/actions.mk
docker-compose exec varnish curl -s "localhost:6081" | grep -q 'Welcome to nginx!'
docker-compose down
