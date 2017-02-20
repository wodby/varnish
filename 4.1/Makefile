-include env_make

VERSION ?= 4.1

REPO = varnish
NAME = varnish-$(VERSION)

.PHONY: build test test-clean push shell run start stop logs clean release

build:
	docker build -t $(REPO):$(VERSION) ./

test:
	IMAGE=$(REPO):$(VERSION) ./test.sh

push:
	docker push $(REPO):$(VERSION)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION) /bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION) $(CMD)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build
	make push -e VERSION=$(VERSION)

default: build
