#!/bin/bash -e

cd "$(dirname "${0}")/../"

mkdir -p .ssh
ssh-keygen -t rsa -C "" -N "" -f .ssh/id_rsa
if ! grep -e "^JENKINS_SLAVE_SSH_PUBKEY=" ./.env >/dev/null 2>&1; then
  echo "JENKINS_SLAVE_SSH_PUBKEY=$(cat .ssh/id_rsa.pub)" >>./.env
else
  sed -i -e "s/^JENKINS_SLAVE_SSH_PUBKEY=.*/JENKINS_SLAVE_SSH_PUBKEY=$(cat .ssh/id_rsa.pub | sed "s/\//\\\\\//g")/g" ./.env
fi
