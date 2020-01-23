#!/bin/bash

if [ -z "${JENKINS_URL}" ]; then
  # JENKINS_URL=http://<username>:<password>@localhost:8080
  JENKINS_URL=http://localhost:8080
fi

curl --fail -sSL "${JENKINS_URL}/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g' | sed 's/ /:/' | sort
