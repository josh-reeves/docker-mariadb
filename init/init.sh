#!/bin/bash
apt update -y
apt upgrade -y
apt install mariadb-server -y

service mariadb start

mariadb -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$ADMIN_PASSWORD');"

exit 0