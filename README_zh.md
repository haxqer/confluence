# confluence

[README](README.md) | [中文文档](README_zh.md)

默认端口: 8090

感谢: [sunny1025g](https://github.com/sunny1025g) for the `zh` image. [#issues/16](https://github.com/haxqer/confluence/issues/16)
+ 最新的版本: v8(8.3.0)

## 环境要求
- docker-compose: 17.09.0+

## 使用 docker-compose 启动

- start confluence & mysql

```
    git clone https://github.com/haxqer/confluence.git \
        && cd confluence \
        && git checkout latest-zh \
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
    docker volume create confluence_home_data && docker network create confluence-network && docker run -p 8090:8090 -v confluence_home_data:/var/confluence --network confluence-network --name confluence-srv -e TZ='Asia/Shanghai' haxqer/confluence:8.3.0-zh
```

- 然后配置你的数据库:


## 破解 confluence

```
docker exec confluence-srv java -jar /var/agent/atlassian-agent.jar \
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

