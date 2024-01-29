
升级：
修改 docker/.env 中的版本号（如果兼容的话）。


# cat > /etc/docker/daemon.json
{
  "log-driver":"json-file",
  "log-opts": {"max-size":"50m", "max-file":"3"}
}



Inspired by https://github.com/haxqer/confluence

