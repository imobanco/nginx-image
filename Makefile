CURRENT_DIR=$(shell basename $(CURRENT_PWD))
CURRENT_PWD=$(shell pwd)
DATE:=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
GIT_REVISION:=$(shell git rev-parse --short HEAD)

IMAGE_REGISTRY=ghcr.io
IMAGE_NAME=imobanco/nginx
IMAGE_TAG=latest
IMAGE=$(IMAGE_REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)
CONTAINERFILE=Containerfile_1.23

print-%  : ; @echo $($*)

build:
	podman build --file $(CONTAINERFILE) --tag $(IMAGE) --label org.opencontainers.image.created=$(DATE) --label org.opencontainers.image.revision=$(GIT_REVISION) $(args) .

pull: login.registry
	podman pull $(IMAGE)

push.to.registry:
	podman push $(IMAGE)

login.IMAGE_REGISTRY:
	podman login $(IMAGE_REGISTRY)

logout.IMAGE_REGISTRY:
	podman logout $(IMAGE_REGISTRY)

build.and.push:
	make build
	make login.registry.stdin
	make push.to.registry

login.registry:
	podman login $(IMAGE_REGISTRY)

logout.registry:
	podman logout $(IMAGE_REGISTRY)

login.registry.stdin:
	@echo $(PASSWORD)  | podman login --username $(USERNAME) --password-stdin $(IMAGE_REGISTRY)
