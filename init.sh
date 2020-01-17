#!/bin/bash -e

cd "$(dirname "${0}")"

# create default .env
if [ ! -e .env ]; then
  cp .env.example .env
fi

# generate ssh-slave private key
mkdir -p .ssh
ssh-keygen -t rsa -C "" -N "" -f .ssh/id_rsa
echo "JENKINS_SLAVE_SSH_PUBKEY=$(cat .ssh/id_rsa.pub)" >>./ssh-slave.env

# create jnlp-slave.env
touch jnlp-slave.env
