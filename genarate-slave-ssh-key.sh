#!/bin/bash -e

mkdir -p ./jenkins_home/.ssh
ssh-keygen -t rsa -C "" -N "" -f ./jenkins_home/.ssh/id_rsa
echo "JENKINS_SLAVE_SSH_PUBKEY=$(cat ./jenkins_home/.ssh/id_rsa.pub)">>./.env
