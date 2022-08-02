FROM debian:11.4-slim

LABEL maintainer "zhouyueqiu <zhouyueqiu@easycorp.ltd>"

ENV OS_ARCH="amd64" \
    OS_NAME="debian-11" \
    HOME_PAGE="gogs.io"

COPY debian/prebuildfs /

ENV TZ=Asia/Shanghai

RUN install_packages curl wget zip unzip s6 pwgen git cron procps libedit2 \
    && groupadd -g 1024 git \
    && useradd -u 1024 -g 1024 -s /usr/sbin/nologin -d /data/git -M git

# Install gogs
ARG VERSION
ENV EASYSOFT_APP_NAME="gogs $VERSION"

# Install render-template
RUN . /opt/easysoft/scripts/libcomponent.sh && component_unpack "render-template" "1.0.1-10"

# Install su-exec
RUN . /opt/easysoft/scripts/libcomponent.sh && component_unpack "su-exec" "0.2"

# Install wait-for-port
RUN . /opt/easysoft/scripts/libcomponent.sh && component_unpack "wait-for-port" "1.01"

# Install mysql-client
RUN . /opt/easysoft/scripts/libcomponent.sh && component_unpack "mysql-client" "10.5.15"

# Download gogs
RUN . /opt/easysoft/scripts/libcomponent.sh && component_unpack "gogs" "${VERSION}"

# Copy apache,php and gogs config files
COPY debian/rootfs /

WORKDIR /apps/gogs

EXPOSE 3000

# Persistence directory
VOLUME [ "/data"]

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
