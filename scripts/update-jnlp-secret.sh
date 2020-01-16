#!/bin/bash -e

if [ -z "${JENKINS_HOST}" ]; then
  # JENKINS_HOST=<username>:<password>@localhost:8080
  JENKINS_HOST=localhost:8080
fi
if [ -z "${AGENT_NAME}" ]; then
  AGENT_NAME=jnlp-slave
fi
if [ -z "${SLAVE_AGENT_PORT}" ]; then
  SLAVE_AGENT_PORT=50000
fi

if ! grep -e "^SLAVE_AGENT_PORT=" ./.env >/dev/null 2>&1; then
  echo "SLAVE_AGENT_PORT=${SLAVE_AGENT_PORT}" >>./.env
else
  sed -i -e "s/^SLAVE_AGENT_PORT=.*/SLAVE_AGENT_PORT=${SLAVE_AGENT_PORT}/g" ./.env
fi

JENKINS_SLAVE_JNLP_SECRET=$(curl -sSL "http://${JENKINS_HOST}/computer/${AGENT_NAME}/slave-agent.jnlp" | xmllint --xpath "//jnlp/application-desc /argument[1]/text()" -)

if ! grep -e "^JENKINS_SLAVE_JNLP_SECRET=" ./.env >/dev/null 2>&1; then
  echo "JENKINS_SLAVE_JNLP_SECRET=${JENKINS_SLAVE_JNLP_SECRET}" >>./.env
else
  sed -i -e "s/^JENKINS_SLAVE_JNLP_SECRET=.*/JENKINS_SLAVE_JNLP_SECRET=$(echo "${JENKINS_SLAVE_JNLP_SECRET}" | sed "s/\//\\\\\//g")/g" ./.env
fi
