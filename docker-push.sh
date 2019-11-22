#!/bin/sh
HUB_REPOSITORY=rfocosi/synchronet-bbs

docker build --build-arg BUILD_TYPE=minimal -t $HUB_REPOSITORY:minimal .
[ "$?" != "0" ] && exit 1
docker push $HUB_REPOSITORY:minimal

docker build --build-arg BUILD_TYPE=all -t $HUB_REPOSITORY:all .
[ "$?" != "0" ] && exit 1
docker push $HUB_REPOSITORY:all
