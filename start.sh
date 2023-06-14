#!/bin/bash

clear

JOLOKIA_JAR="${HOME}/jolokia-1.7.1/agents/jolokia-jvm.jar"
if [ ! -f "${JOLOKIA_JAR}" ]; then
    echo "Please download the jolokia-jvm jar from https://jolokia.org/download.html & extract to ${JOLOKIA_JAR}"
    exit 1
fi

#
# Do the build first to ensure that BUILD_JAR is available
#
mvn clean install

#
# Execute with the jolokia java agent
#
JAVA_AGENT_OPTS="-javaagent:${JOLOKIA_JAR}=port=8778,host=localhost"
BUILD_JAR=${HOME}/.m2/repository/io/fabric8/quickstarts/spring-boot-camel/1.0-SNAPSHOT/spring-boot-camel-1.0-SNAPSHOT.jar

java "${JAVA_AGENT_OPTS}" -jar ${BUILD_JAR}
