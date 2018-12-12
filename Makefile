-include env.mk

VARNISH_VER ?= 6.0.2
VARNISH_VER_MINOR = $(shell v='$(VARNISH_VER)'; echo "$${v%.*}")

TAG ?= $(VARNISH_VER_MINOR)

REPO = wodby/varnish
NAME = varnish-$(VARNISH_VER_MINOR)

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

.PHONY: build test test-clean push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) --build-arg VARNISH_VER=$(VARNISH_VER) ./

test:
	cd ./tests/basic && IMAGE=$(REPO):$(TAG) ./run.sh
	cd ./tests/drupal && IMAGE=$(REPO):$(TAG) ./run.sh
	cd ./tests/wordpress && IMAGE=$(REPO):$(TAG) ./run.sh

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
