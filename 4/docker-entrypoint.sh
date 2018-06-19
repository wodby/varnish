#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

function _gotpl {
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
    _gotpl 'varnishd.init.d.tpl' '/etc/init.d/varnishd'
    _gotpl 'secret.tpl' '/etc/varnish/secret'
    _gotpl 'default.vcl.tpl' '/etc/varnish/default.vcl'
}

check_varnish_secret
process_templates

exec_init_scripts

if [[ "${1}" == 'make' ]]; then
    exec "${@}" -f /usr/local/bin/actions.mk
else
    exec $@
fi
