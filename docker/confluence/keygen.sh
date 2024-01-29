#!/bin/bash

# check file exists
FILE=/var/atlassian/application-data/confluence/confluence.cfg.xml
if test -f "$FILE"; then

    SERVERID=$(grep -oPm1 "(?<=<property name=\"confluence.setup.server.id\">)[^<]+" /var/atlassian/application-data/confluence/confluence.cfg.xml)

    if [ -z "$SERVERID" ]; then
        echo "Visit: http://localhost:8090"
    else
        echo "SERVERID: "${SERVERID}

        /opt/java/openjdk/bin/java -jar /opt/atlassian/agent/atlassian-agent.jar \
            -m stuff@apache.org \
            -n Apache \
            -o Apache.org \
            -p conf \
            -d \
            -s ${SERVERID}
    fi

else
    echo "config file does not exist."
fi
