FROM jenkins/jenkins:lts

USER root
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
# RUN echo "deb http://download.mono-project.com/repo/debian stable-stretch main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/mono-xamarin.list
RUN echo "deb http://download.mono-project.com/repo/debian wheezy-libjpeg62-compat main" >> /etc/apt/sources.list.d/mono-xamarin.list

RUN apt-get update && apt-get install -y make
RUN apt install -y mono-devel

RUN apt-get install -y rbenv ruby-build
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH=/var/jenkins_home/bin:$PATH' >> /etc/profile.d/rbenv.sh
USER jenkins
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN echo 'export PATH=/var/jenkins_home/bin:$PATH' >> ~/.bashrc
