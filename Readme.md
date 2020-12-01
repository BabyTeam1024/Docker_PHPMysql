# 0x01 搭建PHP环境
`git clone https://github.com/BabyTeam1024/Docker_PHP.git`

从git下载php自动化搭建脚本编写

# 0x02 编写启动脚本
主要负责生成指定版本的php、mysql环境

``` bash
#!/bin/bash

cp .docker-compose.yml.bak docker-compose.yml

read -p "Input PHP Version (default php7.0):" phpv
read -p "Open xdebug (default yes):" xdebug
read -p "Input Mysql Version (default 5.6):" mysqlv
read -p "Input Mysql User (default root):" mysqluser
read -p "Input Mysql Pass (default root):" mysqlpass


if [ "" = "$phpv" ]; then
  phpv="php7.0"
fi
if [ "" = "$xdebug" ]; then
  xdebug="yes"
fi
if [ "" = "$mysqlv" ]; then
  mysqlv="5.6"
fi
if [ "" = "$mysqluser" ]; then
  mysqluser="root"
fi
if [ "" = "$mysqlpass" ]; then
  mysqlpass="root"
fi

sed -i "s/phpdockername/$phpv/g" docker-compose.yml

echo "php_v=$phpv" > .env
echo "xdebug=$xdebug" >> .env
echo "mysql_v=$mysqlv" >> .env
echo "mysql_user=$mysqluser" >> .env
echo "mysql_pass=$mysqlpass" >> .env
docker-compose build
```

# 0x03 编写DockerCompose
利用networks配置局域网络将两台主机联通

``` yml
version: "2"
services:
  mysql:
    image: mysql:$mysql_v
    container_name: mysql$mysql_v
    restart: always
    ports:
      - "3306:3306"
    environment:
      MYSQL_USER: "root"
      MYSQL_PASSWORD: "root"
      MYSQL_ROOT_PASSWORD: "root"
    networks:
      - net-mysql

  phpdockername:
    build: .
    container_name: phpdockername
    ports:
      - "8080:80"
    environment:
      MYSQL_USER: "root"
      MYSQL_PASSWORD: "root"
      MYSQL_ROOT_PASSWORD: "root"
      PMA_HOST: mysql$mysql_v
    networks:
      - net-mysql

networks:
  net-mysql:
```

或者利用links 将mysql添加成php的依赖容器通过

``` yml
version: "2"
services:
  mysql:
    image: mysql:$mysql_v
    container_name: mysql$mysql_v
    hostname: mysql$mysql_v
    restart: always
    ports:
      - "3306:3306"
    environment:
      MYSQL_USER: "root"
      MYSQL_PASSWORD: "root"
      MYSQL_ROOT_PASSWORD: "root"

  phpdockername:
    build: .
    container_name: phpdockername
    ports:
      - "8080:80"
    environment:
      MYSQL_USER: "root"
      MYSQL_PASSWORD: "root"
      MYSQL_ROOT_PASSWORD: "root"
      PMA_HOST: mysql$mysql_v
    tty: true
    links:
    - mysql

```

# 0x04 使用步骤

`git clone https://github.com/BabyTeam1024/Docker_PHPMysql.git`

![](https://codimd.s3.shivering-isles.com/demo/uploads/upload_54b18f9b29901918208e2a259f38b495.png)


