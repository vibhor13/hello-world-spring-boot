#!/bin/bash

set -e

IMAGE_BASENAME="vibhoranand/titaniam:webapp-latest"
CONTAINER_NAME="hello-world-webapp"
WEB_LANDINGPAGE_URL="http://localhost:8080"
OKAY_HTTP_CODE="200"

# Pull latest image
docker pull $IMAGE_BASENAME 2>/dev/null || (echo "Error while pulling image $IMAGE_BASENAME" && exit 1 )

# Check if container is already running 
if [ "$( docker container inspect -f '{{.State.Status}}' $CONTAINER_NAME 2>/dev/null )" == "running" ]; then
	echo "Old container is running stopping and cleaning it up."
	docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME 
	echo "Stopped and Removed old container"
fi 

# Start container with latest image

docker run -d -p 8080:8080 --name $CONTAINER_NAME $IMAGE_BASENAME &>/dev/null || ( echo "Error while starting container $CONTAINER_NAME" && exit 2 )

## Check container has started successfully :
if [ "$( docker container inspect -f '{{.State.Status}}' $CONTAINER_NAME )" == "running" ]; then
	echo "Container $CONTAINER_NAME started successfully"
else
	echo "Container hasn't started successfully " && exit 3 
fi 

## Check wether application is working successfully 

if [ "$(curl -s -o /dev/null -w "%{http_code}" https://www.google.com)" == $OKAY_HTTP_CODE ] ; then
	echo "HTTP Code for website is $OKAY_HTTP_CODE : OK"
else
	echo "ERROR: HTTP STATUS code for website not $OKAY_HTTP_CODE , Please check . "
fi

