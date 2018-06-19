.PHONY: flush check-ready check-live

host ?= localhost
max_try ?= 1
wait_seconds ?= 1
delay_seconds ?= 0
command = varnishadm -T ${host}:6082 -S /etc/varnish/secret 'status' | grep -q 'Child in state running'
service = Varnish

default: check-ready

flush:
	varnishadm -T $(host):6082 -S /etc/varnish/secret "ban req.http.host ~ ."

check-ready:
	wait_for "$(command)" $(service) $(host) $(max_try) $(wait_seconds) $(delay_seconds)

check-live:
	@echo "OK"
