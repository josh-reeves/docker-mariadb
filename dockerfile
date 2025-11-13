FROM debian:stable-slim
ARG ROOT_PASSWORD=""
EXPOSE 3306
VOLUME /var/lib/mysql
VOLUME /etc/mysql
WORKDIR /init
RUN apt update -y && \
    apt upgrade -y && \
    apt install mariadb-server -y && \
    service mariadb start && \
    find /init -name "*.sh" -exec {} \; && \
    find /init -name "*.sql" -exec mariadb -e {} \; && \
    mariadb -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$ROOT_PASSWORD');"
WORKDIR /
RUN rm -rf /init
ENTRYPOINT ["service mariadb start", "tail -f /dev/null"]