FROM jenkinsci/ssh-slave

USER root

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

ENV RBENV_ROOT=/usr/local/rbenv
RUN git clone https://github.com/rbenv/rbenv.git "${RBENV_ROOT}"
RUN git clone https://github.com/rbenv/ruby-build.git "${RBENV_ROOT}/plugins/ruby-build"
RUN "${RBENV_ROOT}/plugins/ruby-build/install.sh"

RUN echo 'export PATH=${RBENV_ROOT}/bin:${PATH}' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

ADD ./ruby-versions.txt /tmp/ruby-versions.txt
RUN ["/bin/bash", "-l", "-e", "-c", "xargs -L 1 rbenv install < /tmp/ruby-versions.txt"]
