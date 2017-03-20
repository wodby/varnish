FROM alpine:3.5

ENV VARNISH_VER 4.1.3-r0
ENV GOTLP_VER 0.1.5

RUN apk --update --no-cache add \
        bash \
        ca-certificates \
        curl \
        make \
        wget \
        pwgen \
        varnish=${VARNISH_VER} && \

    # Download and install Gotlp
    wget -qO- https://github.com/wodby/gotpl/releases/download/${GOTLP_VER}/gotpl-alpine-linux-amd64-${GOTLP_VER}.tar.gz \
        | tar xz -C /usr/local/bin && \

    # Remove default varnishd init script
    rm /etc/init.d/varnishd

EXPOSE 6081 6082

VOLUME /var/lib/varnish

COPY templates /etc/gotpl/
COPY actions /usr/local/bin/
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/etc/init.d/varnishd"]
