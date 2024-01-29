ARG CONFLUENCE_VERSION=8.5.1
FROM atlassian/confluence-server:${CONFLUENCE_VERSION}-jdk11

LABEL maintainer="xSharp <xsharp@hi3w.com>" version="${CONFLUENCE_VERSION}-lts"

ENV AGENT_INSTALL_DIR                          /opt/atlassian/agent
ENV MYSQL_DRIVER_VERSION                       8.0.33

# ENV AGENT_VERSION                            1.3.1
# https://gitee.com/pengzhile/atlassian-agent/attach_files/832832/download/atlassian-agent-v${AGENT_VERSION}.tar.gz
# https://homelab.trac.cn/atlassian-agent-v1.3.1.tar.gz

#RUN mkdir -p   ${AGENT_INSTALL_DIR} \
#    && curl -o ${CONFLUENCE_INSTALL_DIR}/lib/mysql-connector-j-${MYSQL_DRIVER_VERSION}.jar https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/${MYSQL_DRIVER_VERSION}/mysql-connector-j-${MYSQL_DRIVER_VERSION}.jar -L
RUN mkdir -p   ${AGENT_INSTALL_DIR}
COPY mysql-connector-j.jar ${CONFLUENCE_INSTALL_DIR}/lib/
COPY keygen.sh atlassian-agent.jar /opt/atlassian/agent/

ENV JAVA_OPTS="-javaagent:${AGENT_INSTALL_DIR}/atlassian-agent.jar ${JAVA_OPTS}"

WORKDIR ${CONFLUENCE_INSTALL_DIR}


