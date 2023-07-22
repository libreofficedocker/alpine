ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION} AS base

# Poorman process queue using "lockrun.c"
# https://github.com/libreofficedocker/lockrun.c
FROM base AS lockrun
RUN apk add gcc musl-dev \
    && wget -O lockrun.c https://github.com/libreofficedocker/lockrun.c/raw/main/lockrun.c \
    && gcc lockrun.c -o lockrun

# LibreOffice
FROM base

# Default to UTF-8 file.encoding
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"

ARG ALPINE_VERSION
ARG ALPING_EXTRA_PKGS=
RUN <<EOF
    set -euxo pipefail
    ICU_PKGS=""
    if [ ${ALPINE_VERSION} = "edge" ]; then
        ICU_PKGS="icu-data-full"
    elif [ "$(echo "${ALPINE_VERSION} < 3.13" | bc)" -eq 1 ]; then
        ICU_PKGS=""
    elif [ "$(echo "${ALPINE_VERSION} < 3.16" | bc)" -eq 1 ]; then
        ICU_PKGS="icu-data"
    else
        ICU_PKGS="icu-data-full"
    fi
    apk add -U --no-cache \
        bash curl tzdata \
        icu icu-libs ${ICU_PKGS} \
        libstdc++ dbus-x11 \
        ${ALPING_EXTRA_PKGS}
EOF

# fonts - https://wiki.alpinelinux.org/wiki/Fonts
RUN <<EOF
    set -euxo pipefail
    FONT_PKGS=""
    if [ ${ALPINE_VERSION} = "edge" ]; then
        FONT_PKGS="font-noto-all font-noto-cjk ttf-font-awesome ttf-hack"
    elif [ "$(echo "${ALPINE_VERSION} >= 3.13" | bc)" -eq 1 ]; then
        FONT_PKGS="font-noto-all font-noto-cjk ttf-font-awesome ttf-hack"
    else
        FONT_PKGS="font-noto"
    fi
    apk add -U --no-cache \
        ${FONT_PKGS} \
        terminus-font \
        ttf-dejavu \
        ttf-freefont \
        ttf-inconsolata \
        ttf-liberation \
        ttf-opensans   \
        fontconfig \
        msttcorefonts-installer
    update-ms-fonts
    fc-cache -fv
EOF

# Install LibreOffice
RUN <<EOF
    set -euxo pipefail
    apk add -U --no-cache \
        libreoffice-common \
        libreoffice-calc \
        libreoffice-draw \
        libreoffice-impress \
        libreoffice-writer \
        libreoffice-lang-en_us \
        libreofficekit \
        openjdk11-jre-headless
EOF

ENV LD_LIBRARY_PATH=/usr/lib
ENV URE_BOOTSTRAP="vnd.sun.star.pathname:/usr/lib/libreoffice/program/fundamentalrc"
ENV PATH="/usr/lib/libreoffice/program:$PATH"
ENV UNO_PATH="/usr/lib/libreoffice/program"
ENV LD_LIBRARY_PATH="/usr/lib/libreoffice/program:/usr/lib/libreoffice/ure/lib:$LD_LIBRARY_PATH"
ENV PYTHONPATH="/usr/lib/libreoffice/program:$PYTHONPATH"

# lockrun
COPY --from=lockrun /lockrun /usr/bin/lockrun
