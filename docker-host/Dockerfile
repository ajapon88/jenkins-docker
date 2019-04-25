FROM docker:dind

ARG DOCKER_REGISTRY_HOST
RUN mkdir -p /etc/docker
RUN echo -e "{\n\
    \"insecure-registries\" : [\"${DOCKER_REGISTRY_HOST}\"]\n\
}" > /etc/docker/daemon.json
