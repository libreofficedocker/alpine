## About

A ready-to-go Libreoffice in Docker built on top of Alpine releases

### Pre-built image

[![Release](https://github.com/libreofficedocker/alpine/actions/workflows/release.yml/badge.svg)](https://github.com/libreofficedocker/alpine/actions/workflows/release.yml)
[![Test](https://github.com/libreofficedocker/alpine/actions/workflows/test.yml/badge.svg)](https://github.com/libreofficedocker/alpine/actions/workflows/test.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/libreofficedocker/alpine)](https://hub.docker.com/r/libreofficedocker/alpine)

This image uses the [`alpine`](https://hub.docker.com/_/alpine) as base images.

> **Note**
>
> You can find the pre-built images on [Docker Hub](https://hub.docker.com/u/libreofficedocker).
> All release are built following Alpine release versions and only the last 10 versions are built.

```
docker pull libreofficedocker/alpine:${ALPINE_VERSION}
```

> [!NOTE]
> The container images are being build and pushed to the registry periodically through an automated process. It schedules a build every week to ensure that the images are up-to-date with the latest security patches and updates.
>
> Runs at 00:00, only on Saturday every week.

If you want to stick with a specific version, you can pull the image with the tag corresponding to a specific commit hash. Please check the [![Release](https://github.com/libreofficedocker/alpine/actions/workflows/release.yml/badge.svg)](https://github.com/libreofficedocker/alpine/actions/workflows/release.yml) workflow for the build and tags you want to use.

## License

Licensed under [Apache-2.0 license](LICENSE)

<!-- Trigger CI # -->
