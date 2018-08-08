# Varnish Docker Container Image

[![Build Status](https://travis-ci.org/wodby/varnish.svg?branch=master)](https://travis-ci.org/wodby/varnish)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/varnish.svg)](https://hub.docker.com/r/wodby/varnish)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/varnish.svg)](https://hub.docker.com/r/wodby/varnish)
[![Docker Layers](https://images.microbadger.com/badges/image/wodby/varnish.svg)](https://microbadger.com/images/wodby/varnish)

* [Docker images](#docker-images)
* [Environment variables](#environment-variables)
* [Default behaviour](#default-behaviour)
* [Config presets](#config-presets)
    * [Drupal](#drupal)
    * [WordPress](#wordpress)
* [Orchestration actions](#orchestration-actions)    
* [Deployment](#deployment)    

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

| Variable                                   | Default Value              | Description                        |
| ------------------------------------------ | -------------------------- | ---------------------------------- |
| `VARNISH_ALLOW_UNRESTRICTED_PURGE`         |                            | Used for ban requests as well      |
| `VARNISH_ANALYTICS_PARAMS`                 |                            | See default value below            |
| `VARNISH_BACKEND_BETWEEN_BYTES_TIMEOUT`    | `60s`                      |                                    |
| `VARNISH_BACKEND_CONNECT_TIMEOUT`          | `3.5s`                     |                                    |
| `VARNISH_BACKEND_FIRST_BYTE_TIMEOUT`       | `60s`                      |                                    |
| `VARNISH_BACKEND_GRACE`                    | `2m`                       |                                    |
| `VARNISH_BACKEND_HOST`                     |                            | Mandatory                          |
| `VARNISH_BACKEND_PORT`                     | `80`                       |                                    |
| `VARNISH_BIG_FILES_SIZE`                   | `10485760`                 | 10MB                               |
| `VARNISH_BIG_FILES_TTL`                    | `120s`                     |                                    |
| `VARNISH_CACHE_STATIC_FILES`               |                            |                                    |
| `VARNISH_CONFIG_PRESET`                    |                            |                                    |
| `VARNISH_DEFAULT_TTL`                      | `120s`                     |                                    |
| `VARNISH_ERRORS_GRACE`                     | `15s`                      |                                    |
| `VARNISH_KEEP_ANALYTICS_COOKIES`           |                            |                                    |
| `VARNISH_KEEP_ANALYTICS_PARAMS`            |                            |                                    |
| `VARNISH_MOBILE_DISABLE_CASH`              |                            |                                    |
| `VARNISH_MOBILE_SEPARATE_CASH`             |                            |                                    |
| `VARNISH_MOBILE_USER_AGENT`                |                            | See default value below            |
| `VARNISH_PIPE_CLOSE_CONNECTION`            |                            |                                    |
| `VARNISH_PURGE_KEY`                        |                            | Randomly generated if missing      |
| `VARNISH_SECONDARY_STORAGE_CONDITION`      |                            | Must be valid VCL                  |
| `VARNISH_SECRET`                           |                            | Generated automatically if missing |
| `VARNISH_STATIC_FILES`                     |                            | See default value below            |
| `VARNISH_STATIC_TTL`                       | `86400`                    | In seconds                         |
| `VARNISH_STRIP_QUERY_PARAMS`               |                            |                                    |
| `VARNISHD_DEFAULT_TTL`                     | `120`                      |                                    |
| `VARNISHD_MEMORY_SIZE`                     | `64m`                      |                                    |
| `VARNISHD_PARAM_BAN_LURKER_AGE`            | `60.000`                   |                                    |
| `VARNISHD_PARAM_BAN_LURKER_BATCH`          | `1000`                     |                                    |
| `VARNISHD_PARAM_BAN_LURKER_SLEEP`          | `0.010`                    |                                    |
| `VARNISHD_PARAM_BETWEEN_BYTES_TIMEOUT`     | `60.000`                   |                                    |
| `VARNISHD_PARAM_CONNECT_TIMEOUT`           | `3.500`                    |                                    |
| `VARNISHD_PARAM_DEFAULT_GRACE`             | `10.000`                   |                                    |
| `VARNISHD_PARAM_DEFAULT_KEEP`              | `0.000`                    |                                    |
| `VARNISHD_PARAM_DEFAULT_TTL`               | `120.000`                  |                                    |
| `VARNISHD_PARAM_FETCH_CHUNKSIZE`           | `16k`                      |                                    |
| `VARNISHD_PARAM_FIRST_BYTE_TIMEOUT`        | `60.000`                   |                                    |
| `VARNISHD_PARAM_GZIP_BUFFER`               | `32k`                      |                                    |
| `VARNISHD_PARAM_GZIP_LEVEL`                | `6`                        |                                    |
| `VARNISHD_PARAM_GZIP_MEMLEVEL`             | `8`                        |                                    |
| `VARNISHD_PARAM_HTTP_GZIP_SUPPORT`         | `on`                       |                                    |
| `VARNISHD_PARAM_HTTP_MAX_HDR`              | `64`                       |                                    |
| `VARNISHD_PARAM_HTTP_REQ_HDR_LEN`          | `8k`                       |                                    |
| `VARNISHD_PARAM_HTTP_REQ_SIZE`             | `32k`                      |                                    |
| `VARNISHD_PARAM_HTTP_RESP_HDR_LEN`         | `8k`                       |                                    |
| `VARNISHD_PARAM_HTTP_RESP_SIZE`            | `32k`                      |                                    |
| `VARNISHD_PARAM_IDLE_SEND_TIMEOUT`         | `60.000`                   |                                    |
| `VARNISHD_PARAM_MAX_ESI_DEPTH`             | `5`                        |                                    |
| `VARNISHD_PARAM_MAX_RESTARTS`              | `4`                        |                                    |
| `VARNISHD_PARAM_MAX_RETRIES`               | `4`                        |                                    |
| `VARNISHD_PARAM_NUKE_LIMIT`                | `50`                       |                                    |
| `VARNISHD_PARAM_PING_INTERVAL`             | `3`                        |                                    |
| `VARNISHD_PARAM_PIPE_TIMEOUT`              | `60.000`                   |                                    |
| `VARNISHD_PARAM_POOL_REQ`                  | `10,100,10`                |                                    |
| `VARNISHD_PARAM_POOL_SESS`                 | `10,100,10`                |                                    |
| `VARNISHD_PARAM_PREFER_IPV6`               | `off`                      |                                    |
| `VARNISHD_PARAM_RUSH_EXPONENT`             | `3`                        |                                    |
| `VARNISHD_PARAM_SEND_TIMEOUT`              | `600`                      |                                    |
| `VARNISHD_PARAM_SESSION_MAX`               | `100000`                   |                                    |
| `VARNISHD_PARAM_SHORTLIVED`                | `10.000`                   |                                    |
| `VARNISHD_PARAM_TCP_KEEPALIVE_INTVL`       | `75.000`                   |                                    |
| `VARNISHD_PARAM_TCP_KEEPALIVE_PROBES`      | `8`                        |                                    |
| `VARNISHD_PARAM_TCP_KEEPALIVE_TIME`        | `7200.000`                 |                                    |
| `VARNISHD_PARAM_THREAD_POOL_ADD_DELAY`     | `0.000`                    |                                    |
| `VARNISHD_PARAM_THREAD_POOL_DESTROY_DELAY` | `1.000`                    |                                    |
| `VARNISHD_PARAM_THREAD_POOL_FAIL_DELAY`    | `0.200`                    |                                    |
| `VARNISHD_PARAM_THREAD_POOL_MAX`           | `5000`                     |                                    |
| `VARNISHD_PARAM_THREAD_POOL_MIN`           | `100`                      |                                    |
| `VARNISHD_PARAM_THREAD_POOL_STACK`         | `48k`                      |                                    |
| `VARNISHD_PARAM_THREAD_POOL_TIMEOUT`       | `300.000`                  |                                    |
| `VARNISHD_PARAM_THREAD_POOLS`              | `2`                        |                                    |
| `VARNISHD_PARAM_THREAD_QUEUE_LIMIT`        | `20`                       |                                    |
| `VARNISHD_PARAM_TIMEOUT_IDLE`              | `5.000`                    |                                    |
| `VARNISHD_PARAM_TIMEOUT_LINGER`            | `0.050`                    |                                    |
| `VARNISHD_PARAM_VSL_BUFFER`                | `4k`                       |                                    |
| `VARNISHD_PARAM_VSL_RECLEN`                | `255b`                     |                                    |
| `VARNISHD_PARAM_VSL_SPACE`                 | `80M`                      |                                    |
| `VARNISHD_PARAM_VSM_SPACE`                 | `1M`                       |                                    |
| `VARNISHD_PARAM_WORKSPACE_BACKEND`         | `64k`                      |                                    |
| `VARNISHD_PARAM_WORKSPACE_CLIENT`          | `64k`                      |                                    |
| `VARNISHD_PARAM_WORKSPACE_SESSION`         | `0.50k`                    |                                    |
| `VARNISHD_PARAM_WORKSPACE_THREAD`          | `2k`                       |                                    |
| `VARNISHD_SECONDARY_STORAGE`               |                            | See example below                  |
| `VARNISHD_SECRET_FILE`                     | `/etc/varnish/secret`      |                                    |
| `VARNISHD_VCL_SCRIPT`                      | `/etc/varnish/default.vcl` |                                    |

#### `VARNISH_MOBILE_USER_AGENT`:

Backslashes must be escaped as `\\`

```
ipod|android|blackberry|phone|mobile|kindle|silk|fennec|tablet|webos|palm|windows ce|nokia|philips|samsung|sanyo|sony|panasonic|ericsson|alcatel|series60|series40|opera mini|opera mobi|au-mic|audiovox|avantgo|blazer|danger|docomo|epoc|ericy|i-mode|ipaq|midp-|mot-|netfront|nitro|pocket|portalmmm|rover|sie-|symbian|cldc-|j2me|up\\.browser|up\\.link|vodafone|wap1\\.|wap2\\.
```

#### `VARNISH_STATIC_FILES`:

```
asc|doc|xls|ppt|csv|svg|jpg|jpeg|gif|png|ico|css|zip|tgz|gz|rar|bz2|pdf|txt|tar|wav|bmp|rtf|js|flv|swf|html|htm
```

#### `VARNISH_ANALYTICS_PARAMS`

```
utm_source|utm_medium|utm_campaign|utm_content|gclid|cx|ie|cof|siteurl
```

#### `VARNISH_SECONDARY_STORAGE_CONDITION`:

Allows defining custom conditions for storing the cache object in the secondary storage; as it is injected into an `if` it has to contain valid VCL syntax for it.

Please note that `VARNISHD_SECONDARY_STORAGE` must be defined as well, otherwise the secondary storage would not be available.

**Example:** instruct varnish to store in the secondary storage from the backend via custom header `X-Cache-Bin`:

`VARNISH_STORAGE_CONDITION='beresp.http.x-cache-bin = "secondary"'`

## Default behaviour

### When requests not cached?

* Requests method is not GET or HEAD
* Backend response has `Set-Cookie` header
* Static files (see `$VARNISH_STATIC_FILES`) not cached by default, use `$VARNISH_CACHE_STATIC_FILES` to enable
* Error pages 404 and >500 not cached with grace `$VARNISH_ERRORS_GRACE`
* AJAX requests not cached
* Big files (larger than `$VARNISH_BIG_FILES_SIZE`) not cached

### Purging and banning cache

* Purge and ban requests both use Varnish's `ban` method
* Unrestricted purge/bans requests methods are not allowed. The key `$VARNISH_PURGE_KEY` will be generated if not specified. Use header `X-VC-My-Purge-Key` to pass the key
* Purge requests look up for exact match but ignores query params, you can change the method by setting `X-VC-Purge-Method` to `regex` or `exact`
* Ban request currently purges cache only by `Cache-Tags` header (for Drupal). You normally need to use purge requests

### Miscellaneous

* Header `X-VC-Cache` set to `HIT` or `MISS` when varnish delivers content
* Cache hash includes host (or ip) and request protocol
* Varnish adds client's IP added to `X-Forwarded-For`
* [Websocket requests supported](https://varnish-cache.org/docs/4.1/users-guide/vcl-example-websockets.html)
* Analytics params and cookies stripped, see `$VARNISH_KEEP_ANALYTICS_*`
* Hashes and trailing `?` stripped from URL before passing to backend
* Cache for mobile devices can be separated by setting `$VARNISH_MOBILE_SEPARATE_CASH` or completely disabled via `$VARNISH_MOBILE_DISABLE_CASH`. User agent regex `$VARNISH_MOBILE_USER_AGENT` used to identify the mobile devices
* Set the following headers from backend to disable caching: `X-VC-Cacheable: NO`, `Cache-control: private`, `Cache-control: no-cache`
* Set `X-VC-Debug` to show cache hashes and pass through header `X-VC-DebugMessage`
* `BigPipe` supported
* Secondary storage can be defined via `$VARNISH_STORAGE_CONDITION`

## Config presets

You can use one of the following config presets to extend the default behaviour:

### Drupal

Add `VARNISH_CONFIG_PRESET=drupal` to use this preset.

Specific behaviour:

* Pages matching `$VARNISH_DRUPAL_EXCLUDE_URLS` will not be cached
* If any of cookies specified in `$VARNISH_DRUPAL_PRESERVED_COOKIES` are set a page will not be cached. All other cookies stripped  

Additional environment variables for Drupal preset:

#### `VARNISH_DRUPAL_EXCLUDE_URLS`:

Backslashes must be escaped as `\\`

```
^(/update\\.php|/([a-z]{2}/)?admin|/([a-z]{2}/)?admin/.*|/([a-z]{2}/)?system/files/.*|/([a-z]{2}/)?flag/.*|.*/ajax/.*|.*/ahah/.*)$
```

#### `VARNISH_DRUPAL_PRESERVED_COOKIES`:

```
SESS[a-z0-9]+|SSESS[a-z0-9]+|NO_CACHE
```

### WordPress

Add `VARNISH_CONFIG_PRESET=wordpress` to use this preset.

Specific behaviour:

* Does not cache logged-in users
* Passes through requests with `ak_action|app-download` query params or cookie `akm_mobile` for Jetpack mobile plugin
* Strips `replytocom=` query param
* Use `$VARNISH_WP_ADMIN_SUBDOMAIN` if you have your admin on a subdomain to disable caching 

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
