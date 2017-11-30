FROM wodby/alpine:3.6-1.0.0

ARG VARNISH_VER
ARG VARNISH_VER_ALPINE

ENV VARNISH_VER="${VARNISH_VER}" \
    VARNISH_VER_ALPINE="${VARNISH_VER_ALPINE}"

RUN apk --update --no-cache add \
        make \
        pwgen \
        varnish=${VARNISH_VER_ALPINE} && \

    # We don't use default init
    echo "" > /etc/init.d/varnishd

EXPOSE 6081 6082

VOLUME /var/lib/varnish

COPY templates /etc/gotpl/
COPY actions /usr/local/bin/
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/etc/init.d/varnishd"]
