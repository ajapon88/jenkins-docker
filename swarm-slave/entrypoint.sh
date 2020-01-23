#!/bin/bash -e

curl_options=()
curl_options+=("--sSL")
curl_options+=("--fail")
curl_options+=("--globoff")
if [ -n "${JENKINS_USER_NAME}" ]; then
  if [ -n "${JENKINS_USER_PASSWORD}" ]; then
    curl_options+=("--user" "${JENKINS_USER_NAME}:${JENKINS_USER_PASSWORD}")
  else
    curl_options+=("--user" "${JENKINS_USER_NAME}")
  fi
fi
# jenkinsのxpathだとセキュリティ有効時にtext()がエラーになるのでsedで置換
# HTTP ERROR 403 primitive XPath result sets forbidden; implement jenkins.security.SecureRequester
# swarm_version=$(curl "${curl_options[@]}" "${JENKINS_URL}/pluginManager/api/xml?depth=1&xpath=/*/*/shortName[text()='swarm']/parent::node()/version/text()")
swarm_version=$(curl "${curl_options[@]}" "${JENKINS_URL}/pluginManager/api/xml?depth=1&xpath=/*/*/shortName[text()='swarm']/parent::node()/version" | sed -e 's/.*<version>\(.*\)<\/version>.*/\1/g')
if [ -z "${swarm_version}" ]; then
  echo "Failed to get swarm plugin version" >&2
  exit 1
fi
echo "swarm plugin version: ${swarm_version}"

cache_dir="/var/tmp/jenkins/swarm"
swarm_client="swarm-client-${swarm_version}.jar"
jar="${cache_dir}/${swarm_client}"
if [ ! -e "${jar}" ]; then
  mkdir -p "${cache_dir}"
  wget "https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${swarm_version}/${swarm_client}" -O "${jar}"
fi

args=()
if [ -n "${JENKINS_URL}" ]; then args+=("-master" "${JENKINS_URL}"); fi
if [ -n "${JENKINS_TUNNEL}" ]; then args+=("-tunnel" "${JENKINS_TUNNEL}"); fi
if [ -n "${JENKINS_USER_NAME}" ]; then args+=("-username" "${JENKINS_USER_NAME}"); fi
if [ -n "${JENKINS_USER_PASSWORD}" ]; then args+=("-password" "${JENKINS_USER_PASSWORD}"); fi
if [ -n "${JENKINS_AGENT_NAME}" ]; then args+=("-name" "${JENKINS_AGENT_NAME}"); fi
if [ -n "${JENKINS_AGENT_DESCRIPTION}" ]; then args+=("-description" "${JENKINS_AGENT_DESCRIPTION}"); fi
if [ -n "${JENKINS_AGENT_WORKDIR}" ]; then args+=("-fsroot" "${JENKINS_AGENT_WORKDIR}"); fi
if [ -n "${JENKINS_AGENT_EXECUTERS}" ]; then args+=("-executors" "${JENKINS_AGENT_EXECUTERS}"); fi
if [ -n "${JENKINS_AGENT_LABELS}" ]; then args+=("-labels" "${JENKINS_AGENT_LABELS}"); fi
if [ -n "${JENKINS_AGENT_MODE}" ]; then args+=("-mode" "${JENKINS_AGENT_MODE}"); fi

java -jar "${jar}" "${args[@]}"
