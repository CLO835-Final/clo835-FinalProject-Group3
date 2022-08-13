#!/bin/sh

#2 create docker iamge and run locally

#2.1 create docker image
docker build . -t imgfrmconfigmapv1.1
set -x

#display docker images
docker images
set -x

#run docker on backgroud and map container port 81 to host port 8080
docker run -d -p 8080:81  imgfrmconfigmapv1.1

#display docker container
docker ps
set -x

#curl local host

sleep 10
echo "Hello there!"
curl localhost:8080
set -x
