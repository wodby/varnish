#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

function execTpl {
    if [[ -f "/etc/gotpl/$1" ]]; then
        gotpl "/etc/gotpl/$1" > "$2"
    fi
}

execInitScripts() {
    shopt -s nullglob
    for f in /docker-entrypoint-init.d/*.sh; do
        echo "$0: running $f"
        . "$f"
    done
    shopt -u nullglob
}

checkVarnishSecret() {
    if [[ -z "${VARNISH_SECRET}" ]]; then
        export VARNISH_SECRET=$(pwgen -s 128 1)
        echo "Generated Varnish secret: ${VARNISH_SECRET}"
    fi
}

if [[ "${1}" == 'make' ]]; then
    exec "${@}" -f /usr/local/bin/actions.mk
else
    checkVarnishSecret

    execTpl 'varnishd.init.d.tpl' '/etc/init.d/varnishd'
    execTpl 'secret.tpl' '/etc/varnish/secret'
    execTpl 'default.vcl.tpl' '/etc/varnish/default.vcl'

    chmod +x /etc/init.d/varnishd
    execInitScripts

    exec $@
fi
