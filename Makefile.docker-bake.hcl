variable "ALPINE_VERSION" {
    default = "3.16"
}

variable "DOCKER_META_IMAGES" {}
variable "DOCKER_META_VERSION" {}

target "docker-metadata-action" {
    tags = [
        "${DOCKER_META_IMAGES}:${DOCKER_META_VERSION}"
    ]
}

target "default" {
    inherits = ["docker-metadata-action"]
    dockerfile = "Dockerfile"
    context = "."
    args = {
        ALPINE_VERSION = "${ALPINE_VERSION}"
        ALPING_EXTRA_PKGS = "htop"
    }
}
