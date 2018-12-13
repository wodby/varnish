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

us_ip="185.229.59.42"

echo -n "Checking varnish backend response containing a country code header detected via geoip module... "
docker-compose exec php sh -c 'echo "<?php var_dump(\$_SERVER[\"HTTP_X_COUNTRY_CODE\"]);" > /var/www/html/index.php'
docker-compose exec varnish curl --header "X-Forwarded-For: ${us_ip}" -s "localhost:6081" | grep -q "US"
echo "OK"

echo -n "Checking varnish backend response containing the currency... "
docker-compose exec php sh -c 'echo "<?php var_dump(\$_SERVER[\"HTTP_X_CURRENCY\"]);" > /var/www/html/index.php'
docker-compose exec varnish make flush -f /usr/local/bin/actions.mk
docker-compose exec varnish curl --header "X-Forwarded-For: ${us_ip}" -s "localhost:6081" | grep -q "USD"
echo "OK"

docker-compose down
