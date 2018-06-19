# Varnish Docker Container Image

[![Build Status](https://travis-ci.org/wodby/varnish.svg?branch=master)](https://travis-ci.org/wodby/varnish)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/varnish.svg)](https://hub.docker.com/r/wodby/varnish)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/varnish.svg)](https://hub.docker.com/r/wodby/varnish)
[![Docker Layers](https://images.microbadger.com/badges/image/wodby/varnish.svg)](https://microbadger.com/images/wodby/varnish)

## Docker Images

❗For better reliability we release images with stability tags (`wodby/varnish:4-X.X.X`) which correspond to [git tags](https://github.com/wodby/varnish/releases). We strongly recommend using images only with stability tags. 

Overview:

* All images are based on Alpine Linux
* Base image: [wodby/alpine](https://github.com/wodby/alpine)
* [Travis CI builds](https://travis-ci.org/wodby/varnish) 
* [Docker Hub](https://hub.docker.com/r/wodby/varnish)

Supported tags and respective `Dockerfile` links:

* `4.1`, `4`, `latest` [_(Dockerfile)_](https://github.com/wodby/varnish/tree/master/4/Dockerfile)

## Environment Variables

| Variable                                   | Default Value              | Description                      |
| ------------------------------------------ | -------------------------- | -------------------------------- |
| `VARNISH_BACKEND_HOST`                     |                            | Mandatory                        |
| `VARNISH_BACKEND_PORT`                     | `80`                       |                                  |
| `VARNISH_SECRET`                           |                            | Generated automatically if blank |
| `VARNISHD_MEMORY_SIZE`                     | `64m`                      |                                  |
| `VARNISHD_DEFAULT_TTL`                     | `120`                      |                                  |
| `VARNISHD_PARAM_BAN_LURKER_AGE`            | `60.000`                   |                                  |
| `VARNISHD_PARAM_BAN_LURKER_BATCH`          | `1000`                     |                                  |
| `VARNISHD_PARAM_BAN_LURKER_SLEEP`          | `0.010`                    |                                  |
| `VARNISHD_PARAM_BETWEEN_BYTES_TIMEOUT`     | `60.000`                   |                                  |
| `VARNISHD_PARAM_CONNECT_TIMEOUT`           | `3.500`                    |                                  |
| `VARNISHD_PARAM_DEFAULT_GRACE`             | `10.000`                   |                                  |
| `VARNISHD_PARAM_DEFAULT_KEEP`              | `0.000`                    |                                  |
| `VARNISHD_PARAM_DEFAULT_TTL`               | `120.000`                  |                                  |
| `VARNISHD_PARAM_FETCH_CHUNKSIZE`           | `16k`                      |                                  |
| `VARNISHD_PARAM_FIRST_BYTE_TIMEOUT`        | `60.000`                   |                                  |
| `VARNISHD_PARAM_GZIP_BUFFER`               | `32k`                      |                                  |
| `VARNISHD_PARAM_GZIP_LEVEL`                | `6`                        |                                  |
| `VARNISHD_PARAM_GZIP_MEMLEVEL`             | `8`                        |                                  |
| `VARNISHD_PARAM_HTTP_GZIP_SUPPORT`         | `on`                       |                                  |
| `VARNISHD_PARAM_HTTP_MAX_HDR`              | `64`                       |                                  |
| `VARNISHD_PARAM_HTTP_REQ_HDR_LEN`          | `8k`                       |                                  |
| `VARNISHD_PARAM_HTTP_REQ_SIZE`             | `32k`                      |                                  |
| `VARNISHD_PARAM_HTTP_RESP_HDR_LEN`         | `8k`                       |                                  |
| `VARNISHD_PARAM_HTTP_RESP_SIZE`            | `32k`                      |                                  |
| `VARNISHD_PARAM_IDLE_SEND_TIMEOUT`         | `60.000`                   |                                  |
| `VARNISHD_PARAM_MAX_ESI_DEPTH`             | `5`                        |                                  |
| `VARNISHD_PARAM_MAX_RESTARTS`              | `4`                        |                                  |
| `VARNISHD_PARAM_MAX_RETRIES`               | `4`                        |                                  |
| `VARNISHD_PARAM_NUKE_LIMIT`                | `50`                       |                                  |
| `VARNISHD_PARAM_PING_INTERVAL`             | `3`                        |                                  |
| `VARNISHD_PARAM_PIPE_TIMEOUT`              | `60.000`                   |                                  |
| `VARNISHD_PARAM_POOL_REQ`                  | `10,100,10`                |                                  |
| `VARNISHD_PARAM_POOL_SESS`                 | `10,100,10`                |                                  |
| `VARNISHD_PARAM_PREFER_IPV6`               | `off`                      |                                  |
| `VARNISHD_PARAM_RUSH_EXPONENT`             | `3`                        |                                  |
| `VARNISHD_PARAM_SEND_TIMEOUT`              | `600`                      |                                  |
| `VARNISHD_PARAM_SESSION_MAX`               | `100000`                   |                                  |
| `VARNISHD_PARAM_SHORTLIVED`                | `10.000`                   |                                  |
| `VARNISHD_PARAM_TCP_KEEPALIVE_INTVL`       | `75.000`                   |                                  |
| `VARNISHD_PARAM_TCP_KEEPALIVE_PROBES`      | `8`                        |                                  |
| `VARNISHD_PARAM_TCP_KEEPALIVE_TIME`        | `7200.000`                 |                                  |
| `VARNISHD_PARAM_THREAD_POOL_ADD_DELAY`     | `0.000`                    |                                  |
| `VARNISHD_PARAM_THREAD_POOL_DESTROY_DELAY` | `1.000`                    |                                  |
| `VARNISHD_PARAM_THREAD_POOL_FAIL_DELAY`    | `0.200`                    |                                  |
| `VARNISHD_PARAM_THREAD_POOL_MAX`           | `5000`                     |                                  |
| `VARNISHD_PARAM_THREAD_POOL_MIN`           | `100`                      |                                  |
| `VARNISHD_PARAM_THREAD_POOL_STACK`         | `48k`                      |                                  |
| `VARNISHD_PARAM_THREAD_POOL_TIMEOUT`       | `300.000`                  |                                  |
| `VARNISHD_PARAM_THREAD_POOLS`              | `2`                        |                                  |
| `VARNISHD_PARAM_THREAD_QUEUE_LIMIT`        | `20`                       |                                  |
| `VARNISHD_PARAM_TIMEOUT_IDLE`              | `5.000`                    |                                  |
| `VARNISHD_PARAM_TIMEOUT_LINGER`            | `0.050`                    |                                  |
| `VARNISHD_PARAM_VSL_BUFFER`                | `4k`                       |                                  |
| `VARNISHD_PARAM_VSL_RECLEN`                | `255b`                     |                                  |
| `VARNISHD_PARAM_VSL_SPACE`                 | `80M`                      |                                  |
| `VARNISHD_PARAM_VSM_SPACE`                 | `1M`                       |                                  |
| `VARNISHD_PARAM_WORKSPACE_BACKEND`         | `64k`                      |                                  |
| `VARNISHD_PARAM_WORKSPACE_CLIENT`          | `64k`                      |                                  |
| `VARNISHD_PARAM_WORKSPACE_SESSION`         | `0.50k`                    |                                  |
| `VARNISHD_PARAM_WORKSPACE_THREAD`          | `2k`                       |                                  |
| `VARNISHD_SECRET_FILE`                     | `/etc/varnish/secret`      |                                  |
| `VARNISHD_SECONDARY_STORAGE`               |                            |                                  |
| `VARNISHD_VCL_SCRIPT`                      | `/etc/varnish/default.vcl` |                                  |

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
