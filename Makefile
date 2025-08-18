DOCKER_BAKE_FILE := -f docker-bake.hcl -f hacks/docker-metadata-action.hcl
ALPINE_VERSION := latest

.EXPORT_ALL_VARIABLES:
DOCKER_META_IMAGES := libreofficedocker/alpine
DOCKER_META_VERSION := local-latest

print:
	docker buildx bake $(DOCKER_BAKE_FILE) --print

build:
	docker buildx bake $(DOCKER_BAKE_FILE) --load --set="*.platform="
