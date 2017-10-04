FROM wodby/alpine:3.6-1.0.0

ENV VARNISH_VER="4.1.3-r1"

RUN apk --update --no-cache add \
        make \
        pwgen \
        varnish=${VARNISH_VER} && \

    # Remove default varnishd init script
    rm /etc/init.d/varnishd

EXPOSE 6081 6082

VOLUME /var/lib/varnish

COPY templates /etc/gotpl/
COPY actions /usr/local/bin/
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/etc/init.d/varnishd"]
