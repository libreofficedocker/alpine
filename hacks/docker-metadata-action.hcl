variable "DOCKER_META_IMAGES" {}
variable "DOCKER_META_VERSION" {}

target "docker-metadata-action" {
    tags = [
        "${DOCKER_META_IMAGES}:${DOCKER_META_VERSION}"
    ]
}
