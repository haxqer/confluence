# confluence

新的Confluence/Jira版本仅支持数据中心许可证

---
请务必升级到最新版(8.8.1 或者 8.5.7)，因为 confluence 的这个 [bug](https://confluence.atlassian.com/security/cve-2023-22518-improper-authorization-vulnerability-in-confluence-data-center-and-server-1311473907.html).

相关的 issues:
+ [#38](https://github.com/haxqer/confluence/issues/38)
+ [#39](https://github.com/haxqer/confluence/issues/39)

---

[README](README.md) | [中文文档](README_zh.md)

默认端口: 8090

+ 最新版本: v8(8.8.1)
+ 长期维护的版本: v8(8.5.7)
+ [新的使用方式](https://github.com/haxqer/confluence/tree/build-your-own) ，您可方便自行升级、修改各参数，支持https (感谢 [xsharp](https://github.com/xsharp)).
+ 最新的修复中文乱码问题的版本: [v7](https://github.com/haxqer/confluence/tree/latest-zh) (感谢: [sunny1025g](https://github.com/sunny1025g) for the `zh` image. [#issues/16](https://github.com/haxqer/confluence/issues/16) )

## 环境要求
- docker-compose: 17.09.0+

## 使用 docker-compose 启动

- start confluence & mysql

```
    git clone https://github.com/haxqer/confluence.git \
        && cd confluence \
        && docker-compose up
```

- 以守护进程的方式启动 confluence & mysql

```
    docker-compose up -d
```

- 默认的 数据库(mysql8.0) 配置:

```bash
    driver=mysql
    host=mysql-confluence
    port=3306
    db=confluence
    user=root
    passwd=123456
```

## 使用 docker 启动

- 启动 confluence

```
    docker volume create confluence_home_data && docker network create confluence-network && docker run -p 8090:8090 -v confluence_home_data:/var/confluence --network confluence-network --name confluence-srv -e TZ='Asia/Shanghai' haxqer/confluence:8.8.1
```

- 然后配置你的数据库:


## 破解 confluence

```
docker exec confluence-srv java -jar /var/agent/atlassian-agent.jar \
    -d \
    -p conf \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org \
    -s you-server-id-xxxx
```

## 破解 confluence 的插件

- 例如: 你想要破解 BigGantt 插件
1. 从 confluence marketplace 中安装 BigGantt 插件
2. 查看 BigGantt 的 `App Key` 是 : `eu.softwareplant.biggantt`
3. 然后执行 :

```
docker exec confluence-srv java -jar /var/agent/atlassian-agent.jar \
    -d \
    -p eu.softwareplant.biggantt \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org \
    -s you-server-id-xxxx
```

4. 最后粘贴生成的 licence


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

