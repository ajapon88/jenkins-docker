FROM openjdk:11-jdk

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_AGENT_HOME=/home/${user}

ENV JENKINS_AGENT_HOME ${JENKINS_AGENT_HOME}

RUN groupadd -g ${gid} ${group} \
    && useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"

ENV JENKINS_AGENT_WORKDIR=${JENKINS_AGENT_HOME}

VOLUME "${JENKINS_AGENT_WORKDIR}" "/tmp" "/var/tmp" "/run" "/var/run"
WORKDIR "${JENKINS_AGENT_WORKDIR}"

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
