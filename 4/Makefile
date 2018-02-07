VARNISH_VER ?= 4.1.9
VARNISH_VER_ALPINE ?= $(VARNISH_VER)-r0
TAG ?= $(VARNISH_VER)

REPO = wodby/varnish
NAME = varnish-$(VARNISH_VER)

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

.PHONY: build test test-clean push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) \
		--build-arg VARNISH_VER=$(VARNISH_VER) \
		--build-arg VARNISH_VER_ALPINE=$(VARNISH_VER_ALPINE) ./

test:
	cd ./test && IMAGE=$(REPO):$(TAG) ./test.sh

push:
	docker push $(REPO):$(TAG)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) $(CMD)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build push
