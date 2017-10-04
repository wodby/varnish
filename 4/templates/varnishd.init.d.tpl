#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

exec varnishd \
    -j unix,user=varnish \
    -F \
    -a :6081 \
    -T :6082 \
    -f {{ getenv "VARNISHD_VCL_SCRIPT" "/etc/varnish/default.vcl" }} \
    -S {{ getenv "VARNISHD_SECRET_FILE" "/etc/varnish/secret" }} \
    -s main=malloc,{{ getenv "VARNISHD_MEMORY_SIZE" "64M" }} \
    {{ if getenv "VARNISHD_STORAGE_SIZE" }}-s secondary=file,/var/lib/varnish/storage.bin,{{ getenv "VARNISHD_STORAGE_SIZE" }} {{ end }} \
    -t {{ getenv "VARNISHD_DEFAULT_TTL" "120" }} \
    -p thread_pools={{ getenv "VARNISHD_THREAD_POOLS" "1" }} \
    -p thread_pool_add_delay={{ getenv "VARNISHD_THREAD_POOL_ADD_DELAY" "2" }} \
    -p thread_pool_min={{ getenv "VARNISHD_THREAD_POOL_MIN" "100" }} \
    -p thread_pool_max={{ getenv "VARNISHD_THREAD_POOL_MAX" "1000" }}
