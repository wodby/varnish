#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

docker-compose up -d

echo -n "Running check-ready action... "
docker-compose exec varnish make check-ready max_try=10 -f /usr/local/bin/actions.mk
echo "OK"

echo -n "Running flush action... "
docker-compose exec varnish make flush -f /usr/local/bin/actions.mk
echo "OK"

echo -n "Checking varnish backend response... "
docker-compose exec varnish curl -s "localhost:6081" | grep -q 'Welcome to nginx!'
echo "OK"

docker-compose down
