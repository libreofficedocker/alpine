variable "ALPINE_VERSION" {
    default = "3.16"
}

target "docker-metadata-action" {}

target "default" {
    inherits = ["docker-metadata-action"]
    dockerfile = "Dockerfile"
    context = "."
    args = {
        ALPINE_VERSION = "${ALPINE_VERSION}"
    }
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
}
