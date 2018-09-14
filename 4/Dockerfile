FROM wodby/alpine:3.6-2.1.1

ARG VARNISH_VER
ARG VARNISH_VER_ALPINE

ENV VARNISH_VER="${VARNISH_VER}"

RUN set -ex; \
    \
    apk --update --no-cache -t .varnish-rundeps add \
        make \
        pwgen \
        varnish="${VARNISH_VER_ALPINE}"; \
    \
    touch /etc/varnish/preset.vcl; \
    mkdir -p /etc/varnish/defaults /etc/varnish/includes; \
    # We do not use default init
    echo "" > /etc/init.d/varnishd

EXPOSE 6081 6082

VOLUME /var/lib/varnish

COPY templates /etc/gotpl/
COPY bin /usr/local/bin/
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/etc/init.d/varnishd"]
