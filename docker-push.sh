#!/bin/sh
HUB_REPOSITORY=rfocosi/synchronet-bbs

docker build -f Dockerfile-base -t $HUB_REPOSITORY:base .
[ "$?" != "0" ] && exit 1
docker push $HUB_REPOSITORY:base

docker build -f Dockerfile-minimal -t $HUB_REPOSITORY:minimal .
[ "$?" != "0" ] && exit 1
docker push $HUB_REPOSITORY:minimal

docker build -f Dockerfile-all -t $HUB_REPOSITORY:all .
[ "$?" != "0" ] && exit 1
docker push $HUB_REPOSITORY:all
