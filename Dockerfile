FROM debian:11.4-slim

LABEL maintainer "zhouyueqiu <zhouyueqiu@easycorp.ltd>"

ENV OS_ARCH="amd64" \
    OS_NAME="debian-11" \
    HOME_PAGE="gogs.io"

COPY debian/prebuildfs /

ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive

RUN install_packages curl wget zip unzip s6 pwgen git cron procps libedit2 \
    && groupadd -g 1024 git \
    && useradd -u 1024 -g 1024 -s /usr/sbin/nologin -d /data/git -M git

# Install gogs
ARG VERSION
ARG APP_SHA256
ENV EASYSOFT_APP_NAME="gogs $VERSION"

# Install render-template
RUN . /opt/easysoft/scripts/libcomponent.sh && component_unpack "render-template" "1.0.1-10" --checksum 5e410e55497aa79a6a0c5408b69ad4247d31098bdb0853449f96197180ed65a4

# Install su-exec
RUN . /opt/easysoft/scripts/libcomponent.sh && component_unpack "su-exec" "0.2" --checksum 687d29fd97482f493efec73a9103da232ef093b2936a341d85969bc9b9498910

# Install wait-for-port
RUN . /opt/easysoft/scripts/libcomponent.sh && component_unpack "wait-for-port" "1.01" -c 2ad97310f0ecfbfac13480cabf3691238fdb3759289380262eb95f8660ebb8d1

# Install mysql-client
RUN . /opt/easysoft/scripts/libcomponent.sh && component_unpack "mysql-client" "10.5.15" -c 31182985daa1a2a959b5197b570961cdaacf3d4e58e59a192c610f8c8f1968a8

# Download gogs
RUN . /opt/easysoft/scripts/libcomponent.sh && component_unpack "gogs" "${VERSION}" -c ${APP_SHA256}

# Copy apache,php and gogs config files
COPY debian/rootfs /

WORKDIR /apps/gogs

EXPOSE 3000

# Persistence directory
VOLUME [ "/data"]

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
