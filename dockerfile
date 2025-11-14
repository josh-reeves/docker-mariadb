FROM debian:stable-slim
ARG ROOT_PASSWORD=""
EXPOSE 3306
VOLUME /var/lib/mysql
VOLUME /etc/mysql
RUN apt update -y && \
    apt upgrade -y && \
    apt install mariadb-server -y && \
    service mariadb start && \
    mariadb -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$ROOT_PASSWORD');"
ENTRYPOINT ["service mariadb start", "tail -f /dev/null"]