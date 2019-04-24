FROM docker:dind

ENV DOCKER_REGISTRY_HOST=docker-registry:5000
RUN mkdir -p /etc/docker
RUN echo "{ \"insecure-registries\" : [\"${DOCKER_REGISTRY_HOST}\"] }" > /etc/docker/daemon.json
