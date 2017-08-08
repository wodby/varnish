#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

started=0
host=$1
max_try=$2
wait_seconds=$3
delay_seconds=$4

sleep "${delay_seconds}"

for i in $(seq 1 "${max_try}"); do
    if varnishadm -T "${host}":6082 -S /etc/varnish/secret "status" | grep -q "Child in state running"; then
        started=1
        break
    fi
    echo 'Varnish is starting...'
    sleep "${wait_seconds}"
done

if [[ "${started}" -eq '0' ]]; then
    echo >&2 'Error. Varnish is unreachable.'
    exit 1
fi

echo 'Varnish has started!'
