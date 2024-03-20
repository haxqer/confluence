# confluence


New Confluence/Jira releases support only Data Center licenses. To generate a Data Center licenses, add the `-d` parameter.

---
Please be sure to upgrade to the latest version(8.8.1 or 8.5.7), as this [bug](https://confluence.atlassian.com/security/cve-2023-22518-improper-authorization-vulnerability-in-confluence-data-center-and-server-1311473907.html).

Related issues:
+ [#38](https://github.com/haxqer/confluence/issues/38)
+ [#39](https://github.com/haxqer/confluence/issues/39)
+ [#46](https://github.com/haxqer/confluence/issues/46) (Thanks to: [pldavid2](https://github.com/pldavid2))

---
[README](README.md) | [中文文档](README_zh.md)

default port: 8090

+ Latest Version: v8(8.8.1)
+ LTS Version: v8(8.5.7)
+ [The new way](https://github.com/haxqer/confluence/tree/build-your-own) of use allows you to conveniently upgrade and modify parameters on your own, and it offers convenient support for HTTPS (thanks to [xsharp](https://github.com/xsharp)).
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
docker volume create confluence_home_data && docker network create confluence-network && docker run -p 8090:8090 -v confluence_home_data:/var/confluence --network confluence-network --name confluence-srv -e TZ='Asia/Shanghai' haxqer/confluence:8.8.1
```

- config your own db:


## How to hack confluence

```
docker exec confluence-srv java -jar /var/agent/atlassian-agent.jar \
    -d \
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
    -d \
    -p eu.softwareplant.biggantt \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org \
    -s you-server-id-xxxx
```

4. Paste your license


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

