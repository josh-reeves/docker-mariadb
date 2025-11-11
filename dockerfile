FROM debian:stable-slim
ENV ADMIN_PASSWORD=""
WORKDIR /init
COPY ./init .
EXPOSE 3306
VOLUME /var/lib/mysql
VOLUME /etc/mysql
RUN chmod +x ./init.sh && ./init.sh
RUN adduser mysql-user
USER mysql-user
CMD service mariadb start && tail -f /dev/null