#!/bin/bash -e

cd "$(dirname "${0}")/../"

if [ -z "${JENKINS_URL}" ]; then
  # JENKINS_URL=http://<username>:<password>@localhost:8080
  JENKINS_URL=http://localhost:8080
fi
if [ -z "${AGENT_NAME}" ]; then
  AGENT_NAME=jnlp-slave
fi

JENKINS_SECRET=$(curl --fail -sSL "${JENKINS_URL}/computer/${AGENT_NAME}/slave-agent.jnlp" | xmllint --xpath "//jnlp/application-desc /argument[1]/text()" -)

echo "JENKINS_SECRET=${JENKINS_SECRET}" >./jnlp-slave.env
