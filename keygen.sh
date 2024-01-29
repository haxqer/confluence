#!/usr/bin/env bash

shDir=$(cd $(dirname $0) && pwd)
ENVFILE=${shDir}/docker/.env
if [ ! -f "$ENVFILE" ]; then
  echo "File docker/.env NOT exists."
  exit
fi

. ${ENVFILE}

if ! [ -x "$(command -v docker)" ]; then
  echo 'Error: docker is not installed.' >&2
  exit 1
fi

if [ ! "$(docker ps -q -f name=confluence-app)" ]; then
  echo 'Docker container: confluence-app IS NOT running'
  exit 1
fi

# check file exists
FILE=./data/confluence/confluence.cfg.xml
if test -f "$FILE"; then

    SERVERID=$(grep -oPm1 "(?<=<property name=\"confluence.setup.server.id\">)[^<]+" ${FILE})

else
    echo "config file does not exist."
fi

# 容器内
# docker exec -it confluence-app /opt/atlassian/agent/keygen.sh
docker exec -it confluence-app  /opt/java/openjdk/bin/java -jar /opt/atlassian/agent/atlassian-agent.jar -m stuff@apache.org -n Apache -o Apache.org -p conf -d -s ${SERVERID}

echo "Keygen:"
echo "docker exec -it confluence-app /opt/java/openjdk/bin/java -jar /opt/atlassian/agent/atlassian-agent.jar -m stuff@apache.org -n Apache -o Apache.org -d -s ${SERVERID} -p {PRDUCT}"

