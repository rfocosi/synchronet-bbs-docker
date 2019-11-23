#!/bin/sh
HUB_REPOSITORY=rfocosi/synchronet-bbs

docker build -f Dockerfile-minimal -t $HUB_REPOSITORY:minimal .
[ "$?" != "0" ] && exit 1
docker push $HUB_REPOSITORY:minimal

docker build -f Dockerfile-all -t $HUB_REPOSITORY:all .
[ "$?" != "0" ] && exit 1
docker tag $HUB_REPOSITORY:all $HUB_REPOSITORY:latest
docker push $HUB_REPOSITORY:all
docker push $HUB_REPOSITORY:latest
