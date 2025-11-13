FROM debian:stable-slim
ARG ROOT_PASSWORD=""
ARG DATABASE_NAME=""
ARG ADMIN_USER=""
ARG ADMIN_PASSWORD=""
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
    if [ -n "$ADMIN_USER" ]; then mariadb -e "CREATE USER '$ADMIN_USER'@'localhost' IDENTIFIED BY '$ADMIN_PASSWORD';"; fi && \
    if [ -n "$DATABASE_NAME" ]; then mariadb -e "CREATE DATABASE IF NOT EXISTS $DATABASE_NAME; GRANT ALL PRIVILEGES on $DATABASE_NAME.* TO $ADMIN_USER@localhost; FLUSH PRIVILEGES;"; fi && \
    mariadb -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$ROOT_PASSWORD');"
WORKDIR /
RUN rm -rf /init
ENTRYPOINT ["service mariadb start", "tail -f /dev/null"]