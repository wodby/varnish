#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

exec varnishd \
    -j unix,user=varnish \
    -F \
    -a :6081 \
    -T :6082 \
    -f {{ getenv "VARNISHD_VCL_SCRIPT" "/etc/varnish/default.vcl" }} \
    -S {{ getenv "VARNISHD_SECRET_FILE" "/etc/varnish/secret" }} \
    -s main=malloc,{{ getenv "VARNISHD_MEMORY_SIZE" "64M" }} \
    {{ if getenv "VARNISHD_SECONDARY_STORAGE" }} -s secondary={{ getenv "VARNISHD_SECONDARY_STORAGE" }} {{ end }}\
    -t {{ getenv "VARNISHD_DEFAULT_TTL" "120" }} \
    -p ban_lurker_age={{ getenv "VARNISHD_PARAM_BAN_LURKER_AGE" "60.000" }} \
    -p ban_lurker_batch={{ getenv "VARNISHD_PARAM_BAN_LURKER_BATCH" "1000" }} \
    -p ban_lurker_sleep={{ getenv "VARNISHD_PARAM_BAN_LURKER_SLEEP" "0.010" }} \
    -p between_bytes_timeout={{ getenv "VARNISHD_PARAM_BETWEEN_BYTES_TIMEOUT" "60.000" }} \
    -p connect_timeout={{ getenv "VARNISHD_PARAM_CONNECT_TIMEOUT" "3.500" }} \
    -p default_grace={{ getenv "VARNISHD_PARAM_DEFAULT_GRACE" "10.000" }} \
    -p default_keep={{ getenv "VARNISHD_PARAM_DEFAULT_KEEP" "0.000" }} \
    -p default_ttl={{ getenv "VARNISHD_PARAM_DEFAULT_TTL" "120.000" }} \
    -p fetch_chunksize={{ getenv "VARNISHD_PARAM_FETCH_CHUNKSIZE" "16k" }} \
    -p first_byte_timeout={{ getenv "VARNISHD_PARAM_FIRST_BYTE_TIMEOUT" "60.000" }} \
    -p gzip_buffer={{ getenv "VARNISHD_PARAM_GZIP_BUFFER" "32k" }} \
    -p gzip_level={{ getenv "VARNISHD_PARAM_GZIP_LEVEL" "6" }} \
    -p gzip_memlevel={{ getenv "VARNISHD_PARAM_GZIP_MEMLEVEL" "8" }} \
    -p http_gzip_support={{ getenv "VARNISHD_PARAM_HTTP_GZIP_SUPPORT" "on" }} \
    -p http_max_hdr={{ getenv "VARNISHD_PARAM_HTTP_MAX_HDR" "64" }} \
    -p http_req_hdr_len={{ getenv "VARNISHD_PARAM_HTTP_REQ_HDR_LEN" "8k" }} \
    -p http_req_size={{ getenv "VARNISHD_PARAM_HTTP_REQ_SIZE" "32k" }} \
    -p http_resp_hdr_len={{ getenv "VARNISHD_PARAM_HTTP_RESP_HDR_LEN" "8k" }} \
    -p http_resp_size={{ getenv "VARNISHD_PARAM_HTTP_RESP_SIZE" "32k" }} \
    -p idle_send_timeout={{ getenv "VARNISHD_PARAM_IDLE_SEND_TIMEOUT" "60.000" }} \
    -p max_esi_depth={{ getenv "VARNISHD_PARAM_MAX_ESI_DEPTH" "5" }} \
    -p max_restarts={{ getenv "VARNISHD_PARAM_MAX_RESTARTS" "4" }} \
    -p max_retries={{ getenv "VARNISHD_PARAM_MAX_RETRIES" "4" }} \
    -p nuke_limit={{ getenv "VARNISHD_PARAM_NUKE_LIMIT" "50" }} \
    -p ping_interval={{ getenv "VARNISHD_PARAM_PING_INTERVAL" "3" }} \
    -p pipe_timeout={{ getenv "VARNISHD_PARAM_PIPE_TIMEOUT" "60.000" }} \
    -p pool_req={{ getenv "VARNISHD_PARAM_POOL_REQ" "10,100,10" }} \
    -p pool_sess={{ getenv "VARNISHD_PARAM_POOL_SESS" "10,100,10" }} \
    -p prefer_ipv6={{ getenv "VARNISHD_PARAM_PREFER_IPV6" "off" }} \
    -p rush_exponent={{ getenv "VARNISHD_PARAM_RUSH_EXPONENT" "3" }} \
    -p send_timeout={{ getenv "VARNISHD_PARAM_SEND_TIMEOUT" "600" }} \
    -p session_max={{ getenv "VARNISHD_PARAM_SESSION_MAX" "100000" }} \
    -p shortlived={{ getenv "VARNISHD_PARAM_SHORTLIVED" "10.000" }} \
    -p tcp_keepalive_intvl={{ getenv "VARNISHD_PARAM_TCP_KEEPALIVE_INTVL" "75.000" }} \
    -p tcp_keepalive_probes={{ getenv "VARNISHD_PARAM_TCP_KEEPALIVE_PROBES" "8" }} \
    -p tcp_keepalive_time={{ getenv "VARNISHD_PARAM_TCP_KEEPALIVE_TIME" "7200.000" }} \
    -p thread_pool_add_delay={{ getenv "VARNISHD_PARAM_THREAD_POOL_ADD_DELAY" "0.000" }} \
    -p thread_pool_destroy_delay={{ getenv "VARNISHD_PARAM_THREAD_POOL_DESTROY_DELAY" "1.000" }} \
    -p thread_pool_fail_delay={{ getenv "VARNISHD_PARAM_THREAD_POOL_FAIL_DELAY" "0.200" }} \
    -p thread_pool_max={{ getenv "VARNISHD_PARAM_THREAD_POOL_MAX" "5000" }} \
    -p thread_pool_min={{ getenv "VARNISHD_PARAM_THREAD_POOL_MIN" "100" }} \
    -p thread_pool_stack={{ getenv "VARNISHD_PARAM_THREAD_POOL_STACK" "48k" }} \
    -p thread_pool_timeout={{ getenv "VARNISHD_PARAM_THREAD_POOL_TIMEOUT" "300.000" }} \
    -p thread_pools={{ getenv "VARNISHD_PARAM_THREAD_POOLS" "2" }} \
    -p thread_queue_limit={{ getenv "VARNISHD_PARAM_THREAD_QUEUE_LIMIT" "20" }} \
    -p timeout_idle={{ getenv "VARNISHD_PARAM_TIMEOUT_IDLE" "5.000" }} \
    -p timeout_linger={{ getenv "VARNISHD_PARAM_TIMEOUT_LINGER" "0.050" }} \
    -p vsl_buffer={{ getenv "VARNISHD_PARAM_VSL_BUFFER" "4k" }} \
    -p vsl_reclen={{ getenv "VARNISHD_PARAM_VSL_RECLEN" "255b" }} \
    -p vsl_space={{ getenv "VARNISHD_PARAM_VSL_SPACE" "80M" }} \
    -p vsm_space={{ getenv "VARNISHD_PARAM_VSM_SPACE" "1M" }} \
    -p workspace_backend={{ getenv "VARNISHD_PARAM_WORKSPACE_BACKEND" "64k" }} \
    -p workspace_client={{ getenv "VARNISHD_PARAM_WORKSPACE_CLIENT" "64k" }} \
    -p workspace_session={{ getenv "VARNISHD_PARAM_WORKSPACE_SESSION" "0.50k" }} \
    -p workspace_thread={{ getenv "VARNISHD_PARAM_WORKSPACE_THREAD" "2k" }}
