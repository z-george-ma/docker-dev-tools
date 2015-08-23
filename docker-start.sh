#!/bin/sh
TAG=my-php

if [ ! -e .boot2docker-path ]; then 
  sh docker-init.sh
fi

VOLUME_ROOT=$(cat .boot2docker-path)
docker rm -f `docker ps -qa`
sh ./docker-build.sh $TAG
docker run --name my-mysql -e MYSQL_ROOT_PASSWORD=qwe1234 -d mysql
docker run -p 80:80 -v //$VOLUME_ROOT:/var/www/html --link my-mysql -d $TAG
