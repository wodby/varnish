# Generic varnish docker container

[![Build Status](https://travis-ci.org/wodby/varnish.svg?branch=master)](https://travis-ci.org/wodby/varnish)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/varnish.svg)](https://hub.docker.com/r/wodby/varnish)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/varnish.svg)](https://hub.docker.com/r/wodby/varnish)

Supported tags and respective `Dockerfile` links

- [`4.1`, `latest` (*4.1/Dockerfile*)](https://github.com/wodby/varnish/tree/master/4.1/Dockerfile)

## Environment Variables Available for Customization

| Environment Variable | Type | Default Value | Required | Description |
| -------------------- | -----| ------------- | -------- | ----------- |
| VARNISH_BACKEND_HOST          | String |                          | ✓ | |
| VARNISH_BACKEND_PORT          | String |                          | ✓ | |
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
