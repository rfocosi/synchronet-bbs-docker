#!/bin/sh
HUB_REPOSITORY=rfocosi/synchronet-bbs
# VERSION=`grep CVS_VERSION Dockerfile-src | sed 's/.\+CVS_VERSION=//' | head -n1`
VERSION=HEAD

if [ -z "$VERSION" ]; then
  echo "ERROR: CVS_VERSION not found on Dockerfile-src!"
  exit 1
fi

docker build -f Dockerfile-base -t $HUB_REPOSITORY:base .

[ "$?" != "0" ] && exit 1

docker tag $HUB_REPOSITORY:base $HUB_REPOSITORY:base-$VERSION
docker push $HUB_REPOSITORY:base-$VERSION
docker push $HUB_REPOSITORY:base


docker build -f Dockerfile-no-xtrn -t $HUB_REPOSITORY:no-xtrn .

[ "$?" != "0" ] && exit 1

docker tag $HUB_REPOSITORY:no-xtrn $HUB_REPOSITORY:no-xtrn-$VERSION
docker push $HUB_REPOSITORY:no-xtrn-$VERSION
docker push $HUB_REPOSITORY:no-xtrn

docker build -f Dockerfile-full -t $HUB_REPOSITORY:full .

[ "$?" != "0" ] && exit 1

docker tag $HUB_REPOSITORY:full $HUB_REPOSITORY:full-$VERSION
docker push $HUB_REPOSITORY:full-$VERSION
docker push $HUB_REPOSITORY:full
