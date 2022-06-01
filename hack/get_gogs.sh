#!/bin/bash

ver=$1

if [ "$ver" == "" ];then
  echo $0: Please input gogs version to download.
  exit 1
fi

base_name="gogs_${ver}_linux_amd64.tar.gz"

[ ! -d $ver ] && mkdir $ver -pv

wget -O ${ver}/${base_name} https://dl.gogs.io/$ver/$base_name \
&& cd $ver \
&& tar xvzf $base_name \
&& mkdir -pv apps/gogs/bin \
&& mv gogs/gogs apps/gogs/bin/ \
&& upx -9 apps/gogs/bin/gogs \
&& tar czvf gogs-$ver-debian-11-amd64.tar.gz apps \
&& ../upload-to-cos.sh gogs-$ver-debian-11-amd64.tar.gz \
&& cat gogs-$ver-debian-11-amd64.tar.gz.sha256 \
&& cd ../ \
&& rm -rf $ver
