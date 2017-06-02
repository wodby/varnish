.PHONY: flush check-ready check-live

host ?= localhost
max_try ?= 1
wait_seconds ?= 1
delay_seconds ?= 0

default: check-ready

flush:
	varnishadm -T $(host):6082 -S /etc/varnish/secret "ban req.http.host ~ ."

check-ready:
	wait-for-varnish.sh $(host) $(max_try) $(wait_seconds) $(delay_seconds)

check-live:
	@echo "OK"
