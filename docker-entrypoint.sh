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

# Backwards compatibility for old env vars names.
_backwards_compatibility() {
    declare -A vars
    # vars[DEPRECATED]="ACTUAL"

    if [[ "${VARNISH_CONFIG_PRESET}" == "drupal" ]]; then
        vars[VARNISH_EXCLUDE_URLS]="VARNISH_DRUPAL_EXCLUDE_URLS"
        vars[VARNISH_PRESERVED_COOKIES]="VARNISH_DRUPAL_PRESERVED_COOKIES"
    elif [[ "${VARNISH_CONFIG_PRESET}" == "wordpress" ]]; then
        vars[VARNISH_ADMIN_SUBDOMAIN]="VARNISH_WP_ADMIN_SUBDOMAIN"
    fi

    for i in "${!vars[@]}"; do
        # Use value from old var if it's not empty and the new is.
        if [[ -n "${!i}" && -z "${!vars[$i]}" ]]; then
            export ${vars[$i]}="${!i}"
        fi
    done
}

init_varnish_secret() {
    if [[ -z "${VARNISH_SECRET}" ]]; then
        export VARNISH_SECRET=$(pwgen -s 128 1)
        echo "Generated Varnish secret: ${VARNISH_SECRET}"
    fi

    echo -e "${VARNISH_SECRET}" > /etc/varnish/secret
}

init_purge_key() {
    if [[ -z "${VARNISH_PURGE_KEY}" ]]; then
        export VARNISH_PURGE_KEY=$(pwgen -s 64 1)
        echo "Varnish purge key is missing. Generating random: ${VARNISH_PURGE_KEY}"
    fi
}

process_templates() {
    _backwards_compatibility

    _gotpl 'varnishd.init.d.tmpl' '/etc/init.d/varnishd'
    _gotpl 'default.vcl.tmpl' '/etc/varnish/default.vcl'

    if [[ -n "${VARNISH_CONFIG_PRESET}" ]]; then
        _gotpl "presets/${VARNISH_CONFIG_PRESET}.vcl.tmpl" '/etc/varnish/preset.vcl'
    fi

    for f in /etc/gotpl/defaults/*.tmpl; do
        _gotpl "defaults/${f##*/}" "/etc/varnish/defaults/$(basename "${f%.tmpl}")";
    done

    for f in /etc/gotpl/includes/*.tmpl; do
        _gotpl "includes/${f##*/}" "/etc/varnish/includes/$(basename "${f%.tmpl}")";
    done
}

init_varnish_secret
init_purge_key
process_templates

exec_init_scripts

if [[ "${1}" == "make" ]]; then
    exec "${@}" -f /usr/local/bin/actions.mk
else
    exec $@
fi
