DOCKER_BAKE_FILE := -f docker-bake.hcl -f hacks/docker-metadata-action.hcl

.EXPORT_ALL_VARIABLES:
ALPINE_VERSION := edge
DOCKER_META_IMAGES := libreofficedocker/alpine
DOCKER_META_VERSION := local-${ALPINE_VERSION}

print:
	docker buildx bake $(DOCKER_BAKE_FILE) --print

build:
	docker buildx bake $(DOCKER_BAKE_FILE) --load --set="*.platform="
