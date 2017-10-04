# Varnish Docker Container Image

[![Build Status](https://travis-ci.org/wodby/varnish.svg?branch=master)](https://travis-ci.org/wodby/varnish)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/varnish.svg)](https://hub.docker.com/r/wodby/varnish)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/varnish.svg)](https://hub.docker.com/r/wodby/varnish)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

## Docker Images

Images are built via [Travis CI](https://travis-ci.org/wodby/varnish) and published on [Docker Hub](https://hub.docker.com/r/wodby/varnish). 

## Versions

| Image tag (Dockerfile)                                             | Varnish | Alpine Linux |
| ------------------------------------------------------------------ | ------- | ------------ |
| [4.1.3](https://github.com/wodby/varnish/tree/master/4/Dockerfile) | 4.1.3   | 3.6          |

## Environment Variables

| Variable                       | Default Value            | Description                      |
| ------------------------------ | ------------------------ | -------------------------------- |
| VARNISH_BACKEND_HOST           |                          | Mandatory                        |
| VARNISH_BACKEND_PORT           | 80                       |                                  |
| VARNISH_MEMORY_SIZE            | 64m                      |                                  |
| VARNISH_SECRET                 |                          | Generated automatically if blank |
| VARNISHD_DEFAULT_TTL           | 120                      |                                  |
| VARNISHD_SECRET_FILE           | /etc/varnish/secret      |                                  |
| VARNISHD_STORAGE_SIZE          |                          |                                  |
| VARNISHD_THREAD_POOLS          | 1                        |                                  |
| VARNISHD_THREAD_POOL_ADD_DELAY | 2                        |                                  |
| VARNISHD_THREAD_POOL_MIN       | 100                      |                                  |
| VARNISHD_THREAD_POOL_MAX       | 1000                     |                                  |
| VARNISHD_VCL_SCRIPT            | /etc/varnish/default.vcl |                                  |

## Orchestration Actions

```
make COMMAND [params ...]

commands:
    check-ready [host port max_try wait_seconds delay_seconds]
    flush [host port_adm]
 
default params values:
    host localhost
    port 6081
    port_adm 6082
    max_try 1
    wait_seconds 1
    delay_seconds 0
```

## Deployment

Deploy Varnish container to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://cloud.wodby.com/stackhub/0e6ce021-9c23-4478-a6e7-d37fd7c054eb/overview).
