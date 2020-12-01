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
