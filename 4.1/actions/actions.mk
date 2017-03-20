.PHONY: flush check-ready check-live

host ?= localhost
port ?= 6081
port_adm ?= 6082
max_try ?= 30
wait_seconds ?= 1

default: check-ready

flush:
	varnishadm -T $(host):$(port_adm) -S /etc/varnish/secret "ban req.http.host ~ ."

check-ready:
	wait-for-varnish.sh $(host) $(port) $(max_try) $(wait_seconds)

check-live:
	@echo "OK"
