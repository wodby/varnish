import directors;

backend backend1 {
    .host = "{{ getenv "VARNISH_BACKEND_HOST" }}";
    .port = "{{ getenv "VARNISH_BACKEND_PORT" "80" }}";
	.first_byte_timeout = {{ getenv "VARNISH_BACKEND_FIRST_BYTE_TIMEOUT" "60s" }};
	.connect_timeout = {{ getenv "VARNISH_BACKEND_CONNECT_TIMEOUT" "3.5s" }};
	.between_bytes_timeout = {{ getenv "VARNISH_BACKEND_BETWEEN_BYTES_TIMEOUT" "60s" }};
}

sub vcl_init {
	new backends = directors.round_robin();
	backends.add_backend(backend1);
}

sub vcl_recv {
	set req.backend_hint = backends.backend();
}
