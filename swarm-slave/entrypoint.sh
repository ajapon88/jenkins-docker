#!/bin/bash -e

ARGS=()
if [ -n "${JENKINS_URL}" ]; then ARGS+=("-master" "${JENKINS_URL}"); fi
if [ -n "${JENKINS_TUNNEL}" ]; then ARGS+=("-tunnel" "${JENKINS_TUNNEL}"); fi
if [ -n "${JENKINS_USER_NAME}" ]; then ARGS+=("-uname" "${JENKINS_USER_NAME}"); fi
if [ -n "${JENKINS_USER_PASSWORD}" ]; then ARGS+=("-password" "${JENKINS_USER_PASSWORD}"); fi
if [ -n "${JENKINS_AGENT_NAME}" ]; then ARGS+=("-name" "${JENKINS_AGENT_NAME}"); fi
if [ -n "${JENKINS_AGENT_DESCRIPTION}" ]; then ARGS+=("-description" "${JENKINS_AGENT_DESCRIPTION}"); fi
if [ -n "${JENKINS_AGENT_WORKDIR}" ]; then ARGS+=("-fsroot" "${JENKINS_AGENT_WORKDIR}"); fi
if [ -n "${JENKINS_AGENT_EXECUTERS}" ]; then ARGS+=("-executors" "${JENKINS_AGENT_EXECUTERS}"); fi
if [ -n "${JENKINS_AGENT_LABELS}" ]; then ARGS+=("-labels" "${JENKINS_AGENT_LABELS}"); fi
if [ -n "${JENKINS_AGENT_MODE}" ]; then ARGS+=("-mode" "${JENKINS_AGENT_MODE}"); fi

java -jar swarm-client.jar "${ARGS[@]}"
