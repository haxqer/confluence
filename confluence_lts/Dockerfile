FROM openjdk:11-bullseye

LABEL maintainer="haxqer <haxqer666@gmail.com>" version="8.5.7"

ARG ATLASSIAN_PRODUCTION=confluence
ARG APP_NAME=confluence
ARG APP_VERSION=8.5.7
ARG AGENT_VERSION=1.3.3
ARG MYSQL_DRIVER_VERSION=8.0.22

ENV CONFLUENCE_HOME=/var/confluence \
    CONFLUENCE_INSTALL=/opt/confluence \
    JVM_MINIMUM_MEMORY=1g \
    JVM_MAXIMUM_MEMORY=3g \
    JVM_CODE_CACHE_ARGS='-XX:InitialCodeCacheSize=1g -XX:ReservedCodeCacheSize=2g' \
    AGENT_PATH=/var/agent \
    AGENT_FILENAME=atlassian-agent.jar \
    LIB_PATH=/confluence/WEB-INF/lib

ENV JAVA_OPTS="-javaagent:${AGENT_PATH}/${AGENT_FILENAME} ${JAVA_OPTS}"

RUN mkdir -p ${CONFLUENCE_INSTALL} ${CONFLUENCE_HOME} ${AGENT_PATH} ${CONFLUENCE_INSTALL}${LIB_PATH} \
&& curl -o ${AGENT_PATH}/${AGENT_FILENAME}  https://github.com/haxqer/confluence/releases/download/v${AGENT_VERSION}/atlassian-agent.jar -L \
&& curl -o /tmp/atlassian.tar.gz https://product-downloads.atlassian.com/software/confluence/downloads/atlassian-${APP_NAME}-${APP_VERSION}.tar.gz -L \
&& tar xzf /tmp/atlassian.tar.gz -C /opt/confluence/ --strip-components 1 \
&& rm -f /tmp/atlassian.tar.gz \
&& curl -o ${CONFLUENCE_INSTALL}/lib/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_DRIVER_VERSION}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar -L \
&& cp ${CONFLUENCE_INSTALL}/lib/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar ${CONFLUENCE_INSTALL}${LIB_PATH}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar \
&& echo "confluence.home = ${CONFLUENCE_HOME}" > ${CONFLUENCE_INSTALL}/${ATLASSIAN_PRODUCTION}/WEB-INF/classes/confluence-init.properties

WORKDIR $CONFLUENCE_INSTALL
EXPOSE 8090

ENTRYPOINT ["/opt/confluence/bin/start-confluence.sh", "-fg"]
