-include .env.mk

.env.mk: .env
		sed 's/"//g ; s/=/:=/' < $< > $@

.PHONY: all build
.DEFAULT_GOAL := build

all: build push

ID:=$(shell id -u)

build:
	podman build --pull -t $(IMAGE) .

shell:
	/usr/bin/docker run --rm -it -e COLUMNS="`tput cols`" \
		-e LINES="`tput lines`" --entrypoint /bin/bash \
		-v $(MEDIADIR):/media -u $(UID) $(IMAGE)
