#!/bin/bash

VERSION="0.0.0-$(git log -1 --format=%cd --date=format:'%Y%m%d%H%M%S')-$(git rev-parse --short=12 HEAD)"
PACKAGE=$1

if [[ $(yarn versions "@clutch-sh/${PACKAGE}" | grep "$VERSION") ]]; then
  echo "Found existing version of ${PACKAGE}@${VERSION}"
  exit 0
fi

(
  cd $PWD && yarn publish --new-version="$VERSION" --access public --dry-run
)