
目前支持

- [x] PHP5.6
- [x] PHP7.0
- [x] PHP7.1
- [x] PHP7.2
- [x] PHP7.3
- [x] PHP7.4
- [x] PHP8.0



# 0x01 设置版本参数
通过env文件向docker-compose传递环境变量，BuildPHPDocker.sh脚本如下

``` bash
#!/bin/bash

cp .docker-compose.yml.bak docker-compose.yml

read -p "Input PHP Version (default n):" phpv
read -p "Open xdebug (default yes):" xdebug
if [ "" = "$docker" ]; then
	xdebug="yes"
fi
sed -i "s/dockername/$phpv/g" docker-compose.yml
echo "php_v=$phpv" > .env
echo "xdebug=$xdebug" >> .env
docker-compose build
```

主要包含两个参数
1. php版本
2. 是否开启xdebug 

# 0x02 DockerCompose

``` docker
version: "3"
services:
  dockername:
    build:
      context: .
      args:
        phpv: ${php_v}
        xdebug: ${xdebug}
    tty: true
```

在dockerfile中cmd为`/bin/bash`时需要在dockercompose中选择tty参数以便在启动后能够一直保持交互；利用args传递参数
# 0x03 Dockerfile

``` dockerfile
FROM ubuntu:18.04
RUN apt update && apt install software-properties-common -y && add-apt-repository ppa:ondrej/php -y && apt update
ARG phpv
ARG xdebug
ENV DEBIAN_FRONTEND noninteractive
RUN apt install $phpv -y --force-yes
RUN if [ "$xdebug" = "yes" ] ; then apt install ${phpv}-xdebug ;fi
CMD ["/bin/bash"]

```

# 0x04 使用

![](https://codimd.s3.shivering-isles.com/demo/uploads/upload_030dbca2861d1c945cd1298c605feaab.png)



