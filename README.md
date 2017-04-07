# Generic Varnish docker image

[![Build Status](https://travis-ci.org/wodby/varnish.svg?branch=master)](https://travis-ci.org/wodby/varnish)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/varnish.svg)](https://hub.docker.com/r/wodby/varnish)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/varnish.svg)](https://hub.docker.com/r/wodby/varnish)

[![Wodby Slack](https://www.google.com/s2/favicons?domain=www.slack.com) Join us on Slack](https://slack.wodby.com/)

## Supported tags and respective `Dockerfile` links

- [`4.1-2.0.0`, `4.1`, `latest` (*4.1/Dockerfile*)](https://github.com/wodby/varnish/tree/master/4.1/Dockerfile)

## Environment Variables Available for Customization

| Environment Variable | Type | Default Value | Required | Description |
| -------------------- | -----| ------------- | -------- | ----------- |
| VARNISH_BACKEND_HOST          | String |                          | ✓ | |
| VARNISH_BACKEND_PORT          | String | 80                       |   | |
| VARNISH_VCL_SCRIPT            | String | /etc/varnish/default.vcl |   | | 
| VARNISH_SECRET_FILE           | String | /etc/varnish/secret      |   | |
| VARNISH_MEMORY_SIZE           | String | 64m                      |   | |
| VARNISH_DEFAULT_TTL           | Int    | 120                      |   | |
| VARNISH_THREAD_POOLS          | Int    | 1                        |   | |
| VARNISH_THREAD_POOL_ADD_DELAY | Int    | 2                        |   | |
| VARNISH_THREAD_POOL_MIN       | Int    | 100                      |   | |
| VARNISH_THREAD_POOL_MAX       | Int    | 1000                     |   | |
| VARNISH_STORAGE_SIZE          | String |                          |   | |
| VARNISH_SECRET                | String | _Will be generated automatically_ |   | | 

## Actions

Usage:
```
make COMMAND [params ...]

commands:
    check-ready [host=<nginx> port=<port> max_try=<10> wait_seconds=<5>]
    flush [host=<nginx> port_adm=<admin port>]
 
default params values:
    host localhost
    port 6081
    port_adm 6082
    max_try 30
    wait_seconds 1
```

Examples:

```bash
# Wait for Varnish to start
docker exec -ti [ID] make check-ready -f /usr/local/bin/actions.mk

# Flush cache
docker exec -ti [ID] make flush host=varnish -f /usr/local/bin/actions.mk
```

You can skip -f option if you use run instead of exec.

## Using in Production

Deploy Varnish container to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com).
