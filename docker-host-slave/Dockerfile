FROM jenkinsci/ssh-slave:v1.0.0

# docker
ENV DOCKER_VERSION 18.06.3-ce
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz && \
    tar -xvf docker-${DOCKER_VERSION}.tgz && \
    mv docker/* /usr/bin/ && \
    rm -rf docker-${DOCKER_VERSION}.tgz

# https://qiita.com/paper2/items/751246ee7dcae50d5042
ARG DOCKER_GROUP_GID=0
RUN groupadd -o -g ${DOCKER_GROUP_GID} docker && \
    usermod -g docker jenkins

ENTRYPOINT ["setup-sshd"]
