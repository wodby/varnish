#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

# Backwards compatibility for old env vars names.
_backwards_compatibility() {
    declare -A vars
    # vars[DEPRECATED]="ACTUAL"
    vars[VARNISHD_THREAD_POOLS]="VARNISHD_PARAM_THREAD_POOLS"
    vars[VARNISHD_THREAD_POOL_ADD_DELAY]="VARNISHD_PARAM_THREAD_POOL_ADD_DELAY"
    vars[VARNISHD_THREAD_POOL_MIN]="VARNISHD_PARAM_THREAD_POOL_MIN"
    vars[VARNISHD_THREAD_POOL_MAX]="VARNISHD_PARAM_THREAD_POOL_MAX"

    for i in "${!vars[@]}"; do
        # Use value from old var if it's not empty and the new is.
        if [[ -n "${!i}" && -z "${!vars[$i]}" ]]; then
            export "${vars[$i]}"="${!i}"
        fi
    done
}

function exec_tpl {
    if [[ -f "/etc/gotpl/$1" ]]; then
        gotpl "/etc/gotpl/$1" > "$2"
    fi
}

check_varnish_secret() {
    if [[ -z "${VARNISH_SECRET}" ]]; then
        export VARNISH_SECRET=$(pwgen -s 128 1)
        echo "Generated Varnish secret: ${VARNISH_SECRET}"
    fi
}

process_templates() {
    _backwards_compatibility

    exec_tpl 'varnishd.init.d.tpl' '/etc/init.d/varnishd'
    exec_tpl 'secret.tpl' '/etc/varnish/secret'
    exec_tpl 'default.vcl.tpl' '/etc/varnish/default.vcl'
}

check_varnish_secret
process_templates

exec-init-scripts.sh

if [[ "${1}" == 'make' ]]; then
    exec "${@}" -f /usr/local/bin/actions.mk
else
    exec $@
fi
