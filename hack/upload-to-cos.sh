#!/bin/bash

FILENAME=$1
COS_PATH="cos://pkg-1308438674/files/stacksmith"
SHA_FILE=${FILENAME}.sha256

if [ "$FILENAME" == "" ];then
  echo "$0 need file to upload"
  exit 1
else
  # create sha256sum file
  echo "Create sha256 file: $SHA_FILE"
  sha256sum $1 > $SHA_FILE

  echo "Upload $FILENAME..."
  coscli cp $FILENAME ${COS_PATH}/${FILENAME}

  echo "Upload $SHA_FILE..."
  coscli cp $SHA_FILE ${COS_PATH}/${SHA_FILE}
fi
