#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

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

check_varnish_secret

exec_tpl 'varnishd.init.d.tpl' '/etc/init.d/varnishd'
exec_tpl 'secret.tpl' '/etc/varnish/secret'
exec_tpl 'default.vcl.tpl' '/etc/varnish/default.vcl'

exec-init-scripts.sh

if [[ "${1}" == 'make' ]]; then
    exec "${@}" -f /usr/local/bin/actions.mk
else
    exec $@
fi
