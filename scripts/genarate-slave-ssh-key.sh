#!/bin/bash -e

cd "$(dirname "${0}")/../"

mkdir -p .ssh
ssh-keygen -t rsa -C "" -N "" -f .ssh/id_rsa
echo "JENKINS_SLAVE_SSH_PUBKEY=$(cat .ssh/id_rsa.pub)">>./.env
