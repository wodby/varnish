#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

varnish() {
    docker-compose exec varnish "${@}"
}

docker-compose up -d

echo -n "Running check-ready action... "
varnish make check-ready max_try=10 -f /usr/local/bin/actions.mk
echo "OK"

echo -n "Running flush action... "
varnish make flush -f /usr/local/bin/actions.mk
echo "OK"

us_ip="185.229.59.42"

echo -n "Checking varnish backend response containing a country code header detected via geoip module... "
docker-compose exec php sh -c 'echo "<?php var_dump(\$_SERVER[\"HTTP_X_COUNTRY_CODE\"]);" > /var/www/html/index.php'
varnish curl --header "X-Real-IP: ${us_ip}" -s "localhost:6081" | grep -q "US"
varnish make flush -f /usr/local/bin/actions.mk
echo "OK"

echo -n "Checking varnish backend response containing the currency... "
docker-compose exec php sh -c 'echo "<?php var_dump(\$_SERVER[\"HTTP_X_CURRENCY\"]);" > /var/www/html/index.php'
varnish curl --header "X-Real-IP: ${us_ip}" -s "localhost:6081" | grep -q "USD"
varnish make flush -f /usr/local/bin/actions.mk
echo "OK"

echo -n "Checking varnish backend response containing the currency (from Cloudflare \"CF-IPCountry\" header)... "
docker-compose exec php sh -c 'echo "<?php var_dump(\$_SERVER[\"HTTP_X_CURRENCY\"]);" > /var/www/html/index.php'
varnish curl --header "CF-IPCountry: US" -s "localhost:6081" | grep -q "USD"
varnish make flush -f /usr/local/bin/actions.mk
echo "OK"

echo -n "Checking varnish VCKEY cookies... "
docker-compose exec php sh -c 'echo "<?php echo(\"Hello World\");" > /var/www/html/index.php'
varnish sh -c 'curl -sI -b "VCKEYinvalid=123"  localhost:6081 | grep -q "X-VC-Cache: MISS"'
varnish sh -c 'curl -sI -b "VCKEYinvalid=123"  localhost:6081 | grep -q "X-VC-Cache: MISS"'
varnish sh -c 'curl -sI -b "VCKEY-.invalid=123"  localhost:6081 | grep -q "X-VC-Cache: MISS"'
varnish sh -c 'curl -sI -b "VCKEY-.invalid=123"  localhost:6081 | grep -q "X-VC-Cache: MISS"'
varnish sh -c 'curl -sI -b "vckey-invalid=123"  localhost:6081 | grep -q "X-VC-Cache: MISS"'
varnish sh -c 'curl -sI -b "vckey-invalid=123"  localhost:6081 | grep -q "X-VC-Cache: MISS"'
varnish sh -c 'curl -sI -b "VCKEY-valid=123" localhost:6081 | grep -q "X-VC-Cache: MISS"'
varnish sh -c 'curl -sI -b "VCKEY-valid=123" localhost:6081 | grep -q "X-VC-Cache: HIT"'
varnish sh -c 'curl -sI -b "VCKEY-valid=123; VCKEY-multiple-cookies_1=123;" localhost:6081 | grep -q "X-VC-Cache: MISS"'
varnish sh -c 'curl -sI -b "VCKEY-valid=123; VCKEY-multiple-cookies_1=123;" localhost:6081 | grep -q "X-VC-Cache: HIT"'
varnish sh -c 'curl -sI -b "VCKEY-valid=123; VCKEY-multiple-cookies_1=321;" localhost:6081 | grep -q "X-VC-Cache: MISS"'
varnish make flush -f /usr/local/bin/actions.mk
echo "OK"

echo -n "Checking varnish VCKEY cookies availability on a backend... "
sleep 1 # Waiting for cache to be purged
docker-compose exec php sh -c 'echo "<?php print mt_rand(10000, 99000);" > /var/www/html/index.php'
resp_no_vckey1=$(varnish sh -c 'curl -s localhost:6081')
resp_vckey_a1=$(varnish sh -c 'curl -s -b "VCKEY-Key-A=100" localhost:6081')
resp_vckey_a2=$(varnish sh -c 'curl -s -b "VCKEY-Key-A=200" localhost:6081')
resp_vckey_b1=$(varnish sh -c 'curl -s -b "VCKEY-Key-B=100" localhost:6081')
resp_vckey_b2=$(varnish sh -c 'curl -s -b "VCKEY-Key-B=100" localhost:6081')
resp_no_vckey2=$(varnish sh -c 'curl -s localhost:6081')
[[ "${resp_no_vckey1}" =~ ^[0-9]{5}$ ]] || exit 1
[[ "${resp_no_vckey2}" =~ ^[0-9]{5}$ ]] || exit 1
[[ "${resp_vckey_a1}" =~ ^[0-9]{5}$ ]] || exit 1
[[ "${resp_vckey_a2}" =~ ^[0-9]{5}$ ]] || exit 1
[[ "${resp_vckey_b1}" =~ ^[0-9]{5}$ ]] || exit 1
[[ "${resp_vckey_b2}" =~ ^[0-9]{5}$ ]] || exit 1
[[ "${resp_vckey_a1}" != "${resp_vckey_a2}" ]] || exit 1
[[ "${resp_vckey_b1}" == "${resp_vckey_b2}" ]] || exit 1
[[ "${resp_no_vckey1}" == "${resp_no_vckey2}" ]] || exit 1
echo "OK"

docker-compose down
