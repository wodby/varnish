-include env.mk

VARNISH_VER ?= 6.0.16
VARNISH_VER_MINOR = $(shell echo "${VARNISH_VER}" | grep -oE '^[0-9]+\.[0-9]+')

ALPINE_VER ?= 3.22

PLATFORM ?= linux/arm64

ifeq ($(BASE_IMAGE_STABILITY_TAG),)
    BASE_IMAGE_TAG := $(ALPINE_VER)
else
    BASE_IMAGE_TAG := $(ALPINE_VER)-$(BASE_IMAGE_STABILITY_TAG)
endif

TAG ?= $(VARNISH_VER_MINOR)

REPO = wodby/varnish
NAME = varnish-$(VARNISH_VER_MINOR)

ifneq ($(ARCH),)
	override TAG := $(TAG)-$(ARCH)
endif

.PHONY: build buildx-build buildx-push test test-clean push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) \
	    --build-arg BASE_IMAGE_TAG=$(BASE_IMAGE_TAG) \
	    --build-arg VARNISH_VER=$(VARNISH_VER) ./

buildx-build:
	docker buildx build --platform $(PLATFORM) -t $(REPO):$(TAG) \
	    --build-arg BASE_IMAGE_TAG=$(BASE_IMAGE_TAG) \
	    --build-arg VARNISH_VER=$(VARNISH_VER) \
	    --load \
	    ./

buildx-push:
	docker buildx build --push --platform $(PLATFORM) -t $(REPO):$(TAG) \
	    --build-arg BASE_IMAGE_TAG=$(BASE_IMAGE_TAG) \
	    --build-arg VARNISH_VER=$(VARNISH_VER) \
	    ./

buildx-imagetools-create:
	docker buildx imagetools create -t $(REPO):$(TAG) \
				$(REPO):$(VARNISH_VER_MINOR)-amd64 \
				$(REPO):$(VARNISH_VER_MINOR)-arm64
.PHONY: buildx-imagetools-create

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
