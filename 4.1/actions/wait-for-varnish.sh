#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

started=0
host=$1
port=$2
max_try=$3
wait_seconds=$4

for i in $(seq 1 "${max_try}"); do
    if curl -s "${host}:${port}" &> /dev/null; then
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
