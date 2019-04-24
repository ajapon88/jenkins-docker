#!/usr/bin/env bash -le
set -v

DOCKER_REGISTRY_HOST=localhost:5000

docker build https://github.com/ajapon88/jenkins-rbenv-slave-docker.git -t jenkins-rbenv-slave
docker tag jenkins-rbenv-slave:latest ${DOCKER_REGISTRY_HOST}/ajapon88/jenkins-rbenv-slave:latest
docker push ${DOCKER_REGISTRY_HOST}/ajapon88/jenkins-rbenv-slave:latest
docker image rm ${DOCKER_REGISTRY_HOST}/ajapon88/jenkins-rbenv-slave:latest
