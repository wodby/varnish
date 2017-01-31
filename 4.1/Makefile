-include env_make

NS = wodby
VERSION ?= 4.1

REPO = varnish
NAME = varnish-$(VERSION)

.PHONY: build test test-clean push shell run start stop logs rm release

build:
	docker build -t $(NS)/$(REPO):$(VERSION) ./

test:
	IMAGE=$(NS)/$(REPO):$(VERSION) ./test.sh

test-clean:
	IMAGE=$(NS)/$(REPO):$(VERSION) ./test.sh clean

push:
	docker push $(NS)/$(REPO):$(VERSION)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION) /bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION) $(CMD)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

rm:
	docker rm -f $(NAME)

release: build
	make push -e VERSION=$(VERSION)

default: build
