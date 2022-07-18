#!/bin/bash

set -Eeuo pipefail

COS_PATH="cos://pkg-1308438674/files/stacksmith"
REPO_URL="https://api.github.com/repos/gogs/gogs/releases/latest"
LATEST_VER=$( curl -s -L $REPO_URL | jq -r .tag_name | sed 's/^v//')
CURRENT_VER=$( grep ^ver VERSION |cut -d = -f 2 )

repack() {
  local ver=${1:?version is error.}
  local base_name="gogs_${ver}_linux_amd64.tar.gz"

  [ ! -d /tmp/$ver ] && mkdir /tmp/$ver -pv

  wget -O /tmp/${ver}/${base_name} https://dl.gogs.io/$ver/$base_name \
  && cd /tmp/$ver \
  && tar xvzf $base_name \
  && mkdir -pv apps/gogs/bin \
  && mv gogs/gogs apps/gogs/bin/ \
  && upx -9 apps/gogs/bin/gogs \
  && tar czvf gogs-$ver-debian-11-amd64.tar.gz apps \
  && upload_to_cos "gogs-$ver-debian-11-amd64.tar.gz" \
  && echo "sha=$(cat gogs-$ver-debian-11-amd64.tar.gz.sha256)" >> VERSION \
  && cd ../ \
  && rm -rf $ver
}

upload_to_cos() {

  local filename=${1:?filename is missing.}
  local sha_file=${filename}.sha256

  if [ "$filename" == "" ];then
    echo "$0 need file to upload"
    exit 1
  else
    # create sha256sum file
    echo "Create sha256 file: $sha_file"
    sha256sum $filename > $sha_file

    echo "Upload $filename..."
    coscli cp $filename ${COS_PATH}/${filename}

    echo "Upload $sha_file..."
    coscli cp $sha_file ${COS_PATH}/${sha_file}
  fi

}



if [ "$LATEST_VER" != "$CURRENT_VER" ];then
  echo "ver=${LATEST_VER}" > VERSION
  echo "New version was detected. repack gogs and rebuild docker image."
  repack $LATEST_VER
else
  echo "$CURRENT_VER is the latest version."
fi
