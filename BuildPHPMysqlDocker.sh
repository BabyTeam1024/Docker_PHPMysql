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
