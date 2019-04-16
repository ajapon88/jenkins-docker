FROM jenkinsci/ssh-slave

USER root

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

RUN git clone https://github.com/rbenv/rbenv.git /usr/local/rbenv
RUN git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build
RUN /usr/local/rbenv/plugins/ruby-build/install.sh
RUN ln -s /usr/local/rbenv/bin/rbenv /usr/local/bin/rbenv
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
