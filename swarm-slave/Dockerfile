FROM jenkins/slave:3.40-1

ENV SWARM_VERSION 3.17
RUN wget "https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_VERSION}/swarm-client-${SWARM_VERSION}.jar" -O "swarm-client.jar"

ENV JENKINS_AGENT_WORKDIR=/home/jenkins

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
