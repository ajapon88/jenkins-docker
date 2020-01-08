#!/bin/bash

if [ -z "${JENKINS_HOST}" ]; then
  # JENKINS_HOST=<username>:<password>@localhost:8080
  JENKINS_HOST=localhost:8080
fi

curl -sSL "http://${JENKINS_HOST}/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g' | sed 's/ /:/' | sort
