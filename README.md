# Varnish docker container image

[![Build Status](https://travis-ci.org/wodby/varnish.svg?branch=master)](https://travis-ci.org/wodby/varnish)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/varnish.svg)](https://hub.docker.com/r/wodby/varnish)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/varnish.svg)](https://hub.docker.com/r/wodby/varnish)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

## Supported tags and respective `Dockerfile` links

- [`4.1-2.1.0`, `4.1`, `latest` (*4.1/Dockerfile*)](https://github.com/wodby/varnish/tree/master/4.1/Dockerfile)

## Environment variables available for customization

| Environment Variable | Default Value | Description |
| -------------------- | ------------- | ----------- |
| VARNISH_BACKEND_HOST          |                          | Mandatory |
| VARNISH_BACKEND_PORT          | 80                       | |
| VARNISH_VCL_SCRIPT            | /etc/varnish/default.vcl | | 
| VARNISH_SECRET_FILE           | /etc/varnish/secret      | |
| VARNISH_MEMORY_SIZE           | 64m                      | |
| VARNISH_DEFAULT_TTL           | 120                      | |
| VARNISH_THREAD_POOLS          | 1                        | |
| VARNISH_THREAD_POOL_ADD_DELAY | 2                        | |
| VARNISH_THREAD_POOL_MIN       | 100                      | |
| VARNISH_THREAD_POOL_MAX       | 1000                     | |
| VARNISH_STORAGE_SIZE          |                          | |
| VARNISH_SECRET                |                          | Generated automatically if blank | 

## Actions

Usage:
```
make COMMAND [params ...]

commands:
    check-ready [host port max_try wait_seconds]
    flush [host port_adm]
 
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

## Using in production

Deploy Varnish container to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com).
