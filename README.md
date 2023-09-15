# confluence
[README](README.md) | [中文文档](README_zh.md)

default port: 8090

+ Long Term Support Version: v7(7.19.14)
+ Latest Version: v8(8.4.2)
+ Latest Chinese Version: [v7](https://github.com/haxqer/confluence/tree/latest-zh) (Thanks to: [sunny1025g](https://github.com/sunny1025g) for the `zh` image. [#issues/16](https://github.com/haxqer/confluence/issues/16) )

## Requirement
- docker-compose: 17.09.0+

## How to run with docker-compose

- start confluence & mysql

```
    git clone https://github.com/haxqer/confluence.git \
        && cd confluence \
        && docker-compose up
```

- start confluence & mysql daemon

```
    docker-compose up -d
```

- default db(mysql8.0) configure:

```bash
    driver=mysql
    host=mysql-confluence
    port=3306
    db=confluence
    user=root
    passwd=123456
```

## How to run with docker

- start confluence

```
    docker volume create confluence_home_data && docker network create confluence-network && docker run -p 8090:8090 -v confluence_home_data:/var/confluence --network confluence-network --name confluence-srv -e TZ='Asia/Shanghai' haxqer/confluence:7.19.14
```

- config your own db:


## How to hack confluence

```
docker exec confluence-srv java -jar /var/agent/atlassian-agent.jar \
    -p conf \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org \
    -s you-server-id-xxxx
```

## How to hack confluence plugin

- .eg I want to use BigGantt plugin
1. Install BigGantt from confluence marketplace.
2. Find `App Key` of BigGantt is : `eu.softwareplant.biggantt`
3. Execute :

```
docker exec confluence-srv java -jar /var/agent/atlassian-agent.jar \
    -p eu.softwareplant.biggantt \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org \
    -s you-server-id-xxxx
```

4. Paste your license

## `Datacenter` license

Generate `datacenter` license by adding `-d` parameter.

```
docker exec confluence-srv java -jar /var/agent/atlassian-agent.jar \
    -d \
    -p conf \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org \
    -s you-server-id-xxxx
```

## How to upgrade

```shell
cd confluence && git pull
docker pull haxqer/confluence:latest && docker-compose stop
docker-compose rm
```

enter `y`, then start server

```shell
docker-compose up -d
```

