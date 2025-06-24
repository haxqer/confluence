# confluence


New Confluence/Jira releases support only Data Center licenses. To generate a Data Center licenses, add the `-d` parameter.

---
Please be sure to upgrade to the latest version(9.2.1 or 8.5.19), as this [bug](https://confluence.atlassian.com/security/cve-2023-22518-improper-authorization-vulnerability-in-confluence-data-center-and-server-1311473907.html).

Related issues:
+ [#38](https://github.com/haxqer/confluence/issues/38)
+ [#39](https://github.com/haxqer/confluence/issues/39)
+ [#46](https://github.com/haxqer/confluence/issues/46) (Thanks to: [pldavid2](https://github.com/pldavid2))

---
[README](README.md) | [中文文档](README_zh.md)

default port: 8090

+ Latest Version(arm64&amd64): v8(8.9.8) v9(9.2.1)
+ LTS Version:(arm64&amd64) v8(8.5.19)
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
docker volume create confluence_home_data && docker network create confluence-network && docker run -p 8090:8090 -v confluence_home_data:/var/confluence --network confluence-network --name confluence-srv -e TZ='Asia/Shanghai' haxqer/confluence:9.2.1
```

- config your own db:


## How to hack confluence

- After installing the Confluence docker container you will encounter the license page and copy your server-id and keep it for the hack sections. 

```
docker exec confluence-srv java -jar /var/agent/atlassian-agent.jar \
    -d \
    -p conf \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org \
    -s you-server-id-xxxx
```

## How to install and hack confluence plugins

- .eg I want to use BigGantt plugin
1. Go to [Atlassian Marketplace](https://marketplace.atlassian.com/) and find the plugin and choose the "Data Center" version and download the file from resources section.
2. Go to Confluence administration settings and select "Manage Apps" (optional: For better web load of this section to see installed apps without lag, select the setting at the bottom of this page and uncheck "Connect to the Atlassian Marketplace").
3. For installing BigGantt choose the "Upload app" from "Manage Apps" and upload the downloaded file, the plugin will be installed.
4. Find the `App Key` of BigGantt from app details section of installed apps : `eu.softwareplant.biggantt`
5. Execute :

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
